# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program which instantiates an object from the Date class
#	as follows:
#		Date d = new Date(10, 31, 2015);
#	With the date object corresponding to the calendar date October 31, 2015.
#	Include a toString() method in your program which will print out the date
#	in this format:
#		10/31/2015

# ----------------------------------------
# Data Declarations:
.data

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start



# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main