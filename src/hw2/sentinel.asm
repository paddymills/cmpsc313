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

inputMessage: .asciiz "Enter a temperature (or -99 to quit): "
avgMessage: .asciiz "The average of the temperatures is "
sentinel: .word -99
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start

	lw $t0, sentinel
	li $t1, 0       # number of temperatures collected
	li $t2, 0       # sum of temperatures collected

loop:
	li $v0,4        # ask for temperature
	la $a0,inputMessage
	syscall
	li $v0,5        # read int into $v0
	syscall

	beq $v0, $t0, print # temperature == sentinel

	addi $t1, $t1, 1    # increment temperature counter
	add $t2, $t2, $v0   # add temperature to running total

	b loop

print:
	# calculate average ($t2/$t1)
	mtc1 $t1, $f2       # load number of temperatures into float register
	cvt.s.w $f2, $f2    # convert number of temperatures to float
	mtc1 $t2, $f4       # load sum of temperatures into float register
	cvt.s.w $f4, $f4    # convert sum of temperatures to float
	div.s $f6, $f4, $f2 # calculate!

	li $v0,4            # print output message
	la $a0,avgMessage
	syscall
	li $v0,2            # print float
	mov.s $f12, $f6
	syscall
	li $v0,4            # print newline
	la $a0,newline
	syscall

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main