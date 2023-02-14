.text
NPC_CURANDEIRA:
    addi sp, sp, -4
    sw ra, 0(sp)
  
    xori s0, s0, 1

    la a0, CURANDEIRA1
    mv a1, s0
    jal PRINT_TEXT_BOX

    la a0, P_PLAYER
    li a1, 0x12
    jal GET_POKEMON_STAT

    mv a2, a0
    la a0, P_PLAYER
    li a1, 0x10
    jal SET_POKEMON_STAT

    la a0, CURANDEIRA2
    mv a1, s0
    jal PRINT_TEXT_BOX

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

