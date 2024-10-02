# Patrick Miller
# Problem 1: Pattern
# Description:
#   Write a MIPS assembly language program which asks the user for an integer
#   greater than zero. Your program should output a pattern based on the integer
#   the user enters. For instance, if the user enters 5 for input, you should
#   output the following pattern:
#     *
#     **
#     ***
#     ****
#     *****
#     ****
#     ***
#     **
#     *


# ----------------------------------------
# Data Declarations:
.data

inputMessage: .asciiz "Pattern length: "
invalidMessage: .asciiz "Length must be greater than 0\n"

star: .asciiz "*"
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
    li $v0,4        # ask for number
    la $a0,inputMessage
    syscall
    li $v0,5        # read number
    syscall
    move $t0,$v0    # store number

    blez $t0,invalid

    li $t1,1        # iteration counter (line length)
    li $t2,1        # movement direction (increase/decrease)
loop:
    li $t3,0        # for counting number of stars printed
printLoop:
    # exit if line length == stars printed
    beq $t1, $t3, endPrintLoop

    li $v0,4        # print star
    la $a0,star
    syscall

    add $t3, $t3, 1 # increment star counter
    b printLoop

endPrintLoop:
    li $v0,4            # print newline
    la $a0,newline
    syscall

    add $t1, $t1, $t2   # increment iteration counter

    # if line length == user number, reverse direction
    beq $t1, $t0, reverseDirection
    # else, next
    b nextIteration

reverseDirection:
    li $t2,-1   # start descending pattern
nextIteration:
    beqz $t1, end
    b loop

invalid:
    li $v0,4    # report invalid number
    la $a0,invalidMessage
    syscall
    b main      # retry input

# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall

.end main