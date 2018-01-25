.data
Hi : .asciiz "Hello world"
.text
.globl main
main:
	#Output on the screen is shown as using a system call
	#The system call number for printing the string on the screen is 4 
	#Argument to this call is only the address of string to be printed 
	li $v0, 4		# li- load immediate [ for loading 32 signed values directly into register]
	la $a0, Hi 		# la- load address   [ for loading the address of the label's base ]
	syscall

	#system call number for exit is 10 and it takes no arguments
	li $v0, 10
	syscall
