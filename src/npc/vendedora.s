.text
VENDEDORA:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Xori no s0
    xori s0, s0, 1

    # Printar string vendedora_fala1
    la a0, LOJA0
    mv a1, s0
    la a2, LOJA1
    jal PRINT_TEXT_BOX

    # Printar string venddedora_fala2
    # la a0, LOJA1
    # mv a1, s0
    # jal PRINT_TEXT_BOX

    # Menu de compra
    jal VENDEDORA_MENU

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret


VENDEDORA_MENU:
    # Load na pilha
    addi sp, sp, -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)

    # Printar string vendedora_fala3
    la a0, vendedora_fala3
    mv a1, s0
    jal PRINT_TEXT_BOX
    
    # Pritar string sim na tela
    la a0, sim
    li a1, 32
    li a2, 220
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar string nao na tela
    la a0, nao
    li a1, 128
    li a2, 220
    li a3, 0x0000FF00
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Inicializar registradores temporários
    li t0, 22
    mv t2, zero

    # Printar seta na tela
    mv a0, t0
    li a1, 220
    li a2, 0x0000FF0F
    jal DRAW_SETA

    Vendedora_Menu_Loop:
        # Adquirir o input
        jal KEY2

        # Verificar se o input é 'a'
        li t1, 'a'
        beq a0, t1, Move_Seta_Left3

        # Verificar se o input é 'd'
        li t1, 'd'
        beq a0, t1, Move_Seta_Right3

        # Verificar se o input é 'z'
        li t1, 'z'
        beq a0, t1, Comprar_Marmita

        j Vendedora_Menu_Loop

        Move_Seta_Left3:
            # Mover seta para a esquerda
            li t1, 22
            beq t0, t1, Vendedora_Menu_Loop
            
            # Printar seta na tela
            mv a0, t0
            li a1, 220
            li a2, 0x0000FFFF
            jal DRAW_SETA

            li t0, 22

            # Printar seta na tela
            mv a0, t0
            li a1, 220
            li a2, 0x0000FF0F
            jal DRAW_SETA
            
            mv t2, zero
            j Vendedora_Menu_Loop

        Move_Seta_Right3:
            # Mover seta para a direita
            li t1, 118
            beq t0, t1, Vendedora_Menu_Loop

            # Printar seta na tela
            mv a0, t0
            li a1, 220
            li a2, 0x0000FFFF
            jal DRAW_SETA

            li t0, 118
            # Printar seta na tela
            mv a0, t0
            li a1, 220
            li a2, 0x0000FF0F
            jal DRAW_SETA

            li t2, 1
            j Vendedora_Menu_Loop

        Comprar_Marmita:
            # Comprar marmita ou nao  
            bnez t2, End_Vendedora_Menu
            
            # Verificar se o jogador possui creditos suficientes para comprar
            la t1, creditos
            lb t2, 0(t1)
            li t3, 50
            blt t2, t3, Creditos_Insuficientes
            
            # Diminuir o número de créditos em 50
            addi t2, t2, -50
            sb t2, 0(t1)
            
            # Aumentar o número de poções em 1
            la t0, player_bag
            lw t1, 4(t0)
            addi t1, t1, 1
            sw t1, 4(t0)
            
            # Ir para o fim da função
            j End_Vendedora_Menu

        Creditos_Insuficientes:
            # Printar a string vendedora_fala4
            la a0, vendedora_fala5
            mv a1, s0
            jal PRINT_TEXT_BOX

    End_Vendedora_Menu:
        # Printar a string vendedora_fala3
        la a0, vendedora_fala4
        mv a1, s0
        jal PRINT_TEXT_BOX    

    # Load na pilha
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 20
    # Retornar
    ret
