# Patrick Miller
# Program Name: coin
# Description:
# In MIPS programming, the following code can be used to generate a random integer:
# ```
# li $v0, 41 ; Service 41, random int
# xor $a0, $a0, $a0 ; Select random generator 0
# syscall ; Generate random int (returns in $a0)
# li $v0, 1 ; Service 1, print int
# syscall ; Print previously generated random int
# ```
# Using this information, you will then create a MIPS function called flipCoin
# which returns the following:
#   • 1 being HEADS
#   • 2 being TAILS
# For this exercise you will ask the user for a positive, non-zero integer.
# Your program will then simulate a coin flip operation for as many times as
# the user asks. You will then print out the number of times that HEADS landed,
# as well as the number of times that TAILS landed. Please provide percentages
# that each occurred as well, in addition to ensuring that the user provides
# valid integer input

# ----------------------------------------
# Data Declarations:
.data

getIterations: .asciiz "Number of times to flip coin: "
randomStates: .word 1 1 2 1 2 2 2 1 2 2 2 2 1 1 2 1 1 2 1 1
numRandomStates: .word 20

telemMsgHeads: .asciiz "Heads: "
teleMsgTails: .asciiz "Tails: "
telemMsgParen: .asciiz " ("
teleMsgPercent: .asciiz "%)\n"
oneHundred: .float 100.0

newline: .asciiz "\n"


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# load random states
	la $s0, randomStates
	lw $s1, numRandomStates
	li $s2, 1

	li $v0, 4
	la $a0, getIterations
	syscall
	li $v0, 5	# get number of iterations from user
	syscall
	move $s3, $v0

	li $t7, 0	# heads counter
	li $t8, 0	# tails counter

loop:
	beqz $s3, telemetry
	jal flipCoin

	move $a0, $v0	# move random number to $a0

	addi $s3, $s3, -1	# decrement counter
	beq $a0, 2, isTails

isHeads:
	addi $t7, $t7, 1
	b loop

isTails:
	addi $t8, $t8, 1
	b loop

telemetry:
	# TODO:
	#	Heads: count & percentage
	#	Tails: count & percentage

	# move values to FP registers for division
	mtc1 $t7, $f0
	mtc1 $t8, $f2
	cvt.s.w $f0, $f0
	cvt.s.w $f2, $f2

	add.s $f4, $f0, $f2	# total flips

	div.s $f6, $f0, $f4		# calculate heads percentage
	l.s $f10, oneHundred	# for scaling
	mul.s $f6, $f6, $f10	# scale heads percentage for printing
	sub.s $f8, $f10, $f6	# calculate tails percentage

	# print heads telemetry
	li $v0, 4
	la $a0, telemMsgHeads
	syscall
	li $v0, 1
	move $a0, $t7
	syscall
	li $v0, 4
	la $a0, telemMsgParen
	syscall
	li $v0, 2
	mov.s $f12, $f6
	syscall
	li $v0, 4
	la $a0, teleMsgPercent
	syscall

	# print tails telemetry
	li $v0, 4
	la $a0, teleMsgTails
	syscall
	li $v0, 1
	move $a0, $t8
	syscall
	li $v0, 4
	la $a0, telemMsgParen
	syscall
	li $v0, 2
	mov.s $f12, $f8
	syscall
	li $v0, 4
	la $a0, teleMsgPercent
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl flipCoin
.ent flipCoin
flipCoin:
	# simulates a coin flip
	# returns 1 for HEADS, 2 for TAILS

	beq $s2, $s1, resetState	# reset state counter past the last state

simulateCoin:
	sll $t0, $s2, 2		# calculate offset
	add $t0, $t0, $s0	# calculate address of random state
	lw $v0, ($t0)		# store random number for result
	addi $s2, $s2, 1	# increment state counter

	jr $ra

resetState:
	li $s2, 0
	b simulateCoin

.end flipCoin