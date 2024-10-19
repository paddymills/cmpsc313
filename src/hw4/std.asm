# Patrick Miller
# Program Name:
# Description:
# 	This exercise will involve using dynamic memory allocation with MIPS.
# 	For this assignment you will ask the user for a positive, non-zero integer
# 	n. You will then dynamically allocate memory to hold those n integers, and
# 	then ask the user to input each of those n integers. Once the data has been
# 	collected, calculate the standard deviation of that data set. As you recall,
# 	the formula for standard deviation is the following:
# 		o_greek = sqrt((1/N) * sum(i=1 to N, (xi - u_greek)^2))


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