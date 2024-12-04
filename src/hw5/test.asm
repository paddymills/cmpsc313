
# ----------------------------------------
# Data Declarations:
.data
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
	la $a0, testFirst
	la $a1, testLast

	jal constructPerson
	move $s0, $v0

	move $a0, $s0
	lw $t0, 0($s0)
	jalr $t0

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl constructPerson
.ent constructPerson
constructPerson:
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
.end constructPerson

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
