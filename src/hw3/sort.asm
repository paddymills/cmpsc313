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
getArrayValues: .asciiz "Array values: \n"
getArrayValuesStart: .asciiz "Array["
getArrayValuesEnd: .asciiz "]: "

outUnsortedArray: .asciiz "Unsorted array: "
outSortedArray: .asciiz "Sorted array: "
outArrayStart: .asciiz "["
outArrayDelim: .asciiz ", "
outArrayEnd: .asciiz "]\n"

newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# get array length
	li $v0, 4
	la $a0, getArrayLength
	syscall
	li $v0, 5
	syscall
	move $s0, $v0		# store array length


	# get array values
	li $t0, 0		# index counter
	li $v0, 4
	la $a0, getArrayValues
	syscall
loopInput:
	beq $t0, $s0, printUnsorted

	# prompt: `Array[i]: `
	li $v0, 4
	la $a0, getArrayValuesStart
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, getArrayValuesEnd
	syscall

	# get number from user
	li $v0, 5
	syscall
	subu $sp, $sp, 4	# decrement stack pointer
	sw $v0, ($sp)		# push number onto stack

	addi $t0, $t0, 1	# increment index counter
	b loopInput
printUnsorted:
	li $v0, 4
	la $a0, outUnsortedArray
	syscall

	# print array
	jal printArray

sortArray:
	# idea: use the stack for our dynamic array?
	#	- store i, j, pivot and bounds as copies of $sp

printSortedArray:
	li $v0, 4
	la $a0, outSortedArray
	syscall
	jal printArray

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl printArray
.ent printArray
printArray:
	# array is on stack
	# $sp is the top of the stack
	# $s0 is the length of the array

	move $t0, $s0		# element counter

	li $v0, 4
	la $a0, outArrayStart
	syscall

printArrayLoop:
	addi $t0, $t0, -1	# decrement element counter

	sll $t1, $t0, 2		# calculate offset ($t1 = $t0 * 4)
	add $t1, $t1, $sp	# calculate address of next element

	# print the array element
	li $v0, 1
	lw $a0, ($t1)
	syscall

	beqz $t0, endPrintArray	# last element: exit loop

	# print delimiter
	li $v0, 4
	la $a0, outArrayDelim
	syscall

	b printArrayLoop

endPrintArray:
	li $v0, 4
	la $a0, outArrayEnd
	syscall

	jr $ra

.end printArray

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