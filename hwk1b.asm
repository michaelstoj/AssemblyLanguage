# written by: Mike Stoj
# program 1B: moving the sprite

# the sprite in memory
	.data
sprite: .byte 0xee,0xee,0xee,0x0e

	.globl 	main
	.text
main:	
	lw $t1, sprite			# load the sprinte into register
	li $t2, 0			# create a counter
	
rightShift:
	ror $t1, $t1, 4			# roteate the sprite right
	sw $t1, sprite			# store the rotation in memory
	
	addi $t2,$t2,1			# add 1 to counter
	bne $t2, 7, rightShift		# contine loop if not equal to 9

leftShift:
	rol	$t1, $t1, 4		# at end shift left
	sw $t1,	sprite			# store after shift	
	addi $t2, $t2, 1		#increase count by 1
	
	bne $t2, 14, leftShift	
	
	
	li	$v0, 10			# end the program
	syscall
	
	