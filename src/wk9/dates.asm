# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
slash: .asciiz "/"
newline: .asciiz "\n"


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 9
	li $a0, 12
	syscall
	move $s0, $v0

	# day
	li $t0, 25
	sw $t0, 0($s0)

	# month
	li $t0, 12
	sw $t0, 4($s0)

	# year
	li $t0, 2021
	sw $t0, 8($s0)

	move $a0, $s0
	jal print_date


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl print_date
.ent print_date
print_date:
	sub $sp, $sp, 4
	sw $s0, 0($sp)

	move $s0, $a0

	li $v0, 1
	lw $a0, 0($s0)
	syscall

	li $v0, 4
	la $a0, slash
	syscall

	li $v0, 1
	lw $a0, 4($s0)
	syscall

	li $v0, 4
	la $a0, slash
	syscall

	li $v0, 1
	lw $a0, 8($s0)
	syscall

	li $v0, 4
	la $a0, newline
	syscall

	lw $s0, 0($sp)
	add $sp, $sp, 4

	jr $ra
.end print_date