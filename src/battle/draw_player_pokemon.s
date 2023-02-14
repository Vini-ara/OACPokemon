.text
DRAW_PLAYER_POKEMON_SPRITE:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar sprite
    la a0, P_PLAYER
    li a1, 52
    li a2, 124
    jal DRAW_POKEMON

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_PLAYER_POKEMON_NAME:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar nome do pokémon
    la a0, P_PLAYER
    li a1, 200
    li a2, 142
    li a3, 0x0000FF00
    jal DRAW_POKEMON_NAME

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_PLAYER_POKEMON_LEVEL:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar level do pokémon
    la a0, P_PLAYER
    li a1, 213
    li a2, 165
    li a3, 0x0000FF00
    jal DRAW_POKEMON_LVL

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_PLAYER_POKEMON_LIFE:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Desenhar vida do pokémon
    la a0, P_PLAYER
    li a1, 265
    li a2, 165
    li a3, 0x0000FF00
    jal DRAW_POKEMON_LIFE

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

PRINT_PLAYER_POKEMON_LIFE_MAX:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Desenhar vida_máx
    la a0, P_PLAYER
    li a1, 285
    li a2, 165
    li a3, 0x0000FF00
    jal DRAW_POKEMON_LIFE_MAX

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

DRAW_PLAYER_POKEMON_BATTLE_INFO:
    addi sp, sp, -4
    sw ra, 0(sp)

    jal DRAW_PLAYER_POKEMON_SPRITE
    
    jal PRINT_PLAYER_POKEMON_NAME
    
    jal PRINT_PLAYER_POKEMON_LEVEL
    
    jal PRINT_PLAYER_POKEMON_LIFE

    # Desenhar barra
    li a0, 265
    li a1, 165
    jal DRAW_BARRA

    jal PRINT_PLAYER_POKEMON_LIFE_MAX
    
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

    
