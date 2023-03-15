	.data
prompt: .asciiz "enter an int: "
output: .asciiz "the factorial is: "
	.text
main:
	li $v0,4
	la $a0,prompt
	syscall
	
	li $v0,5
	syscall
	
	move $a0,$v0
	jal fact
	
	move $a1,$v0
	li $v0,4
	la $a0,output
	syscall
	
	li $v0,1
	move $a0,$a1
	syscall
	
	li $v0,10
	syscall
	
fact:
	subi $sp,$sp,8
	sw $ra,4($sp)
	sw $a0,0($sp)
	li $v0,1
	ble $a0,$zero,base
	addi $a0,$a0,-1
	
	jal fact
	
	lw $a0,0($sp)
	mul $v0,$v0,$a0
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra
	
base:
	lw $ra 4($sp)
	addi $sp,$sp,8
	jr $ra