.text
GYM_BATTLE:
    # Load na pilha
    addi sp, sp, -32
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
    sw t5, 24(sp)
    sw t6, 28(sp)

    # xori no s0
    xori s0, s0, 1
    
    # Printar a string GIN2 e GIN3
    la a0, GIN2
    mv a1, s0
    la a2, GIN3
    jal PRINT_TEXT_BOX

    # Printar a string GIN4 e GIN5
    la a0, GIN4
    mv a1, s0
    la a2, GIN5
    jal PRINT_TEXT_BOX

    # Printar a string GIN6
    la a0, GIN6
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX
    
    # Printar a string GIN8
    la a0, GIN8
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Transição para a batalha
    li a0, 0
    mv a1, a0
    jal COLOR_SCREEN

    li a0, 1000
    csrr a1, 3073
    jal SLEEP

    # Criar pokémon do líder
    la a0, P_SINUCA         
    li a1, 10
    la a2, P_INIMIGO
    jal CREATE_POKEMON

    # Desenhar tela de batalha
    jal DRAW_BATTLE_SCREEN
    
    # Desenhar pokémon do jogador
    jal DRAW_PLAYER_POKEMON_BATTLE_INFO

    # Desenhar pokémon inimigo  
    jal DRAW_ENEMY_POKEMON_BATTLE_INFO

    # Inicializar registradores
    la t0, P_PLAYER
    la t1, P_INIMIGO

    # Loop da batalha
    Loop_Gym_Battle:
        # Contar o número de turnos
        la t2, turnos
        lb t3, 0(t2)
        addi t3, t3, 1
        sb t3, 0(t2)

        # Adquirir a ação do jogador
        jal BATTLE_MENU
        mv t2, a0
        mv t3, a1

        li t4, 3
        beq t2, t4, Run_Bat2
        # Adquirir ação da IA
        la a0, turnos
        lb a0, 0(a0)
        jal GYM_POKEMON_DECISION
        mv t4, a0

        # Desenhar a caixa de diálogo
        la a0, dialog_box_battle
        mv a1, zero
        li a2, 180
        mv a3, s0
        mv a4, zero
        jal DRAW_IMAGE

        # Verificar se o jogador um item
        li t5, 1
        beq t2, t5, Player_Use_Item2

        # Se não usou item, o pokémon com maior velocidade começa atacando
        # Adquirir a velocidade do pokémon do jogador
        mv a0, t0
        li a1, 0x16
        jal GET_POKEMON_STAT
        mv t5, a0

        # Adquirir a velocidade do pokémon selvagem
        mv a0, t1
        li a1, 0x16
        jal GET_POKEMON_STAT
        mv t6, a0
        
        # Comparar as velocidade
        bgt t6, t5, Gym_Pokemon_First

        Player_First2:
            # Executar o ataque do pokémon do jogador
            mv a0, t3
            mv a1, t0
            mv a2, t1
            jal RUN_ATTACK

            # Desenhar a caixa de diálogo
            la a0, dialog_box_battle
            mv a1, zero
            li a2, 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE

            # Atualizar vida do pokémon selvagem
            ## Limpar vida antiga
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar a novo valor
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Verificar se o pokémon selvagem morreu
            mv a0, t1
            jal CHECK_LIFE
            bnez a0, Won_Battle_Gym

            # Executar o ataque do pokémon selvagem
            mv a0, t4
            mv a1, t1
            mv a2, t0
            jal RUN_ATTACK

            # Atualizar a vida do pokémon do jogador
            ## Limpar a vida antiga
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar o novo valor
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Verificar se o pokémon do jogador morreu
            mv a0, t0
            jal CHECK_LIFE
            bnez a0, Defeat_Battle_Gym

            # Voltar para o início do loop
            j Loop_Gym_Battle

        Gym_Pokemon_First:
             # Executar o ataque do pokémon selvagem
            mv a0, t4
            mv a1, t1
            mv a2, t0
            jal RUN_ATTACK

            # Desenhar a caixa de diálogo
            la a0, dialog_box_battle
            mv a1, zero
            li a2, 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE

            # Atualizar a vida do pokémon do jogador
            ## Limpar a vida antiga
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar o novo valor
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Verificar se o pokémon do jogador morreu
            mv a0, t0
            jal CHECK_LIFE
            bnez a0, Defeat_Battle_Gym

            # Executar o ataque do pokémon do jogador
            mv a0, t3
            mv a1, t0
            mv a2, t1
            jal RUN_ATTACK

            # Atualizar vida do pokémon selvagem
            ## Limpar vida antiga
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar a novo valor
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Verificar se o pokémon selvagem morreu
            mv a0, t1
            jal CHECK_LIFE
            bnez a0, Won_Battle_Gym

            # Voltar para o início do loop
            j Loop_Gym_Battle

        Player_Use_Item2:
            # Printar a string use_potion_dial
            la a0, use_potion_dial
            li a1, 25
            li a2, 195
            li a3, 0x000051FF
            mv a4, s0
            jal PRINT_STRING_SAVE
            
            # Usar a potion
            mv a0, t0   
            mv a1, t3
            jal USE_POTION
            
            # Esperar o jogador apertar a tecla z
            jal CONFIRM_DIALOG 
            
            # Atualizar a vida do pokémon do jogador
            ## Limpar a vida antiga
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar o novo valor
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Limpar a caixa de diálogo
            la a0, use_potion_dial
            li a1, 25
            li a2, 195
            li a3, 0x00005151
            mv a4, s0
            jal PRINT_STRING_SAVE

            # Esperar o jogador apertar a tecla z
            jal CONFIRM_DIALOG 

            # Executar o ataque do pokémon selvagem
            mv a0, t4
            mv a1, t1
            mv a2, t0
            jal RUN_ATTACK

            # Atualizar a vida do pokémon do jogador
            ## Limpar a vida antiga
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar o novo valor
            mv a0, t0
            li a1, 265
            li a2, 165
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Verificar se o pokémon do jogador morreu
            mv a0, t0
            jal CHECK_LIFE
            bnez a0, Defeat_Battle_Gym

            # Voltar para o início do loop
            j Battle_Wild_Pokemon_Loop

        Gym_Pokemon_Use_Item:
            # Printar a string fala5
            la a0, fala5
            li a1, 25
            li a2, 195
            li a3, 0x000051FF
            mv a4, s0
            jal PRINT_STRING_SAVE
            
            # Usar a potion
            mv a0, t1   
            la a1, I_POTION
            jal USE_POTION
            
            # Esperar o jogador apertar a tecla z
            jal CONFIRM_DIALOG 
            
            # Atualizar vida do pokémon selvagem
            ## Limpar vida antiga
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar a novo valor
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Limpar a caixa de diálogo
            la a0, fala5
            li a1, 25
            li a2, 195
            li a3, 0x00005151
            mv a4, s0
            jal PRINT_STRING_SAVE

            # Esperar o jogador apertar a tecla z
            jal CONFIRM_DIALOG 

            # Executar o ataque do pokémon do jogador
            mv a0, t3
            mv a1, t0
            mv a2, t1
            jal RUN_ATTACK

            # Desenhar a caixa de diálogo
            la a0, dialog_box_battle
            mv a1, zero
            li a2, 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE

            # Atualizar vida do pokémon selvagem
            ## Limpar vida antiga
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FFFF
            jal DRAW_POKEMON_LIFE_MAX

            ## Printar a novo valor
            mv a0, t1
            li a1, 134
            li a2, 33
            li a3, 0x0000FF00
            jal DRAW_POKEMON_LIFE

            # Verificar se o pokémon selvagem morreu
            mv a0, t1
            jal CHECK_LIFE
            bnez a0,  Won_Battle_Gym

            # Voltar para o início do loop
            j Battle_Wild_Pokemon_Loop

    Won_Battle_Gym:
        jal WILD_BATTLE_VICTORY
        jal GYM_BATTLE_VICTORY
        li a0, 1
        j End_Gym_Battle

    Defeat_Battle_Gym:
        # Desenhar a caixa de diálogo
        la a0, dialog_box_battle
        mv a1, zero
        li a2, 180
        mv a3, s0
        mv a4, zero
        jal DRAW_IMAGE 

        # Printar nome do pokémon do jogador
        la a0, P_PLAYER
        jal GET_POKEMON_NAME

        li a1, 16
        li a2, 200
        li a3, 0x000051FF
        mv a4, s0
        jal PRINT_STRING_SAVE

        # Printar a string dead
        la a0, dead
        li a1, 16
        li a2, 220
        li a3, 0x000051FF
        mv a4, s0
        jal PRINT_STRING_SAVE

        # Esperar o jogador apertar a tecla z
        jal CONFIRM_DIALOG
        
        jal GYM_BATTLE_DEFEAT
        jal BATTLE_DEFEAT
        mv a0, zero
        j End_Gym_Battle

    Run_Bat2:
        # Desenhar a caixa de diálogo
        la a0, dialog_box_battle
        mv a1, zero
        li a2, 180
        mv a3, s0
        jal DRAW_IMAGE

        # Printar a string str_run
        la a0, fuga
        li a1, 16
        li a2, 200
        li a3, 0x000051FF
        mv a4, s0
        jal PRINT_STRING_SAVE

        # Esperar o jogador apertar a tecla z
        jal CONFIRM_DIALOG  
        j Loop_Gym_Battle   
    
    End_Gym_Battle:
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
    
    # Retornar
    ret
