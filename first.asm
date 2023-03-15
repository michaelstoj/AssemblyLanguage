	.data
prompt: .asciiz "\nenter a string: "
output: .asciiz "output:\t\t"
str: 	.space 41
strsize: .word 40
	
	.globl main
	.text
main:


	li $18, -10
	li $19, 0xBA	
	lw $t0, prompt
	lb $t0, prompt+1
	
	
	add $t1, $s2, $19
	

	addi $t1, $t1, 2

	move $t3, $t1	
	
	li $v0, 1
	la $a0, ($t1)
	syscall
	
		
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, str
	lw $a1, strsize
	syscall
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 4
	la $a0, str
	syscall
	
	li $v0, 10
	syscall
	
