/*
 * Filename: testrangeCheck.c
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: Unit test program to test the function rangeCheck().
 * Date: Oct 14, 2018
 * Sources of Help: Tutor
 */ 

#include <stdio.h>

#include "pa1.h"
#include "test.h"

/*
 * Unit Test for rangeCheck.s
 *
 * long rangeCheck( long value, long minRange, long maxRange );
 *
 * Checks to see if value is within the range of minRange to maxRange,
 * inclusive.
 *
 * Returns -1 if minRange > maxRange.
 * Returns 1 if value is between minRange and maxRange (inclusive).
 * Returns 0 otherwise.
 */
void testrangeCheck( ) {

  /* Test around 0 */
  TEST( rangeCheck( 0, 0, 1 ) == 1 );
  TEST( rangeCheck( 0, 0, 0 ) == -1 );
  TEST( rangeCheck( 0, 0, -1 ) == -1 );
  // Test around the error condition
  TEST( rangeCheck( 5, 1, 5) == 0);
  // 3 Normal tests
  TEST( rangeCheck( 1, 1, 5 ) == 1 ); 
  TEST( rangeCheck( 3, 2, 6 ) == 1 );
  TEST( rangeCheck( 9, 3, 10 ) == 1 );
  
  // 3 abnormal tests
  TEST( rangeCheck( 1, 0, 1 ) == 0 );
  TEST( rangeCheck( 0, 2, 5 ) == 0 );
  TEST( rangeCheck( -1, 3, 6 ) == 0 );
  
  // 3 error cases
  TEST( rangeCheck( 0, 1, 0 ) == -1 );
  TEST( rangeCheck( 5, 0, -5 ) == -1 ); 
  TEST( rangeCheck( 5, -5, -5 ) == -1 );
 
  //3 extreme cases
  TEST( rangeCheck( 0, -100, 100 ) == 1 );
  TEST( rangeCheck( -100, -105, -99) == 1 );
  TEST( rangeCheck( 5, 0, 1000 ) == 1 );
}

int main( void ) {

  fprintf(stderr, "Running tests for rangeCheck...\n");
  testrangeCheck();
  fprintf(stderr, "Done running tests!\n");

  return 0;
}
