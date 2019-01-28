/*
 * Filename: testisOdd.c
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: Unit test program to test the function isOdd().
 * Date: Oct 14th
 * Source of Help: Tutor
 */

#include <stdio.h>
#include "pa1.h"
#include "test.h"

/*
 * Unit Test for isOdd.s
 * 
 * long isOdd( long value );
 *
 * check to see if the value is odd or even
 *
 * Return 0 if value is even; 1 if value is odd.
 */

void testisOdd(){

    /* Test around 0-3 */
    TEST ( isOdd(0) == 0);
    TEST ( isOdd(1) == 1);
    TEST ( isOdd(2) == 0);
    TEST ( isOdd(3) == 1);

    /* Test -1 to -3 */
  
    TEST ( isOdd(-1) == 1);
    TEST ( isOdd(-2) == 0);
    TEST ( isOdd(-3) == 1);

    /* Test big numbers */
 
    TEST ( isOdd(1000) == 0);
    TEST ( isOdd(-10001) == 1);
}

int main(void){
    
    fprintf(stderr, "Running tests for isOdd..\n");
    testisOdd();
    fprintf(stderr, "Done running tests!\n");

    return 0;
}
