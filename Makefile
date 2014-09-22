#!/usr/bin/make -f
#
#
# Makefile for ServerCountThrees
#
# Command: make
#          Creates src directory, unzip source file, ServerCountThrees.zip,
#          to src directory, and compiles ServerCountThrees 
#
# Command: make test
#          Creates test directory, unzip data source file, threesData.zip,
#          to test directory, and runs ServerCountThrees
#
# Command: make clean
#          Removes all files and directories created by make or make test
#

SHELL = /bin/sh

.SUFFIXES:
.SUFFIXES: .c .o

# holds source files form ServerCountThrees.zip
OBJDIR = src

# holds ServerCountThrees and data file threesData.bin for test run
TESTDIR = test

objects = readInt32BitLE.o ServerCountThrees.o

ServerCountThrees : data $(objects)
	cc -o ServerCountThrees $(objects)

readInt32BitLE.o : $(OBJDIR)/readInt32BitLE.c $(OBJDIR)/readInt32BitLE.h
	cc -c $(OBJDIR)/readInt32BitLE.c

ServerCountThrees.o : $(OBJDIR)/ServerCountThrees.c $(OBJDIR)/readInt32BitLE.h
	cc -c $(OBJDIR)/ServerCountThrees.c

# create directory to hold source files
.PHONY : data
data :
	mkdir $(OBJDIR)
	unzip ServerCountThrees.zip -d $(OBJDIR)

# run ServerCountThrees with data file threesData.bin
.PHONY : test
test :
	mkdir $(TESTDIR)
	mv ServerCountThrees $(TESTDIR)
	unzip threesData.zip
	mv threesData.bin $(TESTDIR)
	cd $(TESTDIR) && ./ServerCountThrees 

# remove files, directories create during make and make test 
# -rm to ignore errors, such as missing files
.PHONY : clean
clean :
	-rm ServerCountThrees $(objects)
	-rm -rf $(OBJDIR) $(TESTDIR)


