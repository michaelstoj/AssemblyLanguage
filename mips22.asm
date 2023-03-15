########################################################
# This procedure takes a binary byte and prints a hexadecimal character.
#
# The call to syscall has the following parameters:
#   $a0: thing to be printed
#   $v0: Mode
#       1=integer
#       4=null-terminated string
########################################################
	.data
header: .asciiz  "Print byte: 0x"		
table:  .asciiz  "0123456789ABCDEF"		
char:	.byte	 0,0
number: .byte  	 0x4b				
	.text
	.globl main
main:						
	li 	$v0,4			# printString("Print byte: 0x"
	la	$a0,header
	syscall					
	lb	$s2,number		# index = number >> 4 & 0xf			
	srl	$s4,$s2,4	   	
		
	andi	$s4,$s4,0xf
	sw $s4,-4($sp)
	
	jal PrtNbl
							
	andi	$s4,$s2,0xf		# index = number & 0xf
	sw $s4,-4($sp)
	jal PrtNbl
	
	j exit
	
########################################
# PrintNibble(Nibble):  This procedure prints a nibble
# Register convention:  (how registers are used)
# Calling sequence: lw $a0,nibble
# jal PrtNbl
########################################
	
# Stack usage:   4($sp) = binary nibble
# 0($sp) = return address
PrtNbl:
.text
	addi $sp,$sp,-8
	sw $ra,0($sp)
	
	lw $a1, 4($sp)
	
	la	$t5,table		# entry = table[index]
	add	$t5,$t5,$a1
	lb	$t3,0($t5)
	sb	$t3,char		# char = entry
#						
	li	$v0,4			# printString(char)
	la	$a0,char
	syscall
	
	lw $ra,0($sp)
	addi $sp, $sp, 8
	jr $ra
exit:#					 
	li	$v0,10			# exit
	syscall
