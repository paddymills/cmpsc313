# Patrick Miller
# Program Name:
# Description:
# 	Included in the assignment is a file named people.txt. For this assignment
# 	you are to read the file and construct a person object for each of the
# 	lines in the file. As an example: Person p = new Person("Henry", "Smith");
# 	Include a toString() method in your file which will simply print out the
# 	name of the person representing the object.

# ----------------------------------------
# Data Declarations:
.data
peopleFile: .asciiz "/mnt/c/Users/pmiller1/src/cmpsc313/src/hw5/people.txt"
buffer: .space 4

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# open file
	li $v0, 13
	la $a0, peopleFile
	li $a1, 0
	syscall
	move $s0, $v0

	# $t0 = bytes read
	# $t1 = buffer
	# $t2 = buffer[0]
	# -------------------
	# $t3 = First name buffer
	# $t4 = Last name buffer

	li $t6, 0x2C	# ascii for comma (',')
	li $t7, 0x0A	# ascii for newline ('\n')
init_person:
	li $v0, 9
	li $a0, 68	# 32 bytes for first name, 32 bytes for last name, 4 bytes for jump table
	syscall
	move $s0, $v0
	addi $t3, $s0, 0
	addi $t4, $s0, 32

	la $t0, toString
	sw $t0, 64($s0)

loop_read_last:
	# read from file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 1
	syscall

	move $t0, $v0	# bytes read (0 = EOF, -1 = error)
	beqz $t0, end_read

	la $t1, buffer
	lb $t2, 0($t1)
	beq $t2, $t6, loop_read_first

	# write to buffer
	sb $t2, 0($t4)
	addi $t4, $t4, 1

	j loop_read_last

loop_read_first:
	# read from file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 1
	syscall

	move $t0, $v0	# bytes read (0 = EOF, -1 = error)
	beqz $t0, finalize_person

	la $t1, buffer
	lb $t2, 0($t1)
	beq $t2, $t7, finalize_person

	# write to buffer
	sb $t2, 0($t3)
	addi $t3, $t3, 1

	j loop_read_first

finalize_person:
	move $a0, $s0
	lw $t0, 64($s0)
	jalr $t0

	j init_person

end_read:
	# close file
	li $v0, 16
	move $a0, $s0
	syscall

	j end

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.text
toString:
	# assume the Person object is in $a0
	addi $t0, $a0, 0	# first name
	addi $t1, $a0, 32	# last name

loop_print_first:
	lb $a0, 0($t0)
	beqz $a0, print_space

	li $v0, 11
	syscall

	addi $t0, $t0, 1

	j loop_read_first

print_space:
	li $v0, 11
	li $a0, 0x20	# ascii for space (' ')
	syscall

loop_print_last:
	lb $a0, 0($t1)
	beqz $a0, print_newline

	li $v0, 11
	syscall

	addi $t1, $t1, 1

	j loop_read_last

print_newline:
	# print "\n" (line feed + carriage return)
	li $v0, 11
	li $a0, 0x0A
	syscall
	li $v0, 11
	li $a0, 0x0D
	syscall

	jr $ra
