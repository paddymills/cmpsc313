# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
	number: .asciiz "123"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	la $a0, number
	jal atoi
	move $t0, $v0

	addi $t0, $t0, 10

	li $v0, 1
	move $a0, $t0
	syscall

	# print "\n" (line feed + carriage return)
	li $v0, 11
	li $a0, 0x0A
	syscall
	li $v0, 11
	li $a0, 0x0D
	syscall


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl atoi
.ent atoi
atoi:
	# convert a string to an integer
	# assume the string is in $a0
	# return the integer in $v0
	li $v0, 0
	li $t0, 0
loop:
	lb $t1, 0($a0)		# load byte
	beqz $t1, done		# if byte is zero, we're done

	sub $t1, $t1, 0x30	# convert ascii to integer
	mul $v0, $v0, 10	# shift existing number left (base 10)
	add $v0, $v0, $t1	# add new digit
	addi $a0, $a0, 1	# advance to next byte

	j loop
done:
	jr $ra
.end atoi