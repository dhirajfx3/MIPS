.text
main:
	#A1
	li $t0, 1
	li $t1, 2
	add $t2, $t0, $t1
	#A2
	lui $t3, 0x1000
	ori $t3, 0x0001
	lui $t4, 0x2000
	ori $t4, 0x0002
	add $t5, $t4, $t3
	ori $v0,10
	syscall