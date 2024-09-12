# Roulette Wheel
# input: roulette number from 0 to 36
# output: color of the number
# - 0 is green
# - red
#   - 1 to 10  odd
#   - 11 to 19 even
#   - 20 to 28 odd
#   - 29 to 36 even
# - black
#   - 1 to 10 even
#   - 11 to 19 odd
#   - 20 to 28 even
#   - 29 to 36 odd

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

inputMessage: .asciiz "Enter a number between 0 and 36: "
greenOutput: .asciiz "Green\n"
redOutput: .asciiz "Red\n"
blackOutput: .asciiz "Black\n"
invalidOutput: .asciiz "Invalid input\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    li $v0, 4
    la $a0, inputMessage
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 0
    blt $t0, $t1, invalid
    li $t1, 36
    bgt $t0, $t1, invalid

    beqz $t0, green
    ble $t0, 10, checkRedIsOdd
    ble $t0, 19, checkRedIsEven
    ble $t0, 28, checkRedIsOdd
    j checkRedIsEven

checkRedIsEven:
    # case where color is red if number is even
    rem $t1, $t0, 2
    beqz $t1, redOutput
    j blackOutput
checkRedIsOdd:
    # case where color is red if number is odd
    rem $t1, $t0, 2
    beqz $t1, blackOutput
    j redOutput

green:
    la $a0, greenOutput
    j print
red:
    la $a0, redOutput
    j print
black:
    la $a0, blackOutput
    j print

invalid:
    la $a0, invalidOutput
    j print

print:
    li $v0, 4
    syscall
# -----
# Done, terminate program.

    li $v0, 10
    syscall # all done!

.end main