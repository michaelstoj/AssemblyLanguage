# Homework 2 Parsing a RISC-V Instruction
# written by: Mike Stoj
# figure out the opcode and run whatever procedure based on format
# cahnge code1 to code2 or code3 to run the other formats


	.data
code1: .word 0x003100b3			# r format code
code2: .word 0x3e813083			# i format code
code3: .word 0x3e113423			# s format code
code4: .word 0x00110193
code5: .word 0x00000113
code6: .word 0x007302B3
code7: .word 0xFCE08793


rFormat: .asciiz "R-format "		
iFormat: .asciiz "I-Format "
sFormat: .asciiz "S-Format "

space: .asciiz " "			# blank space
x: .asciiz " x" 			# print X
error: .asciiz "error: not a good format" # print error

	.text
	.globl main
	
# the main checks the opcoode and will branch to the correct format based on 
# the opcode, if the opcode is wrong, it prints wrong format
# to run the different types change the first statement to other code
main:
							
	lw $t0,code3			# load instruction to memory
	
	
	and $t1,$t0,0x7f		# get opcode 
	
	beq $t1, 0x33, rLoop		# if eqal then its R format
	
	beq $t1, 0x03, iLoop		# branch to I format
	beq $t1, 0x13, iLoop		# other i loop possibility
	
	beq $t1, 0x23, sLoop		# branch to S format

	li $v0, 4			# print error msg if none of formats
	la $a0, error
	syscall	

	j exit				# exit if it's none of the three formats
	

## if the format is I then run this portions
iLoop:					#i instuction loop
.text
	srl $t2, $t0, 15		# get the RS1 
	and $t2, $t2, 0x1f		
	
	srl $t3, $t0, 7			# get the RD field
	and $t3, $t3, 0x1f		
	
	srl $t4, $t0, 20		# get the Imme field
	and $t4, $t4, 0xfff		
		
	
	
	li $v0, 4			# print I Format
	la $a0, iFormat
	syscall	
	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# print RS1
	move $a0, $t3	
	syscall
	
	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# print RS1
	move $a0, $t2	
	syscall
	
	li $v0,4			# print a space
	la $a0,space
	syscall
	
	li $v0,1			# print the imm field
	move $a0,$t4
	syscall

	j exit				# exit
	
# if the opcode is an S format then run this
sLoop:	
.text				# s instruction loop
				
	srl $t4, $t0, 20		# get the RS2
	and $t4, $t4, 0x1f		
	
	srl $t3, $t0, 15		# get Rs1
	and $t3, $t3, 0x1f
	
	srl $t5, $t0, 7			# get half imm value
	and $t5,$t5,0x1F
	
	srl $t6, $t0, 25		# get 2nd half imm value
	and $t6,$t6,0x3F
	
	sll $t6,$t6,5			#shift the 2nd imm to correct position
	
	or $t5, $t6, $t5		# combine the two imm fields into one


	li $v0, 4			# print S Format
	la $a0, sFormat
	syscall	
	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# print RS1
	move $a0, $t4	
	syscall
	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# print RS2
	move $a0, $t3	
	syscall
	
	li $v0,4			# print a space
	la $a0,space
	syscall
	
	li $v0, 1			# print immediate
	move $a0, $t5	
	syscall

	j exit				# exit
	
# if the opcode is an r format it will run this portion
rLoop:					# r instruction loop
.text
	srl $t2, $t0, 7			# get RD
	and $t2, $t2, 0x1f
	
	srl $t3, $t0, 15		# get Rs1
	and $t3, $t3, 0x1f
	
	srl $t4, $t0, 20		# get RS2
	and $t4, $t4, 0x1f

	li $v0, 4			# print F format string
	la $a0, rFormat
	syscall	

	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# print the first value
	move $a0, $t2
	syscall
	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	
	li $v0, 1			# print the second value
	move $a0, $t3
	syscall	
	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# get the last value
	move $a0, $t4	
	syscall
	
	j exit
exit:				# exit the program
	li $v0,10
	syscall
