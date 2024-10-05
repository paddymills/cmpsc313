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



# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	jal flipCoin

	move $a0, $v0	# move random number to $a0
	li $v0, 1		# print int syscall
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

	li $v0, 41			# random number generator syscall
	xor $a0, $a0, $a0	# select random generator 0
	syscall				# generate random int into $a0

	move $v0, $a0		# store the random number in $v0
	jr $ra

.end flipCoin