# from a list of numbers, find the min/max and number of occurences

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
arr: .word 63 53 49 48 10 79 50 74 74 12
size: .word 10

outputMin: .asciiz "Min: "
outputMax: .asciiz "Max: "
occur: .asciiz ", Occurences: "
newline: .asciiz "\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    # counter
    li $t0, 0
    lw $t9, size

    # load array
    la $t1, arr
    lw $t2, ($t1)    # min
    lw $t3, ($t1)    # max

loopMinMax:
    beq $t0, $t9, output
    mul $t4, $t0, 4
    add $t5, $t1, $t4

checkMin:
    bge $t2, $t5, checkMax
    move $t2, $t5

checkMax:
    ble $t3, $t5, nextIter
    move $t3, $t5

nextIter:
    addi $t0, $t0, 1
    j loopMinMax

loopOccur:
    # TODO

output:
    li $v0, 4
    la $a0, outputMin
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, outputMax
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall
# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall # all done!

.end main