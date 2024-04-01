.data
out_text: .asciiz "p + q: "  # Text to print before the result
newline: .asciiz "\n"        # Newline character for formatting output

.text
# Entry point of the program
MAIN:   
    li $s0, 2                # Initialize $s0 (x) with 2
    li $s1, 4                # Initialize $s1 (y) with 4
    li $s2, 6                # Initialize $s2 (z) with 6
    
    # Prepare arguments for foo by moving them into argument registers
    move $a0, $s0            # Move x into $a0
    move $a1, $s1            # Move y into $a1
    move $a2, $s2            # Move z into $a2
    
    jal foo                  # link to foo and calculates foo(x, y, z)
    
    # Add results of foo to $s2 (z)
    add $s2, $s2, $s1
    add $s2, $s2, $s0
    add $s2, $s2, $v0        # $s2 = x + y + z + foo(x, y, z)
   
     # Print final result stored in $s2
    move $a0, $s2            # Move result into $a0 for printing
    li $v0, 1                # System call for print integer
    syscall
  
      # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit program
    li $v0, 10               # System call for exit
    syscall
    
# foo function: Performs arithmetic operations and calls bar
foo:    
    addi $sp, $sp, -8        # Allocate space on stack for $ra
    sw $ra, 0($sp)           # Save return address on stack
    
    # First call to bar with (m + o, n + o, m + n)
    add $t0, $a0, $a2
    add $t1, $a1, $a2
    add $t2, $a0, $a1
    jal bar
    move $t3, $v0            # Store result of first call in $t3
  
     # Second call to bar with (m - o, n - m, 2n)
    sub $t0, $a0, $a2
    sub $t1, $a1, $a0
    add $t2, $a1, $a1
    jal bar
    add $t3, $t3, $v0        # Add result of second call to $t3
  
      # Print "p + q: "
    li $v0, 4
    la $a0, out_text
    syscall
  
      # Print sum of bar calls
    move $a0, $t3
    li $v0, 1
    syscall
  
      # Print newline
    li $v0, 4
    la $a0, newline
    syscall
 
       # Prepare return value and restore $ra
    move $v0, $t3
    lw $ra, 0($sp)
    addi $sp, $sp, 8         # Deallocate space from stack
    jr $ra                   # Return to caller
    
# bar function: Performs (b - a) << c operation
bar:    
    addi $sp, $sp, -8        # Allocate space on stack for $ra
    sw $ra, 0($sp)           # Save return address on stack
    
    # Perform the operation and store in $v0
    sub $v0, $t1, $t0
    sllv $v0, $v0, $t2       # Shift left logical variable
   
     # Restore $ra and return
    lw $ra, 0($sp)
    addi $sp, $sp, 8         # Deallocate space from stack
    jr $ra                   # Return to caller
