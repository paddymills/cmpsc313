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
	# TODO: store start of array location in $s0 ($sp of first element)
	# TODO: store length of array in $s1 (currently in $s0)

	b testArray	# skip user input for testing

	# get array length
	li $v0, 4
	la $a0, getArrayLength
	syscall
	li $v0, 5
	syscall
	move $s1, $v0		# store array length

	# create dynamic array
	li $v0, 9
	move $a0, $s1
	syscall
	move $s0, $v0		# store array start address

	# get array values
	li $t0, 0		# index counter
	move $t1, $s0	# store array start address
	li $v0, 4
	la $a0, getArrayValues
	syscall
loopInput:
	beq $t0, $s1, printUnsorted

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
	sw $v0, ($t1)		# push number onto stack
	addi $t1, $t1, 4	# increment array pointer
	addi $t0, $t0, 1	# increment index counter

	b loopInput

testArray:
	# create dynamic array
	li $v0, 9
	li $a0, 32	# 8 elements at 4 bytes each
	syscall

	move $s0, $v0	# store array start address
	li $s1, 8		# store array length
	
	# load numbers
	li $t1, 4
	li $t2, 1
	li $t3, 2
	li $t4, 7
	li $t5, 3
	li $t6, 9
	li $t7, 8
	li $t8, 6
	
	# push numbers into array
	sw $t1,   ($s0)
	sw $t2,  4($s0)
	sw $t3,  8($s0)
	sw $t4, 12($s0)
	sw $t5, 16($s0)
	sw $t6, 20($s0)
	sw $t7, 24($s0)
	sw $t8, 28($s0)

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

	move $t0, $s0		# start of array
	move $t1, $s1		# element counter

	li $v0, 4
	la $a0, outArrayStart
	syscall

printArrayLoop:
	addi $t1, $t1, -1	# decrement element counter

	# print the array element
	li $v0, 1
	lw $a0, ($t0)
	syscall

	add $t0, $t0, 4		# select next element
	beqz $t1, endPrintArray	# last element: exit loop

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

recursiveCalls:
	# recursive calls to quicksort

	# base case: if a >= b, return

	# calculate pivot
	#	- p = b - 1
	#	- i = a - 1
	#	- j = a

	# loop:
	#	- if arr[j] < arr[p], swap arr[i+1] and arr[j], increment i
	#	- increment j

	# swap arr[i+1] and arr[p]

	# recursive call: quicksort(arr[a:pivot])
	# recursive call: quicksort(arr[pivot+1:b])

	# return


.end quicksort