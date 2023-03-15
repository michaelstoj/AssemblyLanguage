# written by: Mike Stoj
# program 1A: perfroms and, or clculations


# the data hold the string in the memory so we can print the string
# and space for the answer
	.data
result:	.asciiz	"0x3f & 0xaa | 0x03  = "
ans: 	.word		

	.globl 	main
	.text
main:
	li	$t1, 0x3f		# load the hex value
	
	and	$t1, $t1, 0xaa		# perform  the AND of two values calucation
	ori	$t1,$t1, 0x03		# perform OR of the prevsiou calc and 3rd value
	
	sb	$t1, ans		# store ans in memory
								
	li $v0, 4			# prints the result string
	la $a0, result
	syscall
	
	li $v0, 34
	lb $a0, ans			# print the answer of the calculation as INT
	syscall
	
	
	li	$v0, 10			# end the program
	syscall
	
	
