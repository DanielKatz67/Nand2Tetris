
class CodeWriter:
    def __init__(self, output_file_path):
        """
         Opens the output file/stream, and gets ready ro parse it
        """
        self.file = open(output_file_path, 'a')
        self.jumpCounter=0

    # noinspection PyTypeChecker
    def writeArithmetic(self, command):
        """
        Writes to the output file the assembly code that
        implements the given arithmetic-logical command
        'add', 'sub', 'and', 'or', 'neg', 'not', 'eq', 'gt', 'lt'
        """
        if command in ['add', 'sub', 'and', 'or']:
            self._stack_manipulation()
            if command == 'add': self.file.write('   M=M+D\n')
            if command == 'sub': self.file.write('   M=M-D\n')
            if command == 'and': self.file.write('   M=M&D\n')
            if command == 'or' : self.file.write('   M=M|D\n')
        if command == 'neg': self.file.write('   D=0\n   @SP\n   A=M-1\n   M=D-M\n')
        if command == 'not': self.file.write('   @SP\n   A=M-1\n   M=!M\n')
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
        self.file.write("//stack manipulation\n")
        self.file.write("   @SP\n   AM=M-1\n   D=M\n   A=A-1\n")

    def _translateComparison(self, jump_kind: str, comparison_kind: str):
        """
        Handling comparison 'eq', 'gt', 'lt'
        """
        self._stack_manipulation()
        self.file.write(
        f"   D=M-D\n"
        f"//Comparison and conditional jump\n"
        f"   @{comparison_kind}{self.jumpCounter}_CONDITION_IS_FALSE\n"
        f"   D;{jump_kind}\n"
        f"//Setting the result for true condition. -1 is true\n"
        f"   @SP\n"
        f"   A=M-1\n"
        f"   M=-1\n"
        f"   @{comparison_kind}{self.jumpCounter}_CONDITION_IS_TRUE\n"
        f"   0;JMP\n"
        f"//Handling false condition. 0 is false\n"
        f"({comparison_kind}{self.jumpCounter}_CONDITION_IS_FALSE)\n"
        f"   @SP\n"
        f"   A=M-1\n"
        f"   M=0\n"
        f"({comparison_kind}{self.jumpCounter}_CONDITION_IS_TRUE)\n")

    def writePushPop(self, c_type, segment, i):
        """
        Writes to the output file the assembly code that
        implements the given push or pop command
        """
        if c_type == 'C_PUSH':
            if segment == 'pointer' and i == 0 : self._translatePush("THIS", i)
            if segment == 'pointer' and i == 1 : self._translatePush("THAT", i)
            if segment == 'constant'           : self._translatePush('constant', i)
            if segment == 'static'             : self._translatePush(str(16+int(i)), i)
            if segment == 'temp'               : self._translatePush("R5", str(int(i)+5))
            if segment == 'local'              : self._translatePush('LCL', i)
            if segment == 'argument'           : self._translatePush('ARG', i)
            if segment == 'this'               : self._translatePush('THIS', i)
            if segment == 'that'               : self._translatePush('THAT', i)
        else:
            if segment == 'pointer' and i == 0 : self._translatePop("THIS", i)
            if segment == 'pointer' and i == 1 : self._translatePop("THAT", i)
            if segment == 'static'             : self._translatePop(str(16+int(i)), i)
            if segment == 'temp'               : self._translatePop("R5", str(int(i)+5))
            if segment == 'local'              : self._translatePop('LCL', i)
            if segment == 'argument'           : self._translatePop('ARG', i)
            if segment == 'this'               : self._translatePop('THIS', i)
            if segment == 'that'               : self._translatePop('THAT', i)

    def _translatePush(self, segment, i):
        addition_not_for_direct = ''
        if segment not in ['pointer','static']:
            addition_not_for_direct = (
            f"   @{i}\n"
            f"   A=D+A\n"
            f"   D=M\n")


        suffix = (
        "   @SP\n"
        "   A=M\n"
        "   M=D\n"
        "//SP++\n"
        "   @SP\n"
        "   M=M+1\n")

        if segment == 'constant':
            self.file.write(
            f"   @{i}\n"
            f"   D=A\n"
            f"{suffix}")

        else:
            self.file.write(
            f"//D=RAM[i+{segment}Pointer]\n"
            f"   @{segment}\n"
            f"   D=M\n{addition_not_for_direct}\n"
            f"//RAM[SP]=D\n"
            f"{suffix}")

    def _translatePop(self, segment, i):
        addition_not_for_direct = '   D=A'
        if segment not in ['pointer','static']:
            addition_not_for_direct = (
            f"   D=M\n"
            f"   @{i}\n"
            f"   D=D+A\n")


        self.file.write(
        f"   @{segment}\n"
        f"{addition_not_for_direct}"
        f"   @R15\n"
        f"   M=D\n"
        f"   @SP\n"
        f"   AM=M-1\n"
        f"   D=M\n"
        f"   @R15\n"
        f"   A=M\n"
        f"   M=D\n")

    def write_vm_line_as_comment(self, line):
        self.file.write(f"//{line}\n")

    def write_vm_file_name_comment(self, path):
        self.file.write(f"\n//{path.split('/')[-1]}:\n")

    def set_SP_to_256(self):
        self.file.write(
        "//SetSP = 256\n"
        "   @256\n"
        "   D=A\n"
        "   @SP\n"
        "   M=D\n")

    def close(self):
        """
        closes the output file
        """
        self.file.write(
        "(END)\n"
        "   @END\n"
        "   0;JMP\n")
        self.file.close()