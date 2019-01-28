/*
 * File: displayWindmill.c
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Desciption: a File that displays ths function will print out individual
 *             characters (via calls to printChar() and printLine()) to print
 *             the windmill
 * Date Oct:14th
 * Source of help: tutor
 */

#include <stdio.h>
#include "pa1.h"

/*
 * Function name: displayWindmill
 * Function prototype: void displayWindmill
 * Description: it is file that displays windmill on the screen
 * Parameters: height: the height of the pattern
 *             border: border character
 *             filler: flller character
 *             windmill: windmill character
 * Side effects: none
 * Error Conditions: none
 * Return value: void
 */
void displayWindmill( long height, char border, char filler, char windmill ){
    int HEIGHT = height;
    printf("\n");
    //section 1: print border
    for(int i = 0; i < height+2; i++){
        (void) printChar(border);
    }
    printf("\n");
    //section 2: print body
    for(int i = 0; i < height; i++){
        (void) printChar(border);
        (void) printLine(i, height, windmill, filler);
        (void) printChar(border);
        printf("\n"); 
    }
    //section 3: print border
    for(int i = 0; i < height+2; i++){
        (void) printChar(border);
    }
    printf("\n");
    printf("\n");
}

