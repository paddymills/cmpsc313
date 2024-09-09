
# Write a MIPS program that asks the user for an integer value. Your program
# will output “EVEN” if the value is even and “ODD” if the value is odd.

# TODO: documentation

.data
	inputPrompt: .asciiz "Please enter a number: "
	isEven: .asciiz "EVEN\n"
	isOdd: .asciiz "ODD\n"

.text
.globl main
.ent main
main:
	li $v0, 4
	la $a0, inputPrompt
	syscall

	# read integer
	li $v0, 5
	syscall

	# store number in a temp register
	move $t0, $v0

	# set up to show answer (so that we dont' have to do it twice in branches)
	li $v0, 4

	# check if LSB is even or odd
	#	because the immediate value is 0000..001, all except the LSB will be 0
	#	the resulting number will be what the LSB is
	#		0 -> even
	#		1 -> odd
	andi $t1, $t0, 1

	# if result is 0, number is even
	beqz $t1, even
	# else, go to odd
	j odd

even:
	la $a0, isEven
	j end

odd:
	la $a0, isOdd

end:
	# show answer
	syscall

# -----
# Done, terminate program.
li $v0, 10
syscall # all done!

.end main