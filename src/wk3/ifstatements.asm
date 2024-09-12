
# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

COLD_TEMP: .word 30
enterMessage: .asciiz "Enter the temperature: "
coatMessage: .asciiz "Wear a coat\n"
sunscreenMessage: .asciiz "Wear sunscreen\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

    li $v0, 4
    la $a0, enterMessage
    syscall

    li $v0, 5 # read integer
    syscall # $v0 has result
    move $t0, $v0

    lw $t1, COLD_TEMP
    blt $t0, $t1, coat

sunscreen:
    li $v0, 4
    la $a0, sunscreenMessage
    syscall
    j done

coat:
    li $v0 4
    la $a0, coatMessage
    syscall

# -----
# Done, terminate program.
done:
    li $v0, 10
    syscall # all done!

.end main