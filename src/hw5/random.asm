# Patrick Miller
# Program Name:
# Description:
# 	Included with this assignment is a file named random.txt. It includes a
# 	list of randomly generated numbers. For this assignment you are to open
# 	this file and output how many numbers are in this file. You are to collect
# 	the minimum, maximum, average (integer) and median values as well.
# 	Please write these statistics to a file named output.txt.

# ----------------------------------------
# Data Declarations:
.data
randomFile: .asciiz "/path/to/files/random.txt"
outputFile: .asciiz "/path/to/files/output.txt"

buffer: .space 4
newline: .asciiz "\n"

msgNum: .asciiz "Number of values: "
msgMin: .asciiz "Minimum: "
msgMax: .asciiz "Maximum: "
msgAvg: .asciiz "Average: "
msgMed: .asciiz "Median:  "
msgLast:

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# $s0 = numbers file
	li $s1, 999	# $s1 = minimum
	li $s2, 0	# $s2 = maximum
	li $s3, 0	# $s3 = average
	# $s4 = median
	li $s5, 0	# $s5 = count

	# open file
	li $v0, 13
	la $a0, randomFile
	li $a1, 0
	syscall
	move $s0, $v0

	li $t0, 0		# number
loop_read:
	# read from file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 1
	syscall

	# check for EOF
	beqz $v0, process_num

	# check for newline (any ASCII less than number)
	la $t1, buffer
	lb $t2, 0($t1)
	blt $t2, 48, process_num

	# convert buffer to integer
	sub $t2, $t2, 48
	mul $t0, $t0, 10
	add $t0, $t0, $t2

	j loop_read

process_num:
	beqz $t0, return_to_loop

	move $t7, $v0	# save EOF status

	# increment count
	addi $s5, $s5, 1

	# add to average
	add $s3, $s3, $t0

	# check for min
	blt $t0, $s1, new_min

	# check for max
	bgt $t0, $s2, new_max

	j return_to_loop

new_min:
	move $s1, $t0
	j return_to_loop

new_max:
	move $s2, $t0
	j return_to_loop

return_to_loop:
	beqz $t7, end_read	# check for EOF

	li $t0, 0
	j loop_read

end_read:
	# close file
	li $v0, 16
	move $a0, $s0
	syscall

	# calculate average
	div $s3, $s3, $s5

	j end

write:
	# open file
	li $v0, 13
	la $a0, outputFile
	li $a1, 577	# write mode
	li $a2, 420	# file mode (octal 0644)
	syscall
	move $s0, $v0

write_min:
	move $a0, $s0
	la $a1, msgMin
	li $a2, 9
	move $a3, $s1
	jal write_line

write_max:
	move $a0, $s0
	la $a1, msgMax
	li $a2, 9
	move $a3, $s2
	jal write_line

write_avg:
	move $a0, $s0
	la $a1, msgAvg
	li $a2, 9
	move $a3, $s3
	jal write_line

write_median:
	move $a0, $s0
	la $a1, msgMed
	li $a2, 9
	move $a3, $s4
	jal write_line

	# close file
	li $v0, 16
	move $a0, $s0
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 4
	la $a0, msgNum
	syscall
	li $v0, 1
	move $a0, $s5
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	li $v0, 10
	syscall

.end main

.globl write_line
.ent write_line
write_line:
	# $a0 = file descriptor
	# $a1 = message
	# $a2 = message length
	# $a3 = number

	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3

	li $v0, 15
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	syscall

	# write number
	li $t7, 0	# length counter
loop_num:
	beqz $t3, end_num

	rem $t4, $t3, 10	# remainder
	add $t4, $t4, 48	# convert to ASCII

	subu $sp, $sp, 4
	sw $t4, 0($sp)
	addi $t7, $t7, 1

	div $t3, $t3, 10	# integer division

	j loop_num

write_num:
	beqz $t7, end_num

	lw $t4, 0($sp)
	addu $sp, $sp, 4

	li $v0, 15
	la $a1, buffer
	sb $t4, ($a1)
	li $a2, 1
	syscall

	sub $t7, $t7, 1
	j write_num

end_num:
	li $v0, 15
	move $a0, $t0
	la $a1, newline
	li $a2, 1
	syscall

	jr $ra

.end write_line