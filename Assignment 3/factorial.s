.data
p1 : .asciiz "Enter number whose factorial is to be evaluated :"
endl : .asciiz "\n"
p2 : .asciiz "The factorial of input number is : "
exiting : .asciiz "\nExiting...\n"
.text
factorial:  # evaluates the factorial of number stored in $a0
	# 4 for ra, 4 for a0+12,4 for fp 4 for sp 
	bnez $a0, f_label
		li $v0, 1
		jr $ra
f_label:
	addi $sp, -32
	sw $fp, 28($sp)   # saving fp

	move $t0, $sp      # saving sp
	addi $t0, 32
	sw $t0, 24($sp)

	move $fp, $sp		# saving ra
	addi $fp, 28
	sw $ra, -8($fp)

	addi $a0,-1
	sw $a0,-28($fp)		#saving arguments for next call

	jal factorial

	lw $t0,4($fp)
	mult $t0, $v0
	mflo $v0
	lw $ra, -8($fp)
	lw $sp, -4($fp)
	lw $fp, -4($sp)
	jr $ra
main:

	mult $t0,$t1
	li $v0, 4
	la $a0, p1
	syscall

	li $v0, 5
	syscall
	move $a0, $v0


	addi $sp,-32
	sw $a0,($sp)
	jal factorial

	move $t0, $v0

	li $v0, 4
	la $a0, p2
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, exiting
	syscall

	li $v0, 10
	syscall
