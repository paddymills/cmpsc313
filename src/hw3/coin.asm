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

newline: .asciiz "\n"


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 4
	la $a0, getIterations
	syscall
	li $v0, 5	# get number of iterations from user
	syscall
	move $t0, $v0

loop:
	beqz $t0, telemetry
	jal flipCoin

	move $a0, $v0	# move random number to $a0
	li $v0, 1		# print int syscall
	syscall

telemetry:
	# TODO:
	#	Heads: count & percentage
	#	Tails: count & percentage

# -----
# Done, terminate program.
end:
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 10
	syscall

.end main

.globl flipCoin
.ent flipCoin
flipCoin:
	# simulates a coin flip
	# returns 1 for HEADS, 2 for TAILS

	# hardcode 1 for testing
	li $a0, 1

	move $v0, $a0		# store the random number in $v0
	jr $ra

.end flipCoin