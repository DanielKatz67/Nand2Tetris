//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push return address
   @Sys.init$ret.1
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//D=RAM[i+LCLPointer]
   @LCL
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//D=RAM[i+ARGPointer]
   @ARG
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
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
//ARG = SP - 5 - nArgs
   @SP
   D=M
   @5
   D=D-A
   @0
   D=D-A
   @ARG
   M=D
//LCL = SP
   @SP
   D=M
   @LCL
   M=D
//goto functionName
   @Sys.init
   0;JMP
(Sys.init$ret.1)
//push constant 0
   @0
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop local 0         // sum = 0
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
//label LOOP
BasicLoop$LOOP)
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//add
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M+D
//pop local 0	        // sum = sum + n
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
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 1
   @1
   D=A
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
//pop argument 0      // n--
   @ARG
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
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//if-goto LOOP        // if n > 0, goto LOOP
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
//jump if true (if not false=0)
   @LOOP
   D;JNE
//push local 0        // else, pushes sum to the stack's top
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
//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push return address
   @Sys.init$ret.1
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//D=RAM[i+LCLPointer]
   @LCL
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//D=RAM[i+ARGPointer]
   @ARG
   D=M

//RAM[SP]=D
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
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
//ARG = SP - 5 - nArgs
   @SP
   D=M
   @5
   D=D-A
   @0
   D=D-A
   @ARG
   M=D
//LCL = SP
   @SP
   D=M
   @LCL
   M=D
//goto functionName
   @Sys.init
   0;JMP
(Sys.init$ret.1)
//push argument 1         // sets THAT, the base address of the
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
//pop pointer 1           // that segment, to argument[1]
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
//push constant 0         // sets the series' first and second
   @0
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 0              // elements to 0 and 1, respectively
   @THAT
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
//push constant 1
   @1
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 1
   @THAT
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
//push argument 0         // sets n, the number of remaining elements
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 2         // to be computed to argument[0] minus 2,
   @2
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//sub                     // since 2 elements were already computed.
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
//pop argument 0
   @ARG
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
//label LOOP
FibonacciSeries$LOOP)
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//if-goto COMPUTE_ELEMENT // if n > 0, goto COMPUTE_ELEMENT
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
//jump if true (if not false=0)
   @COMPUTE_ELEMENT
   D;JNE
//goto END                // otherwise, goto END
   @END
   0;JMP
//label COMPUTE_ELEMENT
FibonacciSeries$COMPUTE_ELEMENT)
//push that 0
//D=RAM[i+THATPointer]
   @THAT
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
//push that 1
//D=RAM[i+THATPointer]
   @THAT
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
//add
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M+D
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
//push constant 1
   @1
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
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 1
   @1
   D=A
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
//pop argument 0
   @ARG
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
//goto LOOP
   @LOOP
   0;JMP
//label END
FibonacciSeries$END)
//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push argument 1         // sets THAT, the base address of the
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
//pop pointer 1           // that segment, to argument[1]
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
//push constant 0         // sets the series' first and second
   @0
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 0              // elements to 0 and 1, respectively
   @THAT
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
//push constant 1
   @1
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 1
   @THAT
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
//push argument 0         // sets n, the number of remaining elements
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 2         // to be computed to argument[0] minus 2,
   @2
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//sub                     // since 2 elements were already computed.
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
//pop argument 0
   @ARG
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
//label LOOP
(FibonacciSeries$LOOP)
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//if-goto COMPUTE_ELEMENT // if n > 0, goto COMPUTE_ELEMENT
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
//jump if true (if not false=0)
   @FibonacciSeries$COMPUTE_ELEMENT
   D;JNE
//goto END                // otherwise, goto END
   @FibonacciSeries$END
   0;JMP
//label COMPUTE_ELEMENT
(FibonacciSeries$COMPUTE_ELEMENT)
//push that 0
//D=RAM[i+THATPointer]
   @THAT
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
//push that 1
//D=RAM[i+THATPointer]
   @THAT
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
//add
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M+D
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
//push constant 1
   @1
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
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 1
   @1
   D=A
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
//pop argument 0
   @ARG
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
//goto LOOP
   @FibonacciSeries$LOOP
   0;JMP
//label END
(FibonacciSeries$END)
//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push argument 1         // sets THAT, the base address of the
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
//pop pointer 1           // that segment, to argument[1]
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
//push constant 0         // sets the series' first and second
   @0
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 0              // elements to 0 and 1, respectively
   @THAT
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
//push constant 1
   @1
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 1
   @THAT
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
//push argument 0         // sets n, the number of remaining elements
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 2         // to be computed to argument[0] minus 2,
   @2
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//sub                     // since 2 elements were already computed.
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
//pop argument 0
   @ARG
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
//label LOOP
(FibonacciSeries$LOOP)
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//if-goto COMPUTE_ELEMENT // if n > 0, goto COMPUTE_ELEMENT
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
//jump if true (if not false=0)
   @FibonacciSeries$COMPUTE_ELEMENT
   D;JNE
//goto END                // otherwise, goto END
   @FibonacciSeries$END
   0;JMP
//label COMPUTE_ELEMENT
(FibonacciSeries$COMPUTE_ELEMENT)
//push that 0
//D=RAM[i+THATPointer]
   @THAT
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
//push that 1
//D=RAM[i+THATPointer]
   @THAT
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
//add
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M+D
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
//push constant 1
   @1
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
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 1
   @1
   D=A
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
//pop argument 0
   @ARG
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
//goto LOOP
   @FibonacciSeries$LOOP
   0;JMP
//label END
(FibonacciSeries$END)
//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push argument 1         // sets THAT, the base address of the
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
//pop pointer 1           // that segment, to argument[1]
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
//push constant 0         // sets the series' first and second
   @0
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 0              // elements to 0 and 1, respectively
   @THAT
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
//push constant 1
   @1
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//pop that 1
   @THAT
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
//push argument 0         // sets n, the number of remaining elements
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 2         // to be computed to argument[0] minus 2,
   @2
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//sub                     // since 2 elements were already computed.
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M-D
//pop argument 0
   @ARG
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
//label LOOP
(FibonacciSeries$LOOP)
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//if-goto COMPUTE_ELEMENT // if n > 0, goto COMPUTE_ELEMENT
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
//jump if true (if not false=0)
   @FibonacciSeries$COMPUTE_ELEMENT
   D;JNE
//goto END                // otherwise, goto END
   @FibonacciSeries$END
   0;JMP
//label COMPUTE_ELEMENT
(FibonacciSeries$COMPUTE_ELEMENT)
//push that 0
//D=RAM[i+THATPointer]
   @THAT
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
//push that 1
//D=RAM[i+THATPointer]
   @THAT
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
//add
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M+D
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
//push constant 1
   @1
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
//push argument 0
//D=RAM[i+ARGPointer]
   @ARG
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
//push constant 1
   @1
   D=A
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
//pop argument 0
   @ARG
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
//goto LOOP
   @FibonacciSeries$LOOP
   0;JMP
//label END
(FibonacciSeries$END)
