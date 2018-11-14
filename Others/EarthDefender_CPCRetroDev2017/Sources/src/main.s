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

.include "cpctelera.h.s"
.include "enemies.h.s"
.include "player.h.s"
.include "bullet.h.s"
.include "video.h.s"
.include "state.h.s"
.include "score.h.s"

.globl _sprite_palette
.globl _song_ingame
.globl _go_start
.globl _init_gameoverChiquitin

menu_erased: .db #00
points_shown: .db #00
score_drawn: .db #00

initialize:
	call 	cpct_disableFirmware_asm ;;deshabilitamos le Firware

	ld    	c, #0                 ;;Ponemos en C un 0
	call  	cpct_setVideoMode_asm ;;Cambiamos el modo de video al que esta en el registro C (0)

	ld    	hl, #_sprite_palette
	ld  	de, #16
	call	cpct_setPalette_asm

	ld	l, #16
	ld	h, #20
	call 	cpct_setPALColour_asm

	ld	de, #_song_ingame
	call	cpct_akp_musicInit_asm

	call 	videoInitialize

	ret

;;=================================================
;;	Draw menu screen
;;	INPUT: DE: pointer to screen memory, B: height, C: width
;;	DESTROYS: AF, BC, DE, HL
;;=================================================
drawMenu:
	;; Get screen position
	call getVideoPtr
	;ld  de, #0xC8F8			;; Pointer to the start of the screen memory

	;; Draw menu
	ld  c, #30			;; width = 200 -> 100 bytes
	ld  b, #32			;; height = 24 -> 24 bytes
	ld  hl, #_go_start	;; HL = Entity_Sprite_hl
	call cpct_drawSprite_asm
	call switchBuffers
ret

drawGO:
	;; Get screen position
	call getVideoPtr
	;ld  de, #0xC8F8			;; Pointer to the start of the screen memory

	;; Draw menu
	ld  c, #30			;; width = 200 -> 100 bytes
	ld  b, #32			;; height = 24 -> 24 bytes
	ld  hl, #_init_gameoverChiquitin	;; HL = Entity_Sprite_hl
	call cpct_drawSprite_asm
	call switchBuffers
ret

eraseMenu:
	;; Get screen position
	call getVideoPtr
	;ld  de, #0xC8F8			;; Pointer to the start of the screen memory

	;; Draw menu
	ld  a, #00
	ld  c, #30			;; width = 200 -> 100 bytes
	ld  b, #32			;; height = 24 -> 24 bytes
	call cpct_drawSolidBox_asm
	call switchBuffers
ret

;;===============================
;; Main program entry
;;===============================
_main::
	ld  sp, #0x8000	;; Cambiamos la pila de sitio
	call initialize

	main_loop:
		call CheckEnterInput
		call CheckCurrentState	
		cp #00
		jr z, draw_main_menu	;; If current state = 0, draw main menu
		cp #01
		jr z, draw_game		;; If current state = 1, draw main game
		cp #02
		jr z, draw_game_over	;; If current state = 2, draw main game over screen

		draw_main_menu:
			call getVideoPtr		;; Pointer to memory video in DE
        		call player_draw
        		call drawMenu
        		call cpct_waitVSYNC_asm
        	jr main_loop

        	draw_game:
			;; CALLS A DRAW, UPDATE Y ERASE
			;; --------- ERASE ---------
			ld a, (menu_erased)
			cp #00
			jp z, menu_erase		;; Erase the menu only once

			ld a, (score_drawn)
			cp #00
			jp z, draw_score		;; Erase the menu only once

			call getVideoPtr		;; Pointer to memory video in DE
			call player_erase		;; Erase the player
			
			call getVideoPtr		;; Pointer to memory video in DE
			call bullet_erase		;; Erase the bullets
			
			call getVideoPtr		;; Pointer to memory video in DE
			ld  a, #0
			call enemies_erase

			;; --------- UPDATE ---------
			call player_update		;; Update player's position
			ld  a, #0
			call enemies_update


			call bullet_getPtrHL
			call enemies_checkCollision

			;; --------- DRAW ---------
			call getVideoPtr		;; Pointer to memory video in DE
			call player_draw		;; Draw the player

			call getVideoPtr		;; Pointer to memory video in DE
			call bullet_draw		;; Draw the bullets
			
			call getVideoPtr		;; Pointer to memory video in DE
			ld  a, #1		;; Cantidad de enemigos a dibujar, de 0 a 3 (1 dibuja 1, 2 dibuja 2...)
			call enemies_draw
			
			call cpct_waitVSYNC_asm
			call cpct_akp_musicPlay_asm	;; Play Music d(*_*)b
			call switchBuffers
		jp main_loop

		draw_game_over:
			call getVideoPtr		;; Pointer to memory video in DE
			call player_erase		;; Erase the player
			call getVideoPtr		;; Pointer to memory video in DE
			call bullet_erase		;; Erase the bullets
			call getVideoPtr		;; Pointer to memory video in DE
			ld  a, #00
			call enemies_erase
			ld a, #00
			ld (menu_erased), a
			ld a, #00
			ld (points_shown), a
			ld a, #00
			ld (score_drawn), a
			call player_reset
			call enemy_reset
			call drawGO
			call drawGO
			call cpct_waitVSYNC_asm
			call cpct_akp_musicPlay_asm	;; Play Music d(*_*)b

	jp main_loop

	menu_erase:
		inc a
		ld (menu_erased), a
		call eraseMenu			;; Erase the menu
		call eraseMenu			;; Erase the menu
		ld a, (points_shown)
		inc a
		ld (points_shown), a
		call score_reset
	jp draw_game

	draw_score:
		inc a
		ld (score_drawn), a
		call drawScore
		call switchBuffers
		call drawScore
		call switchBuffers
	jp draw_game

;;	reset_points:
;;		inc a
;;		ld (points_shown), a
;;		call score_reset
;;	jp draw_game
