.data

.text
# DRAW_IMAGE
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

DRAW_IMAGE:
    
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
	
	lw t0, 0(sp)
	
        ret

