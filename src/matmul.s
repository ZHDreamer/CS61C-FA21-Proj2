.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 59
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 59
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 59
# =======================================================
matmul:
    # Error checks
    li t0, 1
    blt a1, t0, exit
    blt a2, t0, exit
    blt a4, t0, exit
    blt a5, t0, exit
    bne a2, a4, exit

    # Prologue
    # todo
    addi sp, sp, -40
    sw s0,  0(sp)
    sw s1,  4(sp)
    sw s2,  8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    sw ra, 36(sp)

    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5
    mv s6, a6

    li s7, 0                # Outer loop counter

outer_loop_start:
    bge s7, s1, outer_loop_end

    li s8, 0                # Inner loop counter

inner_loop_start:
    bge s8, s5, inner_loop_end

    mul t0, s7, s2          # Start address of v0
    slli t0, t0, 2
    add a0, t0, s0

    slli t0, s8, 2          # Start address of v1
    add a1, t0, s3

    mv a2, s2               # Size of vector

    li a3, 1                # Stride of v0

    mv a4, s5               # Stride of v1

    jal dot                 # Call dot

    mul t1, s7, s5          # Store value to d
    add t0, t1, s8
    slli t0, t0, 2
    add t0, t0, s6
    sw a0, 0(t0)

    addi s8, s8, 1
    j inner_loop_start

inner_loop_end:
    addi s7, s7, 1
    j outer_loop_start

outer_loop_end:
    # Epilogue
    lw ra, 36(sp)
    lw s8, 32(sp)
    lw s7, 28(sp)
    lw s6, 24(sp)
    lw s5, 20(sp)
    lw s4, 16(sp)
    lw s3, 12(sp)
    lw s2,  8(sp)
    lw s1,  4(sp)
    lw s0,  0(sp)
    addi sp, sp, 40

    ret

exit:
    li a1, 59
    call exit2
