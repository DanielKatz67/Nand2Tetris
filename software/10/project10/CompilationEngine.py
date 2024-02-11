import JackTokenizer

class CompilationEngine:
    def __init__(self, input_file_path, output_file_path):
        """
        Creates a new compilation engine with the given input and output.
        the next routine called (by the JackAnalyzer module) must be compileClass.
        """
        self.tokenizer = JackTokenizer.JackTokenizer(input_file_path)
        self.output_file_path = output_file_path
        self.first_routine = True

    def write(self, content):
        with open(self.output_file_path, 'a') as file:
            file.write(content + '\n')

    def remove_last_newline(self):
        with open(self.output_file_path, 'r+') as file:
            file.seek(0, 2)  # Move to the end of the file
            pos = file.tell() - 1  # Find the position of the last character
            while pos > 0 and file.seek(pos):
                if file.read(1) == '\n':
                    pos -= 1
                else:
                    break
            file.seek(pos + 1)
            file.truncate()

    def compileClass(self):
        """
        Compiles a complete class.
        """
        self.tokenizer.advance()
        self.write("<class>")
        self.write("<keyword> class </keyword>")
        self.tokenizer.advance()
        # self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
        self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
        self.tokenizer.advance()
        self.write("<symbol> { </symbol>")
        self.compileClassVarDec()
        self.compileSubRoutine()
        self.write("<symbol> } </symbol>")
        self.write("</class>")

    def compileClassVarDec(self):
        """
        Compiles a static variable declaration, or a field declaration.
        """
        self.tokenizer.advance()
        while self.tokenizer.keyWord in {"static", "field"}:
            self.write("<classVarDec>")
            self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
            self.tokenizer.advance()

            if self.tokenizer.tokenType == "IDENTIFIER":
                self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
            elif self.tokenizer.tokenType == "KEYWORD":
                self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
            self.tokenizer.advance()
            self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
            self.tokenizer.advance()

            if self.tokenizer.symbol == ',':
                self.write("<symbol> , </symbol>")
                self.tokenizer.advance()
                self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
                self.tokenizer.advance()

            self.write("<symbol> ; </symbol>")
            self.tokenizer.advance()
            self.write("</classVarDec>")

        if self.tokenizer.keyWord in ["function", "method", "constructor"]:
            self.tokenizer.lookBack()

    def compileSubRoutine(self):
        """
        Compiles a complete method, function or constructor.
        """
        moreSubRoutines = False
        self.tokenizer.advance()

        if self.tokenizer.symbol == "}" and self.tokenizer.tokenType == "SYMBOL":
            return

        if self.first_routine and self.tokenizer.keyWord in ["function", "method","constructor"]:
            self.first_routine = False
            self.write("<subroutineDec>")
            moreSubRoutines = True

        if self.tokenizer.keyWord in ["function", "method", "constructor"]:
            moreSubRoutines = True
            self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
            self.tokenizer.advance()

        if self.tokenizer.tokenType == "IDENTIFIER":
            self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
            self.tokenizer.advance()

        elif self.tokenizer.tokenType == "KEYWORD":
            self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
            self.tokenizer.advance()

        if self.tokenizer.tokenType == "IDENTIFIER":
            self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
            self.tokenizer.advance()

        if self.tokenizer.symbol == "(":
            self.write("<symbol> ( </symbol>")
            self.write("<parameterList>")
            self.compileParameterList()
            self.write("</parameterList>")
            self.write("<symbol> ) </symbol>")

        self.compileSubroutineBody()
        if moreSubRoutines:
            self.write("</subroutineBody>")
            self.write("</subroutineDec>")
            self.first_routine = True
        self.compileSubRoutine()

    def compileParameterList(self):
        """
         Compiles a (possibly empty) parameter list.
         Doesn't handle the enclosing parentheses tokens ( and ).
        """
        self.tokenizer.advance()
        while not (self.tokenizer.tokenType == "SYMBOL" and self.tokenizer.symbol == ')'):
            if self.tokenizer.tokenType == "IDENTIFIER":
                self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")

            elif self.tokenizer.tokenType == "KEYWORD":
                self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")

            elif self.tokenizer.tokenType == "SYMBOL" and self.tokenizer.symbol == ',':
                self.write("<symbol> , </symbol>")

            self.tokenizer.advance()

    def compileSubroutineBody(self):
        """
        Compiles a subroutine's body.
        """
        self.tokenizer.advance()
        if self.tokenizer.symbol == "{":
            self.write("<subroutineBody>")
            self.write("<symbol> { </symbol>")
            self.tokenizer.advance()

        while self.tokenizer.keyWord == "var" and self.tokenizer.tokenType == "KEYWORD":
            self.tokenizer.lookBack()
            self.compileVarDec()

        self.write("<statements>")
        self.compileStatements()
        self.write("</statements>")
        self.write("<symbol> } </symbol>")

    def compileVarDec(self):
        """
        Compiles a var declaration.
        """
        self.tokenizer.advance()
        self.write("<varDec>")

        if self.tokenizer.keyWord == "var" and self.tokenizer.tokenType == "KEYWORD":
            self.write(f"<keyword> var </keyword>")
            self.tokenizer.advance()

        if self.tokenizer.tokenType == "IDENTIFIER":
            self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
        elif self.tokenizer.tokenType == "KEYWORD":
            self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
        self.tokenizer.advance()

        if self.tokenizer.tokenType == "IDENTIFIER":
            self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
            self.tokenizer.advance()

        if self.tokenizer.symbol == ',' and self.tokenizer.tokenType == "SYMBOL":
            self.write("<symbol> , </symbol>")
            self.tokenizer.advance()
            self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
            self.tokenizer.advance()

        if self.tokenizer.symbol == ';' and self.tokenizer.tokenType == "SYMBOL":
            self.write("<symbol> ; </symbol>")
            self.tokenizer.advance()

        self.write("</varDec>")

    def compileStatements(self):
        """
        Compiles a sequence of statements.
        Doesn't handle the enclosing curly bracket tokens { and }.
        """
        if self.tokenizer.symbol=="}" and self.tokenizer.tokenType == "SYMBOL":
            return

        if self.tokenizer.keyWord == "do" and self.tokenizer.tokenType == "KEYWORD":
            self.write("<doStatement>")
            self.compileDo()
            self.write("</doStatement>")
        elif self.tokenizer.keyWord == "let" and self.tokenizer.tokenType == "KEYWORD":
            self.write("<letStatement>")
            self.compileLet()
            self.write("</letStatement>")
        elif self.tokenizer.keyWord == "if" and self.tokenizer.tokenType == "KEYWORD":
            self.write("<ifStatement>")
            self.compileIf()
            self.write("</ifStatement>")
        elif self.tokenizer.keyWord == "while" and self.tokenizer.tokenType == "KEYWORD":
            self.write("<whileStatement>")
            self.compileWhile()
            self.write("</whileStatement>")
        elif self.tokenizer.keyWord == "return" and self.tokenizer.tokenType == "KEYWORD":
            self.write("<returnStatement>")
            self.compileReturn()
            self.write("</returnStatement>")

        self.tokenizer.advance()
        self.compileStatements()

    def compileLet(self):
        """
        Compiles a let statement.
        """
        self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
        self.tokenizer.advance()  # Skip 'let'
        self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
        self.tokenizer.advance()  # Skip variable name

        if self.tokenizer.symbol == '[' and self.tokenizer.tokenType == "SYMBOL":
            self.write("<symbol> [ </symbol>")
            self.compileExpression()
            self.tokenizer.advance()
            if self.tokenizer.symbol == ']' and self.tokenizer.tokenType == "SYMBOL":
                self.write("<symbol> ] </symbol>")
            self.tokenizer.advance()  # Consume ']'

        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
        self.compileExpression()
        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
        self.tokenizer.advance()  # Consume ';'

    def compileIf(self):
        """
        Compiles an if statement, possibly with a trailing else clause.
        """
        self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
        self.tokenizer.advance()  # Skip 'if'
        self.write("<symbol> ( </symbol>")
        self.compileExpression()
        self.write("<symbol> ) </symbol>")
        self.tokenizer.advance()  # Consume ')'
        self.write("<symbol> { </symbol>")
        self.tokenizer.advance()
        self.write("<statements>")
        self.compileStatements()
        self.write("</statements>")
        self.write("<symbol> } </symbol>")
        self.tokenizer.advance()  # Consume '}'

        if self.tokenizer.keyWord == "else" and self.tokenizer.tokenType == "KEYWORD":
            self.write("<keyword> else </keyword>")
            self.tokenizer.advance()  # Skip 'else'
            self.write("<symbol> { </symbol>")
            self.tokenizer.advance()
            self.write("<statements>")
            self.compileStatements()
            self.write("</statements>")
            self.write("<symbol> } </symbol>")
            # self.tokenizer.advance()  # Consume '}'
        else:
            self.tokenizer.lookBack()

    def compileWhile(self):
        """
        Compiles a while statement.
        """
        self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
        self.tokenizer.advance()  # Skip 'while'
        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
        self.compileExpression()
        self.tokenizer.advance()

        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
        self.tokenizer.advance()  # Consume ')'

        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
        self.write("<statements>")
        self.compileStatements()
        self.write("</statements>")
        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
        # self.tokenizer.advance()  # Consume '}'

    def compileDo(self):
        """
        Compiles a do statement.
        """
        if self.tokenizer.keyWord == "do":
            self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
        self.compileCall()
        self.tokenizer.advance()  # Consume ';'
        self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")

    def compileCall(self):
        self.tokenizer.advance()
        self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
        self.tokenizer.advance()  # Skip identifier or class/var name

        if self.tokenizer.tokenType == "SYMBOL":
            self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
            if self.tokenizer.symbol == '.':
                self.tokenizer.advance()  # Skip '.'
                self.write(f"<identifier> {self.tokenizer.identifier} </identifier>")
                self.tokenizer.advance()  # Skip subroutine name
                self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
                self.write("<expressionList>")
                self.compileExpressionList()
                self.write("</expressionList>")
                self.tokenizer.advance()
                self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")

            elif self.tokenizer.symbol == '(':
                self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
                self.write("<expressionList>")
                self.compileExpressionList()
                self.write("</expressionList>")
                self.tokenizer.advance()
                self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")

    def compileReturn(self):
        """
        Compiles a return statement.
        """
        self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")
        self.tokenizer.advance()  # Skip 'return'

        if not (self.tokenizer.symbol == ';' and self.tokenizer.tokenType == "SYMBOL"):
            self.tokenizer.lookBack()
            self.compileExpression()
        if self.tokenizer.symbol == ';' and self.tokenizer.tokenType == "SYMBOL":
            self.write("<symbol> ; </symbol>")

    def compileExpression(self):
        """
        Compiles an expression.
        """
        self.write("<expression>")
        self.compileTerm()
        self.tokenizer.advance()
        while self.tokenizer.is_operation() and self.tokenizer.tokenType == "SYMBOL":
            # Handle special symbols with XML escape sequences
            symbol = self.tokenizer.symbol
            if symbol == '<':
                self.write("<symbol> &lt; </symbol>")
            elif symbol == '>':
                self.write("<symbol> &gt; </symbol>")
            elif symbol == '&':
                self.write("<symbol> &amp; </symbol>")
            else:
                self.write(f"<symbol> {symbol} </symbol>")

            self.compileTerm()
            self.tokenizer.advance()

        self.tokenizer.lookBack()
        self.write("</expression>")

    def compileTerm(self):
        """
        Compiles a term. If the current token is an identifier, the routine must
        resolve it into a variable,an array entry, or a subroutine call.
        A single lookahead token, which may be [, (, or ., suffices to distinguish
        between the possibilities.
        Any other token is not part of this term and should not be advanced over.
        *** The only one which lookahead ***
        """
        self.write("<term>")
        self.tokenizer.advance()
        if self.tokenizer.tokenType == "IDENTIFIER":
            identifier = self.tokenizer.identifier
            self.tokenizer.advance()  # Lookahead to check the next symbol
            if self.tokenizer.symbol == '[' and self.tokenizer.tokenType == "SYMBOL":
                self.write(f"<identifier> {identifier} </identifier>")
                self.write("<symbol> [ </symbol>")
                self.compileExpression()
                self.tokenizer.advance()
                self.write("<symbol> ] </symbol>")
            elif self.tokenizer.symbol in ['(', '.'] and self.tokenizer.tokenType == "SYMBOL":
                # Roll back to identifier as compile_call will handle it
                # Go back to the identifier
                self.tokenizer.lookBack()
                self.tokenizer.lookBack()
                self.compileCall()
            else:
                self.write(f"<identifier> {identifier} </identifier>")
                self.tokenizer.lookBack()  # Rollback the lookahead
        elif self.tokenizer.tokenType == "INT_CONST":
            self.write(f"<integerConstant> {self.tokenizer.intVal} </integerConstant>")

        elif self.tokenizer.tokenType == "STRING_CONST":
            self.write(f"<stringConstant> {self.tokenizer.stringVal} </stringConstant>")

        elif (self.tokenizer.tokenType == "KEYWORD" and
              self.tokenizer.keyWord in ["this", "null", "true", "false"]):
            self.write(f"<keyword> {self.tokenizer.keyWord} </keyword>")

        elif self.tokenizer.symbol == '(' and self.tokenizer.tokenType == "SYMBOL":
            self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
            self.compileExpression()
            self.tokenizer.advance()
            self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")

        elif self.tokenizer.symbol in ['-', '~'] and self.tokenizer.tokenType == "SYMBOL":
            self.write(f"<symbol> {self.tokenizer.symbol} </symbol>")
            self.compileTerm()

        self.write("</term>")

    def compileExpressionList(self):
        """
        Compiles a list of expressions.
        """
        self.tokenizer.advance()

        if self.tokenizer.symbol == ')' and self.tokenizer.tokenType == "SYMBOL":
            self.tokenizer.lookBack()
        else:
            self.tokenizer.lookBack()
            self.compileExpression()

        self.tokenizer.advance()
        while self.tokenizer.symbol == ',' and self.tokenizer.tokenType == "SYMBOL":
            self.write("<symbol> , </symbol>")
            self.compileExpression()
            self.tokenizer.advance()
        self.tokenizer.lookBack()







