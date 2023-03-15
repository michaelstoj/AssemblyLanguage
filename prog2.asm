# written by: Mike Stoj
# program 2: conver to binary

	.data
	
hex: 	.word 0xabcdef 

	.text
	.globl main
main:

	lw $16,hex              #s0 put hex into 16 
	addiu $8,$0,31         	# make counter
	li $9,1                 #(t1) mask 
	sll $9,$9,31            # shift left 31 bits

 
loop: 
	beq $t0,-1,end_loop   	#if t0 == -1 exit loop 
  	and $t3,$s0,$t1           #isolate the bit 
  	beq $t0,$0,after_shift    #shift is needed only if t0 > 0 
  	srlv $t3,$t3,$t0          #right shift before display 
  	
after_shift: 
  	move $a0,$t3              #prepare bit for print 
  	
  	li $v0,1                 #prepare system call for printing values 
  	syscall                   #print bit 
 
 	 subi $t0, $t0, 1          #decrease the counter 
 	 srl $t1,$t1, 1            #right shift the mask 
  	 j loop 
  	
end_loop: 

	la $v0, 10			# exit
	syscall
