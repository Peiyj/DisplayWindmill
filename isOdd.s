/*
 * File: isOdd.s
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: the file that contains function with regards to whether the
 *              value is odd or not
 * Date: Oct 14,2018
 * 
 */

@ Raspberry Pi directives
        .cpu    cortex-a53                  @ version of our Pis
        .syntax unified                     @ Modern syntax
@ Useful source code constants
        .equ    FP_OFFSET, 4                @ Offset to set fp to the base
        .equ    PARAM_SPACE, 4              @ Allocate 4 bytes of param vars
        .equ    PARAM1_OFFSET, -8           @ 1st param
        .equ    ZERO, 0                     @ store 0 
        .equ    DIVISER, 2                  @ store DIVISER=2
        .equ    ONE, 1                      @ store 1
@ Store numbers
        .global isOdd                       @ Specify as a global symbol
@ Text region
        .text                               @ Switch to Text segment
        .align 2                            @ Align

/*
 * Function Header: isOdd()
 * Function Prototype: long isOdd( long value );
 * Description: return 0 if value is even; 1 if value is odd.
 * Parameters: value -- the numeric value of the number
 * Side Effects: none
 * Error Conditions: none
 * Registers used:
 * r0 -- arg 1 -- value ,also as return value
 */

isOdd:
@ Standard prologue
        push    {fp, lr}                    @ save registers
        add     fp,sp,FP_OFFSET             @ set fp to the base

        @ Allocate space for params
        sub     sp,sp, PARAM_SPACE          @ Allocate param

        str     r0, [fp, PARAM1_OFFSET]     @ store value
        ldr     r0, [fp, PARAM1_OFFSET]     @ get the "value"
        mov     r1, DIVISER                 @ get 2
        bl      getRemainder                @ call getRemainder
        
        cmp     r0, ZERO                       @ compare to see if r0 is positive
        beq     end_if                      @ go to endif
        mov     r0, ONE                       @ set r0 to 1
end_if:
        sub     sp,fp,FP_OFFSET             @ deallocate vars
        pop     {fp,pc}                     @ restore caller's fp
