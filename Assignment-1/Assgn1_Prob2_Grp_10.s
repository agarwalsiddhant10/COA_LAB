####################Assignment Submission Details#######################
#Group number 10
#AUTUMN-19
#Assignment 1
#problem 2
#Members: Divyang Mittal(17CS10012), Siddhant Agarwal(17CS30035)

####################Data Segment#########################
	.data
msg1: .asciiz "Enter an integer(positive number)"
msg2: .asciiz "The corresponding fibonacci number is "
msg3: .asciiz "Please give a positve number, Try again\n"


####################Code Segment#########################

	.text
	.globl main
	
	main:
		
		la $a0, msg1
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		li $t0, 0
		li $t1, 1
		
		blt $v0, $zero, Negative
		Loop:
			add $t2, $t1, $t0
			sub $v0, $v0, 1
			move $t0, $t1
			move $t1, $t2
			bgt $v0, $zero, Loop

		la $a0,msg2
		li $v0,4
		syscall
	
		move $a0, $t0 # get result in $a0
		li  $v0, 1 # for print_int
		syscall 
		j Exit
		
		Negative:
		la $a0, msg3
		li $v0, 4
		syscall
		j main
		
		Exit:
		li $v0,10
		syscall
		