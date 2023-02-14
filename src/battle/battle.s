.textbase
# BATTLE
#   - Promove uma batalha entre 2 pokémons (o pokémon armazenado em P_INIMIGO e o armazenado em P_PLAYER)

BATTLE:

#

# BATTLE_WILD_POKEMON
#   - Promove uma batalha entre o jogador e um pokemon selvagem
#   - Parâmetros:
#       > a0 ---> pokemon base
#       > a1 ---> lvl do pokemon selvagem
#   - Retorno:
#       > a0 ---> 0 se derrota, 1 se vitória
BATTLE_WILD_POKEMON:
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
    
    # Criar pokémon selvagem
    la a2, P_INIMIGO
    jal CREATE_POKEMON

    # la a0, P_INIMIGO
	# li a1, 0x16
	# li a2, 20
	# jal SET_POKEMON_STAT

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
    Battle_Wild_Pokemon_Loop:
        # Adquirir a ação do jogador
        jal BATTLE_MENU
        mv t2, a0
        mv t3, a1

        li t4, 3
        beq t2, t4, Run_Bat
        # Adquirir ação da IA
        jal WILD_POKEMON_DECISION
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
        beq t2, t5, Player_Use_Item

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
        bgt t6, t5, Wild_Pokemon_First

        Player_First:
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
            bnez a0, Player_Won

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
            bnez a0, Wild_Pokemon_Won

            # Voltar para o início do loop
            j Battle_Wild_Pokemon_Loop

        Wild_Pokemon_First:
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
            bnez a0, Wild_Pokemon_Won

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
            bnez a0, Player_Won

            # Voltar para o início do loop
            j Battle_Wild_Pokemon_Loop

        Player_Use_Item:
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
            bnez a0, Wild_Pokemon_Won

            # Voltar para o início do loop
            j Battle_Wild_Pokemon_Loop

    Player_Won:
        jal WILD_BATTLE_VICTORY
        li a0, 1
        j End_Battle_Wild_Pokemon

    Wild_Pokemon_Won:
        jal BATTLE_DEFEAT
        mv a0, zero
        j End_Battle_Wild_Pokemon

    Run_Bat:
        jal RUN_BATTLE
        li a0, 1
    
    End_Battle_Wild_Pokemon:
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

