	.data
prompt1: .asciiz "enter lenght: "
prompt2: .asciiz "enter width: "
output1: .asciiz "the area of a "
output2: .asciiz " x "
output3: .asciiz " rectangle is: "
output4: .asciiz "the permimiter is : "
new_ln: .asciiz "\n"

	.text
main:
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
	jal find_info
	move $t0, $v0
	move $t1, $v1
	
	li $v0, 4
	la $a0, output1
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, output2
	syscall
	
	li $v0,1
	move $a0,$s1
	syscall
	
	li $v0,4
	la $a0, output3
	syscall
	
	li $v0,1
	move $a0,$t0
	syscall
	
	li $v0, 4
	la $a0, new_ln
	syscall
	
	li $v0, 4
	la $a0, output4
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0,10
	syscall
	
	
	
find_info:
	.text
	subi $sp, $sp, 4
	sw $s0, 0 ($sp)
	add $t0, $a0, $a0
	add $t1,$a1,$a1
	add $s0,$t0,$t1
	move $v1,$s0
	mult $a0,$a1
	mflo $v0
	lw $s0,0($sp)
	addi $sp, $sp, 4
	jr $ra
