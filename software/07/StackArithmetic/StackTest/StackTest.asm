//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//eq
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @EQ_0_CONDITION_IS_FALSE
   D;JNE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @EQ_0_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(EQ_0_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(EQ_0_CONDITION_IS_TRUE)
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 16
   @16
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//eq
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @EQ_1_CONDITION_IS_FALSE
   D;JNE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @EQ_1_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(EQ_1_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(EQ_1_CONDITION_IS_TRUE)
//push constant 16
   @16
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//eq
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @EQ_2_CONDITION_IS_FALSE
   D;JNE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @EQ_2_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(EQ_2_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(EQ_2_CONDITION_IS_TRUE)
//push constant 892
   @892
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//lt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @LT_3_CONDITION_IS_FALSE
   D;JGE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @LT_3_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(LT_3_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(LT_3_CONDITION_IS_TRUE)
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 892
   @892
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//lt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @LT_4_CONDITION_IS_FALSE
   D;JGE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @LT_4_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(LT_4_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(LT_4_CONDITION_IS_TRUE)
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//lt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @LT_5_CONDITION_IS_FALSE
   D;JGE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @LT_5_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(LT_5_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(LT_5_CONDITION_IS_TRUE)
//push constant 32767
   @32767
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//gt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @GT_6_CONDITION_IS_FALSE
   D;JLE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @GT_6_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(GT_6_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(GT_6_CONDITION_IS_TRUE)
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 32767
   @32767
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//gt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @GT_7_CONDITION_IS_FALSE
   D;JLE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @GT_7_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(GT_7_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(GT_7_CONDITION_IS_TRUE)
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//gt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @GT_8_CONDITION_IS_FALSE
   D;JLE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @GT_8_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(GT_8_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(GT_8_CONDITION_IS_TRUE)
//push constant 57
   @57
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 31
   @31
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 53
   @53
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
//push constant 112
   @112
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
//neg
   D=0
   @SP
   A=M-1
   M=D-M
//and
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M&D
//push constant 82
   @82
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//or
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M|D
//not
   @SP
   A=M-1
   M=!M
//SetSP = 256
   @256
   D=A
   @SP
   M=D
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//eq
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @EQ_0_CONDITION_IS_FALSE
   D;JNE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @EQ_0_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(EQ_0_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(EQ_0_CONDITION_IS_TRUE)
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 16
   @16
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//eq
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @EQ_1_CONDITION_IS_FALSE
   D;JNE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @EQ_1_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(EQ_1_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(EQ_1_CONDITION_IS_TRUE)
//push constant 16
   @16
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 17
   @17
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//eq
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @EQ_2_CONDITION_IS_FALSE
   D;JNE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @EQ_2_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(EQ_2_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(EQ_2_CONDITION_IS_TRUE)
//push constant 892
   @892
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//lt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @LT_3_CONDITION_IS_FALSE
   D;JGE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @LT_3_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(LT_3_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(LT_3_CONDITION_IS_TRUE)
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 892
   @892
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//lt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @LT_4_CONDITION_IS_FALSE
   D;JGE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @LT_4_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(LT_4_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(LT_4_CONDITION_IS_TRUE)
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 891
   @891
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//lt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @LT_5_CONDITION_IS_FALSE
   D;JGE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @LT_5_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(LT_5_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(LT_5_CONDITION_IS_TRUE)
//push constant 32767
   @32767
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//gt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @GT_6_CONDITION_IS_FALSE
   D;JLE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @GT_6_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(GT_6_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(GT_6_CONDITION_IS_TRUE)
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 32767
   @32767
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//gt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @GT_7_CONDITION_IS_FALSE
   D;JLE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @GT_7_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(GT_7_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(GT_7_CONDITION_IS_TRUE)
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 32766
   @32766
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//gt
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   D=M-D
//Comparison and conditional jump
   @GT_8_CONDITION_IS_FALSE
   D;JLE
//Setting the result for true condition. -1 is true
   @SP
   A=M-1
   M=-1
   @GT_8_CONDITION_IS_TRUE
   0;JMP
//Handling false condition. 0 is false
(GT_8_CONDITION_IS_FALSE)
   @SP
   A=M-1
   M=0
(GT_8_CONDITION_IS_TRUE)
//push constant 57
   @57
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 31
   @31
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//push constant 53
   @53
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
//push constant 112
   @112
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
//neg
   D=0
   @SP
   A=M-1
   M=D-M
//and
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M&D
//push constant 82
   @82
   D=A
   @SP
   A=M
   M=D
//SP++
   @SP
   M=M+1
//or
//stack manipulation
   @SP
   AM=M-1
   D=M
   A=A-1
   M=M|D
//not
   @SP
   A=M-1
   M=!M
