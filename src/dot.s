.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 58
# =======================================================
dot:
    li t0, 1
    blt a2, t0, exit_57
    blt a3, t0, exit_58
    blt a4, t0, exit_58

    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)

loop_start:
    li t0, 0               # t0 is the result
    li t1, 0               # t1 is the loop counter

loop_continue:
    bge t1, a2, loop_end
    mul t2, t1, a3          # index of v0
    mul t3, t1, a4          # index of v1
    slli t2, t2, 2
    add t2, t2, a0          # address of v0
    slli t3, t3, 2
    add t3, t3, a1          # address of v1

    lw t2, 0(t2)            # load the value of v0
    lw t3, 0(t3)            # load the value of v1

    mul t2, t2, t3          # sum += v0[i] * v1[i]
    add t0, t0, t2

    addi t1, t1, 1
    j loop_continue

loop_end:
    mv a0, t0

    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4

    ret

exit_57:
    li a1, 57
    call exit2

exit_58:
    li a1, 58
    call exit2
