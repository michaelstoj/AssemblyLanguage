# Homework 3 Using Procedure
# written by: Mike Stoj
# 
# put the RISC codes into code in the data section
#
##########################################################
	.data
	

code: .word 0x003100b3 0xFCE08793 0x3e813083 0x00011111 0x3e113423 0x00110193 0x00000113 0x007302B3
	0x003100b3 0xFCE08793 0x3e813083 0x00011111 0x3e113423 0x00110193 0x00000113 0x007302B3  #  code
endLoop: .word 0x11111111		# used this to know when the  code was done to end the loop

pR: .asciiz 	"R-format "
pI: .asciiz 	"I-format "
pS: .asciiz 	"S-format "
error: .asciiz "error msg: wrong format"
x: .asciiz 	" x"
func3: .asciiz	" Func3: "
func7: .asciiz	" Func7: "
space: .asciiz " "
newLine: .asciiz "\n"

	.globl main
##########################################################
# the main gets the opcod and will pass the opcode to decode the rest of the
# machine code, then it passes the opcode to the sweitch which will check
# which format it is and then run based on that
# this will run the first code
#
# jumps: 
#	decode
#	switch
##########################################################
main:	
.text	
	
	lw $t9, endLoop			# set end loop condition
	la $s1,code			# load instruction to memory
	lw $a0,($s1)			# load the word at memory into location
	jal decode			# run decode	
	jal switch			# run switch based on opcode


########################################################	
#  will get the next word to run until there code matches the end code
#  which i have set to 0x11111111 
#  Cslling Sequence: 
# 	rForm, iForm, sForm, deocde
# Returns: Nothin
# Stack Usage : will have all the data sections parsed
#	 28($sp) = RA
# 	24($sp) = opcode
# 	20($sp) = 7-11 bits
# 	16($sp) = Func3
# 	12($sp) = RS1
# 	8($sp) = RS2 / Imm
# 	4($sp) = Func7 / Imm
#
# jumps:
#	decode and link back
#	switch 
##########################################################
next:
.text	
	addi $s1, $s1 4			# icreament mem location by 4	
	
	li $v0,4			# print a newline
	la $a0,newLine
	syscall
	
	lw $a0,($s1)			# load the next code to run
	beq $a0,$t9, exit		# branch if it's the endo of memory
	
	jal decode			# run decode	
	j switch			# run switch based on opcode
	


##########################################################		
# if the swtich branches to R format it will run this portions, it will take
# the data on the stack and roate and get the correct bits for an r format 
# style machine code and print the right registers
#	
# Calling Sequence: 
#	switch
#	
# Stack Usage : will have all the data sections parsed
#	 28($sp) = RA
# 	24($sp) = opcode
# 	20($sp) = 7-11 bits
# 	16($sp) = Func3
# 	12($sp) = RS1
# 	8($sp) = RS2 / Imm
# 	4($sp) = Func7 / Imm
#
# jumps :
# 	next
##########################################################
##########################################################
rForm:
.text

	li $v0, 4			# print R format String
	la $a0, pR
	syscall
	
	
	lw $a1,20($sp)			# load first value into register
	jal print_Reg_Num		# pass value and print
	
	lw $a1,12($sp)			# pass second value
	jal print_Reg_Num		# pass value and run print
	
	lw $a1,8($sp)			# pass third value
	jal print_Reg_Num		# pass value and run print
	
	
	lw $a1,16($sp)
	
	jal print_Func			# print Func3
	
	li $v0, 4			# print first func3
	la $a0, func7
	syscall
	
	lw $a1,4($sp)			# load fun3 from stack
	
	li $v0,1			# move func 7 to register
	move $a0,$a1
	syscall
	
	addi $sp, $sp, 28
	
	j next				# exit
#########################################################
# will take the machine code from the stack and print the correct
# output based on the opcode and whats passed to it
#
#
# Calling Sequence: 
#	switch
#	
# Stack Usage : will have all the data sections parsed
#	 28($sp) = RA
# 	24($sp) = opcode
# 	20($sp) = 7-11 bits
# 	16($sp) = Func3
# 	12($sp) = RS1
# 	8($sp) = RS2 / Imm
# 	4($sp) = Func7 / Imm
#
# jumps :
# 	next
##########################################################
##########################################################
iForm:
.text

	li $v0, 4			# print I format
	la $a0, pI
	syscall
	
	lw $a1,20($sp)			# load first value into register
	jal print_Reg_Num		# pass value and print
	
	lw $a1,12($sp)			# pass second value
	jal print_Reg_Num		# pass value and run print
	
	srl $a1, $t0, 20		# get the Imme field
	and $a1, $a1, 0xfff		# turn other bits of
		
	
	li $v0,4			# print a space
	la $a0,space
	syscall
	
	li $v0,1			# print the imm field
	move $a0,$a1
	syscall
	
	lw $a1,16($sp)			# load fun3 from stack

	jal print_Func			# print func3
	
	addi $sp, $sp, 28
	
	j next				# exit
