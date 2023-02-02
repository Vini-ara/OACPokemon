.text
# DRAW_IMAGE
#   - A função desenha uma imagem em uma determinada posição na tela;
#   - Parâmetros:
#       > a0 = Endereço da Imagem
#       > a1 = Posição x
#       > a2 = Posição y
#       > a3 = Frame (0 ou 1)
#       > a4 = espelhado (1 = sim, 0 = nao)
#   - Registradores Temporários
#       > t0 = Endereço do Bitmap Display
#       > t1 = Endereço da imagem  
#       > t2 = Contador de linha
#       > t3 = Contador de coluna
#       > t4 = Largura da imagem   
#       > t5 = Comprimento da imagem

DRAW_IMAGE:
  addi sp, sp, -32
  sw ra, 28(sp)
  sw t6, 24(sp)
  sw t5, 20(sp)
  sw t4, 16(sp)
  sw t3, 12(sp)
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw t0, 0(sp)
    
  # Calculando endereço do Frame
  li t0, 0xFF0                    # Inicializando t0 = 0xFF0
  add t0, t0, a3                  # t0 = t0 + a3
  slli t0, t0, 20                 # Shiftando 20 bits a esquerda de t0

  # Calcular endereço inicial (posição (x,y))
  add t0, t0, a1                  # t0 = t0 + a1 (Movendo o endereço para a posição x)
  li t1, 320                      # t1 = 320
  mul t1, t1, a2                  # t1 = t1 x a2
  add t0, t0, t1                  # t0 = t0 + t1

  # Inicializando variáveis (Registradores Temporários)
  addi t1, a0, 8                  # t1 = a0 + 8 (Pular largura e comprimento da imagem)
  mv t2, zero                     # t2 = 0 (Contador começa no 0)
  mv t3, zero                     # t3 = 0 (Contador começa no 0)
  lw t4, 0(a0)                    # t4 = a0 (Os primeiros 4 bytes do arquivo .data representam a largura da imagem)
  lw t5, 4(a0)                    # t5 = a0 (Os bytes das posições 4 a 7 do arquivo .data representam a largura da imagem)

  beqz a4, Print_Line             # Printar sem espelhar

  add t1, t1, t4                 # t1 = ultimo byte da primeira linha da imagem + 1
  addi t1, t1, -1                # t4 = t4 - 1 (ultimo byte da linha) 

  # Desenha as linhas de tras para frente 
  Print_Inverted_Line: 
    lb t6, 0(t1)                     # Le 1 byte da imagem e armazena em t6
    sb t6, 0(t0)                     # Armazena o byte lido no endereco do frame

    addi t0, t0, 1                   # t0 = t0 + 1
    addi t1, t1, -1                  # t1 = t1 + 1

    addi t3, t3, 1                   # t3 = t3 + 1
    blt t3, t4, Print_Inverted_Line  # se t3 < t4, ir para Print_Inverted_Line

    addi t0, t0, 320                 # t0 = t0 + 320 (pular para a proxima linha)
    sub t0, t0, t4                   # t0 = t0 - t4 (voltar para o inicio da linha)

    mv t3, zero                      # t3 = 0 (Resetar o contador)
    addi t2, t2, 1                   # t2 = t2 + 1 (incrementar o contador)

    add t1, t1, t4                  # Volta ao ultimo byte da linha
    add t1, t1, t4                  # Pula uma linha (ultimo byte da proxima linha)

    bgt t5, t2, Print_Inverted_Line  # Se t5 > t2, ir para Print_Inverted_Line
    
    jal zero, DRAW_IMAGE.FIM         # Ir para o fim do procedimento

  # Loop - Desenha a imagem linha a linha
  Print_Line:
    lw t6, 0(t1)                # Lê 4 bytes da imagem e armazena em t6
    sw t6, 0(t0)                # Armazena os 4 bytes lidos no endereço do Frame

    addi t0, t0, 4              # t0 = t0 + 4
    addi t1, t1, 4              # t0 = t0 + 4

    addi t3, t3, 4              # t3 = t3 + 4
    blt t3, t4, Print_Line      # Se t3 < t4, ir para Print_Line

    addi t0, t0, 320            # t0 = t0 + 320 (pular para a próxima linha)
    sub t0, t0, t4              # t0 = t0 - t4 (voltar para o início da linha)

    mv t3, zero                 # t3 = 0 (Resetar o contador t3)
    addi t2, t2, 1              # t2 = t2 + 1 
    bgt t5, t2, Print_Line      # Se t5 > t2, ir para Print_Line
  
  DRAW_IMAGE.FIM:
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    lw t6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32

    ret

