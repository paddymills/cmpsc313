
# Write a MIPS program that will ask the user for two integers a and b. Your
# program will output the integer division result of a / b if b != 0. Your
# program should output “ERROR” if otherwise.

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations


# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.


# -----
# Done, terminate program.
li $v0, 10
syscall # all done!

.end main