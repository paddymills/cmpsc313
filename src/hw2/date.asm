# Patrick Miller
# Problem 4: Date
# Description:
#   Write a MIPS program which accepts three integers from the user, a month
#   (between 1 and 12), a day (between 1 and 31) and a four-digit year. Your
#   program should use input-validation loops to loop until the user enters a
#   valid date. For instance, if the user enters 4 for the month, 31 for the day
#   and 1996 for the year, the user would be asked to enter all three of these
#   values again since April 31st is an invalid calendar date.
#
#   Assume 30 days in September, April, June and November.
#   Also ensure that your code handles the rules for leap year determination.
#   Your program should halt once a valid date is entered by the user.

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