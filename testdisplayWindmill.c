/*
 * Filename: testdisplayWindmill.c
 * Author: Yingjian Pei 
 * Userid: cs30fex
 * Description: Unit test program to test the function displayWindmill().
 * Date: Oct 14th
 * Sources of Help: Tutor
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for displayWindmill.c (milestone) and displayWindmill.s (final)
 *
 * void displayWindmill( long height, char border, char filler, char windmill );
 *
 * Prints an ASCII-art windmill with width and height specified with the first
 * parameter using only the characters specified in the last three parameters.
 *
 * Please note this unit test is unable to determine if it was successful or
 * not. You must compare the output of this test with the output of the 
 * reference executable by passing the same parameters.
 */
void testdisplayWindmill( ) {

  (void) displayWindmill( 11, 'B', '.', 'W' );

  /*
   * TODO: write more tests here
   *
   * Note: displayWindmill() is allowed to assume that height is odd and within a
   *       reasable range.
   */

  //Test between 13-19
  (void) displayWindmill( 13, 'A', '/', 'i' );
  (void) displayWindmill( 15, 'B', ';', 'p' );
  (void) displayWindmill( 17, 'C', 'p', 's' );
  (void) displayWindmill( 19, 'D', 'a', 'q' );

  //Test arund 1
  
  (void) displayWindmill( 1, 'B', '.', 'W' );
  (void) displayWindmill( 1, 'A', '.', 'W' );
  (void) displayWindmill( 1, 'C', '.', 'W' );
}


int main( void ) {

  fprintf(stderr, "Running tests for displayWindmill...\n");
  testdisplayWindmill();
  fprintf(stderr, "Done running tests!\n");

  return 0;
}
