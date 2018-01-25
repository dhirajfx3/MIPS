#MIPS program to take array of length 8 as input an finding the maximum value
.data
p1: .asciiz "Enter the value "
endl: .asciiz "\n"
p2: .asciiz "The max value of array is: "
spc: .asciiz " : "
ex: .asciiz "Exiting..."
#address must be multiple of 4 since at each turn 4 bytes are read by assembler
.align 2
A : .space 32  #allocate space for 8 integers each of 4 byte hence 32 bytes

.globl main

.text

main:
	li $t0,1 	#loop counter
	la $t1, A   #load address of array
	li $t2, 0x80000001 #register storing maximum value initialized with minimum value

	loop:
		beq $t0, 9, exit #if loop counter is equal to 9 then goto exit label
		
		#prompt user of input
		li $v0, 4
		la $a0, p1
		syscall

		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, spc
		syscall
		
		#take input
		li $v0, 5
		syscall

		slt $t4, $v0, $t2 #check if new value is less than current maxima 
		bgtz $t4, old     #if new value is less than current maxima then skip the move statement of next line [43]
		move $t2, $v0
		old :
		sw $v0, ($t1)     # store the newly read value at required location
		addi $t0, 1		  # increment the loop counter
		addi $t1, 4       # move the array pointer by 4 so that next value can be stored at next location
		j loop 	
	exit:
		#print the maximum value
		li $v0, 4
		la $a0, p2 
		syscall
		
		li $v0, 1
		move $a0, $t2
		syscall

		li $v0, 4
		la $a0, endl
		syscall

		#print the exit string
		li $v0, 4
		la $a0, ex
		syscall

		li $v0, 10
		syscall		
