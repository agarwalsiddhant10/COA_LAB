##########################Submission Details###############
#Group Number: 10
#Autumn-19
#Assignment-2
#Problem-2
#Members: Siddhant Agarwal(17CS30035), Divyang Mittal(17CS10012)
##########################Data Segment#########################
.data
LC0: .asciiz "Enter the eight numbers: "
LC1: .asciiz "Sorted array is:\n "
LC2: .asciiz " "

#########################Code Segment############################
.text
.globl main

main:
	sub $sp, $sp, 32		#Create a contiguous segment of 32 bits = 8 integer.
	la $a0, LC0				#Print to ask for eight numbers		
	li $v0, 4
	syscall
	
	move $t2, $sp			#Keep copy of the stack pointer to access array elements

	li $t0, 0				#Loop counter
	j L1
	
L2:
	li $v0, 5
	syscall
	
	lw $t3, ($t2)
	
	sw $v0, ($t2)
	addi $t2, $t2, 4
	addi $t0, $t0, 4


L1:
	ble $t0, 28, L2  		#Loop condition	


	addi $t0, $zero, 0		#Bubble sort starts here. Initialise loop variables.
	addi $t3, $sp, 0 		#$t3<--pointer to base address of the array
	j L3

L4: addi $t1, $zero, 0		#Inner loop counter initialisation.
	addi $t5, $sp, 0		#$t5<--pointer to base address of array
	j L5

L6:  
	lw $t6, 0($t3)
	lw $t7, 0($t5)
	blt $t6, $t7, L8		#Compare A[i] < A[j]
	addi $t1, $t1, 1		#Update loop variable
	addi $t5, $t5, 4		#Update array pointer
	j L5

L8:
	sw $t6, 0($t5)			#Swap if condition is true
	sw $t7, 0($t3)
	j L5

L3: ble $t0, 7, L4			#outer loop condition
	j Print	

L5:
	ble $t1, 7, L6			#Inner loop condition
	addi $t0, $t0, 1		#Update loop variable
	addi $t3, $t3, 4		#Update array pointer
	j L3

L9:
	ble $t0, 28, L10
	j Exit


L10:
	add $t3, $sp, $t0 	
	lw $a0, ($t3)			#Print array element
	li $v0, 1
	syscall

	la $a0, LC2
	li $v0, 4				#Print space
	syscall

	addi $t0, $t0, 4
	j L9

Print: 
	li $t0, 0
	la $a0, LC1				#Print "the sorted array is"
	li $v0, 4
	syscall
	j L9


Exit: 
	addi $sp, $sp, 32		#Restore the stack pointer -> free memory.
	li $v0, 10
	syscall
		
	
	