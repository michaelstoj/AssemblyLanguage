###################################################################
#  This program converts from little endian to big endian (or vice versa)
#  in two different ways: direct addressing and pointers (addresses).
#  Author: <Mike Stoj>
###################################################################
	.data
in1buf:	.byte   1,2,3,4,5,6,7,8
out1bf:	.byte	0,0,0,0,0,0,0,0
in2buf:	.byte   9,10,11,12,13,14,15,16
out2bf:	.byte	0,0,0,0,0,0,0,0
string: .asciiz "hello world\n"
string2: .asciiz "again"
sum: .byte
	
	.globl 	main
	.text
main:



################# Exercise 1 ######################################
	lb	$t1,in1buf	   # out1buf[3] = in1buf[0]
	sb	$t1,out1bf+3
	lb	$t1,in1buf+1	 # out1buf[2] = in1buf[1]
	sb	$t1,out1bf+2
	lb	$t1,in1buf+2	   # out1buf[1] = in1buf[2]
	sb	$t1,out1bf+1
	lb	$t1,in1buf+3	   # out1buf[0] = in1buf[3]
	sb	$t1,out1bf
	lb	$t1,in1buf+4	   # out1buf[7] = in1buf[4]
	sb	$t1,out1bf+7
	lb	$t1,in1buf+5	   # out1buf[6] = in1buf[5]
	sb	$t1,out1bf+6
	lb	$t1,in1buf+6	   # out1buf[5] = in1buf[6]
	sb	$t1,out1bf+5
	lb	$t1,in1buf+7	   # out1buf[4] = in1buf[7]
	sb	$t1,out1bf+4
	
			
################# Exercise 2 ######################################
	la	$s0,in2buf         # in2ptr = &in2buf    # (address(in2buf))
	la	$s1,out2bf         # out2ptr = &out2buf  # (address(out2buf))
	
	lb	$t1,0($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,3($s1)
	lb	$t1,1($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,2($s1)	
	lb	$t1,2($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,1($s1)	
	lb	$t1,3($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,0($s1)
	lb	$t1,4($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,7($s1)
	lb	$t1,5($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,6($s1)
	lb	$t1,6($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,5($s1)
	lb	$t1,7($s0)         # value(out2ptr+3) = value(in2ptr+0)
	sb	$t1,4($s1)
	
	
###################################################################################
########### im going to try and do the addition

	lb	$t1,in1buf			# load a byte at a time from inbuf1 into $t1 and add that to the total at $s2
	add $s2,$s2,$t1
	lb	$t1,in1buf+1
	add $s2,$s2,$t1
	lb	$t1,in1buf+2
	add $s2,$s2,$t1
	lb	$t1,in1buf+3
	add $s2,$s2,$t1
	lb	$t1,in1buf+4
	add $s2,$s2,$t1
	lb	$t1,in1buf+5
	add $s2,$s2,$t1
	lb	$t1,in1buf+6
	add $s2,$s2,$t1
	lb	$t1,in1buf+7
	add $s2,$s2,$t1
	
	lb	$t1,in2buf			# load a byte from inbuf2 at a time into $t1 and add that to the total at $s2
	add $s2,$s2,$t1
	lb	$t1,in2buf+1
	add $s2,$s2,$t1
	lb	$t1,in2buf+2
	add $s2,$s2,$t1
	lb	$t1,in2buf+3
	add $s2,$s2,$t1
	lb	$t1,in2buf+4
	add $s2,$s2,$t1
	lb	$t1,in2buf+5
	add $s2,$s2,$t1
	lb	$t1,in2buf+6
	add $s2,$s2,$t1
	lb	$t1,in2buf+7
	add $s2,$s2,$t1
	

	
################################################################
### printes the strings hello world with new line character and followed by again
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 4
	la $a0, string2
	syscall
	
	li      $v0,10		   # exit
	syscall
