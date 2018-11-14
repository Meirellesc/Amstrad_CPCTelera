;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;												      ;;
;;	TOJO: EARTH DEFENDER is a videogame created for the CPC Amstrad computer.		      ;;
;;												      ;;
;;	Copyright (C) 2017  Jorge Garcia Valera, Thomás Cafaro Fernandez & Marta Tirado Asencio	      ;;
;;												      ;;
;;	       This program is free software: you can redistribute it and/or modify		      ;;
;;	    it under the terms of the GNU Affero General Public License as published by		      ;;
;;	       the Free Software Foundation, either version 3 of the License, or		      ;;
;;			      (at your option) any later version.				      ;;
;;												      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _CODE

.include "cpctelera.h.s"
.include "bullet.h.s"
.include "player.h.s"
.include "score.h.s"

.globl _sprite_enemigo

;;==================================
;;==================================
;; PRIVATE DATA
;;==================================
;;==================================

.equ Ent_x, 0
.equ Ent_x2, 1
.equ Ent_x3, 2
.equ Ent_y, 3
.equ Ent_y2, 4
.equ Ent_y3, 5
.equ Ent_w, 6
.equ Ent_h, 7
.equ Ent_sprite_w, 8
.equ Ent_sprite_h, 9

seed: .db #0

;; LOS ENEMIGOS TIENE QUE IR DESDE LA LINEA 0 HASTA LA LINEA 200-16
.macro defineEntity name, x1, x2, x3, y1, y2, y3, w, h, sprite
name'_data:
	name'_x: .db #x1, #x2, #x3
	name'_y: .db #y1, #y2, #y3
	name'_w: .db #w
	name'_h: .db #h
	name'_sprite: .dw sprite
.endm

defineEntity enemy0, 80-8, 80-8, 80-8, 100, 100, 100, 8, 16, _sprite_enemigo

;;==================================
;;==================================
;; PUBLIC FUNCTIONS
;;==================================
;;==================================

enemy_reset::
	ld a, #72
	ld (enemy0_x), a
	ld a, #100
	ld (enemy0_y), a
;;	ld a, #72
;;	ld (enemy1_x), a
;;	ld a, #100
;;	ld (enemy1_y), a
;;	ld a, #72
;;	ld (enemy2_x), a
;;	ld a, #100
;;	ld (enemy2_y), a
ret

;;===============================
;; Erase the enemies
;; DESTROY: AF, BC, HL
;;===============================
enemies_erase::
	ld 	ix, #enemy0_data	;; ix points to the data of enemy0
	ld 	a, #0x00
	call 	eraseEnemies	;; Draw obstacle
	ret

;;===============================
;; Update the enemies
;; DESTROY: AF, BC, HL
;;===============================
enemies_update::
	;; Move obstacle to the left
	ld  ix, #enemy0_data	;; ix points to the data
	ld  a, Ent_x(ix)	;; |
	dec a			;; | Obs_x --
	jr  nz, not_restart_x	;; If (Obs_x != 0) then not restart x

		;; Restart obs_x when it is 0
		call decLives	;; The enemy arrives to the left, so the player lose one life
		call random
		ld Ent_y(ix), a
		ld  a, #80-8	;; A = obs_a = #80

	not_restart_x:
	ld Ent_x(ix), a		;; | Update obs_x

	ret

;;===============================
;; Draw the enemies
;; DESTROY: AF, BC, HL
;;===============================
enemies_draw::
	ld 	ix, #enemy0_data	;; ix points to the data
	call 	updateVar
	call 	drawEnemies
	ret

;;===============================
;; Update the enemy variables for the doble buffer
;;===============================
updateVar:
	;; --- Atualizamos las x ---
	ld	a, Ent_x2(ix)
	ld	Ent_x3(ix), a

	ld	a, Ent_x(ix)
	ld	Ent_x2(ix), a

	;; --- Atualizamos las y ---
	ld	a, Ent_y2(ix)
	ld	Ent_y3(ix), a

	ld	a, Ent_y(ix)
	ld	Ent_y2(ix), a
	ret

;;===============================
;; Check collision between obstacle and other entity
;; INPUT: HL -> points to the other entity with
;; RETURN: xxxxxx
;;===============================
enemies_checkCollision::
	ld	ix, #enemy0_data
	;;
	;; if((enemy_x + enemy_w) <= bullet_x) no_collision
	;;
	;; (enemy_x + enemy_w) - bullet_x <= 0
	ld  a, Ent_x(ix)	;; | enemy_x
	ld  c, a		;; | +
	ld  a, Ent_w(ix)	;; | enemy_w
	add c			;; -
	sub (hl)		;; bullet_x
	jr  z, no_collision	;; if(<= 0)
	jp  m, no_collision	;; then no_collision
	;;
	;; if(bullet_x + bullet_w <= enemy_x) no_collision
	;;
	;; bullet_x + bullet_w - enemy_x <= 0
	ld  a, (hl)		;; bullet_ x
	inc hl			;; +
	inc hl			;; +
	inc hl			;; +
	inc hl			;; +
	inc hl			;; +
	inc hl			;; apuntamos a bullet_w
	add (hl)		;; bullet_w
	ld  c, a		
	ld  a, Ent_x(ix)		
	ld  b, a
	ld  a, c
	sub b			;; bullet_x + bullet_w - enemy_x
	jr  z, no_collision	;; if(<= 0)
	jp  m, no_collision	;; then no_collision
	
	;;
	;; if((enemy_x + enemy_w) <= bullet_y) no_collision
	;;
	;; (enemy_x + enemy_w) - bullet_y <= 0
	ld  a, Ent_y(ix)	;; | enemy_x
	ld  c, a		;; | +
	ld  a, Ent_h(ix)	;; | enemy_w
	add c			;; -
	dec hl	
	dec hl	
	dec hl			;; apuntamos a bullet_y	
	sub (hl)		;; bullet_y
	jr  z, no_collision	;; if(<= 0)
	jp  m, no_collision	;; then no_collision
	;;
	;; if(bullet_y + bullet_h <= enemy_y) no_collision
	;;
	;; bullet_y + bullet_h - enemy_y <= 0
	ld  a, (hl)		;; bullet_y
	inc hl			;; +
	inc hl			;; +
	inc hl			;; +
	inc hl			;; apuntamos a bullet_h
	add (hl)		;; bullet_h
	ld  c, a		
	ld  a, Ent_y(ix)		
	ld  b, a
	ld  a, c
	sub b			;; bullet_y + bullet_h - enemy_y
	jr  z, no_collision	;; if(<= 0)
	jp  m, no_collision	;; then no_collision

	;; Collision
	call increaseScore
	call resetEnemy
	call resetBullet
	ret

	;; No collision
	no_collision:
	ret

;;==================================
;;==================================
;; PRIVATE FUNCTIONS
;;==================================
;;==================================

;;===============================
;; Eeset the enemies
;; INPUT: A -> Colour pattern
;; DESTROY: AF, BC, DE, HL
;;===============================
resetEnemy:
	ld a, #80-8
	ld Ent_x(ix), a
	call random
	ld Ent_y(ix), a
	ret

;;===============================
;; Draw the enemies
;; DESTROY: AF, BC, DE, HL
;;===============================
drawEnemies:
	;; Calculate screen position
	;ld de, #0xC000		;;Video memory pointer
	ld  a, Ent_x(ix)	;; |
	ld  c, a		;; C = obs_x
	ld  a, Ent_y(ix)	;; |
	ld  b, a		;; B = obs_y
	call cpct_getScreenPtr_asm
	ex	de, hl				;; de points to screen position

	;;Draw a box
	ld  c, Ent_w(ix)	;; C = Entity_w
	ld  b, Ent_h(ix)	;; B = Entity_h
	ld  h, Ent_sprite_h(ix)	;; H = Entity_Sprite_h
	ld  l, Ent_sprite_w(ix)	;; B = Entity_Sprite_w
	call cpct_drawSprite_asm
	ret

eraseEnemies:
	;; Calculate screen position
	push af
	;ld de, #0xC000		;;Video memory pointer
	ld  a, Ent_x3(ix)	;; |
	ld  c, a		;; C = obs_x
	ld  a, Ent_y3(ix)	;; |
	ld  b, a		;; B = obs_y
	call cpct_getScreenPtr_asm
	ex	de, hl				;; de points to screen position
	
	;;Draw a box
	pop af
	ld  c, Ent_w(ix)	;; C = Entity_w
	ld  b, Ent_h(ix)	;; B = Entity_h
	call cpct_drawSolidBox_asm
	ret

;; ===========================================
;; GENERA UN NUMERO RANDOM DE 8 BITS
;; ===========================================
rand8:
	ld	a, (seed)	; Seed is usually 0
	ld	b,a
	add	a
	add	a
	add	b
	inc	a		; another possibility is ADD A,7
	ld	(seed),a
	ret

;; ===========================================
;; CREA UN NUMERO RANDOM DENTRO DEL RANGO 0 - (200-16)
;; OUTPUT -> El numero random se guarda en A
;; ===========================================
random:
	call rand8
	ld l,a
	ld h, #0
	ld bc, #168-0		;;valor+alto - valor+bajo
	mod_loop:
	or a
	sbc hl,bc
	jp p,mod_loop
	add hl,bc
	ld bc, #0
	add hl,bc
	ld a,l
	ret