
.text

	.globl main
main:

	# int length, width;

    # // area of a rectangle
    # printf("enter length: ");
	li $v0, 4	# print string
	la $a0, word1Prompt
	syscall
	li $v0, 8	# read a string
    la $a0, word1
    la $a1, 16
	syscall

	li $v0, 4	# print string
	la $a0, word2Prompt
	syscall
	li $v0, 8	# read a string
    la $a0, word2
    la $a1, 16
	syscall
	
	li $v0, 4	# print string
	la $a0, output
	syscall
	li $v0, 4	# print string
	lw $a0, word2
	syscall
	li $v0, 4	# print string
	lw $a0, word1
	syscall
	li $v0, 4	# print string
	la $a0, newline
	syscall

    # return 0;
	li $v0, 10	# end program
	syscall


.data

	word1: .asciiz	""
	word2: .asciiz	""

	word1Prompt: .asciiz    "enter the first word: "
	word2Prompt: .asciiz    "enter the second word: "
    output: .asciiz "The reverse concatenation is: "
	newline: .asciiz	"\n"
	
