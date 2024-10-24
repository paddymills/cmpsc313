# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

msgAge: .asciiz "Age: "
msgPay: .asciiz "Pay: "
msgClass: .asciiz "Class: "
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

	# age
	li $t0, 25
	sw $t0, 0($s0)

	# pay
	li $t0, 1000
	sw $t0, 4($s0)

	# class
	li $t0, 1
	sw $t0, 8($s0)

	move $a0, $s0
	jal print_struct


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl print_struct
.ent print_struct
print_struct:
	# push $s0 on stack
	sub $sp, $sp, 4
	sw $s0, 0($sp)

	move $s0, $a0

	li $v0, 4
	la $a0, msgAge
	syscall
	li $v0, 1
	lw $a0, 0($s0)
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	li $v0, 4
	la $a0, msgPay
	syscall
	li $v0, 1
	lw $a0, 4($s0)
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	li $v0, 4
	la $a0, msgClass
	syscall
	li $v0, 1
	lw $a0, 8($s0)
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# restore $s0 from stack
	lw $s0, 0($sp)
	add $sp, $sp, 4

	jr $ra
.end print_struct