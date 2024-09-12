
# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
.neverPrint: .asciiz "This will never be printed\n"
.alwaysPrint: .asciiz "This will always be printed\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

    j alwaysCall

neverCall:
    li $v0, 4
    la $a0, neverPrint
    syscall


alwaysCall:
    li $v0, 4
    la $a0, alwaysPrint
    syscall


# -----
# Done, terminate program.
li $v0, 10
syscall # all done!

.end main