# Patrick Miller
# Problem 3: Magic Square
# Description:
#   The Lo Shu Magic Square is a grid with 3 rows and 3 columns.
#   The Lo Shu Magic Square has the following properties:
#     • The grid contains 1 through 9 exactly
#     • The sum of each row, each column and each diagonal add up to the same number
#
#   You can simulate this programmatically using a two-dimensional array.
#   Write a MIPS program that prompts the user for three rows of the square.
#   You should output whether the input is a Lo Shu Magic Square.
#
#      15   15  15   15
#       ^   ^   ^    ^
#       |   |   |   /
#     -------------
#     | 4 | 9 | 2 | -> 15
#     -------------
#     | 3 | 5 | 7 | -> 15
#     -------------
#     | 8 | 1 | 6 | -> 15
#     -------------
#                  \
#                  15

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