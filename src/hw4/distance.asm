# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program using a structure to represent a coordinate (with x and
# 	 y values as integers.) Prompt the user for two coordinates and use a
# 	structure for each. With this data in place, calculate the distance between
# 	the two points. As you recall, the distance between two points can be
# 	calculated as:
# 		d = sqrt((x2 - x1)^2 + (y2 - y1)^2)

# ----------------------------------------
# Data Declarations:
.data

fTwo: .float 2.0

pt1: .asciiz "Point 1\n-------\n"
pt2: .asciiz "Point 2\n-------\n"
getX: .asciiz "Enter x: "
getY: .asciiz "Enter y: "

distanceMsg: .asciiz "The distance between the two points is: "
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start

	li $v0, 4
	la $a0, pt1
	syscall
	jal create_point
	move $s0, $v0

	li $v0, 4
	la $a0, pt2
	syscall
	jal create_point
	move $s1, $v0

	move $a0, $s0
	move $a1, $s1
	jal calc_distance

	li $v0, 4
	la $a0, distanceMsg
	syscall

	li $v0, 2
	mov.s $f12, $f0
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 10
	syscall

.end main

.globl calc_distance
.ent calc_distance
calc_distance:
	lw $t0, 0($a0)	# x1
	lw $t1, 4($a0)	# y1
	lw $t2, 0($a1)	# x2
	lw $t3, 4($a1)	# y2

	sub $t4, $t2, $t0	# x2 - x1
	mul $t4, $t4, $t4	# (x2 - x1)^2
	sub $t5, $t3, $t1	# y2 - y1
	mul $t5, $t5, $t5	# (y2 - y1)^2
	add $t4, $t4, $t5	# (x2 - x1)^2 + (y2 - y1)^2


sqrt:
	# find the square root of n using the following algorithm:
	# x = n
	# for (i = 0 to n/2)
	# 	x = (x + n / x) / 2)
	# return x

	# float constants
	l.s $f2, fTwo

	# loop control variables
	li $t6, 0		# i
	srl $t7, $t4, 1	# n / 2

	mtc1 $t4, $f6			# n
	cvt.s.w $f6, $f6		# convert n to float
	mov.s $f8, $f6			# x = n

loop:
	div.s $f12, $f6, $f8	# n / x
	add.s $f12, $f8, $f12	# x + n / x
	div.s $f12, $f12, $f2	# (x + n / x) / 2
	mov.s $f8, $f12			# x = (x + n / x) / 2

	addi $t6, $t6, 1	# i++
	blt $t6, $t7, loop	# i < n / 2

	mov.s $f0, $f8
	jr $ra
.end calc_distance

.globl create_point
.ent create_point
create_point:
	# allocate point
	li $v0, 9
	li $a0, 8
	syscall
	move $t0, $v0

	li $v0, 4
	la $a0, getX
	syscall
	li $v0, 5
	syscall
	sw $v0, ($t0)	# store x

	li $v0, 4
	la $a0, getY
	syscall
	li $v0, 5
	syscall
	sw $v0, 4($t0)	# store y

	move $v0, $t0
	jr $ra
.end create_point