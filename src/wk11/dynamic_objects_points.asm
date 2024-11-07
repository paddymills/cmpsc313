# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# allocate point1 dynamically
	li $v0, 9
	li $a0, 12
	syscall
	sw $v0, point1
	li $t0, 3
	sw $t0, 0($v0)
	li $t0, 5
	sw $t0, 4($v0)
	la $t0, print
	sw $t0, 8($v0)

	lw $a0, point1
	lw $t0, 8($a0)
	jalr $t0

	# allocate point2 dynamically
	li $v0, 9
	li $a0, 12
	syscall
	sw $v0, point2
	li $t0, 1
	sw $t0, 0($v0)
	li $t0, 0
	sw $t0, 4($v0)
	la $t0, print
	sw $t0, 8($v0)

	lw $a0, point2
	lw $t0, 8($a0)
	jalr $t0


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main


.text
print:
	# assume the point is in $a0
	lw $t1, 0($a0)	# get x
	lw $t2, 4($a0)	# get y

	li $v0, 4
	la $a0, pointMsg1
	syscall

	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 4
	la $a0, pointMsg2
	syscall

	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 4
	la $a0, pointMsg3
	syscall

	jr $ra

.data
pointMsg1: .asciiz "Point: ("
pointMsg2: .asciiz ", "
pointMsg3: .asciiz ")\n"

# objects
.data
point1: .word 0
point2: .word 0
	#.word 1		# x
	#.word 0		# y
	#.word print	# method