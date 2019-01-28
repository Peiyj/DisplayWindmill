/*
 * Filename: displayWindmill.s
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Desciption: This assembly module will be a translation of the C code
 * displayWindmill.c and should have the same functionality as 
 * displayWindmill.c
 * Date: Oct 21, 2018
 * Source of Help: Tutor, discussion 3 worksheet
 */

 @ Raspberry Pi
        .cpu    cortex-a53                          @ Version of the Pis
        .syntax unified                             @ Modern syntax
 
 @ Useful source code constants                     
        .equ    FP_OFFSET, 12                       @ (saved register - 1) * 4
        
        //these are param vars
        .equ    PARAM_SPACE,16                      @ alocate 16 bytes 
        .equ    PARAM1_OFFSET, -16                  @ 1st formal param
        .equ    PARAM2_OFFSET, -20                  @ 2nd formal param
        .equ    PARAM3_OFFSET, -24                  @ 3rd formal param
        .equ    PARAM4_OFFSET, -28                  @ 4th formal param
        

 @ define constants
        .equ    TWO, 2                              @ store 2
        .equ    ZERO, 0                             @ store 0
        .equ    newline, '\n'                       @ store print new line

 @ Text region
        .global displayWindmill                     @ specify as global
        .text
        .align  2                                   @ align to 4 bytes


/*
 * Function Header: displayWindmill()
 * Function Prototype: void displayWindmill( long height, char border, char
 *                      filler, char windmill );
 * Description: This function will print out individual characters (via calls to
 * printChar() and printLine()) to display the windmill pattern based on the
 * user-supplied values.
 * Parameters: height: the height
               border: border char
               filler: filler char
               windmill: windmill char
 * Side Effects: none
 * return values: void
 * Registers used:
 * r0: -- arg 1 -- height
 * r1: -- arg 2 -- border
 * r2: -- arg 3 -- filler
 * r3: -- arg 4 -- windmill
 * r4:temp var
 * r5:index
 */

 displayWindmill:
 @ Standard prologue:
        push    {r4-r5, fp, lr}                     @ push 4 regs
        add     fp,sp,FP_OFFSET                     @ set fp to the base

        @ Allocate space for param 
        
        sub     sp,sp,PARAM_SPACE                   @ allocate space

        str     r0, [fp, PARAM1_OFFSET]             @ store r0: height
        str     r1, [fp, PARAM2_OFFSET]             @ store r1: border
        str     r2, [fp, PARAM3_OFFSET]             @ store r2: filler
        str     r3, [fp, PARAM4_OFFSET]             @ store r3: windmill

        //Print new line
        ldr     r0, [fp, PARAM1_OFFSET]             @ load r0
        mov     r0, newline                         @ move newline to r0
        bl      printChar                           @ print new line

        //first for loop
        mov     r5, 0                               @ move 0 to index r5

        ldr     r0, [fp,PARAM1_OFFSET]              @ load height
        add     r0,r0,2                             @ height = height + 2
        cmp     r5,r0                               @ compare
        //i >= height+2
        bge     end_loop                            @ opposite logic to skip
 loop:
        //loop body
        ldr     r1, [fp, PARAM2_OFFSET]             @ load border
        mov     r0,r1                               @ move border to r0
        bl      printChar                           @ call printChar

        add     r5,r5,1                             @ i++

        ldr     r0, [fp, PARAM1_OFFSET]             @ load height
        add     r0,r0,TWO                           @ height = height + 2

        cmp     r5, r0                              @ compare i to height +2
        blt     loop                                @ positive logic to BACK
 end_loop:
        //Print new line
        ldr     r0, [fp, PARAM1_OFFSET]             @ load r0
        mov     r0, newline                         @ move newline to r0
        bl      printChar                           @ print new line

        //second for loop
        mov     r5, 0                               @ move 0 to index r5

        ldr     r0, [fp,PARAM1_OFFSET]              @ load height
        cmp     r5,r0                               @ compare
        //i >= height
        bge     end_loop2                           @ opposite logic to skip
 loop2:
        //loop body
        //Print border
        ldr     r1, [fp, PARAM2_OFFSET]             @ load border
        mov     r0,r1                               @ move border to r0
        bl      printChar                           @ call printChar
        //Print Line
        mov     r0, r5                              @ r0 = i
        ldr     r1, [fp, PARAM1_OFFSET]             @ r1 = height
        ldr     r2, [fp, PARAM4_OFFSET]             @ r2 = windmill
        ldr     r3, [fp, PARAM3_OFFSET]             @ r3 = filler
        
        bl      printLine                           @ call printline
        //Print border
        ldr     r1, [fp, PARAM2_OFFSET]             @ load border
        mov     r0,r1                               @ move border to r0
        bl      printChar                           @ call printChar
        
        //Print new line
        ldr     r0, [fp, PARAM1_OFFSET]             @ load r0
        mov     r0, newline                         @ move newline to r0
        bl      printChar                           @ print new line

        //Compare condition
        add     r5,r5,1                             @ i++
        ldr     r0, [fp, PARAM1_OFFSET]             @ load height

        cmp     r5, r0                              @ compare i to height 
        blt     loop2                               @ positive logic to BACK
 
 end_loop2:
       //third for loop
        mov     r5, 0                               @ move 0 to index r5
        ldr     r0, [fp,PARAM1_OFFSET]              @ load height
        add     r0,r0,2                             @ height = height + 2
        cmp     r5,r0                               @ compare
        //i >= height+2
        bge     end_loop3                           @ opposite logic to skip
 loop3:
        //loop body

        //Print border
        ldr     r1, [fp, PARAM2_OFFSET]             @ load border
        mov     r0,r1                               @ move border to r0
        bl      printChar                           @ call printChar

        add     r5,r5,1                             @ i++
        ldr     r0, [fp, PARAM1_OFFSET]             @ load height
        add     r0,r0,TWO                           @ height = height + 2

        cmp     r5, r0                              @ compare i to height +2
        blt     loop3                               @ positive logic to BACK
 
 end_loop3:
        
        //Print new line
        ldr     r0, [fp, PARAM1_OFFSET]             @ load r0
        mov     r0, newline                         @ move newline to r0
        bl      printChar                           @ print new linei
        //Print new line
        ldr     r0, [fp, PARAM1_OFFSET]             @ load r0
        mov     r0, newline                         @ move newline to r0
        bl      printChar                           @ print new linei

        sub     sp,fp,FP_OFFSET                     @ deallocates vars
        pop     {r4-r5,fp, pc}                      @ restore caller's fp


