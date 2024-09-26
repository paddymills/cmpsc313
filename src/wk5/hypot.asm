# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

aMessage: .asciiz "Enter a: "
bMessage: .asciiz "Enter b: "
cMessage: .asciiz "Hypotenuse is: "
newline: .asciiz "\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    # get a
    li $v0, 4
    la $a0, aMessage
    syscall
    li $v0, 5
    syscall
    move $t0, $v0

    # get b
    li $v0, 4
    la $a0, bMessage
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # calculate hypotenuse
    move $a0, $t0
    move $a1, $t1
    
    jal hypot
    move $a0, $v0

    jal sqrt
    move $t0, $v0

    # print hypotenuse
    li $v0, 4
    la $a0, cMessage
    syscall
    li $v0, 1
    move $a0, $t0
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

.globl hypot
.ent hypot

hypot:
    # input: a in $a0, b in $a1
    # output: hypotenuse in $v0

    mul $a0, $a0, $a0   # a^2
    mul $a1, $a1, $a1   # b^2
    add $v0, $a0, $a1   # a^2 + b^2

    jr $ra

.end hypot

.globl sqrt
.ent sqrt

sqrt:
    # input: number in $a0
    # output: square root in $v0
    # move $v0, $a0

    # x = N
    # iterate 20 times:
    #   x = (x + N/x) / 2

    li $t0, 0
loop:
    div $t1, $v0, $v0   # N/x
    add $v0, $t0, $v0   # x + N/x
    div $v0, $v0, 2     # (x + N/x) / 2

    addi $t0, $t0, 1   # increment counter
    bne $t0, 20, loop

    jr $ra

.end sqrt