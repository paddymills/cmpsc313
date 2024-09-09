#


.data

	word1: .asciiz 50
	word2: .asciiz 50

	word1Prompt: .asciiz "enter the first word: "
	word2Prompt: .asciiz "enter the second word: "
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
	syscall

	# ask for word 2
	li $v0, 4	# print string
	la $a0, word2Prompt
	syscall
	# read word 2
	li $v0, 8	# read a string
	la $a0, word2
	syscall

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
