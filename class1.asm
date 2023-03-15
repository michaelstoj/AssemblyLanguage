.data
numbr:  .word 24
numad1: .word 0
.text   
.globl main   
main:
lw $a0,numbr # numad1 = increment(number)
jal incr
sw $v0,numad1
li   $v0, 10        # exit
syscall                       
######################################
# Increment(): Increments a number and returns it
# Calling sequence:  
#    lw   $a0,number   
# jal incr
#
# Returns: $v0: incremented number
#
# Stack Usage:
# 0($sp) = return address
######################################
incr: # $v0 = increment($a0=number)
addi $sp,$sp,-4 # stack.push(4)
sw $ra,0($sp) # stack[0] = return address
addi $v0,$a0,1 # return_value = number++
lw $ra,0($sp)
addi $sp,$sp,4 # stack.pop(4)
jr $ra # return