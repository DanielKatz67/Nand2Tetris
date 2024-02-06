
class Parser:
    def __init__(self, input_file_path):
        """
        Opens the input file/stream, and gets ready to parse it
        Arguments: Input file path
        """
        self.file = open(input_file_path, 'r')
        self.current_line = ''

    def hasMoreLines(self) -> bool:
        """
        Are there more lines in the input?
        """
        self.current_line = self.file.readline()
        return self.current_line != ''

    def advance(self):
        """
        Reads the next command from the input and makes it the current command.
        This method should be called if hasMoreLines is true.
        Initially there is no current command
        """
        # Assuming current_line already contains the next line from has_more_lines
        # Trim the current line to remove leading and trailing whitespace
        self.current_line = self.current_line.strip()

        # If the line is a comment or empty, keep reading the next line
        while self.current_line == '' or self.current_line.startswith('/'):
            self.current_line = self.file.readline()
            if self.current_line == '':  # End of file reached
                break
            self.current_line = self.current_line.strip()

    def commandType(self) -> str:
        """
        Returns a constant representing the type of the current command.
        If the current command is an arithmetic-logical command, return C_ARITHMETIC.
        Return options: C_ARITHMETIC, C_PUSH, C_POP, C_LABEL, C_GOTO, C_IF, C_FUNCTION, C_RETURN, C_CALL
        """
        arith = ['add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not']
        command = str(self.current_line).split()[0]

        if command in arith: return "C_ARITHMETIC"
        elif command == "push": return "C_PUSH"
        elif command == "pop": return "C_POP"
        elif command == "label": return "C_LABEL"
        elif command == "goto": return "C_GOTO"
        elif command == "if-goto": return "C_IF"
        elif command == "function": return "C_FUNCTION"
        elif command == "return": return "C_RETURN"
        elif command == "call": return "C_CALL"
        else: return "something Wrong ! ! ! !"

    def arg1(self) -> str:
        """
        Return the first argument of the current command.
        In the case of C_ARITHMETIC, the command itself(add, sub...) is returned.
        Should not be called if the current command is C_RETURN
        """
        arith = ['add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not']
        command = str(self.current_line).split()[0]
        if command in arith: return command
        else: return str(self.current_line).split()[1]

    def arg2(self) -> int:
        """
        Return the second argument of the current command.
        Should be called only if the current command is C_PUSH, C_POP, C_FUNCTION, C_CALL
        """
        return self.current_line.split()[2]

    def close(self):
        """
        Closes the file stream.
        """
        self.file.close()