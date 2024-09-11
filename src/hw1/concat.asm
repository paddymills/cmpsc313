# For this problem, you will write a MIPS program that will ask the user for two
# strings. You will then print out a string containing the concatenation of the
# second string and the first string (in that order.) As an example, if “Hello”
# and “World” were inputted by the user in that order, you will output the
# “WorldHello”.

.data

	word1: .asciiz ""
	word2: .asciiz ""

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
