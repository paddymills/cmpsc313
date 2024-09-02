.text

	.globl main
main:

	# int length, width;

    # // area of a rectangle
    # printf("enter length: ");
	li $v0, 4	# print string
	la $a0, lengthInput
	syscall
	
    # scanf("%d", &length);
	li $v0, 5	# read an int
	syscall
	# $v0 has the read value
	sw $v0, length
	
    # printf("enter width: ");
	li $v0, 4	# print string
	la $a0, widthInput
	syscall
	
    # scanf("%d", &width)
	li $v0, 5	# read an int
	syscall
	# $v0 has the read value
	sw $v0, width
	
    # int area = length * width;
	lw $t0, length
	lw $t1, width
	mul $t2, $t0, $t1	# t2 = t0 * t1
	sw $t2, area
	
    # printf("Area of a rectangle: %d\n", area);
	li $v0, 4	# print string
	la $a0, areaOutput
	syscall
	li $v0, 1	# print int
	lw $a0, area
	syscall
	li $v0, 4	# print string
	la $a0, newline
	syscall

    # return 0;
	li $v0, 10	# end program
	syscall


.data

	length: .word 0
	width: .word 0
	area: .word 0

	lengthInput: .asciiz	"enter length: "
	widthInput: .asciiz	"enter width: "
	areaOutput: .asciiz	"Area of a rectangle: "
	newline: .asciiz	"\n"
	
