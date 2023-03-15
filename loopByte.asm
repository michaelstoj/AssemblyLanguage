	.data

InArr:  .byte	10,20,30,40,50,60,70,80,90,100
OutArr: .byte	0,0,0,0,0,0,0,0,0,0

	.text
	.globl main
main: 

	li 	$t5, 10			# 10 is the count of bytes 			#
	li	$t6, 0			# i =  0
	
Loop:	

	lb	$s1,InArr($t6)		# load InArry byte into S1
	sb	$s1,OutArr($t6)		# store byte at S1 into OutArr
	
	addi $t6,$t6,1			# add 1 to byte count
	
	sub 	$t5,$t5,1		# subtract 1 from the bytes left to do
	bnez	$t5, Loop		# if $t5 isn't 0 loop again
	
	li $v0, 10			# end the program when $t5 is 0
	syscall