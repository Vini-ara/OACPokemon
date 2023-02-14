.text
# DRAW_POKEMON:
#   - Desenha a sprite de um pokémon em um posição da tela
#   - Parâmetros:
#       > a0 ---> endereço do pokémon
#       > a1 ---> posição x da sprite do pokémon
#       > a2 ---> posição y da sprite do pokémon
DRAW_POKEMON:
    addi sp, sp -24
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv t2, a2

    # Adquirir o endereço da sprite
    jal GET_POKEMON_SPRITE
    
    # Desenhar a sprite
    mv a1, t1
    mv a2, t2
    mv a3, s0             # a3 = 0
    jal DRAW_IMAGE2

    lw t4, 20(sp)
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 24
    ret
#

# DRAW_POKEMON_NAME:
#   - Desenha o nome de um pokémon em um posição da tela
#   - Parâmetros:
#       > a0 ---> endereço do pokémon
#       > a1 ---> posição x do nome do pokémon
#       > a2 ---> posição y do nome do pokémon
#       > a3 ---> Cor
DRAW_POKEMON_NAME:
    # Store na pilha
    addi sp, sp -16
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv t2, a2

    # Adquirir nome do pokémon
    jal GET_POKEMON_NAME

    # Printar o nome do pokémon
    mv a1, t1
    mv a2, t2
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Load na pilha
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16

    # Retornar
    ret
#

# DRAW_PLAYER_LVL:
#   - Desenha o level de um pokémon em um posição da tela
#   - Parâmetros:
#       > a0 ---> endereço do pokémon
#       > a1 ---> posição x do nome do pokémon
#       > a2 ---> posição y do nome do pokémon
#       > a3 ---> Cor
DRAW_POKEMON_LVL:
    addi sp, sp -16
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv t2, a2

    # Adquirir lvl
    li a1, 0x02
    jal GET_POKEMON_STAT

    # Printar lvl
    mv a1, t1
    mv a2, t2
    mv a4, s0
    jal PRINT_INT_SAVE

    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16
    ret
#

# DRAW_PLAYER_LIFE:
#   - Desenha a vida e a vida_máx de um pokémon em uma posição da tela
#   - Parâmetros:
#       > a0 ---> endereço do pokémon
#       > a1 ---> posição x da vida do pokémon
#       > a2 ---> posição y da vida do pokémon
#       > a3 ---> Cor
DRAW_POKEMON_LIFE:
    addi sp, sp -32
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
    sw t5, 24(sp)
    sw t6, 28(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv t2, a2

    # Acessando a vida
    li a1, 0x10
    jal GET_POKEMON_STAT 
    
    # Printar vida
    mv a1, t1
    mv a2, t2
    mv a4, s0
    jal PRINT_INT_SAVE

    lw t6, 28(sp)
    lw t5, 24(sp)
    lw t4, 20(sp)
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 32
    ret
#

# DRAW_BARRA:
#   - Desenha a barra que fica entre a vida atual e a vida_máx
#   - Parâmetros:
#       > a0 ---> posição x da vida atual
#       > a1 ---> posição y da vida atual
DRAW_BARRA:
    addi sp, sp -4
    sw ra, 0(sp)

    # Printar a barra
    mv a2, a1
    mv a1, a0
    la a0, barra
    addi a1, a1, 15
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

# DRAW_PLAYER_LIFE_MAX:
#   - Desenha a vida_máx de um pokémon em uma posição da tela em relação a vida atual
#   - Parâmetros:
#       > a0 ---> endereço do pokémon
#       > a1 ---> posição x da vida do pokémon
#       > a2 ---> posição y da vida do pokémon
#       > a3 ---> Cor
DRAW_POKEMON_LIFE_MAX:
    addi sp, sp -32
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
    sw t5, 24(sp)
    sw t6, 28(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv t2, a2

    # Acessando a vida_máx
    li a1, 0x12
    jal GET_POKEMON_STAT 

    # Printar a vida_máx do pokémon
    mv a1, t1
    mv a2, t2
    mv a4, s0
    jal PRINT_INT_SAVE

    lw t6, 28(sp)
    lw t5, 24(sp)
    lw t4, 20(sp)
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 32
    ret
