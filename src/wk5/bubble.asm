# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

arr: .word 8 3 5 2 9 7
length: .word 6
beforeMessage: .asciiz "Before sorting: "
afterMessage: .asciiz "After sorting: "
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
    
    # Print "Before sorting: \n"
    la $a0, beforeMessage
    li $v0, 4
    syscall
    la $a0, newline
    li $v0, 4
    syscall

# ------ Print unsorted array ------
    li $t0, 0       # index counter
    lw $t1, length  # length
    la $t2, arr     # array
print_unsorted:
    bge $t0, $t1, done_unsorted

    # Print the array element
    li $v0, 1
    lw $a0, ($t2)
    syscall
    li $v0, 4
    la $a0, whitespace    
    syscall

    addi $t2, $t2, 4    # increment array pointer (4=size of word)
    addi $t0, $t0, 1    # increment index counter

    j print_unsorted

done_unsorted:
    li $v0, 4
    la $a0, newline
    syscall

# ------ Bubble Sort ------    
    li $t0, 1       # did swap (bool)
    lw $t1, length  # length

bubble_while:
    beqz $t0, done_bubble

    la $t2, arr     # load array pointer
    li $t3, 1       # index counter
    li $t0, 0       # reset did swap
bubble_for:
    beq $t3, $t1, bubble_while
    lw $t4, ($t2)   # current element
    lw $t5, 4($t2)  # next element
    bgt $t4, $t5, swap
    b continue_bubble_for
swap:
    sw $t5, ($t2)   # arr[i] = arr[i+1]
    sw $t4, 4($t2)  # arr[i+1] = temp
    li $t0, 1       # set did swap = true
continue_bubble_for:
    addi $t2, $t2, 4    # increment array pointer (4=size of word)
    addi $t3, $t3, 1    # increment index counter
    j bubble_for
done_bubble:


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