##########################Submission Details###############
#Group Number: 10
#Autumn-19
#Assignment-3
#Problem-2
#Members: Siddhant Agarwal(17CS30035), Divyang Mittal(17CS10012)
##########################Data Segment#########################
.data
LC0: .asciiz "Enter the size of array \n"
LC1: .asciiz "Enter elements of array \n"
LC2: .asciiz "Enter size of window \n"
LC3: .asciiz " "
LC4: .asciiz "the moving averaged array is as follows (size is n - h + 1)\n"

##########################Code Segment#########################

.text
.globl main
main:
	la $a0, LC0
	li $v0, 4				#Asking for the size of array.
	syscall

	li $v0, 5				#Taking the size as input.
	syscall

	move $t0, $v0
	sll $t1 $t0, 2			#Calculating equivalent size in bytes
	sub $sp, $sp, $t1		#Creating space for the array.
	move $t1, $sp

	la $a0, LC1
	li $v0, 4				#Asking for the elements of the array.
	syscall	

	addi $t2, $zero, 0		
	j L1

L2:
	li $v0,5
	syscall
	sw $v0, ($t1)		#Storing the input number in the array
	addi $t1,$t1,4
	addi $t2,$t2,1

L1:
	blt $t2, $t0, L2
	
	move $t1, $sp
	la $a0, LC2			#Ask for the window size.
	li $v0, 4
	syscall

	li $v0,5
	syscall				#Get the window size.
	move $t2, $v0
	li $t3, 0
	li $t4, 0
	j L3

L4:
	lw $t5, ($t1)
	add $t4, $t4, $t5		#Add the first w elements
	addi $t1, $t1, 4
	addi $t3, $t3, 1
	j L3

L3:

	blt $t3, $t2, L4


	div $t4, $t2			

	move $t5, $sp
	lw $t6, ($t5)
	sub $t4, $t4, $t6

	mflo $t6
	sw $t6, ($t5)			#Store A[0] = sum of first w elements/w
	addi $t5, $t5, 4

	j L5

L6:
	lw $t6, ($t1)
	add $t4, $t4, $t6
	div $t4, $t2
	lw $t6, ($t5)

	sub $t4, $t4, $t6		#Compute the average over the window in an online manner
							# avg[i] = (avg[i-1]*w + A[i] - A[i-w])/w
	mflo $t6
	sw $t6, ($t5)
	addi $t1, $t1, 4
	addi $t5, $t5, 4
	addi $t3, $t3, 1
	j L5

L5:
	blt $t3, $t0, L6
	j Print

Print:
	la $a0, LC4
	li $v0, 4				
	syscall
	move $t1,$sp
	add $t3, $zero, $zero
	sub $t2, $t0, $t2
	addi $t2, $t2, 1 
	j L8

L7:
	lw $a0, ($t1)
	li $v0, 1				#Print the averages
	syscall

	la $a0, LC3
	li $v0, 4				#Print space
	syscall

	add $t3,$t3,1
	add $t1,$t1,4

L8:
	blt $t3, $t2, L7
	sll $t0, $t0, 2
	add $sp, $sp, $t0			#Restore the stack pointer
	li $v0, 10					#Exit
	syscall
	

