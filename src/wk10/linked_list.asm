# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

numNodes: .asciiz "Nodes: "
arrow: .asciiz " -> "
newline: .asciiz "\n"
containsTwo: .asciiz "Contains 2: "
containsFive: .asciiz "Contains 5: "

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# 1 -> 2 -> 3
	li $v0, 9
	li $a0, 8
	syscall
	move $s0, $v0

	move $t0, $s0
	li $t1, 1
	li $t2, 4
loop_create:
	beq $t1, $t2, end_create
	sw $t1, 0($t0)

	li $v0, 9
	li $a0, 8
	syscall
	sw $v0, 4($t0)

	move $t0, $v0
	addi $t1, $t1, 1

	j loop_create
end_create:
	move $a0, $s0
	jal print_linked_list

	# add to head
	move $a0, $s0
	li $a1, 8
	jal add_to_head
	move $s0, $v0
	move $a0, $s0
	jal print_linked_list

	# remove head
	move $a0, $s0
	jal remove_head
	move $s0, $v0
	move $a0, $s0
	jal print_linked_list

	move $a0, $s0
	jal count_linked_list
	move $t0, $v0

	li $v0, 4
	la $a0, numNodes
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# contains 2
	li $v0, 4
	la $a0, containsTwo
	syscall
	move $a0, $s0
	li $a1, 2
	jal contains_value
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# contains 5
	li $v0, 4
	la $a0, containsFive
	syscall
	move $a0, $s0
	li $a1, 5
	jal contains_value
	move $a0, $v0
	li $v0, 1
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

.globl print_linked_list
.ent print_linked_list
print_linked_list:
	# Print linked list
	move $t0, $a0

print_loop:
	li $v0, 1
	lw $a0, 0($t0)
	syscall

	lw $t0, 4($t0)
	lw $t1, 0($t0)
	beq $t1, $zero, end_print

	# ' -> '
	li $v0, 4
	la $a0, arrow
	syscall

	j print_loop

end_print:
	li $v0, 4
	la $a0, newline
	syscall

	jr $ra

.end print_linked_list

# input:
# 	$a0 -> head
.globl count_linked_list
.ent count_linked_list
count_linked_list:
	move $t0, $a0

	li $t1, 0
count_loop:
	lw $t2, 0($t0)
	beq $t2, $zero, end_count

	addi $t1, $t1, 1
	lw $t0, 4($t0)
	j count_loop

end_count:
	move $v0, $t1
	jr $ra

.end count_linked_list

# input:
# 	$a0 -> head
# 	$a1 -> value
# output:
# 	$v0 -> new head
.globl add_to_head
.ent add_to_head
add_to_head:
	move $t0, $a0	# head
	move $t1, $a1	# value

	li $v0, 9
	li $a0, 8
	syscall
	sw $t1, 0($v0)
	sw $t0, 4($v0)

	# move $v0, $v0
	jr $ra
.end add_to_head

# input:
# 	$a0 -> head
# output:
# 	$v0 -> new head
.globl remove_head
.ent remove_head
remove_head:
	move $t0, $a0

	lw $v0, 4($t0)
	jr $ra
.end remove_head

# input:
# 	$a0 -> head
# 	$a1 -> value
# output:
# 	$v0 -> 1 if value is in linked list, 0 otherwise
.globl contains_value
.ent contains_value
contains_value:
	move $t0, $a0
	move $t1, $a1

contains_loop:
	lw $t2, 0($t0)
	beq $t2, $t1, contains_true

	lw $t0, 4($t0)
	bne $t0, $zero, contains_loop

	# does not contain value
	li $v0, 0
	jr $ra

contains_true:
	li $v0, 1
	jr $ra

.end contains_value
