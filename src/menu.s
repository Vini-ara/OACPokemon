.text 
MENU:
    addi sp, sp, -4
    sw ra, 0(sp)


    xori s0, s0, 1

    mv a0, s0
    jal PRINT_MENU_BOX

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

#  a0 > frame
PRINT_MENU_BOX: 
    addi sp, sp, -8
    sw ra, 0(sp)
    sw t0, 4(sp)

    mv t0, a0

    la a0, pause1
    li a1, 28
    li a2 40
    mv a3, t0
    li a4, 0
    jal DRAW_IMAGE



    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    ret


