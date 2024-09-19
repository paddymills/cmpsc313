# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

arr: .word 1 2 3 4 5
size: .word 5
newline: .asciiz "\n"
# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    li $t0,0   # i = 0
    la $t1,arr

loop:
    bge $t0,5,end

    # x = 2*x
    mul $t2,$t0,4   # offset = size of word * i
    add $t4,$t1,$t2 # 
    lw $t5, ($t4)
    mul $t5,$t5,2
    #sw $t5, 0($t4)

    li $v0,1
    move $a0,$t5,
    syscall
    li $v0,4
    la $a0,newline
    syscall

    # increment
    add $t0,$t0,1

    j loop

# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall # all done!

.end main