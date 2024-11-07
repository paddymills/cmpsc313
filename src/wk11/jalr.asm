# Patrick Miller
# Program Name:
# Description:

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
	lw $t1, jumpTable
	jalr $t1

	lw $t2, jumpTable+4
	jalr $t2

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.data
jumpTable:
	.word	sub1
	.word	sub2

.text
sub1:
	li $v0, 4
	la $a0, msgHello
	syscall
	jr $ra
.data
msgHello: .asciiz "Hello "

.text
sub2:
	li $v0, 4
	la $a0, msgWorld
	syscall
	jr $ra
.data
msgWorld: .asciiz "World\n"