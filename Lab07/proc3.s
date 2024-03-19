.data
output_msg: .asciiz "p + q: "
final_output_msg: .asciiz "Final z value: "
newline: .asciiz "\n"

    .text
    .globl main

# Main function starts here
main:
    # Prepare arguments for foo
    li $a0, 2              # m = 2
    li $a1, 4              # n = 4
    li $a2, 6              # o = 6

    # Call foo
    jal foo                # foo(2, 4, 6)

    # Calculate final value of z and store in $s0
    add $s0, $v0, $a0      # z = return value from foo + x
    add $s0, $s0, $a1      # z += y
    add $s0, $s0, $a2      # z += z

    # Print final z value
    li $v0, 4              # syscall for print string
    la $a0, final_output_msg
    syscall
    move $a0, $s0          # Load final z value into $a0 for printing
    li $v0, 1              # syscall for print int
    syscall
    li $v0, 4              # syscall for print string
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10             # syscall for exit
    syscall

# Function foo starts here
foo:
    # Save return address
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # First call to bar
    add $t0, $a0, $a2      # Prepare first argument for bar
    add $t1, $a1, $a2      # Prepare second argument for bar
    add $t2, $a0, $a1      # Prepare third argument for bar
    jal bar
    move $s0, $v0          # Store result of first bar call in $s0 (p)

    # Second call to bar
    sub $a0, $a0, $a2      # Prepare first argument for bar
    sub $a1, $a1, $a0      # Prepare second argument for bar
    add $a2, $a1, $a1      # Prepare third argument for bar
    jal bar
    move $s1, $v0          # Store result of second bar call in $s1 (q)

    # Calculate p + q
    add $v0, $s0, $s1      # p + q

    # Print "p + q: " followed by the result
    li $v0, 4              # syscall for print string
    la $a0, output_msg
    syscall
    move $a0, $v0          # Move sum (p + q) to $a0 for printing
    li $v0, 1              # syscall for print int
    syscall
    li $v0, 4              # syscall for print string
    la $a0, newline
    syscall

    # Restore return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# Function bar starts here
bar:
    sub $v0, $a1, $a0      # b - a
    sllv $v0, $v0, $a2     # (b - a) << c
    jr $ra                 # Return to caller
