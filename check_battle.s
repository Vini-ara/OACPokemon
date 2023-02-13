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
  and t1, t1, a0

  li t2, 0
  beq t1, t2, CHOOSE_BULBASAUR

  li t2, 1
  beq t1, t2, CHOOSE_SQUIRTLE
   
  li t2, 2
  beq t1, t2, CHOOSE_VULPIX

  li t2, 3
  beq t1, t2, CHOOSE_PIDGEY

  j CHOOSE_GEODUDE

  CHOOSE_BULBASAUR:
    la a0, P_BULBASAUR
    j GO_BATTLE

  CHOOSE_SQUIRTLE:
    la a0, P_SQUIRTLE
    j GO_BATTLE

  CHOOSE_VULPIX:
    la a0, P_VULPIX
    j GO_BATTLE

  CHOOSE_PIDGEY:
    la a0, P_PIDGEY
    j GO_BATTLE

  CHOOSE_GEODUDE:
    la a0, P_GEODUDE
    j GO_BATTLE

  GO_BATTLE:
    xori s0, s0, 1
    li a1, 5
    jal BATTLE_WILD_POKEMON

    la t0, WILL_BATTLE 
    li t1, 1
    sb t1, 0(t0)

CHECK_BATTLE.FIM:
  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  addi sp, sp, 16
  ret
