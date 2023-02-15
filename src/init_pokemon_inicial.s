.text
# INIT_POKEMON_INICIAL
#   - Carrega no endereço P_PLAYER o pokémon inicial escolhido lvl 5
#   - Parâmetros:
#       > a0 ---> Endereço do pokemon inicial
INIT_POKEMON_INICIAL:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    li a1, 5
    la a2, P_PLAYER
    jal CREATE_POKEMON
    
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
