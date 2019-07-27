##########################Submission Details###############
#Group Number: 10
#Autumn-19
#Assignment-3
#Problem-1
#Members: Siddhant Agarwal(17CS30035), Divyang Mittal(17CS10012)
##########################Data Segment#########################
.data
string: .asciiz "MitTal (12) aNd AgarWal (35)  \n"
LC1: .asciiz "Original String: "
LC2: .asciiz "Converted String: "

##########################Code Segment#########################

.text
.globl main
main:
	la $a0, LC1  
	li $v0, 4 
	syscall
	la $t4, string # Printing the original string 
	move $a0, $t4
	li $v0, 4
	syscall
	lui $t5, 0x1000  # Storing the address for converted string. Using hardcoded address.
	move $t6,$t5   	 # Making a copy of address of converted string
	li $t0, 0
	move $t3, $t4	
	j L1

L3:
	sb $t2, ($t5)	  # storing the converted character at new location
	addi $t5, $t5, 1	
	addi $t3, $t3, 1	
	j L1				


L2:
	bgt $t2, 90, L3		# checking if character is in upper-case 
	blt $t2, 65, L3
	addi $t2, $t2, 32  # converting upper case letters to lower case
	j L3

L1:
	lb $t2, ($t3)		
	bne $t2, $zero, L2  

	sb $t2, ($t5)  # concatenating a null character with the new string

	la $a0, LC2
	li $v0, 4
	syscall

	move $a0, $t6   # printing the converted string
	li $v0, 4
	syscall

	li $v0, 10  # Exiting the program
	syscall

