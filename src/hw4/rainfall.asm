# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program that uses a structure to store the following weather
# 	data for a month:
# 		• Total Rainfall
# 		• High Temperature
# 		• Low Temperature
# 		• Average Temperature
#
# 	Your program should have a list of 12 structures to hold weather data for an
# 	entire year. When your program runs, it should ask the user to enter data
# 	for each month (the average temperature should be calculated.) Once the data
# 	is entered for all months, your program should calculate and display the
# 	average monthly rainfall, the total rainfall, the highest and lowest
# 	temperatures for the year (and the months they occurred in), and the average
# 	of all monthly temperatures.

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