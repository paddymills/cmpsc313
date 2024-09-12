
# Name and general description of program

# ----------------------------------------
# Data declarations go in this section.
.data
# program specific data declarations

incomeInput: .asciiz "Enter your income: "
yearsInput: .asciiz "Enter the number of years of experience: "
qualifyOutput: .asciiz "You qualify for the loan\n"
notQualifyOutput: .asciiz "You do not qualify for the loan\n"

minIncome: .word 35000
minExperience: .word 5

# ----------------------------------------
# Program code goes in this section.
.text

.globl main
.ent main
main:

# -----
# your program code goes here.
    li $v0, 4
    la $a0, incomeInput
    syscall
    li $v0, 5 # read integer
    syscall # $v0 has result
    
    lw $t0, minIncome
    blt $v0, $t0, notQualify


    li $v0, 4
    la $a0, yearsInput
    syscall
    li $v0, 5 # read integer
    syscall # $v0 has result

    lw $t0, minExperience
    blt $v0, $t0, notQualify



qualify:
    li $v0, 4
    la $a0, qualifyOutput
    syscall
    j done

notQualify:
    li $v0, 4
    la $a0, notQualifyOutput
    syscall
    j done

# -----
# Done, terminate program.
done:
    li $v0, 10
    syscall # all done!

.end main