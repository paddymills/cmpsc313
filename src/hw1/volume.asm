
# Patrick Miller

# Write a MIPS program which asks the user for the radius of a sphere. Your
# program will then output the volume of the sphere. If the user enters a negative
# value for the radius of the sphere, output an error message. Assume the radius
# of the sphere is a floating-point number.

# Volume
#    4               3
#   --- * pi * radius
#    3

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
pi: .float 3.14159
three: .float 3.0
four: .float 4.0

inputPrompt: .asciiz "Enter the radius of the sphere: "
outputLabel: .asciiz "The volume of the spere is: "

isNegative: .asciiz "Error: a sphere cannot have a negative radius"
newline: .asciiz "\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:
# -----
	# ask for radius
	li $v0, 4
	la $a0, inputPrompt
	syscall

	# read float
	li $v0, 6
	syscall

	# if number is negative, go to error
	cvt.w.s $f2, $f0
	mfc1 $t0, $f2	# load input (float) into integer register
	bltz $t0, error

calculate:
	# $f2 = 4/3
	l.s $f4, four
	l.s $f6, three
	div.s $f2, $f4, $f6

	# $f4 = pi
	l.s $f4, pi

	# $f6 = radius^3
	mul.s $f6, $f0, $f0
	mul.s $f6, $f6, $f0

	# $f8: putting it all together
	mul.s $f8, $f2, $f4
	mul.s $f8, $f8, $f6

	# print output
	li $v0, 4
	la $a0, outputLabel
	syscall

	# print volume
	li $v0, 2
	mov.s $f12, $f8
	syscall

	j end

error:
	li $v0, 4
	la $a0, isNegative
	syscall
	j end

end:
	li $v0, 4
	la $a0, newline
	syscall
	# -----
	# Done, terminate program.
	li $v0, 10
	syscall
.end main