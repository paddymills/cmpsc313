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

    # int decimal_number = 10;
    # cout << find(decimal_number);
    # return 0;
    li $a0, 10
    jal binary  # result in v0
    move 	$t0, $v0		# $t0 = $v0

    # print result
    li $v0, 1
    move 	$a0, $t0		# $a0 = $t0 
    syscall


    # ----
    #  Done, terminate program.
    li $v0, 10
    syscall


.end main
# all done


.globl binary
.ent binary
binary:
    sub $sp, $sp, 8
    sw	$ra, 0($sp)		# 
    sw	$ra, 4($s0)		# 
    sw	$ra, 8($s1)		# 

    # if (decimal_number == 0) 
    #     return 0; 
    beqz $a0, baseCase
    j recursiveCase
baseCase:
    li $v0, 0
    j done
recursiveCase:
    # else
    #     return (decimal_number % 2 + 10 * 
    #             find(decimal_number / 2));
    move 	$s0, $a0		# $s0 = $a0

    move 	$t0, $a0		# $t0 = $a0
    li $t1, 2
    rem $t0, $t0, $t1
    addi	$t0, $t0, 10			# $t0 = $t0 + 10
    
    # store in s1 this (decimal_number % 2 + 10
    move 	$s1, $t0		# $s1 = $t0

    # find(decimal_number / 2)
    div $a0, $a0, 2
    j binary
    add $v0, $v0, $s1

done:
    lw		$ra, 0($sp)		# 
    lw		$ra, 4($s0)		# 
    lw		$ra, 8($s1)		# 
    add $sp, $sp, 12
    jr $ra
.end binary