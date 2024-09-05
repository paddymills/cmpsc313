# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations
name:   .asciiz ""
address:    .asciiz ""
city:    .asciiz ""
state:    .asciiz ""
zip:    .asciiz ""
phone:    .asciiz ""
major:    .asciiz ""

nameInput:  .asciiz "enter your name: "
addressInput:  .asciiz "enter your name: "
cityInput:  .asciiz "enter your name: "
stateInput:  .asciiz "enter your name: "
zipInput:  .asciiz "enter your name: "
phoneInput:  .asciiz "enter your name: "
majorInput:  .asciiz "enter your name: "

nameOutput: .asciiz "name: "
addressOutput: .asciiz "address: "
cityOutput: .asciiz "city: "
stateOutput: .asciiz "state: "
zipOutput: .asciiz "zip: "
phoneOutput: .asciiz "phone: "
majorOutput: .asciiz "major: "

newline:    .asciiz "\n"

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.

# get name
la $a0, nameInput
li $v0, 4   # print string
syscall
la $a0, name
li $a1, 250
li $v0, 8   # read string
syscall

# get address
la $a0, addressInput
li $v0, 4   # print string
syscall
la $a0, address
li $a1, 250
li $v0, 8   # read string
syscall

# print output
la $a0, nameOutput
li $v0, 4
syscall
la $a0, name
li $v0, 4
syscall
la $a0, newline
li $v0, 4
syscall
la $a0, addressOutput
li $v0, 4
syscall
la $a0, address
li $v0, 4
syscall
la $a0, newline
li $v0, 4
syscall

# -----
# Done, terminate program.
li $v0, 10
syscall # all done!

.end main