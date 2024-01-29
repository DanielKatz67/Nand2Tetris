//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push constant 111
   @111
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 333
   @333
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 888
   @888
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop static 8
   @24
   D=A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//pop static 3
   @19
   D=A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//pop static 1
   @17
   D=A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push static 3
//D=RAM[i+19Pointer]
   @19
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push static 1
//D=RAM[i+17Pointer]
   @17
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//sub
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
//push static 8
//D=RAM[i+24Pointer]
   @24
   D=M

//RAM[SP]=D
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
