# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program which has a method with the following signature:
# 		int ReadNumber(int start, int end);
# 	This method reads in an integer in the given range [start, end]. If an
# 	invalid number was entered (or data that’s not a number), the method should
# 	throw an exception. Using this method, write a program that reads in ten
# 	numbers n1, n2, ..., n10 such that 1 < n1 < n2 < ... < n10 < 100.

# ----------------------------------------
# Data Declarations:
.data
promptStart: .asciiz "Enter a number("
promptMid: .asciiz " to "
promptEnd: .asciiz "): "

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $s0, 0	# counter
	li $s1, 10	# number of iterations
	li $s2, 2	# min number

loop:
	# Check if we've read 10 numbers
	beq $s0, $s1, end

	# Read a number
callReadNumber:
	move $a0, $s2	# start
	addi $a1, $s0, 90	# max = 100 - iterations left (cannot select 100 when there are still iterations left)
	jal ReadNumber
	addi $s2, $v0, 1	# update start

	# Increment counter
	addi $s0, $s0, 1

	j loop

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl ReadNumber
.ent ReadNumber
ReadNumber:
	# $a0 = start
	# $a1 = end
	move $t0, $a0
	move $t1, $a1

	li $v0, 4
	la $a0, promptStart
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, promptMid
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, promptEnd
	syscall

	# get number
	li $v0, 5
	syscall

	sub $t2, $v0, $t0
	tlti $t2, 0	# trap if less than the start
	sub $t3, $t1, $v0
	tlti $t3, 0	# trap if greater than the end

	jr $ra

.end ReadNumber

.ktext 0x80000180  # Generic exception vector
	# save a0 and v0
	move 	$k0, $a0		# $k0 = $a0
	move 	$k1, $v0		# $k1 = $v0

	li $v0, 4
	la $a0, invalidNumber
	syscall

	# restore the registers
	move 	$a0, $k0		# $a0 = $k0
	move 	$v0, $k1		# $v0 = $k1

	# retry ReadNumber
	la $k0, callReadNumber

	# move this back to coprocessor-0
	mtc0 $k0, $14

	# error return
	eret

.kdata
	invalidNumber: .asciiz "Error: Number must be inclusive to (start, end)\n"