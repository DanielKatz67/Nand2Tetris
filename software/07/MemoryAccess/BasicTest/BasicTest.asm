//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push constant 10
   @10
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop local 0
   @LCL
   D=M
   @0
   D=D+A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push constant 21
   @21
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 22
   @22
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop argument 2
   @ARG
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
//pop argument 1
   @ARG
   D=M
   @1
   D=D+A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push constant 36
   @36
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop this 6
   @THIS
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
//push constant 42
   @42
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 45
   @45
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 5
   @THAT
   D=M
   @5
   D=D+A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//pop that 2
   @THAT
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
//push constant 510
   @510
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop temp 6
   @R5
   D=M
   @11
   D=D+A
   @R15
   M=D
   @SP
   AM=M-1
   D=M
   @R15
   A=M
   M=D
//push local 0
//D=RAM[i+LCLPointer]
   @LCL
   D=M
   @0
   A=D+A
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push that 5
//D=RAM[i+THATPointer]
   @THAT
   D=M
   @5
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
//push argument 1
//D=RAM[i+ARGPointer]
   @ARG
   D=M
   @1
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
//push this 6
//D=RAM[i+THISPointer]
   @THIS
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
//push this 6
//D=RAM[i+THISPointer]
   @THIS
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
//sub
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
//push temp 6
//D=RAM[i+R5Pointer]
   @R5
   D=M
   @11
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
