
class CodeWriter:
    def __init__(self, output_file_path):
        """
         Opens the output file/stream, and gets ready ro parse it
        """
        self.file = open(output_file_path, 'a')

    # noinspection PyTypeChecker
    def writeArithmetic(self, command):
        """
        Writes to the output file the assembly code that
        implements the given arithmetic-logical command
        'add', 'sub', 'and', 'or', 'neg', 'not', 'eq', 'gt', 'lt'
        """
        if command in ['add', 'sub', 'and', 'or']:
            self._stack_manipulation()
            if command == 'add': self.file.write('M=M+D\n')
            if command == 'sub': self.file.write('M=M-D\n')
            if command == 'and': self.file.write('M=M&D\n')
            if command == 'or' : self.file.write('M=M|D\n')

        if command == 'neg': self.file.write('D=0\n@SP\nA=M-1\nM=D-M\n')
        if command == 'not': self.file.write('@SP\nA=M-1\nM=!M\n')

        if command == 'eq': self.file.write(self._translateComparison('JNE','_EQ'))   # JNE is not 0
        if command == 'gt': self.file.write(self._translateComparison('JLE', '_GT'))  # JLE is <=0
        if command == 'lt': self.file.write(self._translateComparison('JGE', '_LT'))  # JGE is >=0

    def _stack_manipulation(self):
        """
        Needs to load SP-1 to get the last value,
        then do the operation and write it over the second place
        """
        self.file.write("//stack manipulation\n")
        self.file.write("@SP\nAM=M-1\nD=M\nA=A-1\n")

    def _translateComparison(self, jump_kind: str, comparison_kind: str):
        """
        Handling comparison 'eq', 'gt', 'lt'
        """
        self._stack_manipulation()
        self.file.write(f"""\
        D=M-D
        //Comparison and conditional jump
        @{comparison_kind}CONDITION_IS_FALSE
        D;{jump_kind}
        //Setting the result for true condition. -1 is true
        @SP
        A=M-1
        M=-1
        @{comparison_kind}CONDITION_IS_TRUE
        0;JMP
        //Handling false condition. -1 is false
        ({comparison_kind}CONDITION_IS_FALSE)
        @SP
        A=M-1
        M=0
        ({comparison_kind}CONDITION_IS_TRUE) """)

    def writePushPop(self, c_type, segment, i):
        """
        Writes to the output file the assembly code that
        implements the given push or pop command
        """
        if c_type == 'C_PUSH':
            if segment == 'pointer' and i == 0 : self._translatePush("THIS", i)
            if segment == 'pointer' and i == 1 : self._translatePush("THAT", i)
            if segment == 'constant'           : self._translatePush('constant', i)
            if segment == 'static'             : self._translatePush(16, i)
            if segment == 'temp'               : self._translatePush(5, i)
            if segment == 'local'              : self._translatePush('LCL', i)
            if segment == 'argument'           : self._translatePush('ARG', i)
            if segment == 'this'               : self._translatePush('THIS', i)
            if segment == 'that'               : self._translatePush('THAT', i)
        else:
            if segment == 'pointer' and i == 0 : self._translatePop("THIS", i)
            if segment == 'pointer' and i == 1 : self._translatePop("THAT", i)
            if segment == 'static'             : self._translatePop(16, i)
            if segment == 'temp'               : self._translatePop(5, i)
            if segment == 'local'              : self._translatePop('LCL', i)
            if segment == 'argument'           : self._translatePop('ARG', i)
            if segment == 'this'               : self._translatePop('THIS', i)
            if segment == 'that'               : self._translatePop('THAT', i)

    def _translatePush(self, segment, i):
        addition_not_for_pointer = ''
        if segment != 'pointer':
            addition_not_for_pointer = f"""
            @{i}
            A=D+A
            D=M\n
            """

        suffix = f"""\
        @SP
        A=M
        M=D
        //SP++
        @SP
        M=M+1
        """

        if segment == 'constant':
            self.file.write(f"""\
            @index
            D=A
            {suffix}
            """)
        else:
            self.file.write(f"""\")
            //D=RAM[i+{segment}Pointer]
            @{segment}
            D=M{addition_not_for_pointer}
            //RAM[SP]=D
            {suffix}
            """)

    def _translatePop(self, segment, i):
        addition_not_for_pointer = 'D=A'
        if segment != 'pointer':
            addition_not_for_pointer = f"""
            D=M
            @index
            D=D+A
            """

        self.file.write(f"""\
        @{segment}
        {addition_not_for_pointer}
        @R15
        M=D
        @SP
        AM=M-1
        D=M
        @R15
        A=M
        M=D
        """)

    def close(self):
        """
        closes the output file
        """
        self.file.close()