/*
 * Filename: main.c
 * Author: Yingjian Pei
 * Userid: cs30fex
 * Description: The main function will drive the rest of the program. It will
 * first perform input checking by parsing the command line arguments and
 * checking for errors. If all inputs are valid, it will call displayWindmill().
 * Otherwise, it will print the corresponding error message(s). Remember that
 * all error strings have format specifiers, so be sure to add the appropriate
 * arguments when printing error messages. Also, make sure you use your
 * rangeCheck() function when checking the limits of the command line arguments.
 * Date: Oct 14th
 * Source of help: Tutor, discussion 3 worksheet
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include "pa1Strings.h"
#include "pa1.h"

#define ZERO 0
#define ONE 1
#define TWO 2
#define THREE 3
#define FOUR 4
#define FIVE 5
#define EIGHT 8

/*
 * Function name: main.c
 * Function prototype: int main
 * Description: it will first perfrom input checking by parsing the command
 * arguments and checking for errors. If all inputs are valid, it will call
 * displayWindmill()
 * Parameters: int argc: the number of arguments 
 *             char* argv[]: the arguments in char* form
 * Side effects: error printed out to stderr
 * Error conditions: height, border, filler, windmill
 * Return values: failure or success
 */

int main(int argc, char* argv[]){

    /////////////////////////////HEIGHT///////////////////////////////////
    //First: check that the user entered the correct number of command line
    //arguments.
    int errorCounter = 0;
    if(argc != FIVE){
        fprintf(stderr,STR_USAGE, argv[ZERO],HEIGHT_MIN, HEIGHT_MAX, 
                ASCII_MIN, ASCII_MAX, ASCII_MIN, ASCII_MAX, ASCII_MIN, 
                ASCII_MAX);
        return EXIT_FAILURE;
    }
    //declare endptr
    char* endptr;
    //reset errno: use to check for overflow
    errno = ZERO;
    long height = strtol(argv[ONE], &endptr, BASE);
    //if parsing the number succeeds
    if (*endptr == '\0' && errno == ZERO){
        //error case 1: check if the number is odd
        if(isOdd(height)!=ONE){
            errorCounter ++;
            fprintf(stderr,STR_ERR_ODD,STR_HEIGHT,height);
        }
        //error case 2: check for height 
        if(height < HEIGHT_MIN || height > HEIGHT_MAX){
            errorCounter ++;
            fprintf(stderr,STR_ERR_NUM_RANGE,STR_HEIGHT,
                    height,HEIGHT_MIN, HEIGHT_MAX);
        }
    }
    //error case 2: Error converting to long: overflow
   
    else if(errno != ZERO){
        //Use snprintf() to build the error string using STR_ERR_CONVERTING
        errorCounter ++;
        char buffArray[BUFSIZ] ;
        snprintf(buffArray,BUFSIZ,STR_ERR_CONVERTING,STR_HEIGHT,
                argv[ONE],BASE);
        perror(buffArray);
    }

    //error case 3: height contains non-numeric characters 
    else if(*endptr != '\0'){
        errorCounter ++;
        fprintf(stderr,STR_ERR_NOT_INT,STR_HEIGHT,argv[ONE]);
    }


    ///////////////////////////////BORDER//////////////////////////////
    //Moving on to border_char
    //First extract the first character from the border_char argument.
    char borderChar = argv[TWO][ZERO];
    //error case 1: if not a single character
    if (strlen(argv[TWO]) != ONE){
        errorCounter ++;
        fprintf(stderr, STR_ERR_SINGLE_CHAR,STR_BORDER_CHAR,
                argv[TWO]);
    }
    //error case 2: if the character is not in range
    else if (rangeCheck(borderChar, ASCII_MIN, ASCII_MAX + ONE) != ONE){
        errorCounter++;
        fprintf(stderr, STR_ERR_ASCII_RANGE,STR_BORDER_CHAR,
                borderChar, ASCII_MIN, ASCII_MAX);
    }
    

    //////////////////////////////FILLER/////////////////////////////////
    //Moving on to filler_char
    //First extract the frst character from the filler_char argument. 
    char fillerChar = argv[THREE][ZERO];
    //error case 1: if not a single character
    if (strlen(argv[THREE])!= ONE){
        errorCounter++;
        fprintf(stderr, STR_ERR_SINGLE_CHAR, STR_FILLER_CHAR,
                argv[THREE]);
    }
    //error case 2: if the character is not in range
    else if (rangeCheck(fillerChar, ASCII_MIN, ASCII_MAX + ONE) != ONE){
        errorCounter++;
        fprintf(stderr, STR_ERR_ASCII_RANGE, STR_FILLER_CHAR,
                fillerChar,ASCII_MIN, ASCII_MAX);
    }
    

    //////////////////////////////WINDMILL///////////////////////////////////
    //Moving on to windmill_char
    //First extract the first character from the windmill_char argument.
    //error case 1: if not a single character
    char windmillChar =argv[FOUR][ZERO];
    //error case 1: if not a single character
    if (strlen(argv[FOUR])!= ONE){
        errorCounter++;
        fprintf(stderr, STR_ERR_SINGLE_CHAR, STR_WINDMILL_CHAR,
                argv[FOUR]);
    }
    //error case 2: if the character is not in range
    else if (rangeCheck(windmillChar, ASCII_MIN, ASCII_MAX + ONE) != ONE){
        errorCounter++;
        fprintf(stderr, STR_ERR_ASCII_RANGE, STR_WINDMILL_CHAR,
                windmillChar,ASCII_MIN, ASCII_MAX);
    }


    ///////////////////////////////FINAL PART////////////////////////////////// 
    //If any errors from above were encountered, print a newline to stderr and
    //return EXIT_FAILURE
    
    //If any errors from above were encountered, print a newline to stderr and
    //return EXIT_FAILURE
    
    if(errorCounter != 0){
        fprintf(stderr, "\n");
        return EXIT_FAILURE;
    }
    //error case 1: border_char and windmill_char are the same
    if(borderChar == windmillChar){
        fprintf(stderr,STR_ERR_BORDER_WINDMILL_DIFF, 
                 borderChar, windmillChar);
        printf("\n");
        return EXIT_FAILURE;
    }
    //error case 2: filler_char and windmill_char are the same
    else if(fillerChar == windmillChar){
        fprintf(stderr,STR_ERR_FILLER_WINDMILL_DIFF, 
                 fillerChar, windmillChar);
        printf("\n");
        return EXIT_FAILURE; 
    }
    //if no errors, then print displayWindmill()
    (void)displayWindmill(height, borderChar, fillerChar, windmillChar);
    return EXIT_SUCCESS;
}



    
    

