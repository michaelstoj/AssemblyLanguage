	.data
	
array: .byte 2,4,6,8
	.word 5
num: .word 0x016a5826
mem: .word 0
m2: .half 0
m3: .half 0
m4: .byte 0
m5: .word 0
	
	.text
main:

	la          $s0,array

           lb          $s1,array

           lb          $s2,1($s0)

           lw          $s3,array+4

           sw          $s1,array+4

           li          $s4,16
           
           
	lw $t1, num
	srl $t1,$t1, 26
	

	addi $s2,$s2,3
	
	xor $t3,$t3,$t2
	
	
	la $s0, array
	lb $s1, array
	lb $s2, 1($s0)
	lw $s3, array+4
	sw $s1, array+4
	li $s4, 16
	
	lb $s1, array+3
	
	sw $s1, mem
	lb $s1, array+2
	
	sh $s1, m2
	
	lb $s1, array+1
	
	sh $s1, m3
	lb $s1, array+3
	
	sb $s1, m4
	lb $s1, array
	
	sw $s1, m5
	

	andi $s2,$s1,0xf0
