.data
    X: .word 7

.text
.globl main
.ent main
main:

    li $t0, 2147483647 # INT_MAX 
    li $t1, 500
    add $a0, $t0, $t1   # overflow


    # print the result
    li $v0, 1
    syscall

done:
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
    # mfc0 $k0, $14   # it's the EPC

    # go to the next instruction
    # addi $k0, $k0, 4

    la $k0, done

    # move this back to coprocessor-0
    mtc0 $k0, $14

    # error return
    eret

.kdata
    msg: .asciiz "arithmetic overflow!!! \n"