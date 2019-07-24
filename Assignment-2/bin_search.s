##########################Submission Details###############
#Group Number: 10
#Autumn-19
#Assignment-2
#Problem-1
#Members: Siddhant Agarwal(17CS30035), Divyang Mittal(17CS10012)
##########################Data Segment#########################
.data
LC0: .asciiz "Enter the eight numbers: "
LC1: .asciiz "Enter the number to search: "
LC2: .asciiz "Number is present at zero based index: "
LC3: .asciiz "The number is absent"
LC4: .asciiz "Invalid input format \n"
array: .word 0, 0, 0, 0, 0, 0, 0 ,0		#Array of 8 elements
#########################Code Segment#########################
.text
.globl main

main:
	la $a0, LC0			#Print to ask for eight numbers
	li $v0, 4
	syscall
	
	la $t4, array 		#Store base address of array.
	move $t2, $t4		#Make a copy to access the array

	li $v0, 5			#Take the first input
	syscall
	sw $v0, ($t2)
	addi $t2, $t2, 4
	
	li $t0, 0			#Loop begins
	j L1
	
L2:
	li $v0, 5			#Input another number
	syscall

	lw $t3, ($t2)
	blt $v0, $t3, L3 	#Check if input is in increasing order
	
	sw $v0, ($t2)		#Store the number
	addi $t2, $t2, 4	#Increment loop variable
	addi $t0, $t0, 4	#Increment array pointer


L1:
	ble $t0, 24, L2 	#Loop condition
	
	la $a0, LC1
	li $v0, 4			#Ask for number to be searched
	syscall
	
	li $v0, 5
	syscall				#Take the number to be searched
	move $t7, $v0

	li $t0, 0			#Binary search begins
	li $t1, 7
	j L4
	
L5: 
	add $t2, $t1, $t0
	srl $t2, $t2, 1			#Find the mid
	add $t2, $t2, 1
	sll $t3, $t2, 2

	add $t5, $t4, $t3
	lw $t6, ($t5)			#Get A[mid+1]
	
	blt $t6, $t7, L7		#k > A[mid + 1]
	bgt $t6, $t7, L8		#k < A[mid + 1]

	la $a0, LC2
	li $v0, 4				#Number found
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	j Exit
	
L7:
	move $t0, $t2			#Beg = mid + 1
	j L4

L8:
	sub $t1, $t2, 1			#End = mid
	j L4
	
L4:
	blt $t0,$t1,L5		#Loop condition
	j L6
	
L3:
	la $a0,LC4
	li $v0, 4
	syscall
	j main
	
L6: 
	la $a0, LC3
	li $v0, 4		#Number is absent
	syscall

Exit:
	li $v0,10
	syscall

		
	
	