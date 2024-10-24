# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
space: .asciiz " "
# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 9
	li $a0, 20	# 5 ints
	syscall
	move $s0, $v0
	move $s1, $s0

	li $t0, 0
	li $t1, 5
read_loop:
	bge $t0, $t1, print

	add $t2, $t0, 1
	sw $t2, 0($s0)
	add $s0, $s0, 4
	add $t0, $t0, 1
	j read_loop

print:
	move $s0, $s1
	li $t0, 0
	li $t1, 5
print_loop:
	bge $t0, $t1, done_loop

	li $v0, 1
	lw $a0, 0($s0)
	syscall
	li $v0, 4
	la $a0, space
	syscall

	add $s0, $s0, 4
	add $t0, $t0, 1
	j print_loop
done_loop:


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main