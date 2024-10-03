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

square: .space 36   # array of 9 words

inputMessage: .asciiz "Enter 3 rows of numbers for the square\n"
			  .asciiz "  - No number can exist more than once\n"
			  .asciiz "  - Numbers must be 1-9 inclusive\n"
			  .asciiz "  - Row values must be space delimited\n"

inputFirstRow:  .asciiz "First  row\n"
inputSecondRow: .asciiz "Second row\n"
inputThirdRow:  .asciiz "Third  row\n"
displayMsg: .asciiz "Potential Lu Shu Magic Square:\n"
notValidMsg: .asciiz "Square must include all numbers 1-9 once\n"


notLoShuMessage: .asciiz "This is not a Lo Shu Magic Square\n"
isLoShuMessage: .asciiz "This is a Lo Shu Magic Square\n"

newline: .asciiz "\n"
space: .asciiz " "

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	# load array (for storing values in getThreeNums)
	la $s0,square

	# get rows
	li $v0,4
	la $a0,inputFirstRow
	syscall
	jal getThreeNums
	li $v0,4
	la $a0,inputSecondRow
	syscall
	jal getThreeNums
	li $v0,4
	la $a0,inputThirdRow
	syscall
	jal getThreeNums

	# print array
	la $t0,square
	li $t1,0
printLoop:
	beq $t1,9,checkLuShu

	li $v0,1
	lw $a0,($t0)
	syscall
	li $v0,4
	la $a0,space
	syscall

	addi $t0,$t0,4
	addi $t1,$t1,1

	# every third number gets a newline
	rem $t2,$t1,3
	beq $t2,0,nextLine
	j printLoop

nextLine:
	li $v0,4
	la $a0,newline
	syscall

	j printLoop

checkLuShu:
	# validate 1-9 occur once
	jal validate
	bnez $v0,invalid

	# load array
	la $t0,square

	# sum first row
	lw $t1, ($t0)
	lw $t2,4($t0)
	lw $t3,8($t0)
	add $t4,$t1,$t2
	add $t4,$t4,$t3

	# check second row sum against first row sum
	lw $t1,12($t0)
	lw $t2,16($t0)
	lw $t3,20($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# check third row sum against first row sum
	lw $t1,24($t0)
	lw $t2,28($t0)
	lw $t3,32($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# check first column sum against first row sum
	lw $t1,  ($t0)
	lw $t2,12($t0)
	lw $t3,24($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# check second column sum against first row sum
	lw $t1, 4($t0)
	lw $t2,16($t0)
	lw $t3,28($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# check third column sum against first row sum
	lw $t1, 8($t0)
	lw $t2,20($t0)
	lw $t3,32($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# check top-left to bottom-right diagonal sum against first row sum
	lw $t1,  ($t0)
	lw $t2,16($t0)
	lw $t3,32($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# check bottom-left to top-right diagonal sum against first row sum
	lw $t1,24($t0)
	lw $t2,16($t0)
	lw $t3, 8($t0)
	add $t5,$t1,$t2
	add $t5,$t5,$t3
	bne $t4,$t5,notLoShu

	# all checks passed
	li $v0,4
	la $a0,isLoShuMessage
	syscall
	b end

invalid:
	li $v0,4
	la $a0,notValidMsg
	syscall
	j end

notLoShu:
	li $v0,4
	la $a0,notLoShuMessage
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl getThreeNums
.ent getThreeNums
getThreeNums:
	li $t1,0
loop:
	beq $t1,3,endLoop

	li $v0,5
	syscall
	sw $v0, ($s0)
	addi $s0,$s0,4
	addi $t1,$t1,1
	j loop

endLoop:
	jr $ra

.end getThreeNums

.globl validate
.ent validate
validate:
	# no duplicates: return 0
	li $v0,0

	li $t1,1 # number to find
	li $t2,9 # count of numbers
loopNums:
	bgt $t1,$t2,return

	la $t0,square	# load array
	li $t4,0 		# index counter
	li $t5,0 		# count of number
find:
	beq $t4,$t2,check # end of array -> check count

	lw $t3,($t0)
	addi $t0,$t0,4
	addi $t4,$t4,1

	beq $t3,$t1,found # number found -> count it
	j find

found:
	addi $t5,$t5,1
	j find
check:
	addi $t1,$t1,1		# next number
	beq $t5,1,loopNums	# number found once -> next number

	li $v0,1 			# error

return:
	jr $ra

.end validate
