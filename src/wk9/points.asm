# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
msgPoint1: .asciiz "Point "
msgPoint2: .asciiz " ("
msgPoint3: .asciiz ", "
msgPoint4: .asciiz ")\n"

undef: .asciiz "Slope is undefined\n"
msgSlope: .asciiz "Slope: "
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 9
	li $a0, 16
	syscall
	move $s0, $v0	# point 1
	add $s1, $s0, 8	# point 2

	# point 1
	li $t0, 22
	sw $t0, 0($s0)

	li $t0, 78
	sw $t0, 4($s0)

	# point 2
	li $t0, 2
	sw $t0, 0($s1)

	li $t0, 33
	sw $t0, 4($s1)

	li $a0, 1
	move $a1, $s0
	jal print_point

	li $a0, 2
	move $a1, $s1
	jal print_point

	move $a0, $s0
	move $a1, $s1

	jal slope
	move $t0, $v0

	beqz $t0, end

	li $v0, 4
	la $a0, msgSlope
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, newline
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl print_point
.ent print_point
print_point:
	# $s0 is point number
	# $s1 is point address

	sub $sp, $sp, 8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	move $s0, $a0
	move $s1, $a1

	li $v0, 4
	la $a0, msgPoint1
	syscall

	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, msgPoint2
	syscall

	li $v0, 1
	lw $a0, 0($s1)
	syscall

	li $v0, 4
	la $a0, msgPoint3
	syscall

	li $v0, 1
	lw $a0, 4($s1)
	syscall

	li $v0, 4
	la $a0, msgPoint4
	syscall

	lw $s0, 0($sp)
	lw $s1, 4($sp)
	add $sp, $sp, 8

	jr $ra

.end print_point



.globl slope
.ent slope
slope:
	sub $sp, $sp, 8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	move $s0, $a0
	move $s1, $a1

	lw $t0, 0($s1)
	lw $t1, 0($s0)
	sub $t2, $t0, $t1
	beqz $t2, slope_undef

	lw $t0, 4($s1)
	lw $t1, 4($s0)
	sub $t3, $t0, $t1

	div $t4, $t3, $t2
	move $v0, $t4

	b end_slope


slope_undef:
	li $v0, 4
	la $a0, undef
	syscall

	li $v0, 0

end_slope:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	add $sp, $sp, 8

	jr $ra


.end slope