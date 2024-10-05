# Patrick Miller
# Program Name: composite
# Description:
# In Mathematics, a prime number is an integer which is only divisible by the
# numbers 1 and itself. Examples of prime numbers include the integers
# 3, 11 and 17. Likewise a composite number is any number that is not a
# prime number. For this assignment you will create a MIPS function named
# isComposite which you can use to determine whether an integer is composite or
# not. Using this newly written MIPS function, calculate the first 100 composite
# numbers and display them to standard output.

# ----------------------------------------
# Data Declarations:
.data

message: .asciiz "The first 100 composite numbers are:\n"
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $s0, 1	# composite number counter
	li $s1, 4	# number to check for composite

	# Print message
	li $v0, 4
	la $a0, message
	syscall

loopFind:
	move $a0, $s1	# number to check for composite
	jal isComposite
	beqz $v0, incrementNumber	# if not composite, increment counter

	# number is composite
	addi $s0, $s0, 1	# increment composite number counter
	li $v0, 1	# print composite number
	syscall

	li $v0, 4	# print newline
	la $a0, newline
	syscall

incrementNumber:
	addi $s1, $s1, 1	# increment number to check
	ble $s0, 100, loopFind	# check for 100 composite numbers

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl isComposite
.ent isComposite
isComposite:
	li $v0, 0	# default: is not composite
	ble $a0, 3, end	# base case: a0 <= 3 is not composite

	li $t0, 2	# number to check divisible
loopCheckDivisible:
	beq $a0, $t0, endIS	# if a0 == t0, stop checking
	rem $t1, $a0, $t0	# a0 % t0
	beqz $t1, composite	# if a0 % t0 == 0, then a0 is composite

	addi $t0, $t0, 1	# increment number to check
	b loopCheckDivisible

composite:
	li $v0, 1

endIS:
	jr $ra

.end isComposite