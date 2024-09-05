
# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

howMany: .asciiz "How many cookies? "
sugar: .asciiz "Sugar: "
butter: .asciiz "Butter: "
flour: .asciiz "Flour: "
newline: .asciiz "\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

li $v0, 4
la $a0, howMany
syscall

# get num
li $v0, 5
syscall
move $t0, $v0

# ratio
li $t1, 48
divu $t2, $t0, $t1

# print sugar
li $v0, 4
la $a0, sugar
syscall
li $v0, 1
li $t3, 2
mul $a0, $t3, $t2
syscall
li $v0, 4
la $a0, newline
syscall

# print butter
li $v0, 4
la $a0, butter
syscall
li $v0, 1
li $t3, 2
mul $a0, $t3, $t2
syscall
li $v0, 4
la $a0, newline
syscall

# print flour
li $v0, 4
la $a0, flour
syscall
li $v0, 1
li $t3, 2
mul $a0, $t3, $t2
syscall
li $v0, 4
la $a0, newline
syscall

# -----
# Done, terminate program.
li $v0, 10
syscall # all done!

.end main