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

maxMonth: .word 12
maxDay: .word 31
maxYear: .word 9999
sajnMonths: .word 4,6,9,11

inputDay: .asciiz "Enter the day: "
inputMonth: .asciiz "Enter the month: "
inputYear: .asciiz "Enter the year: "

invalidDayMsg: .asciiz "Invalid Day. Try again.\n"
invalidMonthMsg: .asciiz "Invalid Month. Try again.\n"
invalidYearMsg: .asciiz "Invalid Year. Try again.\n"
validDateMsg: .asciiz "That is a valid date.\n"
# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start

	lw $t1, maxMonth
	lw $t2, maxYear
	lw $t3, maxDay

getDate:
	# get month
	la $a0,inputMonth	# load prompt
	jal getNum
	lw $t0,($sp)	# pull result off of stack
	beqz $t0,invalidMonth
	bgt $t0,$t1,invalidMonth

	la $t5, sajnMonths
	li $t6, 4	# number of sajn months
	li $t7, 0	# index
	li $t8, 0	# day adder to offset comparison for September, April, June, November
sajnValidate:
	beq $t7,$t6,getDay	# array searched

	lw $t8,($t5)	# load month index from array
	addi $t5,$t5,4	# increment array pointer
	addi $t7,$t7,1	# increment index
	bne $t0,$t8,sajnValidate

	# month is September, April, June, or November
	li $t8, 1	# day adder

getDay:
	# get day
	la $a0,inputDay	# load prompt
	jal getNum
	lw $t0,($sp)	# pull result off of stack
	beqz $t0,invalidDay

	add $t0, $t0, $t8	# add day adder to compensate for September, April, June, November
	bgt $t0,$t3,invalidDay


validateYear:
	# get year
	la $a0,inputYear	# load prompt
	jal getNum
	lw $t0,($sp)	# pull result off of stack
	beqz $t0,invalidYear
	bgt $t0,$t2,invalidYear

	# is a valid date
	li $v0,4
	la $a0,validDateMsg
	syscall
	b end

invalidMonth:
	li $v0,4
	la $a0,invalidMonthMsg
	syscall
	b getDate

invalidDay:
	li $v0,4
	la $a0,invalidDayMsg
	syscall
	b getDate

invalidYear:
	li $v0,4
	la $a0,invalidYearMsg
	syscall
	b getDate



# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl getNum
.ent getNum
getNum:
	li $v0,4		# write prompt
	syscall
	li $v0,5		# read word from user
	syscall

	sw $v0,($sp)	# push result to stack

	jr $ra

.end