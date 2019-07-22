####################Assignment Submission Details#######################
#Group number 10
#AUTUMN-19
#Assignment 1
#problem 1
#Members: Divyang Mittal(17CS10012), Siddhant Agarwal(17CS30035)

####################Data Segment#########################
	.data
msg1: .asciiz "Enter first integer"
msg2: .asciiz "Enter second integer"
msg3: .asciiz "The gcd is "
msg4: .asciiz "Please give positve numbers, Try again\n"
msg5: .asciiz "Please enter value inputs, Try again\n"


####################Code Segment#########################

	.text
	.globl main
	
	main:
		
		la $a0, msg1      
		li $v0, 4		#print a string 
		syscall
		
		li $v0, 5
		syscall      	#input an integer
		blt $v0, $zero, Negative	#checking for negative input
		move $t0, $v0	
		
		la $a0, msg2	
		li $v0, 4		#print a string
		syscall
		
		li $v0, 5
		syscall			#input second integer
		blt $v0, $zero, Negative	#checking for negative input
		move $t1, $v0
		
		beq $t0, $t1, Final			
		bgt $t0, $t1, Dont_Swap1	#storing the larger of the values in t0
			
		move $t2, $t1
		move $t1, $t0
		move $t0, $t2
		
		Dont_Swap1:
		
		beq $t1,$zero, Final		#handling the case for gcd(k, 0)
		
		Loop:							#using the subtraction method to compute gcd
			bgt $t0, $t1, Dont_Swap		#storing the larger of the values in t0
			
			move $t2, $t1
			move $t1, $t0
			move $t0, $t2
			
			Dont_Swap:
			sub $t0, $t0, $t1
			bne $t0, $t1, Loop
		
		Final:
		beq $t0, $zero, Valid	#gcd(0,0) is indeterminate
		la $a0,msg3				
		li $v0,4
		syscall
	
		
		move $a0, $t0 # get result in $a0
		li  $v0, 1 # to print answer
		syscall
		j Exit

		Negative:
		la $a0, msg4	#handling negative input exception 
		li $v0, 4
		syscall
		j main
		
		Exit:		
		li $v0,10
		syscall
		
		Valid:
		la $a0, msg5
		li $v0, 4
		syscall		#Handling both input zero Exception
		j main
