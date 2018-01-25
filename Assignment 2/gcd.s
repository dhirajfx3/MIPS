#MIPS program to evaluate the gcd of two numbers using eucild's algorithm
.data
rompt: .asciiz "Enter number 1 :"
rompt2: .asciiz "Enter number 2 :" #promts
res : .asciiz "The gcd of the two numbers is : "
ex : .asciiz "Exiting ...\n"
endl : .asciiz "\n"
.text
gcd:   #computes gcd of values in register a0,a1 and puts the final value in register v0
	lab:
		beqz $a1, return    # if a1 is 0 then loop will terminate
		move $t0, $a0		# copy the value of a0 to temporary register
		move $a0, $a1		# copy the value a1 to a0
		div $t0,$a0			#result of division is stored is stored in Lo and Hi, a mod b in Hi and a/b in Lo
		mfhi $a1            # move from hi :extract the remainder of division
		j lab				# loop invariant is maintained gcd(a,b) = gcd(b,a%b) if b!=0
return:
	move $v0, $a0			#move result to v0 register
	jr $ra                  # resume running program by updating the program counter
main:
	# prompt 1
	li $v0, 4
	la $a0, rompt
	syscall

	# Note that performance of the program will be much better if
	# sp is not used since loading and storing data from/to memory is costly
	# in practice variable must be stored at temporary register
	# use of stack pointer is for only demonstration purposes
	li $v0, 5
	syscall

	addi $sp,-4			# move the stack pointer 
	sw $v0, ($sp)		# move the value from v0 to stack

	#prompt 2
	li $v0, 4
	la $a0, rompt2
	syscall
	
	li $v0, 5
	syscall
	move  $a1,$v0
	
	# function call
	lw $a0, ($sp)     #load first value from stack to a0 register
	jal gcd           # jump-and-link 
	addi $sp, -4
	sw $v0, ($sp)     #store the value in the stack

	# output
	li $v0, 4			
	la $a0, res
	syscall

	li $v0, 1		 #load the value of result from the stack
	lw $a0, ($sp)   
	syscall

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
