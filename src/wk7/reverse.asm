#  Name and general description of program
# ---------------------------------------

#  Data declarations go in this section.
.data

outputMessage: .asciiz "Reversed Number: "

# program specific data declarations

# ---------------------------------------
#  Program code goes in this section.
.text

.globl main
.ent main
main:

# ----
# your program code goes here.

    # public static void main(String args[])
    # {
    #     // number to be reversed
    #     int num = 98765;
    # li $a0, 98765

    #     System.out.print("Reversed Number: ");
    li $v0, 4
    la $a0, outputMessage
    syscall

    #     // calling recursive function 
    #     // to print the number in
    #     // reversed form
    #     Reverse(num);
    # }
    li $a0, 98765
    jal reverse

    # ----
    #  Done, terminate program.
    li $v0, 10
    syscall


.end main
# all done

.globl reverse
.ent reverse
reverse:
    sub $sp, $sp, 4
    sw	$ra, 0($sp)		# 

        # // base condition to end recursive calls
        # if (num < 10) {
        #     System.out.println(num);
        #     return;
        # }
    li $t0, 10
    blt		$a0, $t0, baseCase	# if $a0 < $t0 then goto baseCase
    j recursiveCase
baseCase:
    li $v0, 1
    syscall
    j done
recursiveCase:
        # else {

        #     // print the unit digit of the given number
        #     System.out.print(num % 10);
        move    $s0, $a0
        move 	$t0, $a0		# $t0 = $a0
        rem $t0, $t0, 10
        move 	$a0, $t0		# $a0 = $t0
        li $v0, 1
        syscall

        #     // calling function for remaining number other
        #     // than unit digit
        #     Reverse(num / 10);
        # }
        div		$s0, $s0, 10
        move    $a0, $s0
        j reverse

done:   
    lw		$ra, 0($sp)		# 
    add $sp, $sp, 4
    jr $ra
.end reverse