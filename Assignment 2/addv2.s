#MIPS program to take input 2 numbers and printing their sum 
.data
	# using .asciiz for making null terminated strings
	p1  : .asciiz "Enter the number 1: "
	p2  : .asciiz "Enter the number 2: "
	res : .asciiz "The sum of the given two numbers is : "
	endl: .asciiz "\n"
	ex  : .asciiz "Exiting..."

.globl main

.text
	main:
		# prompt1
		li $v0, 4
		la $a0, p1 		#load address of p1
		syscall
		
		# taking input 1
		li $v0, 5
		syscall

		move $t0,$v0	#input is stored in v0 register is then moved to $t0 register
		
		#prompt 2
		li $v0, 4
		la $a0, p2
		syscall

		#taking second input
		li $v0, 5
		syscall			

		#adding the two values
		add $t0,$t0, $v0
		
		#printing the string for result
		li $v0, 4
		la $a0, res
		syscall

		#printing result on the console
		li $v0, 1    
		move $a0,$t0
		syscall

		#printing '\n'
		li $v0, 4
		la $a0, endl
		syscall

		#print exit string
		li $v0, 4
		la $a0, ex
		syscall
		
		#exit system call
		li $v0, 10
		syscall 