# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program which has a method with the following signature:
# 		int ReadNumber(int start, int end);
# 	This method reads in an integer in the given range [start, end]. If an
# 	invalid number was entered (or data that’s not a number), the method should
# 	throw an exception. Using this method, write a program that reads in ten
# 	numbers n1, n2, ..., n10 such that 1 < n1 < n2 < ... < n10 < 100.

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