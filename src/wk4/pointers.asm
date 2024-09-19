# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
x: .word 10
newline: .asciiz "\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    # print x = 10
    li $v0,1
    lw $a0,x
    syscall
    li $v0,4
    la $a0,newline
    syscall

    # load address
    la $t0,x
    # TODO: print

    # deref
    lw $t1,($t0)

    # print deref
    li $v0,1
    move $a0,$t1
    syscall
    li $v0,4
    la $a0,newline
    syscall


# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall # all done!

.end main