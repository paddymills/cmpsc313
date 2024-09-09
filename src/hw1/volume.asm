
# Patrick Miller

# Write a MIPS program which asks the user for the radius of a sphere. Your
# program will then output the volume of the sphere. If the user enters a negative
# value for the radius of the sphere, output an error message. Assume the radius
# of the sphere is a floating-point number.

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