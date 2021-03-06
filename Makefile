#
# Makefile template for CSE 30 -- PA1
# You should not need to change anything in this file.
#
# XXX DO NOT EDIT
#

HEADERS		= pa1.h pa1Strings.h
C_SRCS		= main.c 
ASM_SRCS	= isOdd.s printChar.s rangeCheck.s getRemainder.s
EXE_ASM_SRCS	= displayWindmill.s printLine.s
EC_ASM_SRCS	= displayWindmillEC.s numOfDigitsEC.s printLine.s

C_OBJS		= main.o
ASM_OBJS	= $(ASM_SRCS:.s=.o)
EXE_ASM_OBJS	= $(EXE_ASM_SRCS:.s=.o)
EC_ASM_OBJS	= $(EC_ASM_SRCS:.s=.o)
OBJS		= $(C_OBJS) $(ASM_OBJS) $(EXE_ASM_OBJS)
EC_OBJS		= $(C_OBJS) $(ASM_OBJS) $(EC_ASM_OBJS)

EXE		= pa1
EC_EXE		= pa1EC
TEST_EXES	= testisOdd testprintChar testrangeCheck testgetRemainder \
		  testnumOfDigitsEC testdisplayWindmill


GCC		= gcc
ASM		= $(GCC)
RM		= rm

GCC_FLAGS	= -c -g -std=c99 -pedantic -Wall -D__EXTENSIONS__
LINT_FLAGS1	= -c -err=warn
LINT_FLAGS2	= -u -err=warn
ASM_FLAGS	= -c -g
LD_FLAGS	= -g -Wall

#
# Standard rules
#

%.o : %.s
	@echo "Assembling each assembly source file separately ..."
	$(ASM) $(ASM_FLAGS) $< -o $@
	@echo ""

%.o : %.c
	@echo "Compiling each C source file separately ..."
	$(GCC) $(GCC_FLAGS) $< -o $@
	@echo ""

#
# Simply have our project target be a single default $(EXE) executable.
#

$(EXE):	$(OBJS)
	@echo "Linking all object modules ..."
	$(GCC) $(LD_FLAGS) -o $(EXE) $(OBJS)
	@echo ""
	@echo "Compilation Successful!"

$(EC_EXE): $(EC_OBJS)
	@echo "Linking all object modules ..."
	$(GCC) $(LD_FLAGS) -o $(EC_EXE) $(EC_OBJS)
	@echo ""
	@echo "Compilation Successful!"

$(C_OBJS): $(HEADERS)


clean:
	@echo "Cleaning up project directory ..."
	$(RM) -f *.o $(EXE) $(EC_EXE) core a.out $(TEST_EXES)
	@echo ""
	@echo "Clean."

#
# Unit test targets
#
testdisplayWindmill: pa1.h testdisplayWindmill.o displayWindmill.o printLine.o \
printChar.o
	@echo "Compiling testdisplayWindmill.c"
	$(GCC) $(LD_FLAGS) -o testdisplayWindmill testdisplayWindmill.o \
	displayWindmill.o printLine.o printChar.o
	@echo "Compilation Successful!"

testrangeCheck: test.h pa1.h rangeCheck.o testrangeCheck.o
	@echo "Compiling testrangeCheck.c"
	$(GCC) $(LD_FLAGS) -o testrangeCheck testrangeCheck.o rangeCheck.o
	@echo "Compilation Successful!"

testgetRemainder: test.h pa1.h getRemainder.o testgetRemainder.o
	@echo "Compiling testgetRemainder.c"
	$(GCC) $(LD_FLAGS) -o testgetRemainder testgetRemainder.o getRemainder.o
	@echo "Compilation Successful!"

testisOdd: test.h pa1.h isOdd.o testisOdd.o getRemainder.o
	@echo "Compiling testisOdd.c"
	$(GCC) $(LD_FLAGS) -o testisOdd testisOdd.o isOdd.o getRemainder.o
	@echo "Compilation Successful!"

testprintChar: test.h pa1.h printChar.o testprintChar.o
	@echo "Compiling testprintChar.c"
	$(GCC) $(LD_FLAGS) -o testprintChar testprintChar.o printChar.o
	@echo "Compilation Successful!"

testnumOfDigitsEC: test.h pa1.h numOfDigitsEC.o rangeCheck.o testnumOfDigitsEC.o
	@echo "Compiling testnumOfDigitsEC.c"
	$(GCC) $(LD_FLAGS) -o testnumOfDigitsEC testnumOfDigitsEC.o \
	numOfDigitsEC.o rangeCheck.o
	@echo "Compilation Successful!"

new:
	make clean
	make

