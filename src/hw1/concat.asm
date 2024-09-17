# For this problem, you will write a MIPS program that will ask the user for two
# strings. You will then print out a string containing the concatenation of the
# second string and the first string (in that order.) As an example, if “Hello”
# and “World” were inputted by the user in that order, you will output the
# “WorldHello”.

.data

	word1: .space 50
	word2: .space 50

	word1Prompt: .asciiz "enter the first word(50 characters max): "
	word2Prompt: .asciiz "enter the second word(50 characters max): "
    output: .asciiz "The reverse concatenation is: "
	newline: .asciiz "\n"

.text
.globl main
.ent main
main:
	# ask for word 1
	li $v0, 4	# print string
	la $a0, word1Prompt
	syscall
	# read word 1
	li $v0, 8	# read a string
	la $a0, word1
	li $a1, 16
	syscall

	# ask for word 2
	li $v0, 4	# print string
	la $a0, word2Prompt
	syscall
	# read word 2
	li $v0, 8	# read a string
	la $a0, word2
	li $a1, 16
	syscall

# remove newline from end of word 2
removeNewline:
	li $t0, 0	# initialize array index counter
	li $t2, 10	# ascii character for '\n'
loop:
	lb $t1, word2($t0)	# load character of string at index $t0
	beq $t1, $t2, replace	# newline found, goto replace
	addi $t0, $t0, 1	# increment counter
	bnez $t1, loop	# repeat if not at end of string (\0)
replace:
	sb $zero, word2($t0)	# replace with line termination (\0)

print:
	# print output label
	li $v0, 4	# print string
	la $a0, output
	syscall
	# print word 2
	li $v0, 4	# print string
	la $a0, word2
	syscall
	# print word 1
	li $v0, 4	# print string
	la $a0, word1
	syscall
	# print newline
	li $v0, 4	# print string
	la $a0, newline
	syscall

	# end
	li $v0, 10	# end program
	syscall
.end main
