.text
# -   > a0 = endereço da string
# -   > a1 = frame
# -   > a2 = 0 ? nada : printa a string do endereco passado
PRINT_TEXT_BOX: 
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)

  mv t0, a0
  mv t1, a1
  mv t2, a2

  mv a0, t1
  jal PRINT_BOX

  mv a0, t0
  li a1, 14
  li a2, 204
  li a3, 0x0000FF00
  mv a4, s0
  jal PRINT_STRING_SAVE

  beqz t2, PRINT_TEXT_BOX.FIM

  mv a0, t2
  mv a1, t1
  jal PRINT_TEXT_BOX2

  PRINT_TEXT_BOX.FIM:
    jal CONFIRM_DIALOG

    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16
    ret

# PRINT_TEXT_BOX2
# so printa 
# -   > a0 = endereço da string
# -   > a1 = frame
  PRINT_TEXT_BOX2: 
  addi sp, sp, -8
  sw ra, 0(sp)
  sw t0, 4(sp)

  mv t0, a0
  mv t1, a1

  mv a0, t0
  li a1, 30
  li a2, 204
  li a3, 0x0000FF00
  mv a4, s0
  jal PRINT_STRING_SAVE

  lw t0, 4(sp)
  lw ra, 0(sp)
  addi sp, sp, 8
  ret




# ---- PRINT_BOX
# - desenha a caixa de dialogo branca em que o texto vai ser exibido
# > a0 = frame 
PRINT_BOX:
  addi sp, sp, -20
  sw ra, 16(sp)
  sw t3, 12(sp)
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw t0, 0(sp)

	mv t3, a0
  
  # desenha o canto superior esquerdo
  la a0, tbx1
  li a1, 0
  li a2, 194
  mv a3, t3
  li a4, 0
  jal DRAW_IMAGE

  # desenha o canto inferior esquerdo
  la a0, tbx2
  li a1, 0
  li a2, 218
  mv a3, t3
  li a4, 0
  jal DRAW_IMAGE

  li t0, 0
  li t1, 25
  
  # desenha o meio da caixa
  PRINT_TEXT_BOX.LOOP:
    li t2, 12
    mul t2, t2, t0
    addi t2, t2, 12

    la a0, tbx3
    mv a1, t2
    li a2, 194
    mv a3, t3
    li a4, 0

    jal DRAW_IMAGE

    la a0, tbx4
    mv a1, t2
     li a2, 218
     mv a3, t3
     li a4, 0

     jal DRAW_IMAGE

     addi t0, t0, 1
     blt t0, t1, PRINT_TEXT_BOX.LOOP
    
  # desenha o canto superior direito
  la a0, tbx1
  li a1, 308
  li a2, 194
  mv a3, t3
  li a4, 1

  jal DRAW_IMAGE

  # desenha o canto inferior direito
  la a0, tbx2
  li a1, 308
  li a2, 218
  mv a3, t3
  li a4, 1
  jal DRAW_IMAGE
 
  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw t3, 12(sp)
  lw ra, 16(sp)
  addi sp, sp, 20
  ret
