.data
p1 : .asciiz "Enter size of array "
scn : .asciiz " : "
spc : .asciiz " "
p2 : .asciiz "Enter the element "
p21 : .asciiz " of array "
p3 : .asciiz "The resultant array after merging is :\n"
ex: .asciiz "Exiting...\n"
.align 2
A : .space 1000
B : .space 1000
C : .space 2000
.globl main
.text
merge:
	sw $fp, -8($sp)
	move $fp, $sp
	addi $sp,-8
	lw $t0, ($fp)		# load array pointer
	lw $t1, 4($fp)      # load first array size
	lw $t2, 8($fp)      # load second array pointer
	lw $t3, 12($fp)		# load second array size
	lw $t4, 16($fp)		# load destination array size

	li $t5 ,0
	li $t6 ,0
	merge_loop:
		slt $t7, $t5, $t1
		beqz $t7, merge_endloop1
		slt $t7, $t6, $t3
		beqz $t7, merge_endloop1

		lw $t8, ($t0)
		lw $t9, ($t2)
		slt $t7, $t8, $t9
		beqz $t7, merge_first_isn_less
			sw $t8, ($t4)
			addi $t4, 4
			addi $t5, 1
			addi $t0, 4
			j merge_loop
	merge_first_isn_less:
		sw $t9, ($t4)
		addi $t4, 4
		addi $t6, 1
		addi $t2, 4
		j merge_loop

	merge_endloop1:
		merge_loop2:
			slt $t7, $t5, $t1
			beqz $t7, merge_endloop2
			lw $t8, ($t0)	
			sw $t8, ($t4)
			addi $t4, 4
			addi $t5, 1
			addi $t0, 4
			j merge_loop2

	merge_endloop2:
		merge_loop3:
			slt $t7, $t6, $t3
			beqz $t7, merge_endloop3
			lw $t8, ($t2)	
			sw $t8, ($t4)
			addi $t4, 4
			addi $t6, 1
			addi $t2, 4
			j merge_loop3
	merge_endloop3:
		addi $sp,8
		lw $fp,-8($sp)
		jr $ra

main:
	#get array size 1

	li $v0, 4
	la $a0, p1
	syscall
	
	li $v0, 1
	li $a0, 1
	syscall

	li $v0, 4
	la $a0, scn
	syscall

	li $v0, 5
	syscall

	move $t0, $v0

	#get array size 2

	li $v0, 4
	la $a0, p1
	syscall
	
	li $v0, 1
	li $a0, 2
	syscall

	li $v0, 4
	la $a0, scn
	syscall

	li $v0, 5
	syscall

	move $t1, $v0

	#get array 1:
	li $t2, 1
	la $t3, A
	addi $t0, 1
	loop1:
		beq $t2, $t0, end1 # check counter

		#read input
		li $v0, 4
		la $a0, p2
		syscall

		li $v0, 1
		move $a0,$t2
		syscall

		li $v0, 4
		la $a0, p21
		syscall

		li $v0, 1
		li $a0, 1
		syscall

		li $v0, 4
		la $a0, scn
		syscall

		li $v0, 5
		syscall
		sw $v0, ($t3)

		addi, $t3, 4
		addi $t2, 1
		j loop1
end1:
	addi $t0, -1

	#get array 2:
	li $t2, 1
	la $t3, B
	addi $t1,1
	loop2:
		beq $t2, $t1, end2 # check counter

		#read input
		li $v0, 4
		la $a0, p2
		syscall

		li $v0, 1
		move $a0,$t2
		syscall

		li $v0, 4
		la $a0, p21
		syscall

		li $v0, 1
		li $a0, 2
		syscall

		li $v0, 4
		la $a0, scn
		syscall

		li $v0, 5
		syscall
		sw $v0, ($t3)

		addi, $t3, 4
		addi $t2, 1
		j loop2
end2:
	addi $t1, -1

	addi $sp, -20
	la $t2, A
	la $t3, B
	la $t4, C
	sw $t2, ($sp)
	sw $t0, 4($sp)
	sw $t3, 8($sp)
	sw $t1, 12($sp)
	sw $t4, 16($sp)
	
	jal merge

	li $v0, 4
	la $a0, p3
	syscall

	lw $t0, 4($sp)
	lw $t1, 12($sp)
	la $t2, C 
	add $t0,$t0,$t1
	while:
		beqz $t0,endwhile

		#print value
		li $v0, 1
		lw $a0, ($t2)
		syscall

		li $v0, 4
		la $a0, spc
		syscall

		addi $t2, 4
		addi $t0, -1
		j while
endwhile:
	li $v0, 4
	la $a0, ex
	syscall

	li $v0, 10
	syscall