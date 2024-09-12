# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

gradeInput: .asciiz "Enter your grade: "
gradeA: .asciiz "A\n"
gradeB: .asciiz "B\n"
gradeC: .asciiz "C\n"
gradeD: .asciiz "D\n"
gradeF: .asciiz "F\n"
invalidInput: .asciiz "Invalid input\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
# Prompt user for grade
    li $v0, 4
    la $a0, gradeInput
    syscall
    li $v0, 5 # read integer
    syscall

    bgt $v0, 100, invalid
    bge $v0, 90, A
    bge $v0, 80, B
    bge $v0, 70, C
    bge $v0, 60, D
    bge $v0, 0, F
    j invalid

A:
    la $a0, gradeA
    j print
B:
    la $a0, gradeB
    j print
C:
    la $a0, gradeC
    j print
D:
    la $a0, gradeD
    j print
F:
    la $a0, gradeF
    j print
invalid:
    la $a0, invalidInput
    j print

print:
    li $v0, 4
    syscall

# -----
# Done, terminate program.
    li $v0, 10
    syscall # all done!

.end main