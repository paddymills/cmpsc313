# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program which instantiates an object from the Date class
#	as follows:
#		Date d = new Date(10, 31, 2015);
#	With the date object corresponding to the calendar date October 31, 2015.
#	Include a toString() method in your program which will print out the date
#	in this format:
#		10/31/2015

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
	la $a0, date

	lw $t0, 12($a0)
	jalr $t0

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.text
toString:
	# assume the date is in $a0
	lw $t1, 0($a0)	# get month
	lw $t2, 4($a0)	# get day
	lw $t3, 8($a0)	# get year

	# print month
	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 11
	li $a0, 0x2f	# ascii for slash ('/')
	syscall

	# print day
	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 11
	li $a0, 0x2f	# ascii for slash ('/')
	syscall

	# print year
	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 11
	li $a0, 0x0d	# ascii for carriage return ('\r')
	syscall
	li $v0, 11
	li $a0, 0x0a	# ascii for newline ('\n')
	syscall

	jr $ra

.data
date:
	.word 10		# month
	.word 31		# day
	.word 2015		# year
	.word toString	# method

