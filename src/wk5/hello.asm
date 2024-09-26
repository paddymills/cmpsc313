# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

helloMessage: .asciiz "Hello, world!\n"


# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

    jal hello

# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall # all done!

.end main

.ent hello
hello:
    li $v0, 4
    la $a0, helloMessage
    syscall

    jr $ra
.end hello