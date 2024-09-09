
# Write a MIPS program that will take in two integers from the user. Your
# program should output which of the two numbers is larger than the other.

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