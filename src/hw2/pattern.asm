# Patrick Miller
# Problem 1: Pattern
# Description:
#   Write a MIPS assembly language program which asks the user for an integer
#   greater than zero. Your program should output a pattern based on the integer
#   the user enters. For instance, if the user enters 5 for input, you should
#   output the following pattern:
#     *
#     **
#     ***
#     ****
#     *****
#     ****
#     ***
#     **
#     *


# ----------------------------------------
# Data Declarations:
.data

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start



# -----
# Done, terminate program.
end:
    li $v0, 10
    syscall

.end main