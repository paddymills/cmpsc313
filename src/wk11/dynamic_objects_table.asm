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
	# allocate object1 dynamically
	li $v0, 9
	li $a0, 28
	syscall
	sw $v0, object1

	# build object1 jump table
	la $t0, print
	sw $t0, 0($v0)
	lw $t0, hello
	sw $t0, 4($v0)

	# MyClass object1 = new MyClass("Hello ");
	lw $a0, object1

	# get the method of print()
	lw $t1, 0($a0)
	jalr $t1

	# allocate object2 dynamically
	li $v0, 9
	li $a0, 28
	syscall
	sw $v0, object2

	# build object1 jump table
	la $t0, print
	sw $t0, 0($v0)
	lw $t0, world
	sw $t0, 4($v0)

	# MyClass object2 = new MyClass("World\n");
	lw $a0, object2

	# get the method of print()
	lw $t2, 0($a0)
	jalr $t2


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.data
hello: .asciiz "Hello "
world: .asciiz "World\n"
object1:	.word 0
	# .word print		# 4 bytes
	# .asciiz "Hello "	# 24 bytes (safest way by book)
object2:	.word 0
	# .word print
	# .asciiz "World\n"

# shared method
.text
print:
	li $v0, 4

	# get address of the string
	# assume the object is in $a0
	addiu $a0, $a0, 4
	
	syscall

	jr $ra