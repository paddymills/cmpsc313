
.text
.globl main
.ent main
main:

    la $a0, 0x00000000  # load an address where there is no memory
    sw $a0, ($t0)   # ??????????

done:
    # terminate
    li $v0, 10
    syscall


.end main


# #
# #   kseg0
# #
# .ktext 0x80000180  # Generic exception vector

#     # save a0 and v0
#     move 	$k0, $a0		# $k0 = $a0
#     move 	$k1, $v0		# $k1 = $v0

#     li $v0, 4
#     la $a0, msg
#     syscall

#     # restore the registers
#     move 	$a0, $k0		# $a0 = $k0
#     move 	$v0, $k1		# $v0 = $k1


#     #
#     #   CAUSE register -> cp0 $13
#     #

#     # 0000 0000 0000 0000 0000 0000 0111 1100
#     # in the above example, the "1"s are the ExcCode

#     # move cp0 $13 to cpu
#     mfc0 $t6, $13

#     # extract bits 6 through 2
#     #
#     #   use this mask (00000000000000000000000001111100)2 = (7C)16
#     andi	$t7, $t6, 0x7c			# $t7 = $t6 & 0x7c

#     # go back to end of user program
#     # move this back to coprocessor-0
#     la $k0, done
#     mtc0 $k0, $14

#     # error return
#     eret

# .kdata
#     msg: .asciiz "exception handled!!! \n"