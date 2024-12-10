# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program which takes in an integer from the user. Calculate and
# 	print the square root. If the number is invalid (-1), print Invalid Number.
# 	In all cases print Goodbye once the program is finished execution. Use the
# 	MIPS equivalent of try-catch-finally in your solution.

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