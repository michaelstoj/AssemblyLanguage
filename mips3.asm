	.data
Array: .byte 1,2,3,4
	.word 5
	
	.text
main:
 la          $s0,Array
 
 	add $s0, $s0, 4

           lb          $s1,Array

           lb          $s2,1($s0)

           lw          $s3,Array+4

           sw          $s1,Array+4

           li          $s4,16
