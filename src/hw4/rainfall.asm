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

askRainfall: .asciiz "\tEnter the total rainfall for month "
askHighTemp: .asciiz "\tEnter the high temperature for month "
askLowTemp: .asciiz "\tEnter the low temperature for month "
askMonth: .asciiz "Creating month "

msgAvgMonthlyRain: .asciiz " The average monthly rainfall is "
msgTotalRain: .asciiz " The total rainfall is "
msgHighTemp: .asciiz " The highest temperature for the year (and the month it occurred in) is "
msgLowTemp: .asciiz " The lowest temperature for the year (and the month it occurred in) is "
msgAvgTemp: .asciiz " The average of all monthly temperatures is "
occurred_in: .asciiz " and it occurred in month "

sep: .asciiz "---------------------\n"
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	
	# Allocate memory for 12 months
	li $v0, 9
	li $a0, 48
	syscall
	move $s0, $v0

	# Loop through each month
	li $s1, 0
loop:
	beq $s1, 12, calculations

	li $v0, 4
	la $a0, askMonth
	syscall
	li $v0, 1
	addi $a0, $s1, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	jal create_month

	sll $t0, $s1, 2		# calculate offset
	add $t1, $s0, $t0	# calculate address
	sw $v0, ($t1)		# store month in array

	addi $s1, $s1, 1

	# print separator
	li $v0, 4
	la $a0, sep
	syscall

	b loop

calculations:
	# calculate and display the
	# 	• average monthly rainfall
	# 	• total rainfall
	# 	• highest temperature for the year (and the month it occurred in)
	# 	• lowest temperature for the year (and the month it occurred in)
	# 	• average of all monthly temperatures

	lw $t6, ($s0)	# get first month (to preset {high,low}est temp)

	li $t0, 0		# total rainfall
	lw $t1, 4($t6)	# highest temperature (preset as first month)
	li $t2, 1		# highest temperator month (preset as first month)
	lw $t3, 8($t6)	# lowest temperature (preset as first month)
	li $t4, 1		# lowest temperator month (preset as first month)
	li $t5, 0		# average temperature sum

	# Loop through each month
	li $s1, 0
loop_agg:
	beq $s1, 12, print_results

	sll $t6, $s1, 2		# calculate offset
	add $t6, $s0, $t6	# calculate address of month
	lw $t7, ($t6)		# get month structure address

	#lw $t0, 8($s0)	# get third month
	#lw $t1, 4($t0)	# get high temp

	lw $t8, ($t7)		# get rainfall
	add $t0, $t0, $t8	# add rainfall

	lw $t8, 4($t7)		# get high temp
	lw $t9, 8($t7)		# get low temp

	add $t5, $t5, $t8	# add high temp to avg temp
	add $t5, $t5, $t9	# add low temp to avg temp

	bgt $t8, $t1, new_highest
	blt $t9, $t3, new_lowest
	b next_agg

new_highest:
	# update highest
	move $t1, $t8		# get high temp
	addi $t2, $s1, 1

	blt $t9, $t3, new_lowest
	b next_agg

new_lowest:
	# update lowest
	move $t3, $t9		# get low temp
	addi $t4, $s1, 1

	b next_agg

next_agg:
	addi $s1, $s1, 1
	b loop_agg

print_results:
	li $t6, 12	# number of months

	li $v0, 4
	la $a0, sep
	syscall

	# print average monthly rainfall
	li $v0, 4
	la $a0, msgAvgMonthlyRain
	syscall
	li $v0, 1
	div $a0, $t0, $t6	# total rainfall / number of months
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# print total rainfall
	li $v0, 4
	la $a0, msgTotalRain
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# print highest temperature for the year (and the month it occurred in)
	li $v0, 4
	la $a0, msgHighTemp
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, occurred_in
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# print lowest temperature for the year (and the month it occurred in)
	li $v0, 4
	la $a0, msgLowTemp
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, occurred_in
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# print average of all monthly temperatures
	li $v0, 4
	la $a0, msgAvgTemp
	syscall
	li $v0, 1
	div $a0, $t5, $t6	# total temperature / number of months
	srl $a0, $a0, 1		# divide by 2
	syscall
	li $v0, 4
	la $a0, newline
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl create_month
.ent create_month
create_month:
	# Allocate memory for a month
	li $v0, 9
	li $a0, 12
	syscall
	move $t0, $v0

	# Ask for rainfall
	li $v0, 4
	la $a0, askRainfall
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($t0)

	# Ask for high temperature
	li $v0, 4
	la $a0, askHighTemp
	syscall
	li $v0, 5
	syscall
	sw $v0, 4($t0)

	# Ask for low temperature
	li $v0, 4
	la $a0, askLowTemp
	syscall
	li $v0, 5
	syscall
	sw $v0, 8($t0)

	move $v0, $t0
	jr $ra
.end create_month

.globl avg_temp
.ent avg_temp
avg_temp:
	# Calculate average temperature
	lw $t0, 4($a0)		# High temperature
	lw $t1, 8($a0)		# Low temperature
	add $t0, $t0, $t1	# Add high and low
	srl $t0, $t0, 1		# Divide by 2

	move $v0, $t0
	jr $ra
.end avg_temp