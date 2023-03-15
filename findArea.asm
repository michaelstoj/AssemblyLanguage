	.data
prompt1: .asciiz "enter lenght: "
prompt2: .asciiz "enter width: "
output1: .asciiz "the area of a "
output2: .asciiz " x "
output3: .asciiz " rectangle is: "

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
	jal find_area
	move $t0, $v0
	
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
	
	li $v0,10
	syscall
	
	
	
	
	
find_area:
	.text
	mult $a0, $a1
	mflo $v0
	jr $ra
	