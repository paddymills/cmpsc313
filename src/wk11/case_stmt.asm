# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
msgInput: .asciiz "Enter a month(1 to 12): "

# months
jan: .asciiz "JAN\n"
feb: .asciiz "FEB\n"
mar: .asciiz "MAR\n"
apr: .asciiz "APR\n"
may: .asciiz "MAY\n"
jun: .asciiz "JUN\n"
jul: .asciiz "JUL\n"
aug: .asciiz "AUG\n"
sep: .asciiz "SEP\n"
oct: .asciiz "OCT\n"
nov: .asciiz "NOV\n"
dec: .asciiz "DEC\n"

jumpTable: .word L1 L2 L3 L4 L5 L6 L7 L8 L9 L10 L11 L12

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 4
	la $a0, msgInput
	syscall

	li $v0, 5
	syscall
	move $t1, $v0

	# get the address of the jump table
	la $t0, jumpTable

	# get the address of the jump table entry
	sub $t1, $t1, 1		# adjust for 0-based index
	sll $t1, $t1, 2		# scale by word size
	add $t0, $t0, $t1	# get the address of the jump table entry
	lw $t0, 0($t0)		# load the jump table entry

	jalr $t0

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.text
L1:
	la $a0, jan
	j default
L2:
	la $a0, feb
	j default
L3:
	la $a0, mar
	j default
L4:
	la $a0, apr
	j default
L5:
	la $a0, may
	j default
L6:
	la $a0, jun
	j default
L7:
	la $a0, jul
	j default
L8:
	la $a0, aug
	j default
L9:
	la $a0, sep
	j default
L10:
	la $a0, oct
	j default
L11:
	la $a0, nov
	j default
L12:
	la $a0, dec
	j default

default:
	li $v0, 4
	syscall
	jr $ra