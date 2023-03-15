.data

Mike: .asciiz "Mike is the name\n"
Jake: .asciiz "i wish i was as cool as mike is\n"
myWord: .space 20

.text
main:



	la  $s5,Jake
	lw  $s1, Mike
	srl $s2,$s1,26
	sb $s2, 0($5)
	
	lw $s3,5($s1)
	

# this loads number into memory and does some calculations
li $v0, 4
li $v1, 2

add $a0, $v0, $v1

mult $v0,$v1
mflo $a1

div $v1, $v0
mfhi $a2

# the below prints out one line for mike and one for jake
la $a0,Mike
li $v0, 4
syscall

la $t0, Jake
move $a0, $t0

li $v0, 4
syscall

# gets a word and prints it out
la $a0, myWord
li $a1, 14 #num is the size of characters
li $v0, 8
syscall
li $v0, 4
syscall

li $v0, 10
syscall
