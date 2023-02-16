
ANIMATION:
    addi sp, sp, -32
    sw ra, 28(sp)
    sw t6, 24(sp)
    sw t5, 20(sp)
    sw t4, 16(sp)
    sw t3, 12(sp)
    sw t2, 8(sp)
    sw t1, 4(sp)
    sw t0, 0(sp)

    mv t0, s3 

    beqz t0, ANIMATION.UP 

    li t1, 1
  #  beq t1, t0, ANIMATION.DOWN 

    li t1, 2
    #beq t1, t0, ANIMATION.RIGHT

    jal ANIMATION.up

ANIMATION.UP:
    li t0, 0xFF0                    # Inicializando t0 = 0xFF0
    add t0, t0, s0                  # t0 = t0 + s0
    slli t0, t0, 20

    li t1, 238 # local em que vai começar o loop

    li t2, 320
    mul t1, t1, t2 # endereço na tela

    add t0, t0, t1      # endereço certo na memoria

    li t1, 8 # contador de iteaçõeoes

    ANIMATION.UP_OUT_LOOP:
        li t2, 238 
    
        li t3, 320
        add t0, t0, t3
        addi t0, t0, -1
        li t4, 640

        ANIMATION.UP_INNER_LOOP:
            lb t5, 0(t0)

            add t6, t0, t4

            sb t5, 0(t6)

            addi t0, t0, -1
            addi t3, t3, -1
            bgt t3, zero, ANIMATION.UP_INNER_LOOP

        li a0, 50
        csrr a1, 3073
        jal SLEEP

        addi t1, t1, -1
        bgt t1, zero, ANIMATION.UP_OUT_LOOP

        j ANIMATION.FIM

ANIMATION.DOWN:
    li t0, 0xFF0                    # Inicializando t0 = 0xFF0
    add t0, t0, s0                  # t0 = t0 + s0
    slli t0, t0, 20

    li t1, 238 # local em que vai começar o loop

    li t2, 320
    mul t1, t1, t2 # endereço na tela

    add t0, t0, t1      # endereço certo na memoria

    li t1, 8 # contador de iteaçõeoes

    ANIMATION.DOWN_OUT_LOOP:
        li t2, 238 
    
        li t3, 320
        add t0, t0, t3
        addi t0, t0, -1
        li t4, 640

        ANIMATION.DOWN_INNER_LOOP:
            lb t5, 0(t0)

            add t6, t0, t4

            sb t5, 0(t6)

            addi t0, t0, -1
            addi t3, t3, -1
            bgt t3, zero, ANIMATION.DOWN_INNER_LOOP

        li a0, 50
        csrr a1, 3073
        jal SLEEP

        addi t1, t1, -1
        bgt t1, zero, ANIMATION.DOWN_OUT_LOOP

        j ANIMATION.FIM

    

ANIMATION.FIM  
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
    