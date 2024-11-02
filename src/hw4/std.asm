# Patrick Miller
# Program Name:
# Description:
# 	This exercise will involve using dynamic memory allocation with MIPS.
# 	For this assignment you will ask the user for a positive, non-zero integer
# 	n. You will then dynamically allocate memory to hold those n integers, and
# 	then ask the user to input each of those n integers. Once the data has been
# 	collected, calculate the standard deviation of that data set. As you recall,
# 	the formula for standard deviation is the following:
# 		std_dev = sqrt((1/N) * sum(i=1 to N, (x_i - x_mean)^2))


# ----------------------------------------
# Data Declarations:
.data
fTwo: .float 2.0
askArrayLength: .asciiz "Enter the length of the array: "
askNum: .asciiz "Enter number "

stdDevIs: .asciiz "The standard deviation is "
newline: .asciiz "\n"


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# $s0 = array
	# $s1 = array length

	# ask user for array length
	li $v0, 4
	la $a0, askArrayLength
	syscall
	li $v0, 5
	syscall
	move $s1, $v0

	# allocate array
	li $v0, 9
	sll $a0, $s1, 2	# size = length * 4
	syscall
	move $s0, $v0	# store array start address

	li $t0, 0		# iteration counter
	move $t1, $s0	# array pointer
	li $t2, 0		# sum
loop_get:
	beq $t0, $s1, calc_mean

	# ask for number from user
	li $v0, 4
	la $a0, askNum
	syscall
	li $v0, 5
	syscall

	# store number in array
	sw $v0, ($t1)
	add $t2, $t2, $v0	# sum += number

	addi $t0, $t0, 1	# iteration counter
	addi $t1, $t1, 4	# array pointer

	j loop_get

calc_mean:
	# calculate mean
	mtc1 $t2, $f0		# load sum
	mtc1 $s1, $f2		# load length (N)

	cvt.s.w $f0, $f0	# convert sum to float
	cvt.s.w $f2, $f2	# convert length to float
	div.s $f0, $f0, $f2	# sum / length = mean

	# $f0 = mean
	# $f2 = N

	# calculate (x - mean)^2 for each x in array
	li $t0, 0		# iteration counter
	move $t1, $s0	# array pointer
	li.s $f4, 0.0	# sum accumulator
loop_inner_sum:
	beq $t0, $s1, final_calc

	# load number
	lw $t2, ($t1)
	mtc1 $t2, $f6		# load number
	cvt.s.w $f6, $f6		# convert number to float

	# calculate (x - mean)^2
	sub.s $f6, $f6, $f0	# x - mean
	mul.s $f6, $f6, $f6	# (x - mean)^2
	add.s $f4, $f4, $f6	# sum += (x - mean)^2

	addi $t0, $t0, 1	# iteration counter
	addi $t1, $t1, 4	# array pointer

	j loop_inner_sum

final_calc:
	div.s $f12, $f4, $f2	# sum / N
	jal sqrt

	# $f0 = standard deviation
	li $v0, 4
	la $a0, stdDevIs
	syscall
	li $v0, 2
	mov.s $f12, $f0
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

.globl sqrt
.ent sqrt
sqrt:
	# n = $f12

	# find the square root of n using the following algorithm:
	# x = n
	# for (i = 0 to n/2)
	# 	x = (x + n / x) / 2)
	# return x

	# float constants
	l.s $f2, fTwo

	# loop control variables
	li $t0, 0			# i
	cvt.w.s $f0, $f12	# convert n to integer
	mfc1 $t1, $f0		# move n to integer register
	srl $t1, $t1, 1		# n / 2

	mov.s $f6, $f12			# load n
	mov.s $f8, $f6			# initial x = n

loop:
	div.s $f12, $f6, $f8	# n / x
	add.s $f12, $f8, $f12	# x + n / x
	div.s $f12, $f12, $f2	# (x + n / x) / 2
	mov.s $f8, $f12			# x = (x + n / x) / 2

	addi $t0, $t0, 1	# i++
	blt $t0, $t1, loop	# i < n / 2

sqrt_return:
	mov.s $f0, $f8
	jr $ra

.end sqrt