.section .text
.globl _start

_start:
    # Call the quicksort function
    la a0, array
    li a1, 0
    li a2, 9
    call quicksort

    # End of program
    li a7, 10
    ecall

quicksort:
    # Function to perform quicksort on an array
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 12(sp)

    # Partition function call
    call partition

    lw a0, 4(sp)
    lw a1, 8(sp)
    lw a2, 12(sp)

    # Recursive calls for left and right sub-arrays
    addi a2, a0, -1
    blt a1, a2, quicksort

    addi a1, a0, 1
    addi a0, a1, a1
    blt a0, a2, quicksort

    lw ra, 0(sp)
    addi sp, sp, 16
    ret

partition:
    # Function to partition the array
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    lw s0, 4(a0)  # pivot element
    mv s1, a1     # left index
    mv s2, a2     # right index

loop:
    blt s1, s2, endloop

left:
    lw t0, 4(s1)
    blt t0, s0, skip_left
    j right

skip_left:
    addi s1, s1, 1
    j loop

right:
    lw t1, 4(s2)
    bge t1, s0, skip_right

swap:
    lw t2, 4(s1)
    sw t1, 4(s1)
    sw t2, 4(s2)

skip_right:
    addi s2, s2, -1
    j loop

endloop:
    sw s0, 4(a0)   # place pivot element in correct position

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    
    addi sp, sp, 16
    ret

.data
array: .word 5, 3, 8, 4, 2, 7, 1, 6, 9
