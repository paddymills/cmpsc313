#  Name and general description of program
# ---------------------------------------

#  Data declarations go in this section.
.data

array: .word 1 4 8 11 13 16 19 19
length: .word 8
searchMessage: .asciiz "enter a number to search: "
outputMessage: .asciiz "found at position: "

# program specific data declarations

# ---------------------------------------
#  Program code goes in this section.
.text

.globl main
.ent main
main:

# ----
# your program code goes here.

    #
    #   ask for a number in the array
    li $v0, 4
    la $a0, searchMessage
    syscall
    li $v0, 5
    syscall
    
    #
    #   call binary search
    move $a0, $v0       # needle
    li $a1, 0           # left
    lw		$a2, length		# right
    addi	$a2, $a2, -1			# $a2 = $a2 + -1
    jal binarySearch
    move $t0, $v0

    #
    #   output position
    li $v0, 4
    la $a0, outputMessage
    syscall
    li $v0, 1
    move $a0, $t0
    syscall



    # ----
    #  Done, terminate program.
    li $v0, 10
    syscall


.end main
# all done

#
#   input:
#       needle: $a0
#       left: $a1
#       right $a2
#   output: $v0
#
.globl binarySearch
.ent binarySearch
binarySearch:
    sub $sp, $sp, 4
    sw	$ra, 0($sp)		# 

#     if left > right:  # BASE CASE
#         return None  # The `needle` is not in `haystack`.
    bgt		$a1, $a2, baseCase	# if $a1 > $a2 then goto baseCase
    j recursiveCase
baseCase:
    li $v0, -1
    j done
recursiveCase:
#     mid = (left + right) // 2
    add $t0, $a1, $a2
    div $t0, $t0, 2

    # haystack[mid]
    # add offset * 4 to array base 
    la $t1, array
    add $t1, $t1, $t0
    mul $t1, $t1, 4
    lw $t2, ($t1)

    beq		$t0, $t2, returnMid	# if $t0 == $t2 then goto returnMid
    blt		$t0, $t2, searchLower	# if $t0 < $t2 then goto searchLower
    bgt		$t0, $t2, searchUpper	# if $t0 > $t2 then goto searchUpper
    
returnMid:
#     if needle == haystack[mid]:  # BASE CASE
#         return mid  # The `needle` has been found in `haystack`
    move $v0, $t0
    j done    
searchLower:
#     elif needle < haystack[mid]:  # RECURSIVE CASE
#         return binarySearch(needle, haystack, left, mid - 1)
    move $a2, $t0
    addi $a2, $a2, -1
    jal binarySearch
searchUpper:
#     elif needle > haystack[mid]:  # RECURSIVE CASE
#         return binarySearch(needle, haystack, mid + 1, right)
    move $a1, $t0
    addi $a1, $a1, 1
    jal binarySearch
done:   
    lw		$ra, 0($sp)		# 
    add $sp, $sp, 4
    jr $ra
.end binarySearch



# def binarySearch(needle, haystack, left=None, right=None):
#     # By default, `left` and `right` are all of `haystack`:
#     if left is None:
#         left = 0  # `left` defaults to the 0 index.
#     if right is None:
#         right = len(haystack) - 1  # `right` defaults to the last index.

#     print('Searching:', haystack[left:right + 1])

#     if left > right:  # BASE CASE
#         return None  # The `needle` is not in `haystack`.

#     mid = (left + right) // 2
#     if needle == haystack[mid]:  # BASE CASE
#         return mid  # The `needle` has been found in `haystack`
#     elif needle < haystack[mid]:  # RECURSIVE CASE
#         return binarySearch(needle, haystack, left, mid - 1)
#     elif needle > haystack[mid]:  # RECURSIVE CASE
#         return binarySearch(needle, haystack, mid + 1, right)