# Patrick Miller
# Program Name: sort
# Description:
# This problem simply implements a sorting algorithm of your choice in the
# MIPS programming language.
# • This problem comes with several options for implementation:
# 	o Ask the user for a non-zero positive integer for the number of integers
# 		the user would like to sort.
# 	o Read in from standard input each of the integers the user would like to sort
# 	o Run your sorting algorithm on this list of data
# • In addition to the above, implement using one of the following sorting algorithms:
# 	o Merge Sort
# 	o Quick Sort
# 	o Heap Sort
# 	o An algorithm of similar average-case complexity

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