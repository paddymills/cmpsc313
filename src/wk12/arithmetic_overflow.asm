# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
overflow_msg: .asciiz "Overflow detected\n"



# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
# -----

	# Load the values into registers
	li $t0, 2147483647	# Max positive
	li $t1, 1

	# Add the values
	add $t2, $t0, $t1

	# Check for overflow
	bne $t2, $t0, overflow

	# No overflow, print the result
	li $v0, 1
	move $a0, $t2
	syscall

	# Done, terminate program
	j end

overflow:
	# Overflow, print an error message
	li $v0, 4
	la $a0, overflow_msg
	syscall

	# Done, terminate program
	j end

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main