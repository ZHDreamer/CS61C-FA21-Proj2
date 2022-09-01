.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the vector
#   a1 (int)  is the # of elements in the vector
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# =================================================================
argmax:
    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)

    li  t0, 1             # if a1 < 1, exit
    blt a1, t0, exit


loop_start:
    li t0, 0              # load the largest index to t0
    lw t1, 0(a0)          # load the largest element to t1

    li t2, 0              # loop counter
    li t3, 4              # 4 bytes per int element

loop_continue:
    addi t2, t2, 1

    bge t2, a1, loop_end  # if t0 >= size, end the loop
    mul t4, t2, t3        # calculate the address of element
    add t4, t4, a0
    lw  t5, 0(t4)         # load the element

    ble t5, t1, loop_continue

    mv t0, t2
    mv t1, t5

    j loop_continue

loop_end:
    mv a0, t0
    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4

    ret

exit:
    li a1, 57
    call exit2
