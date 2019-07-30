##########################Submission Details###############
#Group Number: 10
#Autumn-19
#Assignment-4
#Problem-2
#Members: Siddhant Agarwal(17CS30035), Divyang Mittal(17CS10012)
##########################Data Segment#########################
.data
LC0: .asciiz "Enter the number in the matrix: "
LC1: .asciiz " " 
LC2: .asciiz "\n"
LC3: .asciiz "\nThe matrix is:\n"
LC4: .asciiz "Saddle Points found are: "
LC5: .asciiz "Nil\n"
array: .align 2
		.space 64
				#Array of 8 elements
#########################Code Segment#########################
.text
.globl main

main:
	la $a0, LC0			
	li $v0, 4
	syscall
	
	la $t4, array 		#Store base address of array.
	li $t0, 0
	j INPUT_OUTER
	
LOOP:
	sll $t3, $t0, 4
	sll $t5, $t1, 2	
	add $t3, $t3, $t5
	add $t3, $t3, $t4

	li $v0, 5			#Take input from user in A[i][j]
	syscall

	sw $v0, ($t3)

	addi $t1, $t1, 1

INNER_COND:
	ble $t1, 3, LOOP 			#Condition for j
	addi $t0, $t0, 1
	j INPUT_OUTER	

INPUT_INNER:
	li $t1, 0
	j INNER_COND

INPUT_OUTER:
	ble $t0, 3, INPUT_INNER 	#Condition for i


	li $t0, 0
	move $a0, $t4
	jal GetSaddle				#Function call
	bne $v1, 1, NO_SADDLE		#Flag returned. If flag = 0 then no saddle point
	li $t0, 0
	la $a0, LC3
	li $v0, 4
	syscall
	j PRINT_OUTER

NO_SADDLE:
	la $a0, LC5
	li $v0, 4
	syscall

	li $t0, 0
	la $a0, LC3
	li $v0, 4
	syscall
	j PRINT_OUTER
	
P_LOOP:
	sll $t3, $t0, 4
	sll $t5, $t1, 2	
	add $t3, $t3, $t5
	add $t3, $t3, $t4



	lw $a0, ($t3)
	li $v0, 1				#Print A[i][j]
	syscall

	la $a0, LC1
	li $v0, 4
	syscall

	addi $t1, $t1, 1

P_INNER_COND:
	ble $t1, 3, P_LOOP

	la $a0, LC2
	li $v0, 4
	syscall

	addi $t0, $t0, 1
	j PRINT_OUTER	

PRINT_INNER:
	li $t1, 0
	j P_INNER_COND

PRINT_OUTER:


	ble $t0, 3, PRINT_INNER

	
	li $v0, 10
	syscall	


GetSaddle:

	move $t4, $a0					#Take array address as arguement

	la $a0, LC4
	li $v0, 4
	syscall

	li $v1, 0

	li $t0, 0
	j Outer_Cond

Inner:
	li $t1, 0
	j Inner_Cond 

Loop:
	sll $t3, $t0, 4
	sll $t8, $t1, 2	
	add $t3, $t3, $t8
	add $t3, $t3, $t4
	lw $t2, ($t3)				#t2 = A[i][j]
	li $t5, 0					#t5 = min
	li $t6, 0					#t6 = max
	li $t7, 0
	L:
		sll $t3, $t7, 4
		sll $t9, $t1, 2	
		add $t3, $t3, $t9
		add $t3, $t3, $t4
		lw $t8, ($t3)		#t8 = A[it][j]

		ble $t8, $t2, Min 		#If A[it][j] < A[i][j] min++

		C1:
		sll $t3, $t0, 4
		sll $t9, $t7, 2	
		add $t3, $t3, $t9


		add $t3, $t3, $t4
		lw $t8, ($t3)		#t8 = A[i][it]

		bge $t8, $t2, Max 		#If A[i][it] > A[i][j] max++

		C2:



		addi $t7, $t7, 1
		blt $t7, 4, L



	bne $t5, 1, Loop_Body_Mid
	
	bne $t6, 1, Loop_Body_Mid

	li $v1, 1
	move $a0, $t2				#If min ==1 and max == 1 this means that the element is max in col and min in row 
	li $v0, 1
	syscall

	la $a0, LC1
	li $v0, 4
	syscall

	j Loop_Body_End

	Loop_Body_Mid:

		li $t5, 0			#t5 = min
		li $t6, 0			#t6 = max
		li $t7, 0
		L6:
			sll $t3, $t7, 4
			sll $t9, $t1, 2	
			add $t3, $t3, $t9
			add $t3, $t3, $t4
			lw $t8, ($t3)		#t8 = A[it][j]

			bge $t8, $t2, Max6 			#If A[it][j] > A[i][j] max++

			C61:
			sll $t3, $t0, 4 
			sll $t9, $t7, 2	
			add $t3, $t3, $t9
			add $t3, $t3, $t4
			lw $t8, ($t3)		#t8 = A[i][it]

			ble $t8, $t2, Min6  		#If A[i][it] < A[i][j] min++

			C62:

			addi $t7, $t7, 1
			blt $t7, 4, L6

		bne $t5, 1, Loop_Body_End
		
		bne $t6, 1, Loop_Body_End

		li $v1, 1
		move $a0, $t2			#If min ==1 and max == 1 this means that the element is max in col and min in row
		li $v0, 1
		syscall

		la $a0, LC1
		li $v0, 4
		syscall

		j Loop_Body_End

	Loop_Body_End:
		addi $t1, $t1, 1
		j Inner_Cond


Inner_Cond:
	blt $t1, 4, Loop 
	addi $t0, $t0, 1

Outer_Cond:
	blt $t0, 4, Inner 

	jr $ra

Min:
	addi $t5, $t5, 1
	j C1

Max:
	addi $t6, $t6, 1
	j C2

Min6:
	addi $t5, $t5, 1
	j C62

Max6:
	addi $t6, $t6, 1
	j C61