########################################################
# This program moves data from an input array to an output array
#
# Register Usage:
#      S3 = inindex = input pointer
#      S4 = outindex = output pointer
#      T5 = index (for loop - decrements)
#
########################################################
	.data
InArr:  .word	10,20,30,40,50,60,70,80,90,100
OutArr: .word	0,0,0,0,0,0,0,0,0,0


	.text
	.globl main
main:
#						Register conventions:
	la	$s3,InArr		#	S3 = inindex
	la	$s4,OutArr		#	S4 = outindex

	li	$t5,10			#	i=5
Loop:					#	do
	lw	$t1,0($s3)		#		*outindex = *inindex
	sw	$t1,0($s4)
	
	lb	$t1,InArr
	lb	$t1,OutArr
	
	addi	$s3,$s3,4     		#		inindex++
	addi	$s4,$s4,4		#		outindex++
	addi	$t5,$t5,-1		#		i--
	bnez	$t5,Loop		#	until i==0
	li   	$v0, 10            	#     	System(exit)
	syscall                 	# 
