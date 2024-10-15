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

getArrayLength: .asciiz "Number of elements in the array: "
getArrayValues: .asciiz "Array values: "

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start

	# idea: use the stack for our dynamic array?
	#	- store i, j, pivot and bounds as copies of $sp


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl quicksort
.ent quicksort
quicksort:
	# variables (will sort arr[a:b])
	#	- arr: array of numbers
	#	- a: start index (include)
	#	- b: end index (exclude)
	# calculate:
	#	- p: pivot (last, for simplicity)
	#	- i: last element swapped (last element known to be in correct position)
	#	- j: current element being checked
	# recursive call:
	#	- quicksort(arr[a:pivot])
	#	- quicksort(arr[pivot+1:b])

swap:
	# swap arr[i] and arr[j]

.end quicksort