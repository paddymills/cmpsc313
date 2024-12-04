# Patrick Miller
# Program Name:
# Description:
#	Included in the assignment is a file named people.txt. For this assignment
#	you are to read the file and construct a person object for each of the
#	lines in the file. As an example: Person p = new Person(“Henry”, “Smith”);
#	Include a toString() method in your file which will simply print out the
#	name of the person representing the object.

# ----------------------------------------
# Data Declarations:
.data
peopleFile: .asciiz "/src/src/hw5/people.txt"
bufferFirst: .space 32
bufferLast: .space 32
buffer: .space 64

testFirst: .asciiz "Henry"
testLast: .asciiz "Smith"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 1
	li $a0, 0
	syscall

	j test

	# open file
	li $v0, 13
	la $a0, peopleFile
	li $a1, 0
	syscall
	move $s0, $v0

	li $t0, 0
loop_read:
	# read line
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 4
	syscall
	move $t0, $v0	# bytes read (0 = EOF, -1 = error)

	li $v0, 1
	move $a0, $t0
	syscall

	blez $t0, end_read

	li $v0, 4
	la $a0, buffer
	syscall

	j loop_read

end_read:
	li $v0, 16
	move $a0, $s0
	syscall

test:
	la $a0, testFirst
	la $a1, testLast
	jal Person
	move $s0, $v0

	# print Person
	move $a0, $s0
	lw $t0, 0($s0)
	jalr $t0

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl Person
.ent Person
Person:
	# assume the first name is in $a0 and last name is in $a1
	la $t0, toString
	move $t1, $a0
	move $t2, $a1

	# allocate object dynamically
	li $v0, 9
	li $a0, 12
	syscall

	# build object jump table
	sw $t0, 0($v0)
	sw $t1, 4($v0)
	sw $t2, 8($v0)

	jr $ra

.end Person

.text
toString:
	# assume the Person object is in $a0
	lw $t0, 4($a0)	# get first name
	lw $t1, 8($a0)	# get last name

	li $v0, 4
	la $a0, ($t0)
	syscall

	li $v0, 11
	li $a0, 0x20	# ascii for space (' ')
	syscall

	li $v0, 4
	la $a0, ($t1)
	syscall

	# print "\n" (line feed + carriage return)
	li $v0, 11
	li $a0, 0x0A
	syscall
	li $v0, 11
	li $a0, 0x0D
	syscall

	jr $ra