# BATTLE_MENU
#   - Permite o jogador escolher sua ação no turno
#   - Retorno:
#       > a0 ---> Menu selecionado
#       > a1 ---> Ataque/Item escolhido
BATTLE_MENU:
    # Store na pilha
    addi sp, sp, -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)

    # Desenhar a caixa de diálogo
    la a0, dialog_box_battle
    mv a1, zero
    li a2, 180
    mv a3, s0
    mv a4, zero
    jal DRAW_IMAGE
    
    # Desenhar as opções
    la a0, options_battle
    li a1, 160
    li a2 180
    mv a3, s0
    mv a4, zero
    jal DRAW_IMAGE
    
    # Inicializar registradores
    mv t0, zero
    li t1, 170
    li t2, 197
    mv t3, zero

    # Desenhar seta
    mv a0, t1
    mv a1, t2
    li a2, 0x0000FF0F
    jal DRAW_SETA

    Battle_Menu_Loop:
        # Pegar input
        jal KEY2

        li t0, 'w'
        beq a0, t0, Move_Seta_Up

        li t0, 's'
        beq a0, t0, Move_Seta_Down
        
        li t0, 'a'
        beq a0, t0, Move_Seta_Left
        
        li t0, 'd'
        beq a0, t0, Move_Seta_Right

        li t0, 'z'
        beq a0, t0, Change_Menu 
        
        j Battle_Menu_Loop
        
        Move_Seta_Up:
            li t0, 197
            beq t2, t0, Battle_Menu_Loop
            
            # Limpar a seta da tela
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA
            
            # Mudar a posição da seta
            addi t2, t2, -21

            # Desenhar a seta no novo lugar
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, -2
            j Battle_Menu_Loop

        Move_Seta_Down:
            li t0, 218
            beq t2, t0, Battle_Menu_Loop
            
            # Limpar a seta da tela
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA
            
            # Mudar a posição da seta
            addi t2, t2, 21

            # Desenhar a seta no novo lugar
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, 2
            j Battle_Menu_Loop
        
        Move_Seta_Right:
            li t0, 247
            beq t1, t0, Battle_Menu_Loop

            # Limpar a seta da tela
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA
            
            # Mudar a posição da seta
            addi t1, t1, 77

            # Desenhar a seta no novo lugar
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, 1
            j Battle_Menu_Loop

        Move_Seta_Left:
            li t0, 170
            beq t1, t0, Battle_Menu_Loop

            # Limpar a seta da tela
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA
            
            # Mudar a posição da seta
            addi t1, t1, -77

            # Desenhar a seta no novo lugar
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, -1
            j Battle_Menu_Loop

        Change_Menu: 
            # Verificar se o player escolheu o menu de ataques
            beqz t3, Go_Pokemon_Attacks_Menu
            # Verificar se o player escolheu o menu de items
            li t0, 1
            beq t3, t0, Go_Items_Menu

            # Verificar se o player escolheu run
            li t0, 3
            beq t3, t0, End_Battle_Menu

            j Battle_Menu_Loop

        Go_Pokemon_Attacks_Menu:
            jal POKEMON_ATTACKS_MENU
            # Verificar se o player escolheu um ataque
            bnez a0, End_Battle_Menu
            # Desenhar a caixa de diálogo
            la a0, dialog_box_battle
            mv a1, zero
            li a2, 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE
            
            # Desenhar as opções
            la a0, options_battle
            li a1, 160
            li a2 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE

            # Desenhar a seta no lugar
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA

            j Battle_Menu_Loop

        Go_Items_Menu:
            jal ITEMS_MENU
            # Verificar se o player escolheu um item
            bnez a0, End_Battle_Menu
            # Desenhar a caixa de diálogo
            la a0, dialog_box_battle
            mv a1, zero
            li a2, 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE
            
            # Desenhar as opções
            la a0, options_battle
            li a1, 160
            li a2 180
            mv a3, s0
            mv a4, zero
            jal DRAW_IMAGE

            # Desenhar a seta no lugar
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA

            j Battle_Menu_Loop

    End_Battle_Menu:
    mv a0, t3               # a0 = t3
    # Load na pilha
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 20

    # Retornar
    ret
#

