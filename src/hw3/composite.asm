# Patrick Miller
# Program Name: composite
# Description:
# In Mathematics, a prime number is an integer which is only divisible by the
# numbers 1 and itself. Examples of prime numbers include the integers
# 3, 11 and 17. Likewise a composite number is any number that is not a
# prime number. For this assignment you will create a MIPS function named
# isComposite which you can use to determine whether an integer is composite or
# not. Using this newly written MIPS function, calculate the first 100 composite
# numbers and display them to standard output.

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

.globl isComposite
.main isComposite
start:

loop:

end:
	jr $ra

.end isComposite