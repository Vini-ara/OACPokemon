.text
# INIT_POKEMON_INICIAL
#   - Carrega no endereço P_PLAYER o pokémon inicial squirtle lvl 5
INIT_POKEMON_INICIAL:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    la a0, P_SINUCA
    li a1, 5
    la a2, P_PLAYER
    jal CREATE_POKEMON
    
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
