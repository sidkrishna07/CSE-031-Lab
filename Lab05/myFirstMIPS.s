

    .text
    .globl main

main:
    # $t0 = $s0
    move $t0, $s0
    
    # $t1 = $t0 - 7
    sub $t1, $t0, 7
    
    # $t2 = $t1 + $t0
    add $t2, $t1, $t0
    
    # $t3 = $t2 + 2
    addi $t3, $t2, 2
    
    # $t4 = $t3 + $t2
    add $t4, $t3, $t2
    
    # $t5 = $t4 - 28
    sub $t5, $t4, 28
    
    # $t6 = $t4 - $t5
    sub $t6, $t4, $t5
    
    # $t7 = $t6 + 12
    addi $t7, $t6, 12
    
    #End of program
    #Exit the program
    
    li $v0, 10 #syscall code 10 to exit the program
   
    syscall # execute syscall
