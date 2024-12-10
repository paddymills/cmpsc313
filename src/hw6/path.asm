# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program where the user enters a file path (e.g. C:\Windows\win.ini)
# 	and then will display its contents on the screen. Make sure the program
# 	captures all possible exceptions and prints user- friendly error messages. 

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