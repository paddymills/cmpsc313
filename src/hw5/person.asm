# Patrick Miller
# Program Name:
# Description:
#	Included in the assignment is a file named people.txt. For this assignment
#	you are to read the file and construct a person object for each of the
#	lines in the file. As an example: Person p = new Person(“Henry”, “Smith”);
#	Include a toString() method in your file which will simply print out the
#	name of the person representing the object.

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



# -----
# Done, terminate program.
end:
	li $v0, 10
	syscall

.end main