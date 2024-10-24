# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

arrow: .asciiz " -> "
head: .word 0

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
	jal init_linked_list

	la $a0, head
	jal print_linked_list

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl init_linked_list
.ent init_linked_list
init_linked_list:
	# Create linked list
	li $v0, 9
	li $a0, 8
	syscall
	move $s0, $v0

	# Store head of linked list
	sw $v0, head

	li $t0, 1
	li $t1, 4
loop_init:
	beq $t0, $t1, end_init

	# Create linked list node
	li $v0, 9
	li $a0, 8
	syscall
	sw $t0, 0($s0)	# store value
	sw $v0, 4($s0)	# store next node

	add $t0, $t0, 1
	move $s0, $v0
	j loop_init

end_init:
	la $s0, head
	jr $ra
.end init_linked_list

.globl print_linked_list
.ent print_linked_list
print_linked_list:
	move $s0, $a0
loop:
	lw $s1, 0($s0)
	beq $s1, $zero, end_print

	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 11
	li $a0, 32
	syscall

	lw $s0, 4($s0)
	j loop

end_print:
	jr $ra
.end print_linked_list
