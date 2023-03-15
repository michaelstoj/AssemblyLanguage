# written by: Mike Stoj
# program 1C: moving the sprite across two words

# the sprite in two words
	.data
sprite: .byte 0xee,0xee,0xee,0x0e
sprite2: .byte 0xee,0xee,0xee,0xee

	.globl 	main
	.text
main:	

	lw $t0, sprite2			# load sprite into register
	lw $t1, sprite			# load the sprinte into register
	lw $t4, sprite			# have a temp sprite ready
	li $t2, 0			# create a counter
	
rightShift:
	ror $t1, $t1, 4			# roteate the sprite right
	sw $t1, sprite			# store the rotation in memory
	
	addi $t2,$t2,1			# add 1 to counter
	bne $t2, 7, rightShift		# contine loop if not equal to 9
	
	move $t5,$0			# save the byte for use when shifting back
	move $t6,$t1			# move into a register for use later with sprite on far right
	sw $t0, sprite			# swithc the two numbers around by using a temp value
	sw $t4, sprite2			# switch the memory address
	
continueRshift:
	ror $t4, $t4, 4			# continue shifting right
	sw $t4, sprite2			# storing the values in sprite 2
	
	addi $t2,$t2,1			# add 1 to counter
	bne $t2, 14, continueRshift	# contine loop until second word is looped
	
leftShift:
	rol $t4, $t4, 4			# start shifting left
	sw $t4,	sprite2			# store after shift	
	addi $t2, $t2, 1		#increase count by 1
	
	bne $t2, 21, leftShift		# continue until reaches left
	
	
	sw $t0,sprite2			# and move the sprite 2 back to original contents
	sw $t6,sprite			# switch the sprites back
	
continueLshift:
	rol $t4, $t4, 4			# finish shifting left
	sw $t4,	sprite			# store after shift	
	addi $t2, $t2, 1		# increase count by 1
	
	bne $t2, 29, continueLshift	# continue until reaches the last byte
	
	
	li	$v0, 10			# end the program
	syscall
	
	