###########################################################	
# the s format code will take the machine code from the stack and print and 
# parse what it needs to get the right registers
#
#
# Calling Sequence: 
#	switch
#	
# Stack Usage : will have all the data sections parsed
#	 28($sp) = RA
# 	24($sp) = opcode
# 	20($sp) = 7-11 bits
# 	16($sp) = Func3
# 	12($sp) = RS1
# 	8($sp) = RS2 / Imm
# 	4($sp) = Func7 / Imm
#
# jumps :
# 	next
##########################################################
##########################################################
sForm:
.text

	li $v0, 4			# print S format
	la $a0, pS
	syscall
	
	lw $a1,8($sp)			# load first value into register
	jal print_Reg_Num		# pass value and print
	
	lw $a1,12($sp)			# pass second value
	jal print_Reg_Num		# pass value and run print
	
	srl $a1, $t0, 20		# get the Imme field
	and $a1, $a1, 0xfff		# turn other bits of
		
	srl $a1, $t0, 7			# get half imm value
	and $a1,$a1,0x1F
	
	srl $a2, $t0, 25		# get 2nd half imm value
	and $a2,$a2,0x3F
	
	sll $a2,$a2,5			#shift the 2nd imm to correct position
	
	or $a1, $a2, $a1		# combine the two imm fields into one

	
	li $v0,4			# print a space
	la $a0,space
	syscall
	
	li $v0,1			# print the imm field
	move $a0,$a1
	syscall
	
	lw $a1,16($sp)			# load fun3 from stack
	
	jal print_Func			# print func3	
	
	addi $sp, $sp, 28
	
	j next				# exit
############################################################
## will take the opcode and run the procedure based on what format it is
# if the formats are wrong it will print wrong format and terminate the
# program
#
## Calling Sequence: 
#	decode
#	
# Stack Usage : will have all the data sections parsed
#	 28($sp) = RA
# 	24($sp) = opcode
# 	20($sp) = 7-11 bits
# 	16($sp) = Func3
# 	12($sp) = RS1
# 	8($sp) = RS2 / Imm
# 	4($sp) = Func7 / Imm
#
# jumps :
# 	next
##########################################################
##########################################################
switch: 
.text
	lw $t1,24($sp) 			# get opcode from stack
	
	beq $t1,0x33, rForm		# R Format
		# 
	beq $t1, 0x03, iForm		# branch to I format
	beq $t1, 0x13, iForm		# other i loop possibility
	
	beq $t1, 0x23, sForm		# branch to S format
	
	
	li $v0, 4			# error message if code is wrong format
	la $a0, error
	syscall
	
	j next				# exit
	
################################################################
# decode will get each portion of the machine code and save it onto the stack
# since the codes always use the same bits you can decode all 3 formats
# the same way
# 
# Calling Sequence: 
#	main / next
#	
# Stack Usage : will have all the data sections parsed
#	 28($sp) = RA
# 	24($sp) = opcode
# 	20($sp) = 7-11 bits
# 	16($sp) = Func3
# 	12($sp) = RS1
# 	8($sp) = RS2 / Imm
# 	4($sp) = Func7 / Imm
#
# jumps :
# 	RA
##########################################################
#####################################################
decode:
.text

	move $t0, $a0			# move the pass arg into temp 
	subi $sp,$sp,28			# move stack to make room for all code
	
	sw $ra, 28($sp)			# store RA on stack
	
	and $t1,$t0,0x7f		# get opcode 
	sw $t1,24($sp)			# store op code on stack(24)
		
	srl $t3, $t0, 7			# get 7-11 bits, RD or Imm
	and $t3, $t3, 0x1f		# turn off all the other bits
	sw $t3,20($sp)			# store on stack(20)
		
	srl $t2, $t0, 12		# get the Func 3
	and $t2, $t2, 0x07		# turn off other bits
	sw  $t2, 16($sp)		# store on stack(16)
	
	srl $t4, $t0, 15		# get the RS1
	and $t4, $t4, 0x1f		# turn off other bits
	sw  $t4, 12($sp)		# store on stack(12)
	
	srl $t5, $t0, 20		# get RS2
	and $t5, $t5, 0x1f		# turn off other bits
	sw  $t5, 8($sp)			# store on stack(8)
	
	srl $t6, $t0, 25		# get Fun7 or Imm
	and $t6, $t6, 0x1f		# turn off other bits
	sw  $t6, 4($sp)			# store on stack(4)
	
	lw $ra, 28($sp)			# load RA from stoack
	jr $ra				# go to RA

###########################################################
# will print the x followed by the value thats passed to it in $a1
#
# Calling Sequence: 
#	rForm, sForm, iForm
#
# Pass:
#	$a1 = number to print	
#
# jumps :
# 	RA
##########################################################
print_Reg_Num:
.text	
	li $v0, 4			# print the x 
	la $a0, x
	syscall	
	
	li $v0, 1			# print the first value
	move $a0,$a1
	syscall
	
	jr $ra				# jump back 

#############################################################3
# will print the Func3 statment that all three machine codes use
#
#
# Calling Sequence: 
#	rForm, sForm, iForm
#
# Pass:
#	$a1 = number to print	
#
# jumps :
# 	RA
#
##########################################################
print_Func:
.text
	li $v0, 4			# print first func3
	la $a0, func3
	syscall
	
	li $v0, 1			# print the fun 
	move $a0,$a1
	syscall
	
	jr $ra				# jump back after procedure
	
#######################################################3#	
# exits the program
#
#
##########################################################
exit:					# exit the program
	li $v0,10
	syscall
