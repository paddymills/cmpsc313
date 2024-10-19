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
getArrayValuesStart: .asciiz "Array["
getArrayValuesEnd: .asciiz "]: "

outArrayStart: .asciiz "Array: ["
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
	move $s1, $v0		# store array length

	# calculate size of array
	sll $t0, $s1, 2		# size = length * 4

	# create dynamic array
	li $v0, 9
	move $a0, $t0
	syscall
	move $s0, $v0		# store array start address

	# get array values
	li $t0, 0		# index counter
	move $t1, $s0	# store array start address
loopInput:
	beq $t0, $s1, sortArray	# if index == length, exit loop

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

	sw $v0, ($t1)		# push number into array
	addi $t1, $t1, 4	# increment array pointer
	addi $t0, $t0, 1	# increment index counter

	b loopInput

sortArray:
	# call quick sort algorithm
	move $a0, $s0
	move $a1, $s1
	jal quicksort

	# print sorted array
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
	#	- $a0: address of start of array (or section of array)
	#	- $a1: length of array to sort
	# calculate:
	#	- p: pivot (last, for simplicity)
	#	- i: last element swapped (last element known to be in correct position)
	#	- j: current element being checked

	# store return address on stack
	subu $sp, $sp, 4
	sw $ra, ($sp)

	move $t7, $a0	# store start of array
	move $t8, $a1	# store length of array

base_case:
	ble $t8, 1, return	# if length <= 1, return

setup:
	# $t0 = i (address before first element: $a0 - 4)
	addi $t0, $t7, -4	# i = start - 4

	# $t1 = j (address of first element: $a0)
	move $t1, $t7		# j = start of array

	# $t2 = pivot (last element: $t0 offset by length bytes)
	sll $t2, $t8, 2		# pivot offset = length * 4
	add $t2, $t0, $t2	# pivot address = (start - 4) + offset

loop:
	beq $t1, $t2, move_pivot	# if j == pivot, move pivot (end loop)

	# compare arr[j] and arr[pivot]
	lw $t3, ($t1)	# load arr[j]
	lw $t4, ($t2)	# load arr[pivot]
	blt $t3, $t4, swap	# if arr[j] < arr[pivot] -> swap arr[i] and arr[j]

	b post_loop	# if arr[j] >= arr[pivot], continue loop

swap:
	addi $t0, $t0, 4	# increment i
	beq $t0, $t1, post_loop	# if i == j, swap does nothing

	# swap arr[i] and arr[j]
	lw $t3, ($t0)	# load arr[i] into temp1
	lw $t4, ($t1)	# load arr[j] into temp1
	sw $t3, ($t1)	# store arr[i] in arr[j]
	sw $t4, ($t0)	# store arr[j] in arr[i]

post_loop:
	addi $t1, $t1, 4	# increment j
	b loop

move_pivot:
	# swap pivot with arr[i+1]
	addi $t0, $t0, 4	# increment i

	# swap arr[i+1] and arr[pivot]
	lw $t3, ($t2)	# load pivot into temp1
	lw $t4, ($t0)	# load arr[i] into temp2
	sw $t4, ($t2)	# store arr[i] in last position
	sw $t3, ($t0)	# store pivot where i was

	# $t0 is now the pivot
	# $t2 is now the last element of the array slice

recursiveCalls:
	# recursive calls to quicksort:
	#	- quicksort(arr[start:pivot])
	#	- quicksort(arr[pivot+1:end])

	addi $t3, $t0, 4	# pivot+1 (start of array for second recursive call)
	sub $t4, $t0, $t7	# pivot_offset = pivot - start
	div $t4, $t4, 4		# pivot_index = pivot_offset /4
	sub $t4, $t8, $t4	# length = original_length - pivot_index
	addi $t4, $t4, -1	# compensate for zero-indexing

	# store pivot+1 and length on stack for second call
	subu $sp, $sp, 8
	sw $t3, ($sp)		# pivot+1
	sw $t4, 4($sp)		# length

	# $a0 -> start of array from original call
	move $a0, $t7
	# $a1 -> distance from start of array to pivot
	sub $a1, $t0, $a0	# length (bytes) = pivot - start
	div $a1, $a1, 4		# length /= 4

	# recursive call: left partition
	jal quicksort

	# return array and length from stack
	lw $a0, ($sp)		# pivot+1
	lw $a1, 4($sp)		# length
	addu $sp, $sp, 8

	# recursive call: right partition
	jal quicksort

return:
	lw $ra, ($sp)
	addu $sp, $sp, 4

	jr $ra


.end quicksort