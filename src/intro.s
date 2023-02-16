.text
INTRODUCTION:
    addi sp, sp, -4
    sw ra, 0(sp)

    la a0, lamar
    li a1, 20
    li a2, 100
    mv a3, zero
    jal DRAW_IMAGE2

    la a0, START0
    mv a1, zero
    la a2, START1
    jal PRINT_TEXT_BOX

    la a0, START2
    mv a1, zero
    la a2, START3
    jal PRINT_TEXT_BOX

    la a0, START4
    mv a1, zero
    la a2, START5
    jal PRINT_TEXT_BOX

    la a0, START6
    mv a1, zero
    la a2, START7
    jal PRINT_TEXT_BOX

    la a0, START8
    mv a1, zero
    la a2, START9
    jal PRINT_TEXT_BOX

    la a0, START10
    mv a1, zero
    mv a2, zero
    jal PRINT_TEXT_BOX

    la a0, START12
    mv a1, zero
    la a2, START13
    jal PRINT_TEXT_BOX

    lw ra, 0(sp)
    addi sp, sp, 4
    ret