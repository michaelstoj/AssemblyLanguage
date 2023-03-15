	.data
	
input: .asciiz " "
ouput: .asciiz " "

	.globl 	main
	.text
main:	

	li $v0, 8
	la $a0, input
	li $a1, 14
	syscall
	

	sw $a0,	
	
			
	li $v0,4
	la $a0, input
	syscall
	
	
	
	
	
	li $v0, 10