# POKEMON_ATTACKS_MENU
#   - Permite o jogador escoher um dos ataques do pokémon para atacar
#   - Retorno:
#       > a0 ---> 0 se o jogador não escolheu nenhum ataque, 1 se o jogador escolheu um ataque
#       > a1 ---> o ataque escolhido pelo jogador (0 caso não tenha escolhido)
POKEMON_ATTACKS_MENU: 
    addi sp, sp -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)

    # Desenhar background
    la a0, pokemon_attacks_menu_bg
    mv a1, zero
    li a2, 180
    mv a3, s0
    mv a4, zero
    jal DRAW_IMAGE
    
    # Printa o nome dos ataques
    jal PRINT_POKEMON_ATTACKS_NAMES
    
    # Inicializando registradores
    li t1, 17                   # Coordadena x da seta
    li t2, 195                  # Coordenada y da seta
    li t3, 28

    # Printa a seta
    mv a0, t1
    mv a1, t2
    li a2, 0x0000FF0F
    jal DRAW_SETA

    Pokemon_Attacks_Menu_Loop:
        # Pegar input
        jal KEY2

        # Administrar input
        li t0, 'w'
        beq a0, t0, Move_Seta_Up2

        li t0, 's'
        beq a0, t0, Move_Seta_Down2
        
        li t0, 'a'
        beq a0, t0, Move_Seta_Left2
        
        li t0, 'd'
        beq a0, t0, Move_Seta_Right2

        li t0, 'z'
        beq a0, t0, Check_Attack 
        
        li t0, 'x'
        beq a0, t0, Back_Battle_Menu

        j Pokemon_Attacks_Menu_Loop

        Move_Seta_Up2:
            li t0, 195
            beq t2, t0, Pokemon_Attacks_Menu_Loop
            # Limpar a seta
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA
            
            # Atualizar posição da seta
            addi t2, t2, -20

            # Desenhar seta na nova posição
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, 16
            j Pokemon_Attacks_Menu_Loop

        Move_Seta_Down2:
            li t0, 220
            beq t2, t0, Pokemon_Attacks_Menu_Loop
            # Limpar a seta
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA

            # Atualizar posição da seta
            addi t2, t2, 20
            
            # Desenhar a seta na nova posição
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, -16
            j Pokemon_Attacks_Menu_Loop

        Move_Seta_Left2:
            li t0, 17
            beq t1, t0, Pokemon_Attacks_Menu_Loop
            
            # Limpar a seta
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA

            # Atualizar posição da seta
            addi t1, t1, -100
            
            # Desenhar a seta na nova posição
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, 8
            j Pokemon_Attacks_Menu_Loop

        Move_Seta_Right2:
            li t0, 117
            beq t1, t0, Pokemon_Attacks_Menu_Loop

            # Limpar a seta
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FFFF
            jal DRAW_SETA
            
            # Atualizar posição da seta
            addi t1, t1, 100

            # Desenhar seta na nova posição
            mv a0, t1
            mv a1, t2
            li a2, 0x0000FF0F
            jal DRAW_SETA
            addi t3, t3, -8
            j Pokemon_Attacks_Menu_Loop

        Check_Attack:
            la t0, P_PLAYER
            lw t0, 8(t0)                        # Load na word de ataques do pokémon do jogador
            srl t0, t0, t3                      # t0 = t0 shifitado t3 bits para a direita (extrair o index do ataque selecionado)
            andi t0, t0, 0xF 
            beqz t0, Pokemon_Attacks_Menu_Loop  # Se t0 = 0, o slot de ataque está vazio
            mv a1, t0
            li a0, 1
            j End_Pokemon_Attacks_Menu

        Back_Battle_Menu:
            mv a0, zero
            mv a1, zero


    End_Pokemon_Attacks_Menu:
    # Load na pilha
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 20
    ret
#

# WILD_BATTLE_VICTORY
#   - Administra a vitória de uma batalha com um pokémon selvagem:
#       1) printa o texto na caixa de diálogo;
#       2) soma a xp adquirida na batalha;
#       3) verifica o level up do pokémon;
#       4) apaga o pokémon do endereço P_INIMIGO
WILD_BATTLE_VICTORY:
    # Store na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    
    # Desenhar a caixa de diálogo
    la a0, dialog_box_battle
    mv a1, zero
    li a2, 180
    mv a3, s0
    mv a4, zero
    jal DRAW_IMAGE

    # Printar diálogos
    ## Pokémon inimigo morreu 
    la a0, dead_battle
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    ## Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG

    ## Limpar texto
    la a0, dead_battle
    li a1, 16
    li a2, 200
    li a3, 0x00005151
    mv a4, s0
    jal PRINT_STRING_SAVE

    ## Printar a string xp_pokémon1
    la a0, xp_battle1
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    ## Printar a quantidade de xp adquirida
    la a0, P_INIMIGO
    li a1, 0x02
    jal GET_POKEMON_STAT
    li a1, 200
    li a2, 200
    li a3, 0x000051FF
    mv a4, zero
    jal PRINT_INT_SAVE
    
    ## Printar a string xp_pokemon2
    la a0, xp_battle2
    li a1, 16
    li a2, 220
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Somar xp adquirida
    ## Adquirir xp do pokemon do player
    la a0, P_PLAYER
    li a1, 0x04
    jal GET_POKEMON_STAT
    mv t0, a0

    ## Adquirir xp do pokemon selvagem
    la a0, P_INIMIGO
    li a1, 0x02             # level = xp adquirida de uma batalha com pokemon selvagem
    jal GET_POKEMON_STAT

    ## Somar e setar xp
    add a2, t0, a0
    la a0, P_PLAYER
    li a1, 0x04
    jal SET_POKEMON_STAT

    ## Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG  
    
    # Verificar level up e fazer o level up caso necessário
    jal CHECK_LEVEL_UP
    beqz a0, End_Wild_Battle_Victory
    jal LEVEL_UP

    ## Limpar o texto
    la a0, xp_battle1
    li a1, 10
    li a2, 200
    li a3, 0x00005151
    mv a4, s0
    jal PRINT_STRING_SAVE
    
    li a0, 10
    li a1, 200
    li a2, 200
    li a3, 0x00005151
    mv a4, zero
    jal PRINT_INT_SAVE

    la a0, xp_battle2
    li a1, 16
    li a2, 220
    li a3, 0x00005151
    mv a4, s0
    jal PRINT_STRING_SAVE

    ## Printar a string lvl_up_battle
    la a0, lvl_up_battle
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    la a0, P_PLAYER
    li a1, 0x02
    jal GET_POKEMON_STAT
    li a1, 298
    li a2, 200
    li a3, 0x000051FF
    mv a4, zero
    jal PRINT_INT_SAVE

    ## Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG 

    ## Atualizar o level e a vida na tela
    jal PRINT_PLAYER_POKEMON_LIFE
    jal PRINT_PLAYER_POKEMON_LIFE_MAX
    jal PRINT_PLAYER_POKEMON_LEVEL

    ## Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG 

    # Aumentar o número de créditos
    la t0, creditos
    lb t1, 0(t0)
    addi t1, t1, 10
    sb t1, 0(t0)

    End_Wild_Battle_Victory:
    # Load na pilha
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    
    # Retornar
    ret
