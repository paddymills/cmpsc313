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
	# call print()
	la $a0, object1
	lw $t0, 0($a0)
	jalr $t0

	# call cancel()
	la $a0, object1
	lw $t0, 4($a0)
	jalr $t0

	# call print()
	la $a0, object1
	lw $t0, 0($a0)
	jalr $t0

	# call print()
	la $a0, object2
	lw $t0, 0($a0)
	jalr $t0

	# call cancel()
	la $a0, object2
	lw $t0, 4($a0)
	jalr $t0

	# call print()
	la $a0, object2
	lw $t0, 0($a0)
	jalr $t0

# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main


.text
print:
	# assume the point is in $a0
	li $v0, 4
	addu $a0, $a0, 8
	syscall

	# print "\n" (line feed + carriage return)
	li $v0, 11
	li $a0, 0x0A
	syscall
	li $v0, 11
	li $a0, 0x0D
	syscall


	jr $ra


cancel:
	# input:  "this is a string"
	# output: "xxxxxxxxxxxxxxxx"

	# assume the object is in $a0

	# load data into $t0
	addiu $t0, $a0, 8

	li $t1, 0x78	# 'x'

loopCancel:
	lb $t2, 0($t0)	# load character
	beqz $t2, endCancel

	sb $t1, 0($t0)		# store 'x'
	addiu $t0, $t0, 1	# move to next character

	j loopCancel

endCancel:
	jr $ra


# objects
.data
object1:
	.word print
	.word cancel
	.asciiz "Peter"
object2:
	.word print
	.word cancel
	.asciiz "Griffin"