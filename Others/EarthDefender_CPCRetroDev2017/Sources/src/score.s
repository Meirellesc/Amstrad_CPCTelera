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
.include "video.h.s"


;;==================================
;;==================================
;; PRIVATE DATA
;;==================================
;;==================================

string: .db #83, #99, #111, #114, #101, #58, #32, #48, #48 		;; Score: 00
		.db #32, #32							  	  			;; Spaces
		.db #76, #105, #118, #101, #115, #58, #32, #57, #00	;; Lives: 9

;;==================================
;;==================================
;; PUBLIC FUNCTIONS
;;==================================
;;==================================

;;==================================
;;	Draws the whole score
;;==================================
drawScore::
	call 	getVideoPtr		;; Pointer to memory video in DE
	ld	a, #2
	call drawString
ret

;;==================================
;; Increase Score
;;==================================
increaseScore::
	;; Change first number of score
	ld 	a, #8
	ld	hl, #string	;; HL points to the start of the string
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC

	;; Update number
	ld  a, (hl)
	cp #57		;; A == 9
	jr z, increase_second_number ;; Check wether to update second number

	;; We don't have a 9 -> increase the number
	inc a
	ld	(hl), a		
	call drawScore
	call switchBuffers
	call drawScore
	call switchBuffers
ret
	increase_second_number: ;; Change the index to the second digit
		;; Update the first number (set it to 0 again)
		ld	a, #48
		ld	(hl), a		

		ld 	a, #7
		ld	hl, #string	;; HL points to the start of the string
		ld	 c, a		;; 
		ld	 b, #0		;; BC = A (offset)
		add	hl, bc		;; HL += BC

		ld  a, (hl)
		cp #57		;; A == 9
		jr z, do_not_increase ;; Check wether second number is 9

		;; Update the second number
		ld	a, (hl)
		inc a
		ld	(hl), a	
		call drawScore
		call switchBuffers
		call drawScore
		call switchBuffers
	ret
	do_not_increase:
	ret

;;==================================
;; Increase Score
;;==================================
decreaseLives::
	;; Change number of lives
	ld 	a, #18
	ld	hl, #string	;; HL points to the start of the string
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC

	ld  a, (hl)
	dec a
	ld	(hl), a	
	call drawScore
	call switchBuffers
	call drawScore
	call switchBuffers
ret

score_reset::
	;; Reset number of lives
	ld 	a, #18
	ld	hl, #string	;; HL points to the start of the string
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC
	ld  a, #57
	ld	(hl), a	

	;; Reset first number of score
	ld 	a, #8
	ld	hl, #string	;; HL points to the start of the string
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC
	ld  a, #48
	ld	(hl), a

	;; Reset second number of score
	ld 	a, #7
	ld	hl, #string	;; HL points to the start of the string
	ld	 c, a		;; 
	ld	 b, #0		;; BC = A (offset)
	add	hl, bc		;; HL += BC
	ld  a, #48
	ld	(hl), a	
ret

;;==================================
;;==================================
;; PRIVATE FUNCTIONS
;;==================================
;;==================================

;;==================================
;;	Draws a single character
;;	INPUT: A: position (x), A-push: character
;;==================================

drawString::
	;; a contains x position
	ld  	c, a			;; C = obs_x
	ld  	a, #180			;; |
	ld  	b, a			;; B = obs_y
	call	cpct_getScreenPtr_asm	;; Nos devuelve el puntero donde queremos pintar
	
	ex	de, hl			;; de points to screen position
	;;ld de, #0xC000
	ld	c, #15
	ld	b, #00
	ld  hl, #string
	;cpct_drawCharM0_asm
	;(2B DE) video_memory	Video memory location where the character will be drawn
	;(1B C )    fg_pen	Foreground palette colour index (Similar to BASIC’s PEN, 0-15)
	;(1B B )    bg_pen	Background palette colour index (PEN, 0-15)
	;(1B A )    ascii	Character to be drawn (ASCII code)
	call	cpct_drawStringM0_asm
ret