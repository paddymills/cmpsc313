#  Name and general description of program
# ---------------------------------------

#  Data declarations go in this section.
.data

# program specific data declarations

# ---------------------------------------
#  Program code goes in this section.
.text

.globl main
.ent main
main:

# ----
# your program code goes here.


    # In Java -> throw
    # In C/Python -> RAISE

    # trigger exception handler
    # if $t0 == 0
    teqi $t0, 0     # conditional trap

    # ----
    #  Done, terminate program.
    li $v0, 10
    syscall


.end main
# all done

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
    msg: .asciiz "It's a trap!  This comes from your exception handler!"