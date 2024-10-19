# Patrick Miller
# Program Name:
# Description:
# 	Write a MIPS program using a structure to represent a coordinate (with x and
# 	 y values as integers.) Prompt the user for two coordinates and use a
# 	structure for each. With this data in place, calculate the distance between
# 	the two points. As you recall, the distance between two points can be
# 	calculated as:
# 		d = sqrt((x2 - x1)^2 + (y2 - y1)^2)

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