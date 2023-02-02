.text
DRAW_ENEMY_POKEMON_SPRITE:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar sprite
    la a0, P_INIMIGO
    li a1, 200
    li a2, 52
    jal DRAW_POKEMON

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_ENEMY_POKEMON_NAME:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar nome do pokémon
    la a0, P_INIMIGO
    li a1, 69
    li a2, 9
    li a3, 0x0000FF00
    jal DRAW_POKEMON_NAME

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_ENEMY_POKEMON_LEVEL:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar level do pokémon
    la a0, P_INIMIGO
    li a1, 82
    li a2, 33
    li a3, 0x0000FF00
    jal DRAW_POKEMON_LVL

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_ENEMY_POKEMON_LIFE:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Desenhar vida do pokémon
    la a0, P_INIMIGO
    li a1, 134
    li a2, 33
    li a3, 0x0000FF00
    jal DRAW_POKEMON_LIFE

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_ENEMY_POKEMON_LIFE_MAX:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Desenhar vida_máx
    la a0, P_INIMIGO
    li a1, 154
    li a2, 33
    li a3, 0x0000FF00
    jal DRAW_POKEMON_LIFE_MAX

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

DRAW_ENEMY_POKEMON_BATTLE_INFO:
    addi sp, sp, -4
    sw ra, 0(sp)

    jal DRAW_ENEMY_POKEMON_SPRITE
    
    jal PRINT_ENEMY_POKEMON_NAME
    
    jal PRINT_ENEMY_POKEMON_LEVEL
    
    jal PRINT_ENEMY_POKEMON_LIFE

    # Desenhar barra
    li a0, 134
    li a1, 33
    jal DRAW_BARRA

    jal PRINT_ENEMY_POKEMON_LIFE_MAX
    
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
