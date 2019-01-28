/*
 * Filename: printLine.c
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: This function will be called from displayWindmill() for printing
 *              out the line of characters that make up the windmill pattern 
 *              (fill er chars + windmill chars; this function does not print 
 *              out border characters). 
 * Date: Oct 14th
 * Source of help: tutor, discussion 2 worksheet
 */

#include <stdio.h>
#include "pa1.h"
 
#define HALF_DIVISOR 2

/*
 * Function name: printline
 * Function prototype: void printLine
 * Description: it prints out one single line
 * Parameters: row: the row
 *             width: width
 *             windmill: windmill character
 *             filler: filler character
 * side effect: none
 * Error conditions: none
 * Return: void
 */
void printLine( long row, long width, char windmill, char filler ){
    int col;
    int halfHeight = width / HALF_DIVISOR;
    int countLeftStart;
    int countRightStart;
    char startChar;
    char endChar;
    char centerChar;

    if(row < halfHeight) {
        //case 1: set loop conditions for the top half
        //count left starts at row + 1
        countLeftStart = row + 1;
        //count right start at halfHeight - row
        countRightStart = halfHeight - row;
        startChar = windmill;
        endChar = filler;
        centerChar = filler;
    }

    else if(row == halfHeight){
        //case 2: set loop conditions for the center
        countLeftStart = halfHeight; 
        countRightStart = halfHeight;
        startChar = filler;
        endChar = filler;
        centerChar = windmill;
    }

    else{
        countLeftStart = width - row - 1;
        countRightStart = row - halfHeight - 1;
        startChar = filler;
        endChar = windmill;
        centerChar = filler;
    }

    //print left side of the row
    for(col = 0; col < countLeftStart; ++col) {
        (void) printChar( startChar);
    }
    for(col = countLeftStart; col < halfHeight; ++col){
        (void) printChar( endChar);
    }

    //print center row
    (void) printChar(centerChar);

    //print the right side
    for(col = 0; col < countRightStart; ++col){
        (void) printChar(startChar);
    }

    for(col = countRightStart; col < halfHeight; ++col){
        (void) printChar(endChar);
    }
}
