# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

grades: .word  88  97  79  85  88
		.word  68  87  90  78  88
		.word  94 100  90  96 100
num_students: .word 3
num_grades: .word 5

message: .asciiz "Average: "
newline: .asciiz "\n"


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	la $a0, grades
	jal compute_class_average

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl compute_class_average
.ent compute_class_average
compute_class_average:
	# rows -> $a0
	move $s0, $a0

	lw $t0, num_grades
	lw $t1, num_students

	li $t2, 0

outer_loop:
	bge $t2, $t0, done
	li $t3, 0	# sum
	li $t4, 0	# row counter

inner_loop:
	bge $t4, $t1, test_avg

	# arr[row][col] = base_address + (row * num_cols + col) * data_size
	mul $t5, $t4, $t0	# row_offset = row * num_cols
	add $t5, $t5, $t2	# offset = row_offset + col
	sll $t5, $t5, 2		# offset *= data_size
	add $t7, $s0, $t5	# item = base_address + offset

	lw $t8, ($t7)		# item = arr[row][col]
	add $t3, $t3, $t8	# sum += item
	div $t8, $t3, $t1	# sum / num_students

	addi $t4, $t4, 1
	j inner_loop

test_avg:
	li $v0, 4
	la $a0, message
	syscall
	li $v0, 1
	move $a0, $t8
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	addi $t2, $t2, 1
	j outer_loop

done:
	jr $ra

.end compute_class_average