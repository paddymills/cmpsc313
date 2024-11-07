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
	la $a0, point1
	lw $t0, 8($a0)
	jalr $t0

	la $a0, point2
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
point1:
	.word 3		# x
	.word 5		# y
	.word print	# method
point2:
	.word 1		# x
	.word 0		# y
	.word print	# method