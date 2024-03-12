.data
prompt: .asciiz "Please enter a number: "
evenMsg: .asciiz "\nSum of even numbers is: "
oddMsg: .asciiz "\nSum of odd numbers is: "

.text
.globl main

main:
    # Initialize sums to 0
    li $t0, 0 # even_sum
    li $t1, 0 # odd_sum

loop:
    # Prompt and read user input
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 5
    syscall
    move $t2, $v0 # Move input to $t2

    # Exit loop if input is 0
    beq $t2, $zero, printResults
    
    # Determine if the number is even or odd by using shifting
    # Shift right by 1 then shift back left by 1, if original number equals this result, it's even
    srl $t3, $t2, 1 # $t3 = $t2 >> 1 (essentially dividing by 2)
    sll $t3, $t3, 1 # Shift back left (undo division for even numbers)

    # Compare and add to the respective sum
    beq $t2, $t3, isEven
    add $t1, $t1, $t2 # Add to odd_sum
    j loop

isEven:
    add $t0, $t0, $t2 # Add to even_sum
    j loop

printResults:
    # Print sum of even numbers
    li $v0, 4
    la $a0, evenMsg
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

    # Print sum of odd numbers
    li $v0, 4
    la $a0, oddMsg
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    # Exit program
    li $v0, 10
    syscall
