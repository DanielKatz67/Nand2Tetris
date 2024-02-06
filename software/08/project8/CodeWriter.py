
class CodeWriter:
    def __init__(self, output_file_path):
        """
         Opens the output file/stream, and gets ready ro parse it
        """
        self.file = open(output_file_path, 'a')
        self.jumpCounter=0
        self.ret_Counter=0
        # Init the output file
        self.set_SP_to_256()
        self.input_file_name ='Sys.init'
        self.function_name =''

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
        if command == 'eq':
            self._translateComparison('JNE','EQ_')   # JNE is not 0
            self.jumpCounter += 1
        if command == 'gt':
            self._translateComparison('JLE', 'GT_')  # JLE is <=0
            self.jumpCounter += 1
        if command == 'lt':
            self._translateComparison('JGE', 'LT_')  # JGE is >=0
            self.jumpCounter += 1

    def _stack_manipulation(self):
        """
        Needs to load SP-1 to get the last value,
        then do the operation and write it over the second place
        """
        # self.file.write("//stack manipulation\n")
        self.file.write("@SP\nAM=M-1\nD=M\nA=A-1\n")

    def _translateComparison(self, jump_kind: str, comparison_kind: str):
        """
        Handling comparison 'eq', 'gt', 'lt'
        """
        self._stack_manipulation()
        self.file.write(
        f"D=M-D\n"
        # f"//Comparison and conditional jump\n"
        f"@{comparison_kind}{self.jumpCounter}_CONDITION_IS_FALSE\n"
        f"D;{jump_kind}\n"
        # f"//Setting the result for true condition. -1 is true\n"
        f"@SP\n"
        f"A=M-1\n"
        f"M=-1\n"
        f"@{comparison_kind}{self.jumpCounter}_CONDITION_IS_TRUE\n"
        f"0;JMP\n"
        # f"//Handling false condition. 0 is false\n"
        f"({comparison_kind}{self.jumpCounter}_CONDITION_IS_FALSE)\n"
        f"@SP\n"
        f"A=M-1\n"
        f"M=0\n"
        f"({comparison_kind}{self.jumpCounter}_CONDITION_IS_TRUE)\n")

    def writePushPop(self, c_type, segment, i):
        """
        Writes to the output file the assembly code that
        implements the given push or pop command
        """
        if c_type == 'C_PUSH':
            if segment == 'pointer' and i == 0 : self._translatePush("THIS", i, True)
            if segment == 'pointer' and i == 1 : self._translatePush("THAT", i, True)
            if segment == 'constant'           : self._translatePush('constant', i, False)
            if segment == 'temp'               : self._translatePush("R5", str(int(i)+5), False)
            if segment == 'local'              : self._translatePush('LCL', i, False)
            if segment == 'argument'           : self._translatePush('ARG', i, False)
            if segment == 'this'               : self._translatePush('THIS', i, False)
            if segment == 'that'               : self._translatePush('THAT', i, False)
            if segment == 'static': self._translate_PushPop_for_Static('PUSH',i)

        else:
            if segment == 'pointer' and i == 0 : self._translatePop("THIS", i, True)
            if segment == 'pointer' and i == 1 : self._translatePop("THAT", i, True)
            if segment == 'temp'               : self._translatePop("R5", str(int(i)+5), False)
            if segment == 'local'              : self._translatePop('LCL', i, False)
            if segment == 'argument'           : self._translatePop('ARG', i, False)
            if segment == 'this'               : self._translatePop('THIS', i, False)
            if segment == 'that'               : self._translatePop('THAT', i, False)
            if segment == 'static': self._translate_PushPop_for_Static('POP',i)

    def _translatePush(self, segment, i, noRef):
        addition_not_for_direct = ''
        if not noRef :
            addition_not_for_direct = (
            f"@{i}\n"
            f"A=D+A\n"
            f"D=M\n")

        suffix = (
        "@SP\n"
        "A=M\n"
        "M=D\n"
        # "//SP++\n"
        "@SP\n"
        "M=M+1\n")

        if segment == 'constant':
            self.file.write(
            f"@{i}\n"
            f"D=A\n"
            f"{suffix}")

        else:
            self.file.write(
            # f"//D=RAM[i+{segment}Pointer]\n"
            f"@{segment}\n"
            f"D=M\n{addition_not_for_direct}"
            # f"//RAM[SP]=D\n"
            f"{suffix}")

    def _translatePop(self, segment, i, noRef):
        addition_not_for_direct = 'D=A\n'
        if not noRef :
            addition_not_for_direct = (
            f"D=M\n"
            f"@{i}\n"
            f"D=D+A\n")


        self.file.write(
        f"@{segment}\n"
        f"{addition_not_for_direct}"
        f"@R15\n"
        f"M=D\n"
        f"@SP\n"
        f"AM=M-1\n"
        f"D=M\n"
        f"@R15\n"
        f"A=M\n"
        f"M=D\n")

    def write_vm_line_as_comment(self, line):
        self.file.write(f"//{line}\n")

    def write_vm_file_name_comment(self, path):
        self.file.write(f"\n//{path.split('/')[-1]}:\n")

    def set_SP_to_256(self):
        self.file.write(
        # "//SetSP = 256\n"
        "@256\n"
        "D=A\n"
        "@SP\n"
        "M=D\n")

    # from here there are new function that weren't in project 7, expect the close()

    def setFileName(self, input_file):
        """
        Informs that the translator of a new VM file has started(called by the main)
        """
        self.input_file_name = input_file.split('/')[-1].split('.')[0]

    def _translate_PushPop_for_Static(self, type, i):
        if type == "PUSH":
            self.file.write(
                f"@{self.input_file_name}.{i}\n"
                f"D=M\n"
                f"@SP\n"
                f"A=M\n"
                f"M=D\n"
                # f"//SP++\n"
                f"@SP\n"
                f"M=M+1\n")

        if type == "POP":
            self.file.write(
                f"@{self.input_file_name}.{i}\n"
                f"D=A\n"
                f"@R13\n"
                f"M=D\n"
                f"@SP\n"
                f"AM=M-1\n"
                f"D=M\n"
                f"@R13\n"
                f"A=M\n"
                f"M=D\n")


    def writeLabel(self, label):
        """
        Writes assembly code that effects the label command
        """
        self.file.write(f"({self.function_name}${label})\n")

    def writeGoto(self, label):
        """
        Writes assembly code that effects the goto command
        """
        self.file.write(f"@{self.function_name}${label}\n0;JMP\n")

    def writeIf(self, label):
        """
        Writes assembly code that effects the if-goto command
        """
        self._stack_manipulation()
        self.file.write(
            # f"//jump if true (if not false=0)\n"
            f"@{self.function_name}${label}\n"
            f"D;JNE\n")

    def writeFunction(self, functionName, nVars):
        """
        Writes assembly code that effects the function command
        """
        self.function_name = functionName
        self.ret_Counter = 0

        # self.file.write(f"   @{self.input_file_name}${functionName}\n")
        self.file.write(
            f"({functionName})\n"
            f"@LCL\n"
            f"A=M\n")

        for i in range(0,int(nVars)):
            # self.file.write(f"//push local 0\n")
            # self._translatePush('LCL',0, False)
            self.file.write(
                f"M=0\n"
                f"A=A+1\n"
                f"D=A\n"
                f"@SP\n"
                f"M=M+1\n"
                f"A=D\n")

    def writeCall(self, functionName, nArgs):
        """
        Writes assembly code that effects the call command
        """
        # current_return_label = f"{self.input_file_name}.{functionName}$ret.{self.ret_Counter}"
        current_return_label = f"{self.function_name}$ret.{self.ret_Counter}"
        self.ret_Counter += 1

        self.file.write(
            # f"//push return address\n"
            f"@{current_return_label}\n"
            f"D=A\n"
            f"@SP\n"
            f"A=M\n"
            f"M=D\n"
            # f"//SP++\n"
            f"@SP\n"
            f"M=M+1\n")

        self._translatePush("LCL",0,True)
        self._translatePush("ARG",0,True)
        self._translatePush("THIS",0,True)
        self._translatePush("THAT",0,True)

        self.file.write(
            # f"//ARG = SP - 5 - nArgs\n"
            f"@SP\n"
            f"D=M\n"
            f"@5\n"
            f"D=D-A\n"
            f"@{nArgs}\n"
            f"D=D-A\n"
            f"@ARG\n"
            f"M=D\n"
            # f"//LCL = SP\n"
            f"@SP\n"
            f"D=M\n"
            f"@LCL\n"
            f"M=D\n"
            # f"//goto functionName\n"
            # f"   @{self.input_file_name}${functionName}\n"
            f"@{functionName}\n"
            f"0;JMP\n"
            f"({current_return_label})\n")

    def writeReturn(self):
        """
        Writes assembly code that effects the return command.
        Using R14 for endFrame R15 for RET
        """

        self.file.write(
                f"@LCL\n"
                f"D=M\n"
                f"@R13\n"
                f"M=D\n"
                f"@R13\n"
                f"D=M\n"
                f"@5\n"
                f"D=D-A\n"
                f"A=D\n"
                f"D=M\n"
                f"@R14\n"
                f"M=D\n"
                f"@SP\n"
                f"M=M-1\n"
                f"A=M\n"
                f"D=M\n"
                f"@ARG\n"
                f"A=M\n"
                f"M=D\n"
                f"@ARG\n"
                f"D=M\n"
                f"@SP\n"
                f"M=D+1\n"
                f"@R13\n"
                f"D=M\n"
                f"@1\n"
                f"D=D-A\n"
                f"A=D\n"
                f"D=M\n"
                f"@THAT\n"
                f"M=D\n"
                f"@R13\n"
                f"D=M\n"
                f"@2\n"
                f"D=D-A\n"
                f"A=D\n"
                f"D=M\n"
                f"@THIS\n"
                f"M=D\n"
                f"@R13\n"
                f"D=M\n"
                f"@3\n"
                f"D=D-A\n"
                f"A=D\n"
                f"D=M\n"
                f"@ARG\n"
                f"M=D\n"
                f"@R13\n"
                f"D=M\n"
                f"@4\n"
                f"D=D-A\n"
                f"A=D\n"
                f"D=M\n"
                f"@LCL\n"
                f"M=D\n"
                f"@R14\n"
                f"A=M\n"
                f"0;JMP\n")


    def _translate_frame(self, pos):
        self.file.write(
            f"@R14\n"
            f"D=M-1\n"
            f"AM=D\n"
            f"D=M\n"
            f"@{pos}\n"
            f"M=D\n")
    def close(self):
        """
        closes the output file
        """
        # self.file.write(
        # "(END)\n"
        # "   @END\n"
        # "   0;JMP\n")
        self.file.close()


