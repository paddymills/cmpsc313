# Patrick Miller
# Problem 2: Sentinel
# Description:
#   In computer programming a sentinel is a special value that terminates a list
#   of values. For this exercise, you will be collecting a list of temperatures
#   from the user. The number of temperatures the user enters is unknown,
#   however he should be able to terminate the program by entering -99.
#   Once the program is terminated, the average temperature should be output.
#
#   As example of program execution:
#     Enter a temperature (or -99 to quit): 55
#     Enter a temperature (or -99 to quit): 60
#     Enter a temperature (or -99 to quit): 65
#     Enter a temperature (or -99 to quit): -99
#     The average of the temperatures is 60.0

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