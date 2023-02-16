.data
#Musica
CONTADOR_NOTAS: .word 0
TEMPO_ULTIMA_NOTA: .word 0
TEMPO_REST: .word 0

TAMANHO: 58
NOTAS: 64,256,65,128,67,256,64,256,67,641,67,128,69,384,71,256,69,128,71,256,69,256,71,384,69,256,67,256,65,256,64,256,65,128,67,256,64,256,67,384,60,513,62,256,64,256,62,128,60,256,57,256,60,513,67,384,65,256,64,256,65,128,67,256,64,256,67,513,65,128,67,256,69,256,71,256,69,128,71,256,69,256,71,384,72,256,75,256,74,256,72,256,69,384,60,256,64,256,62,128,60,513,62,256,67,256,65,128,64,256,65,256,67,641,65,513		


.text
TOCA_MUSICA:
	csrr t0,3073
	la t1,TEMPO_ULTIMA_NOTA
	lw t1,0(t1)
	sub t0,t0,t1
	la t1,TEMPO_REST
	lw t1,0(t1)
	
	bgeu t0,t1,TOCA_NOTA #verifica se já passou o tempo necessario para tocar a nota
	ret
	
TOCA_NOTA:
	la t0,CONTADOR_NOTAS
	mv t2,t0
	la t1,TAMANHO	
	lw t0,0(t0)	#t0 = contador de notas
	lw t1,0(t1)	#t1 = tamanho
	
	bne t0,t1,DIFERENTE #verifica se o contador já passou do tamanho da musica
	sw zero,0(t2)
	
DIFERENTE:
	li t1,8
	mul t1,t0,t1 #ajusta  aposicao da nota
	
	la t3,NOTAS
	add t3,t3,t1
	
	addi sp,sp,-8
	sw t3,0(sp) #guarda a posicao da nota
	sw ra,4(sp)
	
	
	
	#ecall para tocar musica
	
	lw a0,0(t3) #pitch
	lw a1,4(t3) #duracao
	li a2,10 #instrumento
	li a3,100 #volume
	li a7,31 #comentar
	ecall #comentar
	
	#funcao para tocar musica na placa
#	jal MIDI_SAVE #nao funciona no rars
	
	#recupera posicao nota
	
	lw t3,0(sp)
	lw ra,4(sp)
	addi sp,sp,8
	
	lw t4,4(t3)
	la t0,TEMPO_REST
	sw t4,0(t0)
	
	csrr t0,3073
	la t1,TEMPO_ULTIMA_NOTA
	sw t0,0(t1)
	
	
	la t1,CONTADOR_NOTAS
	lw t2,0(t1)
	addi t2,t2,1
	sw t2,0(t1)
	
	ret
	
	
	
	
	
	
	
	
	
	
