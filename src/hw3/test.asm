# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

arr: .word 1, 2, 3, 4, 5
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	la $t0, arr
	addi $t0, $t0, 8

	# print number at array position
	li $v0, 1
	lw $a0, ($t0)
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	addi $t1, $t0, 8
	sub $t2, $t1, $t0
	div $t2, $t2, 4

	# print number at later array position
	li $v0, 1
	lw $a0, ($t1)
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# print length to end
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, newline
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main