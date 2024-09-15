
# Patrick Miller


# Write a MIPS program that will ask the user for two integers a and b. Your
# program will output the integer division result of a / b if b != 0. Your
# program should output “ERROR” if otherwise.

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

inputNum: .asciiz "Enter the numerator: "
inputDenom: .asciiz "Enter the denominator: "
outputResult: .asciiz "The integer quotient is: "

errorLabel: .asciiz "ERROR"
newline: .asciiz "\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
	# get numerator
	li $v0, 4
	la $a0, inputNum
	syscall
	li $v0, 5
	syscall
	move $t0, $v0

	# get denominator
	li $v0, 4
	la $a0, inputDenom
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

calculate:
	# error if denominator is 0
	beqz $t1, error

	# calculate
	div $t3, $t0, $t1

	# print value
	li $v0, 4
	la $a0, outputResult
	syscall
	li $v0, 1
	move $a0, $t3
	syscall

	b end

error:
	li $v0, 4
	la $a0, errorLabel
	syscall

	b end

end:
	li $v0, 4
	la $a0, newline
	syscall

	# -----
	# Done, terminate program.
	li $v0, 10
	syscall # all done!

.end main