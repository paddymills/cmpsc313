#
#   This prints hello world!



#
#	we have two segments, .text and .data


.text

	# program code
	
	# declare main as a global function
	.globl main
	
main:

	# printf("Hello World\n");
	li $v0, 4	# print string
	
	# li -> "load immediate", la -> "load array"
	la $a0, msg

	# execute
	syscall

	# return 0;
	li $v0, 10	# system call for exit
	
	# execute
	syscall


.data

# define our variables
msg: .asciiz "Hello World\n"


