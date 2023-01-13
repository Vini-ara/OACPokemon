.text
# PRINT_PLAYER
#   - A função desenhha o jogador na tela 

PRINT_PLAYER:
    addi sp, sp, -8
    sw ra, 4(sp)
    sw t0, 0(sp)

    li a1,160 # posiçao x 
    li a2,112 # posiçao y
    mv a3, s0 # frame

    li t0, 0
    beq t0, s3, PRINT_PLAYER.CIMA
    li t0, 1
    beq t0, s3, PRINT_PLAYER.BAIXO
    li t0, 2
    beq t0, s3, PRINT_PLAYER.DIR
    li t0, 3
    beq t0, s3, PRINT_PLAYER.ESQ

    PRINT_PLAYER.CIMA:
      la a0, hero4
      mv a4, zero
      jal zero, PRINT_PLAYER.PRINT
    
    PRINT_PLAYER.BAIXO:
      la a0, hero1
      mv a4, zero
      jal zero, PRINT_PLAYER.PRINT

    PRINT_PLAYER.DIR:
      la a0, hero7
      li a4, 1
      jal zero, PRINT_PLAYER.PRINT

    PRINT_PLAYER.ESQ:
      mv a4, zero
      la a0, hero7

    PRINT_PLAYER.PRINT:
      jal DRAW_IMAGE

    lw t0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8

    ret
