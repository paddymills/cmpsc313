# will reverse an array using the stack

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

arr: .word 4 54 23 12 9 2 1 0
length: .word 8
newline: .asciiz "\n"
whitespace: .asciiz " "

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

# ------ push numbers onto stack ------
    li $t0, 0       # index counter
    lw $t1, length  # length
    la $t2, arr     # array
push:
    beq $t0, $t1, end_push

    lw $t3, ($t2)       # load number
    subu $sp, $sp, 4    # decrement stack pointer
    sw $t3, ($sp)       # push number onto stack

    addi $t2, $t2, 4    # increment array pointer (4=size of word)
    addi $t0, $t0, 1    # increment index counter
    j push

end_push:

# ------ pop off of stack onto array ------
    li $t0, 0       # index counter
    lw $t1, length  # length
    la $t2, arr     # array
pop:
    beq $t0, $t1, end_pop

    lw $t3, ($sp)       # pop number off stack
    addi $sp, $sp, 4    # increment stack pointer
    sw $t3, ($t2)       # store number in array

    addi $t2, $t2, 4    # increment array pointer (4=size of word)
    addi $t0, $t0, 1    # increment index counter
    j pop

end_pop:
# ------ Print sorted array ------
    li $t0, 0       # index counter
    lw $t1, length  # length
    la $t2, arr     # array
print_sorted:
    bge $t0, $t1, done_sorted

    # Print the array element
    li $v0, 1
    lw $a0, ($t2)
    syscall
    li $v0, 4
    la $a0, whitespace    
    syscall

    addi $t2, $t2, 4    # increment array pointer (4=size of word)
    addi $t0, $t0, 1    # increment index counter

    j print_sorted

done_sorted:
    li $v0, 4
    la $a0, newline
    syscall


# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall # all done!

.end main