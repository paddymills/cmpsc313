# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data
	file_name: .asciiz "/mnt/c/users/pmiller1/src/cmpsc313/src/wk12/output.txt"
	write_buffer: .asciiz "Hello World!"
	write_buffer_eol:

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
	la $a0, file_name
	li $a1, 0x41
	li $a2, 0x1FF
	syscall
	move $s0, $v0

	# write to file
	li $v0, 15
	move $a0, $s0
	la $a1, write_buffer
	la $a2, write_buffer_eol
	subu $a2, $a2, $a1
	syscall

	# close file
	li $v0, 16
	move $a0, $s0
	syscall


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main