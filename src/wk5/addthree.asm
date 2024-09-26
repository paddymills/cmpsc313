# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

firstMessage: .asciiz "Enter first number: "
secondMessage: .asciiz "Enter second number: "
thirdMessage: .asciiz "Enter third number: "
resultMessage: .asciiz "The sum of the three numbers is: "
newline: .asciiz "\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

    # Print "Enter first number: "
    la $a0, firstMessage
    li $v0, 4
    syscall

    # Read first number
    li $v0, 5
    syscall
    # push number onto stack
    subu $sp, $sp, 4
    sw $v0, ($sp)

    # Print "Enter second number: "
    la $a0, secondMessage
    li $v0, 4
    syscall

    # Read second number
    li $v0, 5
    syscall
    # push number onto stack
    subu $sp, $sp, 4
    sw $v0, ($sp)

    # Print "Enter third number: "
    la $a0, thirdMessage
    li $v0, 4
    syscall

    # Read third number
    li $v0, 5
    syscall
    # push number onto stack
    subu $sp, $sp, 4
    sw $v0, ($sp)

    # call addThree
    jal addThree

    # pop result off stack
    lw $t0, ($sp)
    addi $sp, $sp, 4

    # Print "The sum of the three numbers is: "
    la $a0, resultMessage
    li $v0, 4
    syscall

    # Print result
    li $v0, 1
    move $a0, $t0
    syscall

    # Print newline
    la $a0, newline
    li $v0, 4
    syscall

    j end

# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall # all done!

.end main

.globl addThree
.ent addThree
addThree:
    # first number
    lw $t0, ($sp)
    addi $sp, $sp, 4

    # second number
    lw $t1, ($sp)
    addi $sp, $sp, 4

    # third number
    lw $t2, ($sp)
    addi $sp, $sp, 4

    li $t3, 0
    add $t3, $t0, $t1
    add $t3, $t3, $t2

    # write result to stack
    subu $sp, $sp, 4
    sw $t3, ($sp)

    jr $ra

.end addThree