.data
OBJETOS: .space 16
.include "imagens/tree0.data"
.include "imagens/grass0.data"

.text

inicia_objetos:
	la t0,OBJETOS
#GRASS0
	la t1,grass0
	sw t1,0(t0)
	li t1,1
	sw t1,4(t0)
	
#PROXIMO OBJETO
	addi t0,t0,8
#TREE0
	la t1,tree0
	sw t1,0(t0)
	li t1,0
	sw t1,4(t0)
	
#FIM
	ret
	