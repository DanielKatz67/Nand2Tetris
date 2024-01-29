//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push constant 3030
   @3030
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop pointer 0
   @THIS
   D=A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push constant 3040
   @3040
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop pointer 1
   @THAT
   D=A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push constant 32
   @32
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop this 2
   @THIS
   D=M
   @2
   D=D+A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push constant 46
   @46
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 6
   @THAT
   D=M
   @6
   D=D+A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push pointer 0
//D=RAM[i+THISPointer]
   @THIS
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push pointer 1
//D=RAM[i+THATPointer]
   @THAT
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
//push this 2
//D=RAM[i+THISPointer]
   @THIS
   D=M
   @2
   A=D+A
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
//push that 6
//D=RAM[i+THATPointer]
   @THAT
   D=M
   @6
   A=D+A
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
