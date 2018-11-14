.include "cpctelera.h.s"
.include "colision.h.s"
.include "main.h.s"
.include "entity.h.s"
.include "platform.h.s"

colision:       	.db #-1
colision_borde: 	.db #-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INPUTS -> IX, IY
;; OUTPUTS ->
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

colision_check:

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			X			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; if	(disparo_x + disparo_w - enemy_x <= 0)

ld 	a,	0(ix)
add	4(ix)
sub	0(iy)

jp	m,	no_colision

;; if	(enemy_x + enemy_w - disparo_x <= 0)

ld 	a,	0(iy)
add	4(iy)
sub	0(ix)

jp	m,	no_colision


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			Y			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

ld 	a, 1(iy)
add	5(iy)
sub	1(ix)

jp	m,	no_colision


ld 	a, 	1(ix)		
add 5(ix)
sub	1(iy)

jp	m,	no_colision

;;COLISION
ld a, #1
ld (colision), a
ret

no_colision:
	ld	a, 	#-1
	ld (colision), a

ret


colision_check_ex:

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			X			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; if	(disparo_x + disparo_w - enemy_x <= 0)

ld 	a,	0(iy)
add	4(iy)
sub	0(ix)

jp	m,	no_colision_ex

;; if	(enemy_x + enemy_w - disparo_x <= 0)

ld 	a,	0(ix)
add	2(ix)
sub	0(iy)

jp	m,	no_colision_ex


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			Y			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

ld 	a, 1(ix)
add	3(ix)
sub	1(iy)

jp	m,	no_colision_ex


ld 	a, 	1(iy)		
add 5(iy)
sub	1(ix)

jp	m,	no_colision_ex

;;COLISION
ld a, #1
ld (colision), a
ret

no_colision_ex:
	ld	a, 	#-1
	ld (colision), a

ret




colision_check_border:


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			Y			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

ld 	a, 1(iy)
add	5(iy)
sub	1(ix)

jp	m,	no_colision_border


ld 	a, 	1(ix)		
add 5(ix)
sub #2
sub	1(iy)

jp	m,	no_colision_border
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HAY COLISION  Y
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ld 	a, 	0(iy)
sub 	0(ix)
jp 	m, noSalta

jp compBorde

noSalta:
ld a, 	0(ix)
add		4(ix)
sub 	0(iy)
sub 	4(iy)
jp 	m, noMueve


;;;;;;;;;;BORDE
compBorde:
ld 	a,	0(iy)		;; X PLAT
sub #1
sub 	0(ix)		;; -X HERO
sub 	4(ix) 		;; -W HERO
jp 	m, choque_izq	

jp no_colision_border

choque_izq:
ld 	a, 	0(ix)
sub 	0(iy)
jp 	m, chocaIZQ


ld 	a,	0(ix)		;; X HERO
sub #1
sub 	0(iy)		;; -X PLAT
sub 	4(iy) 		;; -W PLAT
jp 	m, choque_der	


jp no_colision_border

noMueve:
ld 	a, 	#3
ld 	(colision_borde), 	a
ld 	a, 	#-1						;;     PARA QUE COLISIONE Y NO SUBA
ld 	(hero_jump), 	a
;ld 	a, 	e_y(ix)
;ld 	e_y(ix), 	a

call 	plat_checkAll
ret

choque_der:
ld 	a, 	0(iy)
add a,	4(iy)
sub a,	0(ix)
sub a,	4(ix)

jp 	m, chocaDER

jp no_colision_border

chocaIZQ:

	ld 	a, 	#1
	ld 	(colision_borde), 	a

ret

chocaDER:

	ld 	a, 	#2
	ld 	(colision_borde), 	a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			X			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

no_colision_border:
ld 	a, 	#-1
ld 	(colision_borde), 	a
ret


colision_enemy_platform:

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			Y			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

ld 	a, 1(iy)
add	5(iy)
sub	1(ix)




jp		m,		no_colision_enemy

ld 		a, 	1(ix)		
add 	5(ix)
sub		1(iy)
jp		m,		no_colision_enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HAY COLISION  Y
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ld 	a, 	0(iy)			;; Y = ENEMY 	X = PLATFORM
add 	#1
sub 	0(ix)

jp 		m, 		no_colision_enemy


ld 	a, 	0(ix)
add 	4(ix)
sub 	#1
sub 	0(iy)
sub 	4(iy)
jp 		m, 		no_colision_enemy

ld 	a, 	#1
ld 	11(iy), 	a
ret

no_colision_enemy:

ld 	a, 	#-1
ld 	11(iy), 	a
ret
