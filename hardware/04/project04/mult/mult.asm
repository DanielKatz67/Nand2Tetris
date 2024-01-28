//I will add to RAM[R2]=0,  RAM[R1],  RAM[R0] times :
//RAM[R2]=0
//LOOP:
//   if(RAM[R0] == 0) goto END 
//   RAM[R2] += RAM[R1]
//   RAM[R0] -- 
//   goto LOOP
//END

//RAM[R2]=0
    @R2
    M=0
(LOOP)
//if(RAM[R0] == 0) goto END 
    @R0
    D=M
    @END
    D;JLE
//RAM[R2] += RAM[R1]
    @R2
    D=M
    @R1
    D=D+M
    @R2
    M=D
//RAM[R0] -- 
    @R0
    M=M-1
//goto LOOP
    @LOOP
    0;JMP
(END)
    @END
    0;JMP