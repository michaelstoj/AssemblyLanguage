###########################################################################
#  Get info
#  In this example, one buffer is defined in local memory i.e., on the stack.
#  However, it is possible to overflow the stack by reading in a large buffer.
#  The stack buffer is not sufficiently large to hold the data, and
#  and other fields in the stack will overflow, including return address, etc.
#  It is also possible to overflow areas in the data section, as you will see
#  in this example.  That can cause data spillage such as unexpected information
#  to the screen to new users.
#  Buffer = temporary data storage area in memory, used by the OS.
###########################################################################
	.data
getName:.asciiz	"Welcome to Gidget Sales.  To find out our discounts, please enter your name: "
pitch:  .asciiz "We have gidgets for sale today, 2 for the price of 1.  Would you like to buy one?"
getAddr: .asciiz "Enter your address: "
getCC:	 .asciiz "Enter credit card number: "
thanks: .asciiz "Thanks for shopping with us today, "
choice: .asciiz "                            "
name:	 .asciiz "                            "
addr:   .asciiz "                            "
CC:	 .asciiz "                            "

	.text
main:
					# for each customer do:
	jal	GivePtch		#    TransactionType = GiveSalesPitch()
	bne	$v0,$zero,mainx 	#    if (TransactionType==Buy) {
	jal	GetInfo		#	     GetCustomerInfo()
	jal	PrRcpt			#	     PrintReceipt()
					#    }
mainx:	la	$a0,thanks		#    print("Thanks for shopping with us,")
	li	$v0,4
	syscall

	la	$a0,name		#    print(name)
	li	$v0,4
	syscall

	b 	main			# enddo 
	li	$a0,10
	syscall

##########################################################################
#  GiveSalesPitch:  Ask if they want to purchase 
#
#  Stack use:
#      8($sp)   Return address
#      0-7($sp) buffer for input
##########################################################################
GivePtch:
	addi	$sp,$sp,-12	# string localType; 
	sw	$ra,8($sp)	# address returnAddress

	la	$a0,getName	#  printString(GetName)
	li	$v0,4
	syscall
	
	la	$a0,name	#  readString(name)
	jal	RdStrng
		
	la	$a0,pitch	#  print(SalesPitch)
	li	$v0,4
	syscall
	
	la	$a0,0($sp)	#  ReadString(localType)
	jal	RdStrng
	
	li	$v0,0x79	#  return_value = 'y'
	lb	$t1,0($sp)	#  if (localType[0] != 'y')
	bne	$v0,$t1,GivePtch9
	move	$v0,$zero	#     return_value = 0
GivePtch9:	
	lw	$ra,8($sp)
	addi	$sp,$sp,12
	jr	$ra		#  return return_value
##########################################################################
#  GetInfo: Reads customer information and puts in global data
#  Stack Usage: 0(sp) = Return address
#  Calling Sequence: jal   GetInfo
##########################################################################
GetInfo:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,getAddr	#  printString(Get Address)
	li	$v0,4
	syscall
	
	la	$a0,addr	#  readString(address)
	jal	RdStrng
	
	la	$a0,getCC	#  printString(Get CreditCard)
	li	$v0,4
	syscall
	
	la	$a0,CC		#  readString(credit_card)
	jal	RdStrng
	
	lw	$ra,0($sp)	#  return;
	addi	$sp,$sp,4
	jr	$ra

##########################################################################
#  PrintReceipt
#  Stack Usage: 0(sp) = Return address
#  Calling Sequence: jal   PrRcpt
##########################################################################
PrRcpt:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	
	li	$v0,4		#  printString(name) 
	la	$a0,name
	syscall
	
	li	$v0,4		#  printString(address)
	la	$a0,addr
	syscall
	
	li	$v0,4		#  printString(CreditCard)
	la	$a0,CC
#	syscall
	
	lw	$ra,0($sp)
	addi	$sp,$sp,-4
	jr	$ra

###########################################################################
#  Read string:  Reads a string and puts it in the address contained in $a0
#
#  Stack usage: 0(sp) = Return address
#
#  Calling Sequence:
#	la	$a0,StringAddress
#	jal	RdString
###########################################################################
RdStrng:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)	#  save return address
	
	li	$v0,8		#  read_String(addr=argument, length=30)
	li	$a1,30
	syscall
	
	lw	$ra,0($sp)	#  return
	addi	$sp,$sp,4
	jr	$ra
	
