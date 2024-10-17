# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

getX1: .asciiz "Enter Point1 x: "
getY1: .asciiz "Enter Point1 y: "
getX2: .asciiz "Enter Point2 x: "
getY2: .asciiz "Enter Point2 y: "

outPoint1: .asciiz "Point: { x: "
outPoint2: .asciiz ", y: "
outPoint3: .asciiz " }\n"

newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start

	# point 1
	li $v0, 4
	la $a0, getX1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0

	li $v0, 4
	la $a0, getY1
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

	# allocate point
	li $v0, 9
	li $a0, 8
	syscall
	move $s0, $v0
	sw $t0, 0($s0)	# store x
	sw $t1, 4($s0)	# store y

	# point 1
	li $v0, 4
	la $a0, getX2
	syscall
	li $v0, 5
	syscall
	move $t0, $v0

	li $v0, 4
	la $a0, getY2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

	# allocate point
	li $v0, 9
	li $a0, 8
	syscall
	move $s1, $v0
	sw $t0, 0($s1)	# store x
	sw $t1, 4($s1)	# store y


	# print point
	move $a0, $s0
	jal print_point
	move $a0, $s1
	jal print_point

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end 

.globl print_point
.ent print_point
print_point:
	# preserve $s0 and $s1 (not strictly needed, but good practice)
	sub $sp, $sp, 8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	move $t0, $a0

	li $v0, 4
	la $a0, outPoint1
	syscall

	lw $a0, 0($t0)
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, outPoint2
	syscall

	lw $a0, 4($t0)
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, outPoint3
	syscall

	jr $ra

.end print_point