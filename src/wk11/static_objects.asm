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
	# MyClass object1 = new MyClass("Hello ");
	la $a0, object1

	# get the method of print()
	lw $t1, object1
	jalr $t1

	# MyClass object2 = new MyClass("World\n");
	la $a0, object2

	# get the method of print()
	lw $t2, object2
	jalr $t2


# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main

.data
object1:
	.word print
	.asciiz "Hello "
object2:
	.word print
	.asciiz "World\n"

# shared method
.text
print:
	li $v0, 4

	# get address of the string
	# assume the object is in $a0
	addu $a0, $a0, 4

	syscall

	jr $ra