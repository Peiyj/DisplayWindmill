/*
 * Filename: printLine.s
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: This assembly module will be a translation of the C code
 * printLine.c and should have the same functionality as printLine.c
 * Date: Oct 21, 2018
 * Source of help: Tutor, discussion 3 worksheet
 */

 @ Raspberry Pi directives
        .cpu    cortex-a53                      @ Version of the Pis
        .syntax unified                         @ Mordern syntax
 
 @ Useful source code constants
        .equ    FP_OFFSET,12                    @(Saved register - 1) * 4
        
        //these are the local variables
        .equ    LOCAL_VAR_SPACE,24              @ Total number of local var
        .equ    HalfHeight, -16                 @ Local var HalfHeight
        .equ    CLS, -20                        @ Local var countLeftStart
        .equ    CRS, -24                        @ Local var countRightStart
        .equ    start, -28                      @ Local var d offset
        .equ    end, -32                        @ Local var e offset
        .equ    center, -36                     @ Local var f offset

        //these are the param variables
        .equ    PARAM_SPACE, 16                 @ Allocate 16 bytes
        .equ    PARAM1_OFFSET, -40              @ 1st formal param
        .equ    PARAM2_OFFSET, -44              @ 2nd formal param
        .equ    PARAM3_OFFSET, -48              @ 3rd formal param
        .equ    PARAM4_OFFSET, -52              @ 4th formal param
 @ Define constants
        .equ    HALF_DIVISOR, 2                 @ store 2
        .equ    ZERO, 0                         @ store 0
        .equ    ONE, 1                          @ store 1
        

 @ Text region
        .global printLine                       @ Specify it as global
        .text
        .align 2                                @ align to 4 bytes

