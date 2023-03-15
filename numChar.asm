		.data
	char:	.asciiz " "
	buffer:.asciiz	"                    "
	text:  .asciiz "Enter nuber and character"
	cr:	.asciiz "\n"
		.text

	main:
					# 
		li	$v0,4
		la	$a0,text
		syscall
					# 
		li	$v0,5
		syscall
		move	$t0,$v0

					# 
		la	$a0,buffer
		li	$a1,5
		li	$v0,8
		syscall
		lb	$t1,buffer
					# 
		sw	$t0,-4($sp)
		sw	$t1,-8($sp)
		jal	print
		jr	$ra

############################ Print Procedure
	print:				# print()
		addi	$sp,$sp,-12
		sw	$ra,0($sp)
		lw	$t1,4($sp)
		lw	$t0,8($sp)
	sb	$t1,char
					# 
	print1: beq	$0,$t0,print2
					# 	
		la	$a0,char
		li	$v0,4
		syscall
					# 	
		addi	$t0,$t0,-1
		b	print1

	print2: la	$a0,cr
		li	$v0,4
		syscall

		lw	$ra,0($sp)
		addi	$sp,$sp,12
		jr	$ra