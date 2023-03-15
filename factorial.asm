########################################################
# This program prints a factorial number – no frame pointer used
# The call to syscall has the following parameters:
#   $a0: thing to be printed
#   $v0: Mode
#       1=integer
#       4=null-terminated string
# Register Convention:
#       None
# Stack Convention:
#       0(SP) = Return Address
########################################################
        .data
prompt: .asciiz "Enter Value: "

        .align 2
         .text
        .globl main
main:



        addi    $sp,$sp,-4
        sw      $ra, 0($sp)
#                               #  print("Enter value");
        li      $v0,4
        la      $a0,prompt
        syscall
#                               #  count = read_int
        li      $v0,5
        syscall
#                               #  total = factorial(count);
        sw      $v0,-4($sp)
        jal      Fact#                               #  print_int(total);
        move    $a0,$v0
        li      $v0,1
        syscall
#                               #  return
        lw      $ra, 0($sp)
        addi    $sp,$sp,4       
         jr      $ra

############################################
# Factorial Function
# Calling Sequence:
#       -4(SP) = # Register Use:
#       $s0 = Count
# Returns:
#       $v0 = # Stack use:
#       8(SP) = 
#       4(SP) = 
#       0(SP) = ############################################
Fact:                         # int Factorial(int count)

	
        addi    $sp,$sp,-12
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        lw      $s0, 8($sp)#                               # {
#                               #       total = 1;
        li      $v0,1
           
               			#       if (count > 1)
        
 	li $s4, 1
 
 	 slt     $t0,$s0, $s4 
        
        bne     $t0,$zero,fac7
#                               #               total=count*Factorial(count-1)
        addi    $a0,$s0,-1
        sw      $a0,-4($sp)
        jal      Fact      
          mul     $v0,$s0,$v0
#                               #       endif
#                               #       return total
fac7:   lw  $ra, 0($sp)
        lw      $s0, 4($sp)
        addi  $sp,$sp,12
        jr       $ra#                               # }
