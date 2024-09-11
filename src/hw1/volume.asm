
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
radius: .float 0.0

inputPrompt: .asciiz "Enter the radius of the sphere: "
outputLabel: .asciiz "The volume of the spere is"

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

	bltz $f0, error

calc:
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
	syscall # all done!

.end main