.include "main.h.s"
.include "entity.h.s"
.include "funciones_mat.h.s"

posicionY: 	.db 	#200
multiplicar_2:
add a, a
ret

multiplicar_4:
ld 	b, 	a

ld 	c, 	#4
ld 	d, 	#0
multiplica:
	ld 	c, 	a
	ld 	a, 	d
	add	a, 	b
	ld 	d, 	a

	ld 	a, 	c
	dec 	a
jp 	nz, multiplica

ld 	a, 	d

ret

dividir_2:
ld 	b, 	a 			;12

ld 	c, 	#2			;/2
ld 	d, 	#0
divide2:
	ld 	a, 	b		; A = 12
	sub	a, 	c		; A = A-2
	jp 	m, fin_div2
	ld 	b, 	a 		; B = A
	ld 	a, 	d 		; A = RESULT
	add a,	#1		; A = A+1
	ld 	d, 	a
	ld 	a, 	b
	cp 	#0
	jp	nz, divide2
fin_div2:
ld 	a, 	d
ret

dividir_4:
ld 	d, 	a 			;+128 	no lo hace

ld 	c, 	#4			;/2
ld 	b, 	#0
divide:
	ld 	a, 	d		; A = 12
	sub	a, 	c		; A = A-2
	ld 	d, 	a 		; B = A
	ld 	a, 	d		; A = 12
	cp 	#3
	jp 	z, fin_div
	ld 	a, 	d		; A = 12
	cp 	#2
	jp 	z, fin_div
	ld 	a, 	d		; A = 12
	cp 	#1
	jp 	z, fin_div
	ld 	a, 	d		; A = 12
	cp 	#0
	jp 	z, fin_div
	ld 	a, 	b 		; A = RESULT
	add a,	#1		; A = A+1
	ld 	b, 	a
	ld 	a, 	d
	cp 	#0
	jp	nz, divide
fin_div:
ld 	a, 	b
ret