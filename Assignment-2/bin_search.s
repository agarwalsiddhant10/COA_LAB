.data
LC0: .asciiz "Enter the eight numbers: "
LC1: .asciiz "Enter the number to search: "
LC2: .asciiz "Number is present at zero based index: "
LC3: .asciiz "The number is absent"
LC4: .asciiz "Invalid input format \n"
DEBUG: .asciiz "checking   \n"
array: .word 0, 0, 0, 0, 0, 0, 0 ,0

.text
.globl main

main:
	la $a0, LC0
	li $v0, 4
	syscall
	
	la $t4, array
	move $t2, $t4

	li $v0, 5
	syscall

	sw $v0, ($t2)
	li $t0, 0
	j L1
	
L2:
	li $v0, 5
	syscall

	lw $t3, ($t2)
	blt $v0, $t3, L3 
	
	sw $v0, ($t2)
	addi $t2, $t2, 4
	addi $t0, $t0, 4


L1:
	ble $t0, 24, L2
	
	la $a0, LC1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t7, $v0

	li $t0, 0
	li $t1, 7
	j L4
	
L5: 
	add $t2, $t1, $t0
	srl $t2, $t2, 1
	add $t2, $t2, 1
	sll $t3, $t2, 2

	add $t5, $t4, $t3
	lw $t6, ($t5)
	
	blt $t6, $t7, L7
	bgt $t6, $t7, L8
	la $a0, LC2
	li $v0, 4
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	j Exit
	
L7:
	move $t0, $t2
	j L4

L8:
	sub $t1, $t2, 1
	j L4
	
L4:
	blt $t0,$t1,L5
	j L6
	
L3:
	la $a0,LC4
	li $v0, 4
	syscall
	j main
	
L6: 
	la $a0, LC3
	li $v0, 4
	syscall

Exit:
	li $v0,10
	syscall

		
	
	