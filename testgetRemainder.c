/* 
 * Filename: testgetRemainder.c
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: Unit test program to test the function getRemainder().
 * Date: Oct 14
 * Sources of Help: Tutor
 *
 */

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for getRemainder.s
 *
 * long getRemainder( long dividend, long divisor );
 *
 * Check to see if the remainder matches the divident % divisor
 *
 * Returns the remainder
 */
void testgetRemainder(){

    /* Test around 0 */
    TEST ( getRemainder(0, 1) == 0);
    TEST ( getRemainder(0, -5) == 0);
    TEST ( getRemainder(0, 1000) == 0);

    /* 3 normal test */
    TEST ( getRemainder(1, 5) == 1);
    TEST ( getRemainder(2, 6) == 2);
    TEST ( getRemainder(9, 4) == 1);

    /* 3 tests that have remainder as 0 */ 
    TEST ( getRemainder(3, 1) == 0);
    TEST ( getRemainder(9, 3) == 0);
    TEST ( getRemainder(12, 12) == 0);

    /* 2 tests around negative number */
    TEST ( getRemainder(78, -23) == 9);
    TEST ( getRemainder(-372, 24) == -12);
}

int main(void){
    fprintf(stderr, "Running tests for getRemainder...\n");
    testgetRemainder();
    fprintf(stderr, "Done running tests! \n");

    return 0;
}
