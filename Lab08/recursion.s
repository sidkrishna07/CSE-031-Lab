.data
prompt: .asciiz "Please enter an integer: "
return1: .asciiz "Returning 1\n"
return3: .asciiz "Returning 3\n"

.text
main:   
    addi $sp, $sp, -4    # Moving stack pointer to make room for storing local variables
    li $v0, 4            # TPS 2 #3 (display input prompt)
    la $a0, prompt
    syscall

    # TPS 2 #4 (read user input)
    li $v0, 5
    syscall
    move $a0, $v0
        
    jal recursion        # Call recursion(x)
    
    # TPS 2 #6 (print out returned value)
    move $a0, $v0
    li $v0, 1
    syscall
    
    j end                # Jump to end of program

recursion: 
    addi $sp, $sp, -12   # Push stack frame for local storage

    # TPS 2 #7 (Store return address)
    sw $ra, 0($sp)
    
    # TPS 2 #8 (Base case for m == -1)
    li $t1, -1
    beq $a0, $t1, return_one
    
    # TPS 2 #9 (Base case for m == 0)
    li $t1, 0
    beq $a0, $t1, return_three
        
    # Recursive calls and sum of their results
    sw $a0, 4($sp)       # TPS 2 #10 (Why we save $a0)
    addi $a0, $a0, -2    # TPS 2 #11 (Prepare new input argument)
    jal recursion
    sw $v0, 8($sp)       # TPS 2 #12 (Save returned value temporarily)
    
    lw $a0, 4($sp)
    addi $a0, $a0, -1    # TPS 2 #13 (Prepare next input argument)
    jal recursion
    
    lw $t1, 8($sp)       # TPS 2 #14 (Update returned value)
    add $v0, $v0, $t1
    
    j end_recur

return_one:
    li $v0, 4
    la $a0, return1
    syscall
    li $v0, 1
    j end_recur

return_three:
    li $v0, 4
    la $a0, return3
    syscall
    li $v0, 3
    j end_recur

end_recur: 
    # TPS 2 #15 (Retrieve return address)
    lw $ra, 0($sp)
    addi $sp, $sp, 12    # Pop stack frame
    jr $ra

end:    
    li $v0, 10           # Exit syscall
    syscall
