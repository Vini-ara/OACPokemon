.text 
MENU:
    addi sp, sp, -4
    sw ra, 0(sp)

    xori s0, s0, 1

    mv a0, s0
    jal PRINT_MENU_BOX

    la a0, P_PLAYER
    jal GET_POKEMON_NAME

    li a1, 120
    li a2, 65
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, menu_lvl
    li a1, 72
    li a2, 90
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, P_PLAYER
    li a1, 0x02
    jal GET_POKEMON_STAT 

    li a1, 116
    li a2, 90
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_INT_SAVE

    la a0, menu_exp
    li a1, 72
    li a2, 120
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, P_PLAYER
    li a1, 0x04
    jal GET_POKEMON_STAT 

    li a1, 116
    li a2, 120
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_INT_SAVE

    la a0, menu_dinheiro
    li a1, 72
    li a2, 150
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, creditos
    lbu a0, 0(a0)
    li a1, 200
    li a2, 150
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_INT_SAVE

    la a0, menu_cura
    li a1, 180
    li a2, 90
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, player_bag
    lw a0, 4(a0)
    li a1, 240
    li a2, 90
   li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_INT_SAVE 

    la a0, menu_passe
    li a1, 180
    li a2, 120
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, passe 
    lb a0, 0(a0)
    li a1, 240
    li a2, 120
    li a3, 0x0000A3FF
    mv a4, s0
    jal PRINT_INT_SAVE 

    
    jal CONFIRM_DIALOG

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

#  a0 > frame
PRINT_MENU_BOX: 
    addi sp, sp, -32
    sw ra, 28(sp)
    sw t6, 24(sp)
    sw t5, 20(sp)
    sw t4, 16(sp)
    sw t3, 12(sp)
    sw t2, 8(sp)
    sw t1, 4(sp)
    sw t0, 0(sp)

    mv t0, a0

    la a0, pause1
    li a1, 48
    li a2, 40
    mv a3, t0
    li a4, 0
    jal DRAW_IMAGE

    la a0, pause4
    li a1, 64
    li a2, 40
    mv a3, t0
    li a4, 5
    jal PRINT_SEQUENCE

    la a0, pause7
    li a1, 144
    li a2, 40
    mv a3, t0
    li a4, 0
    jal DRAW_IMAGE

    la a0, pause8
    li a1, 160
    li a2, 40
    mv a3, t0
    li a4, 0
    jal DRAW_IMAGE

    la a0, pause4
    li a1, 176
    li a2, 40
    mv a3, t0
    li a4, 5
    jal PRINT_SEQUENCE

    la a0, pause1
    li a1, 256
    li a2, 40
    mv a3, t0
    li a4, 1
    jal DRAW_IMAGE


    li t1, 0
    li t2, 7

    PRINT_MENU_BOX.MIOLO:
        li t3, 56
        li t4, 16
        mul t4, t4, t1
        add t4, t3, t4

        
        la a0, pause3
        li a1, 48
        mv a2, t4
        mv a3, t0
        li a4, 0
        jal DRAW_IMAGE

        la a0, pause6
        li a1, 64
        mv a2, t4
        mv a3, t0
        li a4, 12
        jal PRINT_SEQUENCE

        la a0, pause3
        li a1, 256
        mv a2, t4
        mv a3, t0
        li a4, 1
        jal DRAW_IMAGE

        addi t1, t1, 1
        blt t1, t2, PRINT_MENU_BOX.MIOLO

    li t3, 56
    li t4, 16
    mul t4, t4, t1
    add t4, t3, t4

    la a0, pause2
    li a1, 48
    mv a2, t4
    mv a3, t0
    li a4, 0
    jal DRAW_IMAGE
    
    la a0, pause5
    li a1, 64
    mv a2, t4
    mv a3, t0
    li a4, 12
    jal PRINT_SEQUENCE

    la a0, pause2
    li a1, 256
    mv a2, t4
    mv a3, t0
    li a4, 1
    jal DRAW_IMAGE

    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    lw t6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    ret

# printa um sprite repetidas vezes em sequencia
# > a0 = endereço do sprite
# > a1 = posição na tela
# > a2 = posição na tela
# > a3 = frame
# > a4 = vezes em que vai repetir
PRINT_SEQUENCE:
   addi sp, sp, -32
  sw ra, 28(sp)
  sw t6, 24(sp)
  sw t5, 20(sp)
  sw t4, 16(sp)
  sw t3, 12(sp)
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw t0, 0(sp)

    mv t0, a0

    mv t1, a1
    mv t2, a2 

    li t3, 0
    mv t4, a4

    mv t5, a3

    PRINT_SEQUENCE.LOOP:
        lw t6, 0(t0)
        mul t6, t6, t3 
        add t6, t6, t1

        mv a0, t0
        mv a1, t6
        mv a2, t2
        mv a3, t5 
        li a4, 0
        jal DRAW_IMAGE

        addi t3, t3, 1
        blt t3, t4, PRINT_SEQUENCE.LOOP

    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    lw t6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    ret
