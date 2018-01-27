.data
p1 : .asciiz "Enter size of array :"
scn : .asciiz " : "
spc : .asciiz " "
p2 : .asciiz "Enter the element "
p21 : .asciiz " of array :"
p3 : .asciiz "The resultant array after sorting is :\n"
ex: .asciiz "\nExiting...\n"
.align 2
A : .space 1000			# array value
B : .space 1000			# temporary array
.globl main
.text
merge:
	sw $fp, -8($sp)		#storing  $fp
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
		lw $fp,-8($sp)		# preserving $fp
		jr $ra

merge_sort:			# sorts the array at position a0, with size $a1
	li $t0, 1		# return if size is 1
	beq $t0, $a1, return
	
	addi $sp,-32    # 5 merge'a args 3 preserving registers = 8 registers
	sw $ra, 28($sp)
	sw $s0, 24($sp)
	sw $s1, 20($sp)
	
	move $s0, $a1
	move $s1, $a0
	sra $a1, $a1, 1

	sw $a0, ($sp)
	sw $a1, 4($sp)
	jal merge_sort

	li $t0, 4
	sra $a1, $s0, 1
	mult $t0, $a1
	sub $a1, $s0, $a1
	mflo $t0
	move $a0, $s1
	add $a0, $a0, $t0

	sw $a0, 8($sp)
	sw $a1, 12($sp)
	jal merge_sort

	la $t0, B
	sw $t0, 16($sp)
	jal merge

	la $t0, B

	loop_merge:
		beqz $s0,endloop
		
		lw $t1, ($t0)
		sw $t1, ($s1)
		addi $t0, 4
		addi $s1, 4
		addi $s0, -1
		j loop_merge
	endloop:
	lw $ra, 28($sp)
	lw $s0, 24($sp)
	lw $s1, 20($sp)
	addi $sp,32
	return:
		jr $ra
main:
	#get array size 1

	li $v0, 4
	la $a0, p1
	syscall
	
	li $v0, 5
	syscall

	move $t0, $v0

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


		li $v0, 5
		syscall
		sw $v0, ($t3)

		addi, $t3, 4
		addi $t2, 1
		j loop1
end1:
	addi $t0, -1

	la $a0, A
	move $a1, $t0
	move $s0, $t0

	jal merge_sort

	move $t0, $s0
	la $t2, A 
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