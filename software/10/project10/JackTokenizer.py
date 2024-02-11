class JackTokenizer:
    KEYWORDS = {"class", "constructor", "function", "method", "field",
                "static", "var", "int", "char", "boolean", "void", "true",
                "false", "null", "this", "do", "if", "else", "while", "return", "let"}
    SYMBOLS = "{}()[].,;+-*/&|<>=-~"
    OPERATIONS = "+-*/&|<>="

    def __init__(self, input_file_path):
        """
        Opens the input .jack file/ stream and gets ready to tokenize it.
        """
        self.tokens = []
        self.__token_type = ""
        self.__keyword = ""
        self.__symbol = ''
        self.__identifier = ""
        self.__int_val = 0
        self.__string_val = ""
        self.pointer = 0
        self.first = True

        cleaned_content = []
        # in_block_comment = False

        with open(input_file_path, 'r') as file:
            for line in file:
                if self.__hasComments(line):
                    line = self.__removeComments(line)
                if line.strip() != "":
                    cleaned_content.append(line.strip())


        # Join cleaned lines with a space, removing excessive whitespace
        self.jack_code = " ".join(cleaned_content)

        self.__tokenize()
        # a=1

    def __hasComments(self, line):
        return "//" in line or "/*" in line or line.startswith(" *")

    def __removeComments(self, line):
        # Determine the offset for the start of the comment
        if line.startswith(" *"):
            off_set = line.find("*")
        elif "/*" in line:
            off_set = line.find("/*")
        else:
            off_set = line.find("//")

        # Remove the comment based on the determined offset and trim whitespace
        return line[:off_set].strip()

    def __tokenize(self):
        i = 0
        while i < len(self.jack_code):
            char = self.jack_code[i]

            if char.isspace():
                i += 1
                continue

            if char in self.SYMBOLS:
                self.tokens.append(char)
                i += 1
                continue

            if char == '"':
                end_quote = self.jack_code.find('"', i + 1) + 1
                self.tokens.append(self.jack_code[i:end_quote])
                i = end_quote
                continue

            # Handles numeric constants, keywords, and identifiers
            start = i
            while i < len(self.jack_code) and (self.jack_code[i].isalnum() or self.jack_code[i] in {'_', '"'}):
                i += 1
            token = self.jack_code[start:i]

            # Directly add the token
            self.tokens.append(token)

    def hasMoreTokens(self) -> bool:
        """
        Are there more tokens in the input?
        """
        return self.pointer < len(self.tokens)

    def advance(self):
        """
        Gets the next token from the input and makes it the current token.
        This method should be called only if hasMoreTokens is true.
        Initially there is no current token.
        """
        if not self.first:
            self.pointer += 1
        else:
            self.first = False

        if not self.hasMoreTokens():
            return

        current_token = self.tokens[self.pointer]
        if current_token in self.KEYWORDS:
            self.__token_type = "KEYWORD"
            self.__keyword = current_token
        elif current_token in self.SYMBOLS:
            self.__token_type = "SYMBOL"
            self.__symbol = current_token
        elif current_token.isdigit():
            self.__token_type = "INT_CONST"
            self.__int_val = int(current_token)
        elif current_token.startswith('"'):
            self.__token_type = "STRING_CONST"
            self.__string_val = current_token.strip('"')
        elif current_token == "_" or current_token.isalpha():
            self.__token_type = "IDENTIFIER"
            self.__identifier = current_token
        else:
            return

    @property
    def tokenType(self) -> str:
        """
        Returns the type of the current token, as a constant.
        Options: KEYWORD, SYMBOL, IDENTIFIER, INT_CONST, STRING_CONST
        """
        return self.__token_type

    @property
    def keyWord(self) -> str:
        """
        Returns the keyword which is the current token, as a constant.
        This method should be called only if tokenType is KEYWORD.
        Options: CLASS, METHOD, FUNCTION, CONSTRUCTOR, INT, BOOLEAN,
                 CHAR, VOID, VAR, STATIC, FIELD, LET, DO, IF, ELSE, WHILE,
                 RETURN, TRUE, FALSE, NULL, THIS
        """
        # assert self.__token_type == "KEYWORD", "Current token is not a keyword"
        return self.__keyword

    @property
    def symbol(self) -> str:
        """
        Returns the character which is the current token.
        Should be called only if tokenType is SYMBOL.
        """
        # assert self.__token_type == "SYMBOL", "Current token is not a symbol"
        return self.__symbol

    @property
    def identifier(self) -> str:
        """
        Returns the string which is the current token.
        Should be called only if tokenType is IDENTIFIER.
        """
        # assert self.__token_type == "IDENTIFIER", "Current token is not an identifier"
        return self.__identifier

    @property
    def intVal(self) -> int:
        """
        Returns the integer value of the current token.
        Should be called only if tokenType is INT_CONST.
        """
        # assert self.__token_type == "INT_CONST", "Current token is not an integer constant"
        return self.__int_val

    @property
    def stringVal(self) -> str:
        """
        Returns the string value of the current token, without the opening and closing double qoutes.
        Should be called only if tokenType is STRING_CONST.
        """
        # assert self.__token_type == "STRING_CONST", "Current token is not a string constant"
        return self.__string_val

    def is_operation(self):
        return self.__token_type == "SYMBOL" and self.symbol in self.OPERATIONS

    def lookBack(self):
        if self.pointer > 0:
            self.pointer -= 1

## EXTRA - NEEDED ?
# def hasComments(self) -> bool:
#     """
#     Check if the line we took from the jack file has a comments.
#     """