# DRAW_IMAGE2
#   - A função desenha uma imagem em uma determinada posição na tela;
#   - Parâmetros:
#       > a0 = Endereço da Imagem
#       > a1 = Posição x
#       > a2 = Posição y
#       > a3 = Frame (0 ou 1)
#   - Registradores Temporários
#       > t0 = Endereço do Bitmap Display
#       > t1 = Endereço da imagem  
#       > t2 = Contador de linha
#       > t3 = Contador de coluna
#       > t4 = Largura da imagem   
#       > t5 = Comprimento da imagem
DRAW_IMAGE2:
    # Guardando valores dos registradores temporários na pilha
    addi sp, sp, -24
    sw t0, 20(sp)
    sw t1, 16(sp)
    sw t2, 12(sp)
    sw t3, 8(sp)
    sw t4, 4(sp)
    sw t5, 0(sp)
    # Calculando endereço do Frame
    li t0, 0xFF0                    # Inicializando t0 = 0xFF0
    add t0, t0, a3                  # t0 = t0 + a3
    slli t0, t0, 20                 # Shiftando 20 bits a esquerda de t0

    # Calcular endereço inicial (posição (x,y))
    add t0, t0, a1                  # t0 = t0 + a1 (Movendo o endereço para a posição x)
    li t1, 320                      # t1 = 320
    mul t1, t1, a2                  # t1 = t1 x a2
    add t0, t0, t1                  # t0 = t0 + t1

    # Inicializando variáveis (Registradores Temporários)
    addi t1, a0, 8                  # t1 = a0 + 8 (Pular largura e comprimento da imagem)
    mv t2, zero                     # t2 = 0 (Contador começa no 0)
    mv t3, zero                     # t3 = 0 (Contador começa no 0)
    lw t4, 0(a0)                    # t4 = a0 (Os primeiros 4 bytes do arquivo .data representam a largura da imagem)
    lw t5, 4(a0)                    # t5 = a0 (Os bytes das posições 4 a 7 do arquivo .data representam a largura da imagem)

    # Loop - Desenha a imagem linha a linha
    Print_Line2:
        lb t6, 0(t1)                # Lê 4 bytes da imagem e armazena em t6
        sb t6, 0(t0)                # Armazena os 4 bytes lidos no endereço do Frame

        addi t0, t0, 1              # t0 = t0 + 4
        addi t1, t1, 1              # t0 = t0 + 4

        addi t3, t3, 1              # t3 = t3 + 4
        blt t3, t4, Print_Line2      # Se t3 < t4, ir para Print_Line

        addi t0, t0, 320            # t0 = t0 + 320 (pular para a próxima linha)
        sub t0, t0, t4              # t0 = t0 - t4 (voltar para o início da linha)

        mv t3, zero                 # t3 = 0 (Resetar o contador t3)
        addi t2, t2, 1              # t2 = t2 + 1 
        bgt t5, t2, Print_Line2      # Se t5 > t2, ir para Print_Line
        
        # Recarregar os valores dos registradores temporários
        lw t5, 0(sp)
        lw t4, 4(sp)
        lw t3, 8(sp)
        lw t2, 12(sp)
        lw t1, 16(sp)
        lw t0, 20(sp)
        addi sp, sp, 24
        ret
#

# COLOR_SCREEN
#   - Preenche a tela com uma cor
#   - Parâmetros:
#       > a0 ---> cor (0xCcCcCcCc)
#       > a1 ---> frame
COLOR_SCREEN:
    # Guardando valores dos registradores temporários na pilha
    addi sp, sp, -28
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    sw t6, 24(sp)
    # Calculando endereço do Frame
    li t0, 0xFF0                    # Inicializando t0 = 0xFF0
    add t0, t0, a1                  # t0 = t0 + a1
    slli t0, t0, 20                 # Shiftando 20 bits a esquerda de t0
    li t1, 0x12C00
    add t1, t0, t1

    # Inicializando variáveis (Registradores Temporários)
    mv t2, a0               # t2 = a0
    
    # Loop - Desenha a imagem linha a linha
    Print_Line3:
        sw t2, 0(t0)                # Armazena os 4 bytes lidos no endereço do Frame
        addi t0, t0, 4              # t0 = t0 + 4
        bne t0, t1, Print_Line3
        # Recarregar os valores dos registradores temporários
        lw t6, 24(sp)
        lw t5, 20(sp)
        lw t4, 16(sp)
        lw t3, 12(sp)
        lw t2, 8(sp)
        lw t1, 4(sp)
        lw t0, 0(sp)
        addi sp, sp, 28
        ret



