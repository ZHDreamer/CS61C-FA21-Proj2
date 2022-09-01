.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)

    addi t0, x0, 1      # if a1 < 1, exit
    blt a1, t0, exit

loop_start:
    addi t0, x0, 0
    addi t1, x0, 4

loop_continue:
    bge t0, a1, loop_end  # if t0 >= size, end the loop
    mul t2, t0, t1        # calculate the address of element
    add t3, t2, a0
    lw  t4, 0(t3)         # load the element
    addi t0, t0, 1

    bge t4, x0, loop_continue

    sw x0, 0(t3)
    j loop_continue

loop_end:
    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4

    ret

exit:
    li a1, 57
    call exit2