#

# GYM_BATTLE_DECISION
#   - Argumentos:
#       > a0 ---> Turno
#   - Retorno:
#       > a0 ---> 'p' para usar poção ou o index do ataque (7 ou 8)
GYM_POKEMON_DECISION:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    
    la t0, pot_usada
    lb t0, 0 (t0)
    beqz t0, Escolher_Ataque

    la a0, P_INIMIGO
    li a1, 0x10
    jal GET_POKEMON_STAT
    mv t0, a0
    
    la a0, P_INIMIGO
    li a1, 0x12
    jal GET_POKEMON_STAT
    srli t1, a0, 1

    ble t0, t1, Use_Pot

    Escolher_Ataque:
        li t0, 1
        beq a0, t0, Aplicar_Prego
        li a0, 8 

        j End_Pokemon_Gym_Decision

    Aplicar_Prego:
    li a0, 7
    j End_Pokemon_Gym_Decision

    Use_Pot:
        li a0, 'p'
        la t0, pot_usada
        lb t1, 0(t0)
        addi t1, t1, 1
        sb t1, 0(t0)

    End_Pokemon_Gym_Decision:
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    ret
#

#
GYM_BATTLE_VICTORY:
    # Printar mapa
    mv a0,s1
	mv a1,s2
	jal ra, CARREGA_MAPA

  	jal PRINT_PLAYER

    # Printar string GIN10
    la a0, GIN10
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Printar string GIN12 e GIN13
    la a0, GIN12
    mv a1, s0
    la a2, GIN13
    jal PRINT_TEXT_BOX

    jal END_GAME
#

#
GYM_BATTLE_DEFEAT:
    # Store na pilha
    addi sp, sp -8
    sw ra, 0(sp)
    sw t0, 4(sp)
    
    # Printar mapa
    mv a0,s1
	mv a1,s2
	jal ra, CARREGA_MAPA

  	jal PRINT_PLAYER

    # Printar string GIN14 e GIN15
    la a0, GIN14
    mv a1, s0
    la a2, GIN15
    jal PRINT_TEXT_BOX

    # Printar string GIN16 e GIN17
    la a0, GIN16
    mv a1, s0
    la a2, GIN17
    jal PRINT_TEXT_BOX

    # Tirar o passe do jogador
    la t0, passe
    sb zero, 0(t0) 

    # Load no pilha
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8

    # Retornar
    ret