#

# POKEMON_ATTACKS_MENU
#   - Permite o jogador escoher um dos ataques do pokémon para atacar
#   - Retorno:
#       > a0 ---> 0 se o jogador não escolheu um item, 1 se o jogador escolheu um item
#       > a1 ---> o item escolhido pelo jogador (0 caso não tenha escolhido)
ITEMS_MENU:
    addi sp, sp -8
    sw ra, 0(sp)
    sw t0, 4(sp)

    # Desenhar background
    la a0, pokemon_attacks_menu_bg
    mv a1, zero
    li a2, 180
    mv a3, s0
    mv a4, zero
    jal DRAW_IMAGE
    
    # Printa a string potion
    la a0, n_potion
    li a1, 25
    li a2, 195
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printa a letra x
    la a0, x
    li a1, 80
    li a2, 195
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printa a quantidade de poção que o jogador possui
    la a0, player_bag
    lw a0, 4(a0)
    li a1, 88
    li a2, 195
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_INT_SAVE

    # Printa a seta
    li a0, 17
    li a1, 195
    li a2, 0x0000FF0F
    jal DRAW_SETA

    Items_Menu_Loop:
        # Pegar input
        jal KEY2

        # Administrar input
        li t0, 'z'
        beq a0, t0, Use_Item 
        
        li t0, 'x'
        beq a0, t0, Back_Battle_Menu3

        j Items_Menu_Loop

        Use_Item:
            la t0, player_bag
            lw t0, 4(t0)
            beqz t0, Items_Menu_Loop
            li a0, 1
            la a1, I_POTION
            j End_Items_Menu

        Back_Battle_Menu3:
            mv a0, zero
            mv a1, zero


    End_Items_Menu:
    # Load na pilha
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    ret
#

# BATTLE_DEFEAT
BATTLE_DEFEAT:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

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
    li a1, 90
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG
 
    # Colorir a tela de preto
    li a0, 0
    mv a1, s0
    jal COLOR_SCREEN

    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG

    # Printar string defeat
    la a0, defeat
    li a1, 0
    li a2, 100
    li a3, 0x000000F0
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar string revive_poke
    la a0, revive_poke
    li a1, 0
    li a2, 120
    li a3, 0x0000000F
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret
#

# RUN_BATTLE
RUN_BATTLE:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Desenhar a caixa de diálogo
    la a0, dialog_box_battle
    mv a1, zero
    li a2, 180
    mv a3, s0
    jal DRAW_IMAGE

    # Printar a string str_run
    la a0, str_run
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar a string covarde
    la a0, covarde
    li a1, 16
    li a2, 220
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE



    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG   

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret
