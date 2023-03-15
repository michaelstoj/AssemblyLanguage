	.data
neg: .byte -1
pos: .byte 1
	.text
main:
	lbu $s3, pos
	lb $s2, pos
	lb $t1, neg
	lbu $t2, neg