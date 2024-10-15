#  Name and general description of program
# ---------------------------------------

#  Data declarations go in this section.
.data

inputMessage: .asciiz "Enter a number: "
outputMessage: .asciiz "The fibonacci number is "

# program specific data declarations

# ---------------------------------------
#  Program code goes in this section.
.text

.globl main
.ent main
main:

# ----
# your program code goes here.

    # int n;
    # printf("Enter a number: ");
    # scanf("%d", &n);
    li $v0, 4
    la $a0, inputMessage
    syscall
    li $v0, 5
    syscall
    move 	$a0, $v0		# $a0 = $v0

    # // calculate the nth fibonacci number
    # int result = fib(n);
    jal fib

    # // print the result
    # printf("The %dth fibonacci number is %d\n", n, result);
    move 	$t0, $v0		# $t0 = $v0
    li $v0, 4
    la $a0, outputMessage
    syscall
    li $v0, 1
    move 	$a0, $t0		# $a0 = $t0
    syscall

    # ----
    #  Done, terminate program.
    li $v0, 10
    syscall


.end main
# all done


#   input: $a0
#   output: $v0
.globl fib 
.ent fib
fib:

    # preserve the return address
    sub $sp, $sp, 8
    sw	$ra, 0($sp)		# 
    sw  $s0, 4($sp)

    move 	$t0, $a0		# $t0 = $a0
    beq		$t0, $0, baseCaseZero	# if $t0 == $0 then goto baseCaseZero
    li		$t1, 1		# $t1 = 1
    beq		$t0, $t1, baseCaseOne	# if $t0 == $t1 then goto target
    j recursiveCase

baseCaseZero:
    # if (n == 0) {
    #     return 0;
    # }
    li $v0, 0
    j done

baseCaseOne:    
    # if (n == 1) {
    #     return 1;
    # }
    li $v0, 1
    j done

recursiveCase:

    # fib(n-1)
    move 	$s0, $a0		# $s0 = $a0
    addi	$a0, $a0, -1			# $s0 = $s0 + -1
    jal fib

    # fib(n-2)
    move 	$a0, $s0		# $a0 s0$t1
    addi	$a0, $a0, -2			# $a0 = $a0 + -2
    move 	$s0, $v0		# $s0 = $v0
    jal fib

    # return fib(n - 1) + fib(n - 2);
    add		$v0, $s0, $v0		# $v0 = $s0 + $v0
    


done:   
    lw		$ra, 0($sp)		# 
    lw      $s0, 4($sp)
    add $sp, $sp, 8
    jr $ra
.end fib