
# > a0 = Y
# > a1 = X
# > a2 = direction

CHECK_DIALOG:
  addi sp, sp, -28
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)
  sw t3, 16(sp)
  sw t4, 20(sp)
  sw t5, 24(sp)

  mv t0, s1
  mv t1, s2

  mv t3, s3
  
  la t4, CURRENT_MAP
  lw t5, 0(t4)  # endereco do mapa
   
  lw t4, 0(t5)  # largura do mapa
  mul t4, t4, t0  # largura * posicao-y do jogador
  add t4, t4, t1  # linha do jogador + posicao-x do jogador
  addi t4, t4, 8 # offset do tile em que o jogador esta
  add t4, t4, t5 # endereco de mem em do tile em que o jogador esta

  li t5, 0
  beq t3, t5, CHECK_DIALOG.UP

  li t5, 1
  beq t3, t5 CHECK_DIALOG.BOTTOM

  li t5, 2
  beq t3, t5 CHECK_DIALOG.RIGHT

  li t5, 3
  beq t3, t5 CHECK_DIALOG.LEFT

  j CHECK_DIALOG.FIM

  CHECK_DIALOG.UP:
    la t0, CURRENT_MAP
    lw t1, 0(t0)  # endereco do mapa
    lw t0, 0(t1)  # largura do mapa

    sub t3, t4, t0 # tile em cima do jogador
    lbu t0, 0(t3) # Numero do tile
    li t1, 4
    mul t0, t0, t1
     
    la t1, OBJETOS # array de objetos
    add t1, t1, t0 # indice objeto do tile na frente do jogador
    lw t1, 0(t1) # objeto do sprite
    
    lb t2, 6(t1)
    
    li t3, 3
    beq t2, t3, ACTION

    j CHECK_DIALOG.FIM

  CHECK_DIALOG.BOTTOM: 
    la t0, CURRENT_MAP
    lw t1, 0(t0)  # endereco do mapa
    lw t0, 0(t1)  # largura do mapa

    add t3, t4, t0 # tile em baixo do jogador
    lbu t0, 0(t3) # Numero do tile
    li t1, 4
    mul t0, t0, t1
     
    la t1, OBJETOS # array de objetos
    add t1, t1, t0 # indice objeto do tile na frente do jogador
    lw t1, 0(t1) # objeto do sprite
    
    lb t2, 6(t1)
    
    li t3, 3
    beq t2, t3, ACTION

    j CHECK_DIALOG.FIM

  CHECK_DIALOG.LEFT:
    addi t3, t4, -1 # tile em cima do jogador
    lbu t0, 0(t3) # Numero do tile
    li t1, 4
    mul t0, t0, t1
     
    la t1, OBJETOS # array de objetos
    add t1, t1, t0 # indice objeto do tile na frente do jogador
    lw t1, 0(t1) # objeto do sprite
    
    lb t2, 6(t1)
    
    li t3, 3
    beq t2, t3, ACTION
    
    j CHECK_DIALOG.FIM

  CHECK_DIALOG.RIGHT:
    addi t3, t4, 1 # tile em cima do jogador
    lbu t0, 0(t3) # Numero do tile
    li t1, 4
    mul t0, t0, t1
     
    la t1, OBJETOS # array de objetos
    add t1, t1, t0 # indice objeto do tile na frente do jogador
    lw t1, 0(t1) # objeto do sprite
    
    lb t2, 6(t1)
    
    li t3, 3
    beq t2, t3, ACTION
    
    j CHECK_DIALOG.FIM

  ACTION:
    jal NPC_CURANDEIRA

  CHECK_DIALOG.FIM:
    lw ra, 0(sp)
    lw t0, 4(sp)
    lw t1, 8(sp)
    lw t2, 12(sp)
    lw t3, 16(sp)
    lw t4, 20(sp)
    lw t5, 24(sp)
    addi sp, sp, 28

    ret
