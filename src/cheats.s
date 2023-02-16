.text
CHEAT_ADD_MONEY:
    # Store na pilha
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    
    # Lotar a carteira
    la t0, creditos
    li t1, 255
    sb t1, 0(t0)
    
    # Load na pilha
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 8

    # Retornar
    ret

CHEAT_LEVEL_UP:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Level up
    jal LEVEL_UP

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret 
