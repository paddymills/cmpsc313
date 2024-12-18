# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program where the user enters a file path (e.g. C:\Windows\win.ini)
# 	and then will display its contents on the screen. Make sure the program
# 	captures all possible exceptions and prints user-friendly error messages. 

# ----------------------------------------
# Data Declarations:
.data

promptFile: .asciiz "Enter the full path of the file: "
filename: .space 128
buffer: .space 17	# 16 characters + null terminator
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# get file name
	li $v0, 4
	la $a0, promptFile
	syscall
	li $v0, 8
	la $a0, filename
	li $a1, 128
	syscall

	jal removeNewline

open_file:
	# open file
	li $v0, 13
	la $a0, filename
	li $a1, 0
	syscall

	tlti $v0, 0	# trap on open error
	move $s0, $v0
read_loop:
	# read line
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 16
	syscall
	move $t0, $v0	# bytes read (0 = EOF, -1 = error)

	beqz $t0, end_read
	tlti $t0, 0		# trap on read error

	# replace with line termination (\0)
	# this keeps the last read line from printing characters from the buffer
	# 	that remain from the previous line
	sb $zero, buffer($t0)

	# print line
	li $v0, 4
	la $a0, buffer
	syscall

	j read_loop

end_read:
	# close file
	li $v0, 16
	move $a0, $s0
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


# remove newline from end of word 2
# with help of this post: https://stackoverflow.com/questions/13630989/how-to-remove-newline-in-mips
.globl removeNewline
.ent removeNewline
removeNewline:
	li $t0, 0	# initialize array index counter
	li $t2, 10	# ascii character for '\n'
loop:
	lb $t1, filename($t0)	# load character of string at index $t0
	beq $t1, $t2, replace	# newline found, goto replace
	addi $t0, $t0, 1	# increment counter
	bnez $t1, loop	# repeat if not at end of string (\0)
replace:
	sb $zero, filename($t0)	# replace with line termination (\0)

	jr $ra

.end removeNewline


.ktext 0x80000180  # Generic exception vector

    # save a0 and v0
    move 	$k0, $a0		# $k0 = $a0
    move 	$k1, $v0		# $k1 = $v0

    li $v0, 4
    la $a0, readError
    syscall

    # restore the registers
    move 	$a0, $k0		# $a0 = $k0
    move 	$v0, $k1		# $v0 = $k1

    # skip to end block
	la $k0, end

    # move this back to coprocessor-0
    mtc0 $k0, $14

    # error return
    eret

.kdata
	openError: .asciiz "Error opening file"
    readError: .asciiz "Error reading file"