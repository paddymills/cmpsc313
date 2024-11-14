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
	# divide by zero
	li $t0, 10
	li $t1, 0
	div $t0, $t1
	mflo $t2
	mfhi $t3

	li $v0, 1
	move $a0, $t2
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main