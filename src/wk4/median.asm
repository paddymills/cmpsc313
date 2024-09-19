# find the median of an even list of numbers

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
arr: .word 1 3 5 8 12 16
size: .word 6
denom: .float 2.0

outputMessage: .asciiz "The median is: "
newline: .asciiz "\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    lw $t0, size
    div $t2, $t0, 2
    sub $t1, $t2, 1

    # address of list
    la $t3, arr

    # offsets
    mul $t1, $t1, 4
    mul $t2, $t2, 4
    add $t4, $t1, $t3 # first offset
    add $t5, $t2, $t3 # second offset

    # load the values
    lw $t6, ($t4)
    lw $t7, ($t5)

    # move to FP-reg for calcs
    mtc1 $t6, $f12
    cvt.s.w $f12, $f12
    mtc1 $t7, $f14
    cvt.s.w $f14, $f14

    # add and divide by 2
    add.s $f16, $f12, $f14
    l.s $f18, denom
    div.s $f20, $f16, $f18

    li $v0, 4
    la $a0, outputMessage
    syscall
    li $v0, 2
    mov.s $f12, $f20
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