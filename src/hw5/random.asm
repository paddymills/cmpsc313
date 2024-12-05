# Patrick Miller
# Program Name:
# Description:
#	Included with this assignment is a file named random.txt. It includes a
#	list of randomly generated numbers. For this assignment you are to open
#	this file and output how many numbers are in this file. You are to collect
#	the minimum, maximum, average (integer) and median values as well.
#	Please write these statistics to a file named output.txt.

# ----------------------------------------
# Data Declarations:
.data
randomFile: .asciiz "/mnt/c/Users/pmiller1/src/cmpsc313/src/hw5/random.txt"
outputFile: .asciiz "/mnt/c/Users/pmiller1/src/cmpsc313/src/hw5/output.txt"

buffer: .space 4

msgMin: .asciiz "Minimum: "
msgMax: .asciiz "Maximum: "
msgAvg: .asciiz "Average: "
msgMed: .asciiz "Median: "
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# $s0 = people file
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

	li $t0, 0

loop_read:
	# read from file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 4
	syscall

	# check for EOF
	beqz $v0, process_num


	# check for minimum
	slt $t0, $s1, $a0
	beq $t0, 1, set_min
	move $s1, $a0

process_num:
	# increment count
	addi $s5, $s5, 1

	add $s3, $s3, $t0



	beqz $v0, end_read

end_read:
	# close file
	li $v0, 16
	move $a0, $s0
	syscall

	j end

write:
	# open file
	li $v0, 13
	la $a0, outputFile
	li $a1, 1
	syscall
	move $s0, $v0

	# write to file

	# close file
	li $v0, 16
	move $a0, $s0
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main