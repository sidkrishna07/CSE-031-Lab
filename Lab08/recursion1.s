.data
prompt: .asciiz "Please enter a number: "
result: .asciiz "\n"

.text
.globl main

# Main Function
main:
    # Display prompt and read an integer from the user
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 5
    syscall
    
    move $a0, $v0
    
    jal recursion
    
    move $a1, $v0
    
    # Print the result of the recursion function
    li $v0, 1
    move $a0, $a1
    syscall
    
    # Print a newline character
    li $v0, 4
    la $a0, result
    syscall

    # Exit program
    li $v0, 10
    syscall

# Recursion Function
recursion:
    # Base cases: m == -1 or m <= -2
    li $t0, -1
    beq $a0, $t0, base_case_1
    
    li $t1, -2
    ble $a0, $t1, base_case_2

    # Recursive case: Perform the recursion with m-3 and m-2, then add results and m
    addi $sp, $sp, -12
    
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    sw $t2, 0($sp)
    
    addi $a0, $a0, -3
    
    jal recursion
    
    move $t2, $v0
    lw $a0, 4($sp)
    addi $a0, $a0, -2
    
    jal recursion
    
    add $v0, $v0, $t2
    lw $t2, 0($sp)
    lw $a0, 4($sp)
    
    add $v0, $v0, $a0
    lw $ra, 8($sp)
    
    addi $sp, $sp, 12
    jr $ra

base_case_1:
    li $v0, 3
    jr $ra

base_case_2:
    blt $a0, $t1, less_than_neg2
    li $v0, 1
    jr $ra

less_than_neg2:
    li $v0, 2
    jr $ra
