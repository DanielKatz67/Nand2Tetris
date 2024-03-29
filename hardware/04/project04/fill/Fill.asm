// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen
// by writing 'black' in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen by writing
// 'white' in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//// Replace this comment with your code.

// counter of words of 16 bits that represents the screen
 (START)   
    @8191
    D=A    
    @counter
    M=D

(LOOP)
    @KBD
    D=M
//black screen if key is pressed
    @BLACK 	
    D;JNE
//else white screen
    @WHITE 	
    D;JEQ

(BLACK)
    @counter
    D=M
    @SCREEN
    A=A+D
    M=-1
    @NEXT
    0;JMP
(WHITE)
    @counter
    D=M
    @SCREEN
    A=A+D
    M=0
    @NEXT
    0;JMP

(NEXT)
//RAM[counter] -- 
    @counter
    M=M-1
// if RAM[counter]=-1 : we finish to change all the screen
    @counter
    D=M+1
    @START
    D;JEQ
// else: return to LOOP
    @LOOP
    0;JMP


