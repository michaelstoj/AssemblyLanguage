	.data
p1: .asciiz "enter height: "
p2: .asciiz "enter width: "
out1: .asciiz "the area is: "

	.text
main:
	li $v0, 4
	la $a0, p1
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, p2
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
	
	jal find_area
	move $t0, $v0
	
	li $v0, 4
	la $a0, out1
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	
find_area:
	.text
	
	mult $a0,$a1
	mflo $v0
	jr $ra