//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push constant 7
   @7
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 8
   @8
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//add
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M+D
