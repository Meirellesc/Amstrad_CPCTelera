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

.area _DATA
.area _CODE

.include "player.h.s"
.include "bullet.h.s"
.include "cpctelera.h.s"
.include "keyboard.s"
.include "state.h.s"
.include "score.h.s"

.globl _sprite_nave
.globl _sprite_disparo

;;=================================================
;;=================================================
;;	PLAYER VARIABLES
;;=================================================
;;=================================================

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

defineEntity player, 10, 10, 10, 80, 80, 80, 8, 16, _sprite_nave
defineEntity disparo, 10, 10, 10, 80, 80, 80, 2, 4, _sprite_disparo


;; Player variables
salto: 		.db #-1
saltoDown: 	.db #-1
shooting:	.db #00
puntuacion:	.db #0
vidas:		.db #10

;; Jump Table
jumptable:
	.db #-10, #-10, #-8, #-8, #-7, #-7, #-6, #-6, #-4, #-4, #-3, #-3, #-2, #-2, #00, #00
	.db #00, #00, #02, #02, #03, #03, #04, #04, #06, #06, #07, #07, #08, #08, #10, #10
	.db #0x80

;;=================================================
;;=================================================
;;	PLAYER PUBLIC FUNCTIONS
;;=================================================
;;=================================================
player_erase::
	ld 	ix, #player_data
	ld   	a, #0x00		;; Colour for drawPlayer is 00
	call 	erasePlayer	;; Erase player
ret

player_update::
	ld 	ix, #player_data
	call 	jumpControl	;; Control jump
	call 	jumpControlDown	;; Control jump down
	call 	checkUserInput 	;; Check keyboard input

ret

player_draw::
	ld 	ix, #player_data
	call 	updateVar
	call	drawPlayer		;; Draw player
ret

