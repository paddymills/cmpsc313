.data
    X: .word 7
    goodbyeMessage: .asciiz "*** the program recovered from the exception ***"

.text
.globl main
.ent main
main:

    la $t0, X
    li $a0, 45
    sw $a0, ($t0)   # this should work

    # disalign the address by one byte
    addi $t0, $t0, 1
    sw $a0, ($t0)   # ?????

    # recovery
    li $v0, 4
    la $a0, goodbyeMessage
    syscall


    # terminate
    li $v0, 10
    syscall


.end main


#
#   kseg0
#
.ktext 0x80000180  # Generic exception vector

    # save a0 and v0
    move 	$k0, $a0		# $k0 = $a0
    move 	$k1, $v0		# $k1 = $v0

    li $v0, 4
    la $a0, msg
    syscall

    # restore the registers
    move 	$a0, $k0		# $a0 = $k0
    move 	$v0, $k1		# $v0 = $k1

    # restore the instruction that caused the exception
    mfc0 $k0, $14   # it's the EPC

    # go to the next instruction
    addi $k0, $k0, 4

    # move this back to coprocessor-0
    mtc0 $k0, $14

    # error return
    eret

.kdata
    msg: .asciiz "You have a bad aligned memory address!!!"