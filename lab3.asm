########################################################
# This program prints an ascii table
#
# The call to syscall has the following parameters:
#   $a0: thing to be printed
#   $v0: Mode
#       1 = integer
#       4 = null-terminated string
# Register Convention:
#   $s1 = index
#   $s2 = endloop condition: 256
########################################################
	.data
head:	.asciiz "Ascii Table\n"
char:	.byte   1,10,0   # 10=LineFeed
space: 	.asciiz "   "

	.text
	.globl main
main:

	
	li	$t3, 0x19

ASC00:
	li 	$v0,4		# print (heading);
	la	$a0,head
	syscall

	li 	$s1,0		# index = 0;
	li	$s2,256	        # do {
ASC10:
	li	$v0,1		#   print (index);
	move	$a0,$s1
	syscall
#

	li 	$v0, 4		# print 3 spaces			
	la	$a0, space
	syscall			
 
	li	$v0,4		#   print (byte);
	la	$a0,char
	syscall
#
	addi	$s1,$s1,1 	#   index++;
#
	lb	$a0,char	#   byte++;
	addi	$a0,$a0,1
	sb	$a0,char
#
	bne	$s1,$s2,ASC10   # } (until index = 256)
#
	li	$v0,10		# System(exit)
	syscall
