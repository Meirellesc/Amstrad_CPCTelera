.include "main.h.s"
.include "numbers.h.s"
.include "disparo.h.s"

thenumber: 	.db 	#3
thenumber_l: 	.db 	#0
thenumber_h: 	.db 	#0

selectNumber:

ld 	(thenumber), 	a
cp #0
jp 	nz, 	nocero
ld 	hl, 	#_numbers_sp_00
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
nocero:
ld 	a, 	(thenumber)
cp #1
jp 	nz, 	nouno
ld 	hl, 	#_numbers_sp_01
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
nouno:
ld 	a, 	(thenumber)
cp #2
jp 	nz, 	nodos
ld 	hl, 	#_numbers_sp_02
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
nodos:
ld 	a, 	(thenumber)
cp #3
jp 	nz, 	notres
ld 	hl, 	#_numbers_sp_03
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
notres:
ld 	a, 	(thenumber)
cp #4
jp 	nz, 	nocuatro
ld 	hl, 	#_numbers_sp_04
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
nocuatro:
ld 	a, 	(thenumber)
cp #5
jp 	nz, 	nocinco
ld 	hl, 	#_numbers_sp_05
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
nocinco:
ld 	a, 	(thenumber)
cp #6
jp 	nz, 	noseis
ld 	hl, 	#_numbers_sp_06
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
noseis:
ld 	a, 	(thenumber)
cp #7
jp 	nz, 	nosiete
ld 	hl, 	#_numbers_sp_07
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
nosiete:
ld 	a, 	(thenumber)
cp #8
jp 	nz, 	noocho
ld 	hl, 	#_numbers_sp_08
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a
ret
noocho:
ld 	hl, 	#_numbers_sp_09
ld 	a,	l 	
ld 	(thenumber_l),	a 	
ld  a, 	h
ld  (thenumber_h), 	a

ret

draw_numbers:

	call selectNumber
	ld    de, #0xC000         ;; Comienzo de memoria de video
	ld    c, 	#75          ;; Entidad X
	ld    b, 	#4          ;; Entidad Y
	call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

	;;;HL -> Memoria de video

	ex    de, hl         ;; Cambio lo de HL a DE
	ld    a, (thenumber_l)
	ld    l, a
	ld    a, (thenumber_h)
	ld    h, a
	;;;ld    hl, #_hero_sp_0  
	ld    c, #8     ;; Alto
	ld    b, #4     ;; Ancho
   call cpct_drawSpriteBlended_asm
ret