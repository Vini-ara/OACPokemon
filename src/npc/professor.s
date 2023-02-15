.data
# ESTADO DO PROFESSOR
#	Se for 0, exibir diálogo de escolha dos pokémons, se for 1, exibir diálogo do passe, e se for 2 exibir diálogo padrão
estado_prof: .byte 0
.text
PROFESSOR:
    # Store na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    
    # Xori no s0
    xori s0, s0, 1

    la t0, estado_prof
    lb t0, 0(t0)

    beqz t0, Escolha_Pokemons
    
    li t1, 1
    beq t0, t1, Dialog_Passe

    li t1, 2
    beq t0, t1, Dialog_Padrao

    Escolha_Pokemons:
        jal ESCOLHA_POKEMONS_INICIAL
        j End_Professor

    Dialog_Passe:
        jal DIALOGO_PASSE
        j End_Professor

    Dialog_Padrao:
        jal DIALOGO_PADRAO

    End_Professor:
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    ret
#

#
ESCOLHA_POKEMONS_INICIAL:
    # Store na pilha
    addi sp, sp -4
    sw ra, 0(sp)

    # Printar string LAMAR0
    la a0, LAMAR0
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Printar string LAMAR3
    la a0, LAMAR2
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Printar string LAMAR4 e LAMAR5
    la a0, LAMAR4
    mv a1, s0
    la a2, LAMAR5
    jal PRINT_TEXT_BOX

    # Printar string LAMAR6
    la a0, LAMAR6
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Printar string LAMAR8 E LAMAR9
    la a0, LAMAR8
    mv a1, s0
    la a2, LAMAR9
    jal PRINT_TEXT_BOX

    # Printar string LAMAR10
    la a0, LAMAR10
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Printar string LAMAR12
    la a0, LAMAR12
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Printar string LAMAR14 E LAMAR15
    la a0, LAMAR14
    mv a1, s0
    la a2, LAMAR15
    jal PRINT_TEXT_BOX

    # Printar string LAMAR16
    la a0, LAMAR16
    mv a1, s0
    mv a2, zero
    jal PRINT_TEXT_BOX

    # Menu de escolha dos pokémons iniciais
    jal MENU_ESCOLHA_POKEMONS_INICIAL

    # Printar string LAMAR18 e LAMAR19
    la a0, LAMAR18
    mv a1, s0
    la a2, LAMAR19
    jal PRINT_TEXT_BOX

    # Printar string LAMAR20 e LAMAR21
    la a0, LAMAR20
    mv a1, s0
    la a2, LAMAR21
    jal PRINT_TEXT_BOX

    # Printar string LAMAR22 e LAMAR23
    la a0, LAMAR22
    mv a1, s0
    la a2, LAMAR23
    jal PRINT_TEXT_BOX

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret
#

