# Description: factorial iterative

# ----------------------------------------
# Data Declarations:
.data

inputMessage: .asciiz "Enter a number: "
outputMessage: .asciiz "The factorial of "
isMessage: .asciiz " is "
newline: .asciiz "\n"

# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0,4
	la $a0,inputMessage
	syscall
	li $v0,5
	syscall

	move $a0, $v0
	move $t0, $a0
	jal fact
	move $t1, $v0

	li $v0, 4
	la $a0, outputMessage
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, isMessage
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0,4
	la $a0,newline
	syscall


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.globl fact
.ent fact
fact:
	# $a0 = n
	# $v0 = result
	move $t0, $a0	# $t0 = n
	li $t1, 1
	li $t2, 1
loop:
	bgt $t2, $t0, done

	mul $t1, $t1, $t2
	addi $t2, $t2, 1

	j loop
done:
	move $v0, $t1
	jr $ra

.end fact