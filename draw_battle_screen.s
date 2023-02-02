.text
# DRAW_BATTLE_SCREEN
#   - Desenha na tela de batalha
DRAW_BATTLE_SCREEN:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Desenhar o background
    mv a0, zero
    mv a1, zero
    jal COLOR_SCREEN

    # Desenhar a caixa de diálogo
    la a0, dialog_box_battle
    mv a1, zero
    li a2, 180
    mv a3, zero
    jal DRAW_IMAGE

   # Desenhar as opções
    la a0, options_battle
    li a1, 160
    li a2 180
    mv a3, zero
    jal DRAW_IMAGE

    # Desenhar o box de vida do pokemon do jogador
    la a0, battle_pokemon_stats
    li a1, 192
    li a2, 136
    mv a3, zero
    jal DRAW_IMAGE

    # Desenhar o box de vida do pokemon inimigo
    la a0, battle_pokemon_stats
    li a1, 60
    li a2, 4
    mv a3, zero
    jal DRAW_IMAGE

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

# DRAW_SETA:
#   - Desenha a seta dos menus em uma posição
#   - Parâmetros:
#       > a0 ---> Coordenada x
#       > a1 ---> Coordenada y
#       > a2 ---> Cor
DRAW_SETA:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv a3, a2
    mv a2, a1
    mv a1, a0
    la a0, seta
    jal PRINT_STRING_SAVE

    lw ra, 0(sp)
    addi sp, sp, 4
    ret
#

# PRINT_POKEMON_ATTACKS_NAMES
#   - Printa os nomes dos ataques do pokémon do jogador na tela
PRINT_POKEMON_ATTACKS_NAMES:
    # Store na pilha
    addi sp, sp, -32
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
    sw t5, 24(sp)
    sw t6, 28(sp)

    # Adquirindo lista de ataques do pokémon do jogador
    la t0, P_PLAYER
    lw t0, 8(t0)
    
    li t1, 0xFF000000
    mv t2, zero
    li t5, 25                   # Coordenada x
    li t6, 195                  # Coordenada y

    # Printar os ataques
    Loop_Print_Attacks:
        li t4, 24
        bgt t2, t4, End_Print_Pokemon_Attacks_Names
        srl t3, t1, t2    
        and t3, t3, t0
        beqz t3, Empty_Slot     # Se t3 = 0, o slot de ataque está vazio 
        sub t4, t4, t2
        addi t4, t4, 4
        srl a0, t3, t4
        jal DECODE_ATTACK
        jal GET_ATTACK_NAME
        j Print_Attack_Name
        
        Empty_Slot:
            la a0, traco
        
        Print_Attack_Name:
            mv a1, t5
            mv a2, t6
            li a3, 0x0000FF00
            jal PRINT_STRING_SAVE
            addi t2, t2, 8
            addi t5, t5, 100
            li t4, 200
            blt t5, t4, Loop_Print_Attacks
            li t5, 25
            addi t6, t6, 20
            j Loop_Print_Attacks
        

    End_Print_Pokemon_Attacks_Names:
    # Load na pilha
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
