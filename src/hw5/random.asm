# Patrick Miller
# Program Name:
# Description:
#	Included with this assignment is a file named random.txt. It includes a
#	list of randomly generated numbers. For this assignment you are to open
#	this file and output how many numbers are in this file. You are to collect
#	the minimum, maximum, average (integer) and median values as well.
#	Please write these statistics to a file named output.txt.

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