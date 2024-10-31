# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

inputFile: .asciiz "/src/src/wk10/nums.txt"
outputFile: .asciiz "/src/src/wk10/output.txt"
buffer: .space 16
newline: .asciiz "\n"

outputMessage: .asciiz "I wrote this using MIPS"
outputMessageEnd:



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
	la $a0, inputFile
	li $a1, 0
	syscall
	move $s0, $v0

	li $t0, 0
	li $t1, 1

read_loop:
	# read line
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 4
	syscall
	move $t0, $v0	# bytes read (0 = EOF, -1 = error)

	blez $t0, end_read

	# convert line to int

	li $v0, 4
	la $a0, buffer
	syscall
	li $v0, 11
	li $a0, 124	# ascii for pipe ('|'')
	syscall

	j read_loop

end_read:
	# close file
	li $v0, 16
	move $a0, $s0
	syscall

write:
	# open file
	li $v0, 13
	la $a0, outputFile
	li $a1, 577	# write mode
	li $a2, 420	# file mode (octal 0644)
	syscall
	move $s0, $v0

	li $v0, 15
	move $a0, $s0
	la $a1, outputMessage
	la $a2, outputMessageEnd
	subu $a2, $a2, $a1
	syscall

	# close file
	li $v0, 16
	move $a0, $s0
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