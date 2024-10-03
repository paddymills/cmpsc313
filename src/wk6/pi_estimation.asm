# Patrick Miller
# Program Name:
# Description:

# ----------------------------------------
# Data Declarations:
.data

inputMessage: .asciiz "Enter number of terms: "
leibnizMessage: .asciiz "The value of pi using the Leibniz formula is "
wallisMessage: .asciiz "The value of pi using the Wallis formula is "
newline: .asciiz "\n"

fNegOne: .float -1.0
fZero: .float 0.0
fOne: .float 1.0
fTwo: .float 2.0
fThree: .float 3.0
fFour: .float 4.0


# ----------------------------------------
# Program Code:
.text

.globl main
.ent main
main:
# -----
# Program start
	li $v0, 4
	la $a0, inputMessage
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	# Leibniz
	move $a0, $s0
	jal leibniz

	li $v0, 4
	la $a0, leibnizMessage
	syscall
	li $v0, 2
	# move to f12
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# Wallis
	move $a0, $s0
	jal wallis

	li $v0, 4
	la $a0, wallisMessage
	syscall
	li $v0, 2
	# move to f12
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

.globl leibniz
.ent leibniz
leibniz:
	move $t0, $a0

	l.s $f12 fZero
	l.s $f14 fFour
	l.s $f16 fOne

	li $t1, 1
loopLeibniz:
	bge $t1, $t0, doneLeibniz

	# num += 4
	div.s $f18, $f14, $f16
	add.s $f12, $f12, $f18

	# num *= -1
	l.s $f20, fNegOne
	mul.s $f14, $f14, $f20

	# den += 2
	l.s $f22, fTwo
	add.s $f16, $f16, $f22

	# i++
	addi $t1, $t1, 1


doneLeibniz:
	jr $ra

.end leibniz

.globl wallis
.ent wallis
wallis:
	move $t0, $a0

	l.s $f12 fOne
	l.s $f14 fTwo

	jr $ra

.end wallis