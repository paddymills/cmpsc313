# Patrick Miller
# Problem 5: Power Tower
# Description:
#   Consider the following function that is defined as an infinite power of
#   exponents:
#       y(x) = x^x^x^...
#   We can call this function the power tower function. This function takes two
#   inputs, a base (a) and an exponent (k.)
#
#   For instance, if a = 2 and k = 3, the following should be computed:
#       2^2^2
#
#   For this exercise you will write a MIPS program that accepts those
#   two values as input from the user. Your program should then calculate the
#   power tower based on those values. (As a hint, this problem can be solved
#   using iteration and accumulators.)
#   Also note evaluation is done from right to left.

# ----------------------------------------
# Data Declarations:
.data

inputBaseMsg: .asciiz "Enter the base: "
inputExponentMsg: .asciiz "Enter the exponent: "
errorNegativeMsg: .asciiz "Exponent must be positive. Try Again."

outputMsg: .asciiz "The Power Tower for "
degreeMsg: .asciiz " to the degree of "
isMsg: .asciiz " is "
newline: .asciiz "\n"


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# get base
	li $v0,4
	la $a0,inputBaseMsg
	syscall
	li $v0,5
	syscall
	move $s0,$v0

	# get exponent
	li $v0,4
	la $a0,inputExponentMsg
	syscall
	li $v0,5
	syscall
	move $s1,$v0

	bltz $s1, errorNegative	# if exponent is negative

	li $t0,1
	beqz $s1, output	# if exponent is 0, output 1


	# calculate power tower
	move $t0, $s0   		# copy base to answer
	li $t1, 1				# degree counter
loop:
	move $s2, $t0			# copy answer to output register
	beq $t1, $s1, output	# if degree counter == exponent, output result

	addi $t1, $t1, 1		# increment degree counter
	move $t0, $s0			# copy base to accumulator
	li $t3, 1				# multiplication counter
power:
	beq $t3, $t1, loop		# if multiplication counter == degree counter, go to next degree

	mul $t0, $t0, $t0		# multiply accumulator by itself
	addi $t3, $t3, 1		# increment multiplication counter
	j power

errorNegative:
	li $v0,4
	la $a0,errorNegativeMsg
	syscall
	b main


output:
	li $v0,4
	la $a0,outputMsg
	syscall
	li $v0,1    # print base
	move $a0,$s0
	syscall
	li $v0,4
	la $a0,degreeMsg
	syscall
	li $v0,1    # print exponent
	move $a0,$s1
	syscall
	li $v0,4
	la $a0,isMsg
	syscall
	li $v0,1    # print result
	move $a0,$s2
	syscall
	li $v0,4
	la $a0,newline
	syscall


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main