#
MENU_ESCOLHA_POKEMONS_INICIAL:
    # Load na pilha
    addi sp, sp, -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)

    # Limpar a caixa de diálogo
    mv a0, s0
    jal PRINT_BOX
    
    # Pritar nome do Pombo
    la a0, n_squirtle
    li a1, 32
    li a2, 204
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar string nao na tela
    la a0, n_bulbasaur
    li a1, 200
    li a2, 204
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar string nao na tela
    la a0, n_vulpix
    li a1, 32
    li a2, 220
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Inicializar registradores temporários
    li t0, 22
    li t1, 204
    mv t2, zero

    # Printar seta na tela
    mv a0, t0
    mv a1, t1
    li a2, 0x0000FF0F
    jal DRAW_SETA

   Loop_Menu_Escolha_Pokemons_Inicial:
        # Adquirir o input
        jal KEY2

        # Verificar se o input é 'a'
        li t3, 'a'
        beq a0, t3, Move_Seta_Left4

        # Verificar se o input é 'd'
        li t3, 'd'
        beq a0, t3, Move_Seta_Right4

        # Verificar se o input é 'w'
        li t3, 'w'
        beq a0, t3, Move_Seta_Up3

        # Verificar se o input é 's'
        li t3, 's'
        beq a0, t3, Move_Seta_Down3

        # Verificar se o input é 'z'
        li t3, 'z'
        beq a0, t3, Escolher_Pokemon

        j Loop_Menu_Escolha_Pokemons_Inicial

        Move_Seta_Left4:
            # Mover seta para a esquerda
            li t3, 22
            beq t0, t3, Loop_Menu_Escolha_Pokemons_Inicial
            
            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FFFF
            jal DRAW_SETA

            li t0, 22

            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FF0F
            jal DRAW_SETA
            
            addi t2, t2, -1
            j Loop_Menu_Escolha_Pokemons_Inicial

        Move_Seta_Right4:
            # Mover seta para a direita
            li t3, 190
            beq t0, t3, Loop_Menu_Escolha_Pokemons_Inicial

            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FFFF
            jal DRAW_SETA

            li t0, 190
            li t1, 204
            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FF0F
            jal DRAW_SETA

            li t2, 1
            j Loop_Menu_Escolha_Pokemons_Inicial

        Move_Seta_Up3:
            li t3, 204
            beq t1, t3, Loop_Menu_Escolha_Pokemons_Inicial

            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FFFF
            jal DRAW_SETA

            li t1, 204

            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FF0F
            jal DRAW_SETA

            mv t2, zero
            j Loop_Menu_Escolha_Pokemons_Inicial

        Move_Seta_Down3:
            li t3, 220
            beq t1, t3, Loop_Menu_Escolha_Pokemons_Inicial

            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FFFF
            jal DRAW_SETA

            li t0, 22
            li t1, 220

            # Printar seta na tela
            mv a0, t0
            mv a1, t1
            li a2, 0x0000FF0F
            jal DRAW_SETA

            li t2, 2
            j Loop_Menu_Escolha_Pokemons_Inicial

        Escolher_Pokemon:
            # Verificar se é o Pedro Sarue  
            beqz t2, Escolher_Pedro_Sarue

            # Verificar se é o Caramelo 
            li t3, 1
            beq t2, t3, Escolher_Caramelo

            # Verificar se é o Pombo do Bebedouro 
            li t3, 2
            beq t2, t3, Escolher_Pombo_Bebedouro

        Escolher_Pedro_Sarue:
            # Inicializar o Pedro Sarue
            la a0, P_SARUE
            jal INIT_POKEMON_INICIAL
            j End_Menu_Escolha_Pokemons_Inicial

        Escolher_Caramelo:
            # Inicializar o Caramelo
            la a0, P_CARAMELO
            jal INIT_POKEMON_INICIAL
            j End_Menu_Escolha_Pokemons_Inicial

        Escolher_Pombo_Bebedouro:
            # Inicializar o Pombo do Bebedouro
            la a0, P_POMBO
            jal INIT_POKEMON_INICIAL
            j End_Menu_Escolha_Pokemons_Inicial

    End_Menu_Escolha_Pokemons_Inicial:
        # Mudar o estado do NPC Professor
        la t0, estado_prof
        li t1, 1
        sb t1, 0(t0)
        
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

#
DIALOGO_PASSE:
    # Load na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)

    # Verificar a quantidade de créditos do jogador
    la t0, creditos
    lbu t1, 0(t0)
    li t2, 200
    bge t1, t2, Comprar_Passe

    # Printar string LAMAR24 e LAMAR25
    la a0, LAMAR24
    mv a1, s0
    la a2, LAMAR25
    jal PRINT_TEXT_BOX

    # Printar string LAMAR26 e LAMAR27
    la a0, LAMAR26
    mv a1, s0
    la a2, LAMAR27
    jal PRINT_TEXT_BOX

    j End_Dialogo_Passe

    Comprar_Passe:
        # Printar string LAMAR28 e LAMAR29
        la a0, LAMAR28
        mv a1, s0
        la a2, LAMAR29
        jal PRINT_TEXT_BOX

        # Printar string LAMAR30 e LAMAR31
        la a0, LAMAR30
        mv a1, s0
        la a2, LAMAR31
        jal PRINT_TEXT_BOX

        # Diminuir em 200 os creditos do jogador
        addi t1, t1, -200
        sb t1, 0(t0)

        # Dar o passe ao jogador
        la t0, passe
        li t1, 1
        sb t1, 0(t0)

        # Mudar o estado do NPC Professor
        la t0, estado_prof
        li t1, 2
        sb t1, 0(t0)
    
    End_Dialogo_Passe:
        # Load na Pilha
        lw t1, 8(sp)
        lw t0, 4(sp)
        lw ra, 0(sp)
        addi sp, sp, 12

        # Retornar
        ret
#

#
DIALOGO_PADRAO:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Printar string LAMAR28 e LAMAR29
    la a0, LAMAR28
    mv a1, s0
    la a2, LAMAR29
    jal PRINT_TEXT_BOX

    # Printar string LAMAR30 e LAMAR31
    la a0, LAMAR30
    mv a1, s0
    la a2, LAMAR31
    jal PRINT_TEXT_BOX

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret
