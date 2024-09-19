# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

inputPromptFirst: .asciiz "Enter two integers\n  First: "
inputPromptSecond: .asciiz "  Second: "
headerMessage: .asciiz "Num\tNum^2\n"
tab: .asciiz "\t"
newline: .asciiz "\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:
# -----
# your program code goes here.

    # get number 1
    li $v0,4
    la $a0,inputPromptFirst
    syscall
    li $v0,5
    syscall
    move $t0,$v0

    # get number 2
    li $v0,4
    la $a0,inputPromptSecond
    syscall
    li $v0,5
    syscall
    move $t1,$v0

    li $v0,4
    la $a0,headerMessage
    syscall

    move $t2,$t0
loop:
    bgt $t2,$t1,end

    mul $t3,$t2,$t2

    # print {num1}\t{num2}\n
    li $v0,1
    move $a0,$t2
    syscall
    li $v0,4
    la $a0,tab
    syscall
    li $v0,1
    move $a0,$t3
    syscall
    li $v0,4
    la $a0,newline
    syscall

    add $t2,$t2,1

    j loop


# -----
# Done, terminate program.
end:
    li $v0,4
    la $a0,newline
    syscall
    li $v0, 10
    syscall # all done!

.end main