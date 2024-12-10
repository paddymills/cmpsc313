# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program which takes in an integer from the user. Calculate and
# 	print the square root. If the number is invalid (-1), print Invalid Number.
# 	In all cases print Goodbye once the program is finished execution. Use the
# 	MIPS equivalent of try-catch-finally in your solution.

# ----------------------------------------
# Data Declarations:
.data
	getNumber: .asciiz "Enter a number: "
	sqrtIs: .asciiz "The square root is (approximately): "
	newline: .asciiz "\n"
	goodbye: .asciiz "Goodbye\n"

	fTwo: .float 2.0

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 4
	la $a0, getNumber
	syscall
	li $v0, 5
	syscall

	tlti $v0, 0

	# square root
	move $a0, $v0
	jal sqrt
	mov.s $f12, $f8

	li $v0, 4
	la $a0, sqrtIs
	syscall
	li $v0, 2
	syscall
	li $v0, 4
	la $a0, newline
	syscall

finally:
	li $v0, 4
	la $a0, goodbye
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl sqrt
.ent sqrt
sqrt:
	# find the square root of n using the following algorithm:
	# x = n
	# for (i = 0 to n/2)
	# 	x = (x + n / x) / 2)
	# return x

	# float constants
	l.s $f2, fTwo

	# loop control variables
	li $t6, 0		# i
	srl $t7, $a0, 1	# n / 2

	mtc1 $a0, $f6			# n
	cvt.s.w $f6, $f6		# convert n to float
	mov.s $f8, $f6			# x = n

loop:
	div.s $f12, $f6, $f8	# n / x
	add.s $f12, $f8, $f12	# x + n / x
	div.s $f12, $f12, $f2	# (x + n / x) / 2
	mov.s $f8, $f12			# x = (x + n / x) / 2

	addi $t6, $t6, 1	# i++
	blt $t6, $t7, loop	# i < n / 2

	mov.s $f0, $f8
	jr $ra
.end sqrt

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

	# skip to finally block
	la $k0, finally

	# move this back to coprocessor-0
	mtc0 $k0, $14

	# error return
	eret

.kdata
	invalidNumber: .asciiz "Invalid Number\n"