/*
 * Function Header: printLine()
 * Function Prototype: void printLine( long row, long width, char windmill, char
 *           filler)
 * Description: returns the line pattern
 * Parameters: row - the value of row
 *             width - the value of width
 *             windmill - the character windmill
 *             filler - the charater filler
 * Side Effects: stderr
 * Return values: void
 * Registers used:
 * r0 - arg 1 -- row
 * r1 - arg 2 -- width
 * r2 - arg 3 -- windmill
 * r3 - arg 4 -- filler
 * r4 -use to store temp/intermediate values
 * r5 -use to store index
 */

 printLine:
 @ Standard prologue:
        push    {r4-r5, fp, lr}                 @ push 4 regs
        add     fp,sp,FP_OFFSET                 @ set fp to the base
        
        @ Allocate space for local variables
        sub     sp,sp, LOCAL_VAR_SPACE          @ allocate local space
        @ Allocate space for the incoming formal parameters (divisible by 8)
        sub     sp,sp, PARAM_SPACE              @ allocate space for param vars
        
        str     r0, [fp, PARAM1_OFFSET]         @ store r0: row
        str     r1, [fp, PARAM2_OFFSET]         @ store r1: width
        str     r2, [fp, PARAM3_OFFSET]         @ store r2: windmill
        str     r3, [fp, PARAM4_OFFSET]         @ store r3: filler
        
        //use r4 to store halfHeight
        mov     r0, HALF_DIVISOR                @ temp store r0 as 2
        ldr     r1, [fp, PARAM2_OFFSET]         @ load r1 as width
        sdiv    r4, r1, r0                      @ halfHeight = width/2
        str     r4, [fp, HalfHeight]            @ store r4 to HalfHeight

        //if row >= halfHeight
        ldr     r0, [fp, PARAM1_OFFSET]         @ get current value of row
        ldr     r4, [fp, HalfHeight]            @ get current value of midheight
        cmp     r0, r4                          @ row >= HalfHeight
        bge     else_if                         @ opposite logic to branch
        //inside first if statement:

        //cls = row + 1
        ldr     r4, [fp, CLS]                   @ load cls
        add     r4,r0,ONE                       @ cls = row + 1
        str     r4, [fp,CLS]                    @ store it to the stack 
        
        //crs = halfheight - row
        ldr     r0, [fp, PARAM1_OFFSET]         @ get current value of row
        ldr     r4, [fp, HalfHeight]            @ get current value of midheight
        sub     r4, r4, r0                      @ crs = halfheight - row
        str     r4, [fp,CRS]                    @ store it on the stack
        
        //start = windmill
        ldr     r2, [fp, PARAM3_OFFSET]         @ load windmill
        str     r2, [fp, start]                 @ store to startchar
        //end = filler
        ldr     r3, [fp, PARAM4_OFFSET]         @ load filler
        str     r3, [fp, end]                   @ store to endchar
        //center = filler
        ldr     r3, [fp, PARAM4_OFFSET]         @ load filler
        str     r3, [fp, center]                @ store to center
        b       end_if                          @ branch out of if

  else_if:
        //if row != halfheight
     
        ldr     r0, [fp, PARAM1_OFFSET]         @ get current row
        ldr     r4, [fp, HalfHeight]            @ get current halfheight

        //now compare
        cmp     r0,r4                           @ compare the two values
        bne     else                            @ branch to not equal

        //else if statements

        //cls = halfheight
        ldr     r4, [fp, HalfHeight]            @ get current halfheight
        str     r4, [fp, CLS]                   @ store halfheight to cls 
        //crs = halfheight
        ldr     r4, [fp, HalfHeight]            @ get current halfheight
        str     r4, [fp, CRS]                   @ store halfhieght to crs
        //start = filler
        ldr     r3, [fp, PARAM4_OFFSET]         @ load filler
        str     r3, [fp, start]                 @ store filler to startchar
        //end = filler
        ldr     r3, [fp, PARAM4_OFFSET]         @ load filler
        str     r3, [fp, end]                   @ store filler to endchar
        //center = windmill
        ldr     r2, [fp, PARAM3_OFFSET]         @ load windmill
        str     r2, [fp, center]                @ store windmill to center
        b       end_if                          @ always branch to end_if
  else:
        //cls = width - row - 1
        ldr     r1, [fp, PARAM2_OFFSET]         @ get width
        ldr     r0, [fp, PARAM1_OFFSET]         @ get row
        sub     r4, r1, r0                      @ width = width - row
        sub     r4, r4, ONE                     @ width = width - 1
        str     r4, [fp, CLS]                   @ store to cls
        
        //crs = row - halfHeight - 1
        ldr     r4, [fp, HalfHeight]            @ get halfHeight
        ldr     r0, [fp, PARAM1_OFFSET]         @ get row
        sub     r4, r0, r4                      @ crs = row - halfheight
        sub     r4, r4, 1                       @ crs = row - 1
        str     r4, [fp, CRS]                   @ store to crs
        
        //start = filler
        ldr     r3, [fp, PARAM4_OFFSET]         @ load filler
        str     r3, [fp, start]                 @ store filler to startchar
        //end = windmill
        ldr     r2, [fp, PARAM3_OFFSET]         @ load windmill
        str     r2, [fp, end]                   @ store windmill to endchar
        //center = filler
        ldr     r3, [fp, PARAM4_OFFSET]         @ load filler
        str     r3, [fp, center]                @ store filler to center
  end_if:
        //first for loop
        mov     r5, 0                           @ move 0 to index r5  
        ldr     r4, [fp, CLS]                   @ get cls
        //i >= cls
        cmp     r5,r4                           @ compare i to cls
        bge     end_loop                        @ opposite logic to skip loop
  loop:
        //loop body

        ldr     r0, [fp,PARAM1_OFFSET]          @ get row
        ldr     r4, [fp,start]                  @ get start
        mov     r0, r4                          @ move start value to r0
        bl      printChar                       @ call printChar


        add     r5,r5,ONE                       @ i++
        ldr     r4, [fp, CLS]                   @ get cls

        cmp     r5, r4                          @ compare i to cls
        //i < cls
        blt     loop                            @ positive logic to loop back
  
  end_loop:

        //second for loop
        ldr     r4, [fp, CLS]                   @ get cls
        mov     r5, r4                          @ move cls to index r5
        ldr     r4, [fp, HalfHeight]            @ get halfheight
        //i >= HalfHeight
        cmp     r5,r4                           @ compare i to cls
        bge     end_loop2                       @ opposite logic to skip loop
  loop2:
        //loop body
        ldr     r0, [fp,PARAM1_OFFSET]          @ get row
        ldr     r4, [fp,end]                    @ get endchar
        mov     r0, r4                          @ move endchar value to r0
        bl      printChar                       @ call printChar

        add     r5,r5,ONE                       @ i++
        ldr     r4, [fp, HalfHeight]            @ get HalfHeight

        cmp     r5, r4                          @ compare i to HalfHeight
        //i < cls
        blt     loop2                           @ positive logic to loop back

  end_loop2:
        //bl printchar (centerChar)
        ldr     r4, [fp, center]                @ get centerchar
        ldr     r0, [fp, PARAM1_OFFSET]         @ get row
        mov     r0, r4                          @ move centerchar to r0
        bl      printChar                       @ call printChar

        //third for loop
        mov     r5, 0                           @ move 0 to index r5
        ldr     r4, [fp, CRS]                   @ get crs
        //i >= crs
        cmp     r5,r4                           @ compare i to crs
        bge     end_loop3                       @ opposite logic to skip loop
  loop3:
        //loop body
        ldr     r0, [fp,PARAM1_OFFSET]          @ get row
        ldr     r4, [fp,start]                  @ get start
        mov     r0, r4                          @ move start value to r0
        bl      printChar                       @ call printChar


        add     r5,r5,1                         @ i++
        ldr     r4, [fp, CRS]                   @ get crs

        cmp     r5, r4                          @ compare i to crs
        //i < crs
        blt     loop3                           @ positive logic to loop back
  
  end_loop3:
  
        //fourth for loop
        ldr     r4, [fp, CRS]                   @ get crs
        mov     r5, r4                          @ move crs to index r5
        ldr     r4, [fp, HalfHeight]            @ get halfheight
        //i >= HalfHeight
        cmp     r5,r4                           @ compare i to crs
        bge     end_loop4                       @ opposite logic to skip loop
  loop4:
        //loop body
        ldr     r0, [fp,PARAM1_OFFSET]          @ get row
        ldr     r4, [fp,end]                    @ get endchar
        mov     r0, r4                          @ move endchar value to r0
        bl      printChar                       @ call printChar

        add     r5,r5,ONE                       @ i++
        ldr     r4, [fp, HalfHeight]            @ get HalfHeight

        cmp     r5, r4                          @ compare i to HalfHeight
        //i < cls
        blt     loop4                           @ positive logic to loop back
  end_loop4:
        sub     sp,fp,FP_OFFSET                 @ deallocates vars
        pop     {r4-r5,fp,pc}                         @ restore caller's fp

        
