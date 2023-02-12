.text
# -   > a0 = endereço da string
PRINT_TEXT_BOX: 
  addi sp, sp, -4
  sw ra, 0(sp)

  xori s0, s0, 1

  jal PRINT_BOX

  la a0, dead_battle
  li a1, 20
  li a2, 204
  li a3, 0x0000FF00
  mv a4, s0
  jal PRINT_STRING_SAVE

  jal CONFIRM_DIALOG

  lw ra, 0(sp)
  addi sp, sp, 4
  ret




# ---- PRINT_BOX
# - desenha a caixa de dialogo branca em que o texto vai ser exibido
PRINT_BOX:
  addi sp, sp, -20
  sw ra, 16(sp)
  sw t3, 12(sp)
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw t0, 0(sp)

	mv t3, s0
  
  # desenha o canto superior esquerdo
  la a0, tbx1
  li a1, 6
  li a2, 194
  mv a3, t3
  li a4, 0

  jal DRAW_IMAGE

  # desenha o canto inferior esquerdo
  la a0, tbx2
  li a1, 6
  li a2, 216
  mv a3, t3
  li a4, 0
  jal DRAW_IMAGE

  li t0, 0
  li t1, 24
  
  # desenha o meio da caixa
  PRINT_TEXT_BOX.LOOP:
    li t2, 12
    mul t2, t2, t0
    addi t2, t2, 18

    la a0, tbx3
    mv a1, t2
    li a2, 194
    mv a3, t3
    li a4, 0

    jal DRAW_IMAGE

    la a0, tbx4
    mv a1, t2
    li a2, 216
    mv a3, t3
    li a4, 0

    jal DRAW_IMAGE

    addi t0, t0, 1
    blt t0, t1, PRINT_TEXT_BOX.LOOP
    
  # desenha o canto superior direito
  la a0, tbx1
  li a1, 302
  li a2, 194
  mv a3, t3
  li a4, 1

  jal DRAW_IMAGE

  # desenha o canto inferior direito
  la a0, tbx2
  li a1, 302
  li a2, 216
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
