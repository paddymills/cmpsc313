# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

speed: .word 70
time1: .word 6
time2: .word 10
time3: .word 15

output1: .asciiz "The car traveled "
output2: .asciiz " miles in "
output3: .asciiz " hours\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

lw $t0, speed

# 6hrs
lw $t1, time1
li $v0, 4
la $a0, output1
syscall
li $v0, 1
mul $a0, $t0, $t1
syscall
li $v0, 4
la $a0, output2
syscall
li $v0, 1
lw $a0, time1
syscall
li $v0, 4
la $a0, output3
syscall

# 0hrs
lw $t1, time2
li $v0, 4
la $a0, output1
syscall
li $v0, 1
mul $a0, $t0, $t1
syscall
li $v0, 4
la $a0, output2
syscall
li $v0, 1
lw $a0, time2
syscall
li $v0, 4
la $a0, output3
syscall

# 15hrs
lw $t1, time3
li $v0, 4
la $a0, output1
syscall
li $v0, 1
mul $a0, $t0, $t1
syscall
li $v0, 4
la $a0, output2
syscall
li $v0, 1
lw $a0, time3
syscall
li $v0, 4
la $a0, output3
syscall

# -----
# Done, terminate program.
li $v0, 10
syscall # all done!

.end main