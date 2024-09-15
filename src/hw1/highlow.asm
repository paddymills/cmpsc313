
# Patrick Miller


# Write a MIPS program that will take in two integers from the user. Your
# program should output which of the two numbers is larger than the other.

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
inputNum1: .asciiz "Enter the first number: "
inputNum2: .asciiz "Enter the second number: "
outputLabel: .asciiz "The larger number is: "
newline: .asciiz "\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

	# get the first number
	li $v0, 4
	la $a0, inputNum1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0

	# get the second number
	li $v0, 4
	la $a0, inputNum2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

	# branch for highest number
	bgt $t0, $t1, firstIsGreater
	b secondIsGreater

firstIsGreater:
	move $t2, $t0
	b output

secondIsGreater:
	move $t2, $t1
	b output

output:
	# print output label
	li $v0, 4
	la $a0, outputLabel
	syscall

	# print the larger number
	li $v0, 1
	move $a0, $t2
	syscall

	# newline
	li $v0, 4
	la $a0, newline
	syscall

	# -----
	# Done, terminate program.
	li $v0, 10
	syscall # all done!

.end main