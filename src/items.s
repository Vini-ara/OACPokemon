.data
# ITENS DO JOGO
## POÇÃO --> CURA 10 PONTOS DE VIDA DE UM POKÉMON
I_POTION: .byte 0x0A

n_potion: .string "Marmita"
.text
# USE_POTION
#   - Usa uma poção
#   - Parâmetros:
#       > a0 --> Endereço do pokémon
#       > a1 --> Endereço da poção
USE_POTION:
    # Store na pilha
    addi sp, sp, -16
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)

    # Inicializar registradores temporários
    mv t0, a0
    mv t1, a1
    
    # Adquirir a vida atual do pokémon
    li a1, 0x10
    jal GET_POKEMON_STAT
    mv t2, a0

    # Adquirir a quantidade que a poção cura
    lb t1, 0(t1)
    
    # Somar a vida com a cura da poção
    add t2, t1, t2

    # Verificar se o novo valor da vida é maior que a vida máxima
    mv a0, t0
    li a1, 0x12
    jal GET_POKEMON_STAT

    bgt t2, a0, Set_To_MaxLife
    j End_Use_Potion
    
    Set_To_MaxLife:
        mv t2, a0

    End_Use_Potion:
    # Setar nova vida
    mv a0, t0
    li a1, 0x10
    mv a2, t2
    jal SET_POKEMON_STAT

    # Dimunuir em 1 a quantidade na bag
    la t0, player_bag
    lw t1, 4(t0)
    addi t1, t1, -1
    sw t1, 4(t0)

    # Load na pilha
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16
    # Retornar
    ret


BUY_ITEM:
