;|0x00	0
;|0x04	1
;|0x08 	2
;|0x0C 	3
;|0x10 	4
;|0x14
;|0x18
;|0x1C
;|0x20
;|0x24
;|0x28 	10
;|0x2C
;|0x30
;|0x34
;|0x38
;|0x3C 	15
;|0x40
;|0x44
;|0x48
;|0x4C
;|0x50 	20
;|0x54
;|0x58
;|0x5C
;|0x60 
;|0x64 	25
;|0x68
;|0x6C
;|0x70
;|0x74
;|0x78 	30
;|0x7C
;|0x80
;|0x84
;|0x88
;|0x8C 	35
;|0x90
;|0x94
;|0x98
;|0x9C
;|0xA0 	40
;|0xA4
;|0xA8
;|0xAC
;|0xB0
;|0xB4 	46
;|0xB8
;|0xBC
;|0xC0
;|0xC4
;|0xC8 	50

.include "load_level.h.s"
.include "platform.h.s"
.include "objects.h.s"
.include "enemy.h.s"
.include "entity.h.s"
.include "main.h.s"

n_plat: 	.db	#0
n_enem: 	.db	#0
hero_x:		.db #0
hero_y:		.db #0

;/////////////////////////////////////////////////////////////////
; 					LEVEL 			0
;/////////////////////////////////////////////////////////////////
load_level0:
ld 	a, 	#6
ld 	(n_plat), 	a
ld 	a, 	#0
ld 	(n_enem), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 	#0xA8
ld 	(hero_y), 	a
ld 	e_y(ix), 	a

ld ix, 	#platform_datas	;;
ld 	a, 	#0x00
ld 	b, 	#0xB8
ld 	c, 	#0x16
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data
ld 	a, 	#0x3E
ld 	b, 	#0xB8
ld 	c, 	#0x12
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data2
ld 	a, 	#0x20
ld 	b, 	#0x98
ld 	c, 	#0x1E
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#0x00
ld 	b, 	#0x78
ld 	c, 	#0x16
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#0x20
ld 	b, 	#0x58
ld 	c, 	#0x16
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data5
ld 	a, 	#0x3E
ld 	b, 	#0x38
ld 	c, 	#0x12
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data6
ld 	a, 	#62
ld 	b, 	#56
ld 	c, 	#18
ld 	d, 	#12
call cargar_plataforma

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
ld ix, 	#llave
ld 	a, 	#0x4A
ld 	b, 	#0xA8
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#0x48
ld 	b, 	#0x28
ld 	c, 	#0
call cargar_objetos

ret

;/////////////////////////////////////////////////////////////////
; 					LEVEL 			1
;/////////////////////////////////////////////////////////////////
load_level1:
ld 	a, 	#5
ld 	(n_plat), 	a

ld 	a, 	#1
ld 	(n_enem), 	a
ld 	a, 	#1
ld 	(init_enemy), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 	#0xA8
ld 	(hero_y),	a
ld 	e_y(ix), 	a

ld ix, 	#platform_datas
ld 	a, 	#0x00
ld 	b, 	#0xB8
ld 	c, 	#0x50
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data
ld 	a, 	#0x32
ld 	b, 	#0x98
ld 	c, 	#0x1E
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data2
ld 	a, 	#0x1A
ld 	b, 	#0x80
ld 	c, 	#0x12
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#0x32
ld 	b, 	#0x64
ld 	c, 	#0x0C
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#0x00
ld 	b, 	#0x50
ld 	c, 	#0x2A
ld 	d, 	#0x0C
call cargar_plataforma

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
ld ix, 	#llave
ld 	a, 	#0x48
ld 	b, 	#0x2C
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#0x00
ld 	b, 	#0xA8
ld 	c, 	#0
call cargar_objetos

;/////////////////// ENEMY
ld 	ix, 	#enemy_data0
ld 	a, 	#0x3E
ld  b, 	#0xA8
ld 	c, 	#0x03
call 	cargar_enemigo

ret



;/////////////////////////////////////////////////////////////////
; 					LEVEL 			2
;/////////////////////////////////////////////////////////////////
load_level2:

ld 	a, 	#6
ld 	(n_plat), 	a
ld 	a, 	#0
ld 	(n_enem), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 		#0xA8
ld 	(hero_y), 	a
ld 	e_y(ix), 	a

ld ix, 	#platform_datas
ld 	a, 	#0
ld 	b, 	#184
ld 	c, 	#18
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data
ld 	a, 	#34
ld 	b, 	#184
ld 	c, 	#18
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data2
ld 	a, 	#68
ld 	b, 	#184
ld 	c, 	#12
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#0
ld 	b, 	#148
ld 	c, 	#12
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#0
ld 	b, 	#112
ld 	c, 	#6
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data5
ld 	a, 	#40
ld 	b, 	#124
ld 	c, 	#6
ld 	d, 	#72
call cargar_plataforma


; OBJETOS
ld ix, 	#llave
ld 	a, 	#0
ld 	b, 	#96
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#68
ld 	b, 	#168
ld 	c, 	#0
call cargar_objetos

ld ix, 	#bala
ld 	a, 	#0x40
ld 	b, 	#0x6F
ld 	c, 	#1
call cargar_objetos

ret



;/////////////////////////////////////////////////////////////////
; 					LEVEL 			3   ;;reutlizando lvl 1
;/////////////////////////////////////////////////////////////////
load_level3:
ld 	a, 	#5
ld 	(n_plat), 	a

ld 	a, 	#2
ld 	(n_enem), 	a
ld 	a, 	#1
ld 	(init_enemy), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 	#0xA8
ld 	(hero_y),	a
ld 	e_y(ix), 	a

ld ix, 	#platform_datas
ld 	a, 	#0x00
ld 	b, 	#0xB8
ld 	c, 	#0x50
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data
ld 	a, 	#0x32
ld 	b, 	#0x98
ld 	c, 	#0x1E
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data2
ld 	a, 	#0x1A
ld 	b, 	#0x80
ld 	c, 	#0x12
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#0x32
ld 	b, 	#0x64
ld 	c, 	#0x0C
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#0x00
ld 	b, 	#0x50
ld 	c, 	#0x2A
ld 	d, 	#0x0C
call cargar_plataforma

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
ld ix, 	#llave
ld 	a, 	#0x02
ld 	b, 	#0x38
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#0x00
ld 	b, 	#0xA8
ld 	c, 	#0
call cargar_objetos

;/////////////////// ENEMY
ld 	ix, 	#enemy_data0
ld 	a, 	#0x3E
ld  b, 	#0xA8
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data1
ld 	a, 	#0x10
ld  b, 	#0x40
ld 	c, 	#0x03
call 	cargar_enemigo


ret




;/////////////////////////////////////////////////////////////////
; 					LEVEL 			8
;/////////////////////////////////////////////////////////////////

load_level8:

ld 	a, 	#12
ld 	(n_plat), 	a
ld 	a, 	#1
ld 	(n_enem), 	a
ld 	a, 	#1
ld 	(init_enemy), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 	#0xA8
ld 	(hero_y),	a
ld 	e_y(ix), 	a

ld ix, 	#platform_datas
ld 	a, 	#0
ld 	b, 	#184
ld 	c, 	#12
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data
ld 	a, 	#12
ld 	b, 	#164
ld 	c, 	#2
ld 	d, 	#8
call cargar_plataforma

ld ix, 	#platform_data2
ld 	a, 	#24
ld 	b, 	#164
ld 	c, 	#2
ld 	d, 	#8
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#36
ld 	b, 	#164
ld 	c, 	#2
ld 	d, 	#8
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#48
ld 	b, 	#164
ld 	c, 	#2
ld 	d, 	#8
call cargar_plataforma

ld ix, 	#platform_data5
ld 	a, 	#60
ld 	b, 	#164
ld 	c, 	#2
ld 	d, 	#8
call cargar_plataforma


ld ix, 	#platform_data6
ld 	a, 	#68
ld 	b, 	#160
ld 	c, 	#12
ld 	d, 	#12
call cargar_plataforma


ld ix, 	#platform_data7
ld 	a, 	#74
ld 	b, 	#132
ld 	c, 	#6
ld 	d, 	#8
call cargar_plataforma


ld ix, 	#platform_data8
ld 	a, 	#0
ld 	b, 	#120
ld 	c, 	#66
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data9
ld 	a, 	#0
ld 	b, 	#88
ld 	c, 	#6
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data10
ld 	a, 	#6
ld 	b, 	#64
ld 	c, 	#6
ld 	d, 	#12
call cargar_plataforma

ld ix, 	#platform_data11
ld 	a, 	#20
ld 	b, 	#52
ld 	c, 	#60
ld 	d, 	#8
call cargar_plataforma



; OBJETOS
ld ix, 	#llave
ld 	a, 	#72
ld 	b, 	#36
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#0
ld 	b, 	#168
ld 	c, 	#0
call cargar_objetos

ld ix, 	#bala
ld 	a, 	#0x40
ld 	b, 	#0x6C
ld 	c, 	#1
call cargar_objetos


;/////////////////// ENEMY
ld 	ix, 	#enemy_data0
ld 	a, 	#0
ld  b, 	#104
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data1
ld 	a, 	#0x02
ld  b, 	#0x2C
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data2
ld 	a, 	#0x12
ld  b, 	#0x46
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data3
ld 	a, 	#0x26
ld  b, 	#0x56
ld 	c, 	#0x03
call 	cargar_enemigo

ret

;/////////////////////////////////////////////////////////////////
; 					LEVEL 			9
;/////////////////////////////////////////////////////////////////
load_level9:
ld 	a, 	#9
ld 	(n_plat), 	a
ld 	a, 	#0
ld 	(n_enem), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 	#0x34
ld 	(hero_y), 	a
ld 	e_y(ix), 	a

;;las de 2
ld ix, 	#platform_datas	;;
ld 	a, 	#0
ld 	b, 	#80
ld 	c, 	#12
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data	;;
ld 	a, 	#68
ld 	b, 	#108
ld 	c, 	#12
ld 	d, 	#0x0C
call cargar_plataforma


ld ix, 	#platform_data2	;;
ld 	a, 	#26
ld 	b, 	#64
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#0
ld 	b, 	#160
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#20
ld 	b, 	#132
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data5
ld 	a, 	#20
ld 	b, 	#184
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data6
ld 	a, 	#46
ld 	b, 	#120
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data7
ld 	a, 	#46
ld 	b, 	#184
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data8
ld 	a, 	#74
ld 	b, 	#184
ld 	c, 	#6
ld 	d, 	#0x0C
call cargar_plataforma

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
ld ix, 	#llave
ld 	a, 	#0x4A
ld 	b, 	#0xA8
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#70
ld 	b, 	#92
ld 	c, 	#0
call cargar_objetos

ld ix, 	#bala
ld 	a, 	#26
ld 	b, 	#48
ld 	c, 	#1
call cargar_objetos

ret


;/////////////////////////////////////////////////////////////////
; 					LEVEL 			10
;/////////////////////////////////////////////////////////////////

load_level10:
ld 	a, 	#5
ld 	(n_plat), 	a

ld 	a, 	#4
ld 	(n_enem), 	a
ld 	a, 	#1
ld 	(init_enemy), 	a

ld 	ix, #hero_data   	;; INICIALIZA HEROE
ld 	a, 	#0x01
ld 	(hero_x), 	a
ld 	e_x(ix), 	a
ld 	a, 	#0xA8
ld 	(hero_y), 	a
ld 	e_y(ix), 	a

ld ix, 	#platform_datas	;;
ld 	a, 	#0x00
ld 	b, 	#0xB8
ld 	c, 	#0x4C
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data
ld 	a, 	#0x00
ld 	b, 	#0x98
ld 	c, 	#0x40
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data2
ld 	a, 	#0x10
ld 	b, 	#0x78
ld 	c, 	#0x4E
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data3
ld 	a, 	#0x00
ld 	b, 	#0x58
ld 	c, 	#0x40
ld 	d, 	#0x0C
call cargar_plataforma

ld ix, 	#platform_data4
ld 	a, 	#0x20
ld 	b, 	#0x38
ld 	c, 	#0x4E
ld 	d, 	#0x0C
call cargar_plataforma

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJETOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ld ix, 	#llave
ld 	a, 	#0x4A
ld 	b, 	#80
ld 	c, 	#1
call cargar_objetos

ld ix, 	#puerta
ld 	a, 	#0x48
ld 	b, 	#0x28
ld 	c, 	#0
call cargar_objetos


;/////////////////// ENEMY
ld 	ix, 	#enemy_data0
ld 	a, 	#0x30
ld  b, 	#168
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data1
ld 	a, 	#0x12
ld  b, 	#136
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data2
ld 	a, 	#0x30
ld  b, 	#104
ld 	c, 	#0x03
call 	cargar_enemigo

ld 	ix, 	#enemy_data3
ld 	a, 	#0x12
ld  b, 	#72
ld 	c, 	#0x03
call 	cargar_enemigo


ret

cargar_plataforma:

ld 	p_x(ix), 	a
ld 	p_y(ix), 	b
ld 	p_w(ix), 	c
ld 	p_h(ix), 	d

ret

cargar_objetos:

ld 	obj_x(ix), 	a
ld 	obj_y(ix), 	b
ld 	obj_open(ix), 	c
ret

cargar_enemigo:
ld 	en_x(ix),		a 	
ld 	en_y(ix),		b
ld 	en_life(ix),	c
ret