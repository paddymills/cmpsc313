.text

	# instructions go here

	.globl main

# int main() {
main:

	# int num = 10;
	lw $t1, num	# lw -> "load word"
	
	# "sw" -> "store word", sends from register back to memory
	
    # num += 10;
	# e.g. $t2 = $t1 + $t1
	add $t2, $t1, $t1
	sw $t2, num
	
    # num += 10;
	# e.g. $t3 = $t2 + $t2
	li $t4, 10
	add $t3, $t2, $t4
	sw $t3, num
	
    # printf("%d\n", num);    // 30
	li $v0, 1	# print int
	lw $a0, num
	syscall
	li $v0, 4	# print string
	la $a0, newline
	syscall

	# return 0;
	li $v0, 10	# end program
	syscall

.data

	# variables go
	num: .word 10
	newline: .asciiz "\n"