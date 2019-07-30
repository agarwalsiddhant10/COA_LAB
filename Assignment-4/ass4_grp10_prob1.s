##########################Submission Details###############
#Group Number: 10
#Autumn-19
#Assignment-4
#Problem-1
#Members: Siddhant Agarwal(17CS30035), Divyang Mittal(17CS10012)
##########################Data Segment#########################
.data
LC0: .asciiz "Enter the eight numbers: "
LC1: .asciiz " " 
LC2: .asciiz "Sorted array(descending) is \n "
array: 	.align 2
		.space 32
				#Array of 8 elements
#########################Code Segment#########################
.text
.globl main

InsertionSort:
	move $t2, $a0
	li $t0, 4
	j OUTER

SWAP:
	sw $t7, ($t3)
	sw $t6, ($t5)
	sub $t1, $t1, 4
	j INNER

LOOP:
	# add $t3, $t2, $t0   # artificial intelligence
	add $t5, $t2, $t1	# artificial jarvis
	addi $t3, $t5, 4
	lw $t6, ($t3)
	lw $t7, ($t5)
	blt $t7, $t6, SWAP
	addi $t0, $t0, 4
	j OUTER

INNER:
	bge $t1, $zero, LOOP
	addi $t0, $t0, 4


OUTER:
	bge $t0, 32, RET 
	sub $t1, $t0, 4
	j INNER
RET:
	jr $ra


main:
	la $a0, LC0			#Print to ask for eight numbers
	li $v0, 4
	syscall
	
	la $t4, array 		#Store base address of array.
	move $t2, $t4		#Make a copy to access the array
	li $t0, 0			#Loop begins
	j INPUT_COND
	
INPUT_LOOP:

	li $v0, 5			#Input a number
	syscall
	sw $v0, ($t2)
	addi $t2, $t2, 4	#Increment loop variable
	addi $t0, $t0, 4	#Increment array pointer


INPUT_COND:
	ble $t0, 28, INPUT_LOOP 
	move $a0, $t4
	jal InsertionSort	#Loop condition


	
PRINT:
	li $t0, 0
	la $a0, LC2 
	li $v0, 4
	syscall
	j PRINT_COND

PRINT_LOOP:
	lw $a0, ($t2)
	li $v0, 1
	syscall 
	la $a0, LC1 
	li $v0, 4
	syscall
	add $t2, $t2, 4
	add $t0, $t0, 4

PRINT_COND:
	blt $t0, 32, PRINT_LOOP

	li $v0, 10
	syscall
