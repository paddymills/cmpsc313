# Patrick Miller
# Problem 5: Power Tower
# Description:
#   Consider the following function that is defined as an infinite power of
#   exponents:
#       y(x) = x^x^x^...
#   We can call this function the power tower function. This function takes two
#   inputs, a base (a) and an exponent (k.)
#
#   For instance, if a = 2 and k = 3, the following should be computed:
#       2^2^2
#
#   For this exercise you will write a MIPS program that accepts those
#   two values as input from the user. Your program should then calculate the
#   power tower based on those values. (As a hint, this problem can be solved
#   using iteration and accumulators.)
#   Also note evaluation is done from right to left.

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