player_reset::
	ld a, #10
	ld (vidas), a
	ld a, #0x00
	ld (#0xC000), a
	ld (#0xC001), a
	ld a, #-1
	ld (salto), a
	ld (saltoDown), a
	ld a, #00
	ld (shooting), a
	ld a, #0
	ld (puntuacion), a
	ld a, #10
	ld (player_x), a
	ld a, #80
	ld (player_y), a
ret

decLives::
	call decreaseLives
	ld	a, (vidas)
	dec	a
	ld	(vidas), a
	jr	z, gameOver
	jr 	cont
	
	gameOver:
		call ModifyCurrentState
		ld a, #0xF0
		ld (#0xC000), a
		ld (#0xC001), a

	cont:
	ret

;;=================================================
;;=================================================
;;	PLAYER PRIVATE FUNCTIONS
;;=================================================
;;=================================================
;;===============================
;; Update the player variables for the doble buffer
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

;;=================================================
;;	Get screen position
;;	DESTROYS: de, a, c, b, hl
;;=================================================
getScreenPos:
	;; Input Parameters
	;; DE - Pointer to the start of the screen memory
	;; x  - column
	;; y  - row
	;; Draw a box
	;ld	de, #0xC000			;; Pointer to the start of the screen memory
	ld  a, Ent_x(ix)	;; |
	ld  c, a		;; C = obs_x
	ld  a, Ent_y(ix)	;; |
	ld  b, a		;; B = obs_y
	call	cpct_getScreenPtr_asm
	ex	de, hl				;; de points to screen position
ret

getScreenPosErase:
	ld  a, Ent_x3(ix)	;; |
	ld  c, a		;; C = obs_x
	ld  a, Ent_y3(ix)	;; |
	ld  b, a		;; B = obs_y
	call	cpct_getScreenPtr_asm
	ex	de, hl				;; de points to screen position
ret

;;=================================================
;;	Draw the player
;;	INPUT: A: Colour
;;	DESTROYS: AF, BC, DE, HL
;;=================================================
drawPlayer:

	call getScreenPos
	
	ld  c, Ent_w(ix)	;; C = Entity_w
	ld  b, Ent_h(ix)	;; B = Entity_h
	ld  h, Ent_sprite_h(ix)	;; H = Entity_Sprite_h
	ld  l, Ent_sprite_w(ix)	;; B = Entity_Sprite_w
	call cpct_drawSprite_asm
	ret

ret

erasePlayer:
	push	af

	call getScreenPosErase
	pop	af

	ld  c, Ent_w(ix)	;; C = Entity_w
	ld  b, Ent_h(ix)	;; B = Entity_h
	
	call cpct_drawSolidBox_asm

ret

;;=================================================
;;	Check keyboard input
;;	DESTROYS: AF, BC, DE, HL
;;=================================================
checkUserInput:
	;; Scan keyboard
	call cpct_scanKeyboard_asm

	;; Check for W Key pressed
	;; INPUT: HL contains key 16-bit value
	ld 	hl, #Key_W	;; HL = Key_W Keycode
	call 	cpct_isKeyPressed_asm
	cp	#0
	jr	z, W_not_pressed

		;; W is pressed
		call startJump

	W_not_pressed:
	;; Check for S Key pressed
	;; INPUT: HL contains key 16-bit value
	ld 	hl, #Key_S	;; HL = Key_W Keycode
	call 	cpct_isKeyPressed_asm
	cp	#0
	jr	z, S_not_pressed

		;; W is pressed
		call startJumpDown

	S_not_pressed:
	;; Check for D Key pressed
	;; INPUT: HL contains key 16-bit value
	ld 	hl, #Key_D	;; HL = Key_W Keycode
	call 	cpct_isKeyPressed_asm
	cp	#0
	jr	z, D_not_pressed

		;; W is pressed
		ld  ix, #player_data
		ld  h, Ent_x(ix)
		ld  l, Ent_y(ix)
		ld  ix, #disparo_data
		call shoot

	D_not_pressed:
ret

;;=================================================
;;	Control jump movement
;;	DESTROYS:
;;=================================================
jumpControl:
	;; Check if we are already jumping
	ld	a, (salto)	;; A = salto state
	cp 	#-1		;; Checks if A == -1
	ret	z		;; If A == -1, doesn't jump

	;; Get jump value from jumptable
	ld	hl, #jumptable	;; HL points to the start of jumptable
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC

	;; Check end of jump
	ld	a, (hl)		;; A = jump movement
	cp	#0x80		;; Jump value == 0, stop jump
	jr	z, end_of_jump	;; If 0x80, end of jump

	;; Move player
	ld	b, a		;; B = jump movement
	ld	a, Ent_y(ix)	;; A = pos_y
	add	b		;; A += B (Add jump movement)
	ld 	Ent_y(ix), a	;; Update pos_y value

	;; Increment jumptable index
	ld	a, (salto)	;; A = salto
	inc	a		;; 
	ld 	(salto), a	;; salto++
ret
	;; Put -1 in jump index when jump ends
	end_of_jump:
		ld	a, #-1		;; a = -1
		ld	(salto), a	;; salto (index) = -1
	ret

;;=================================================
;;	Control jump down movement
;;	DESTROYS:
;;=================================================
jumpControlDown:
	;; Check if we are already jumping
	ld	a, (saltoDown)	;; A = salto state
	cp 	#-1		;; Checks if A == -1
	ret	z		;; If A == -1, doesn't jump

	;; Get jump value from jumptable
	ld	hl, #jumptable	;; HL points to the start of jumptable
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC

	;; Check end of jump
	ld	a, (hl)		;; A = jump movement
	cp	#0x80		;; Jump value == 0, stop jump
	jr	z, end_of_jumpDown	;; If 0x80, end of jump

	;; Move player
	ld	b, a		;; B = jump movement
	ld	a, Ent_y(ix)	;; A = pos_y
	sub	b		;; A += B (Add jump movement)
	ld 	Ent_y(ix), a	;; Update pos_y value

	;; Increment jumptable index
	ld	a, (saltoDown)	;; A = salto
	inc	a		;; 
	ld 	(saltoDown), a	;; salto++
ret
	;; Put -1 in jump index when jump ends
	end_of_jumpDown:
		ld	a, #-1		;; a = -1
		ld	(saltoDown), a	;; salto (index) = -1
	ret

;;=================================================
;;	Starts jump
;;	DESTROYS:
;;=================================================
startJump:
	;; Check if jump is active
	ld	a, (salto)	;; A = salto
	cp	#-1		;; Is jump active?
	ret 	nz		;; Jump active, return

	;; Check if jump down is active
	ld	a, (saltoDown)	;; A = salto
	cp	#-1		;; Is jump active?
	ret 	nz		;; Jump active, return

	;; Jump is inactive, start jumping
	ld	a, #0
	ld	(salto), a	
ret

;;=================================================
;;	Starts jump down
;;	DESTROYS:
;;=================================================
startJumpDown:
	;; Check if jump is active
	ld	a, (salto)	;; A = salto
	cp	#-1		;; Is jump active?
	ret 	nz		;; Jump active, return

	;; Check if jump down is active
	ld	a, (saltoDown)	;; A = salto
	cp	#-1		;; Is jump active?
	ret 	nz		;; Jump active, return

	;; Jump is inactive, start jumping
	ld	a, #0
	ld	(saltoDown), a	
ret

;;=================================================
;;	Shoot bullet
;;	DESTROYS:
;;=================================================
shoot:
	ld	a, (shooting)	;; A = shooting
	cp	#01		;; Is player already shooting?
	ret	z		;; Shooting, return

	;; Not shooting
	ld  	a, h			;; Pos player_x
	add	#2			;; Le sumamos un offset
	ld	Ent_x(ix), a		;; Bullet_x_position = player_x_position + 10
	ld  	a, l			;; Pos player_y
	add	#4			;; Le sumamos un offset
	ld	Ent_y(ix), a		;; Bullet_y_position = player_y_position
	ld	a, #01
	ld	(shooting), a		;; Shoot
ret











;;=================================================
;;=================================================
;;	BULLET VARIABLES
;;=================================================
;;=================================================



;;=================================================
;;=================================================
;;	BULLET PUBLIC FUNCTIONS
;;=================================================
;;=================================================
bullet_erase:
	ld 	ix, #disparo_data
	ld   	a, #0x00	;; Colour for drawBullet is 00
	call 	eraseBullet	;; Erase bullet
ret

bullet_draw:
	ld 	ix, #disparo_data
	call 	updateVar
	call 	drawBullet		;; Draw bullet
ret

;;===============================
;; Gets a pointer to bullet data in HL
;; DESTROY: HL
;; RETURN: HL -> Pointer to hero data
;;===============================
bullet_getPtrHL::
	ld 	hl, #disparo_data		;; HL points to the hero data
	ret

;;=================================================
;;	Draw bullet
;;	DESTROYS: 
;;=================================================
resetBullet::
	ld	a, #00
	ld	(shooting), a	;; Stop shooting
	ld	a, (puntuacion)	;; The bullet impacts with an enemy
	inc	a		;; The player puntuation increase
	ld 	(puntuacion), a
	ret

;;=================================================
;;=================================================
;;	BULLET PRIVATE FUNCTIONS
;;=================================================
;;=================================================

;;=================================================
;;	Draw bullet
;;	DESTROYS: 
;;=================================================
drawBullet:
	ld	a, (shooting)		;; A = shooting state
	cp	#00			;; Is player NOT shooting?
	jr	z, return	;; Not shooting, return
		
	;; Get bullet position			
	call getScreenPos
	
	;; Increment bullet x position
	ld  	a, Ent_x(ix)		;; A = bullet x position
	cp	#80-2			;; Check against right limit
	jr	z, destroy_bullet	;; Destroy bullet

		;; Move bullet right
		;push af
		
		;pop af

		;; Draw a Box
		ld  c, Ent_w(ix)	;; C = Entity_w
		ld  b, Ent_h(ix)	;; B = Entity_h
		ld  h, Ent_sprite_h(ix)	;; H = Entity_Sprite_h
		ld  l, Ent_sprite_w(ix)	;; B = Entity_Sprite_w
		call 	cpct_drawSprite_asm
	return:
	ret
	destroy_bullet:
		;pop af
		ld	a, #00
		ld	(shooting), a	;; Stop shooting
	ret


eraseBullet:
	;; Get bullet position
	call getScreenPosErase
	
	ld  	a, Ent_x(ix)
	inc	a
	inc	a
	ld	Ent_x(ix), a	;; bullet x position ++

	;; Draw a Box
	ld  a, #00
	ld  c, Ent_w(ix)	;; C = Entity_w
	ld  b, Ent_h(ix)	;; B = Entity_h
	call 	cpct_drawSolidBox_asm

	ret
