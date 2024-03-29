.text
CHECK_BATTLE:
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)

  la t0, WILL_BATTLE

  lb t1, 0(t0)
  beqz t1, CHECK_BATTLE.FIM

  jal RANDOM_SAVE

  li t1, 5
  rem t1, a0, t1

  li t2, 0
  beq t1, t2, CHOOSE_CARAMELO

  li t2, 1
  beq t1, t2, CHOOSE_SARUE
   
  li t2, 2
  beq t1, t2, CHOOSE_POMBO

  li t2, 3
  beq t1, t2, CHOOSE_GATO

  j CHOOSE_LARVA

  CHOOSE_CARAMELO:
    la a0, P_CARAMELO
    j GO_BATTLE

  CHOOSE_SARUE:
    la a0, P_SARUE
    j GO_BATTLE

  CHOOSE_POMBO:
    la a0, P_POMBO
    j GO_BATTLE

  CHOOSE_GATO:
    la a0, P_GATO
    j GO_BATTLE

  CHOOSE_LARVA:
    la a0, P_LARVA
    j GO_BATTLE

  GO_BATTLE:
    li a1, 3
    jal BATTLE_WILD_POKEMON

    bne a0, zero, CHECK_BATTLE.FIM

    la t0, MAPA_OBJ
    lw t0, 0(t0)

    la t1, CURRENT_MAP
    sw t0, 0(t1)

    li s1, 24
    li s2, 26
    li s3, 0


CHECK_BATTLE.FIM:
  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  addi sp, sp, 16
  ret
