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
buffer: .space 32

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

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main