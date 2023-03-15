	.data
sp: .word 
num: .word
	
	.text
main:
	subi $sp,$sp,4
	sw $ra,0($sp)
	sub $sp,$sp,4
	sw $s0,0($sp)
	subi $sp, $sp, 4
	sw $s1,0($sp)
	jal bar
	
bar: 
	sw	$ra,8($sp) 
	sw	$s0,4($sp) 
	sw	$s1,0($sp) 
	
	lw	$s1,0($sp) 
	lw	$s0,4($sp)
	 lw	$ra,8($sp)
	 addi $sp,$sp,12 
	 jr $ra
