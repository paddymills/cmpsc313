# Name and general description of program
# bmi = (weight * 703) / height^2

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

inputWeight: .asciiz "Enter your weight in pounds: "
inputHeight: .asciiz "Enter your height in inches: "
outputBmi: .asciiz "Your BMI is: "
newline: .asciiz "\n"

CONST_703: .float 703.0

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    li $v0, 4
    la $a0, inputWeight
    syscall
    li $v0, 6
    syscall
    mov.s $f12, $f0

    li $v0, 4
    la $a0, inputHeight
    syscall
    li $v0, 6
    syscall
    mov.s $f14, $f0

    # bmi = (weight * 703) / height^2
    # (weight * 703)
    l.s $f10, CONST_703
    mul.s $f16, $f12, $f10

    # height^2
    mul.s $f18, $f14, $f14

    # bmi = (weight * 703) / height^2
    div.s $f20, $f16, $f18

    li $v0, 4
    la $a0, outputBmi
    syscall

    li $v0, 2
    mov.s $f12, $f20
    syscall

    li $v0, 4
    la $a0, newline
    syscall

# -----
# Done, terminate program.
    li $v0, 10
    syscall # all done!

.end main