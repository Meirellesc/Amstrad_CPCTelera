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

.include "keyboard.s"
.include "cpctelera.h.s"
.include "state.h.s"

current_state: 		.db #00		;; 0 for menu, 1 for game, 2 for game over

;;=============================================
;;	Check Current State
;;	Returns: A: current state
;;=============================================
CheckCurrentState:
	ld a, (current_state)
ret

;;=============================================
;;	Modify Current State
;;=============================================
ModifyCurrentState:
	ld a, (current_state)
	cp #02
	jr z, set_zero			;; If current_state == 2, change it to 0

	ld a, (current_state)
	inc a
	ld (current_state), a		;; If current_state == 0 or current_state == 1, increase it
	
ret

	set_zero:
		ld a, #01
		ld (current_state), a
	ret

CheckEnterInput:
	;; Scan keyboard
	call cpct_scanKeyboard_asm

	;; Check for Enter Key pressed
	;; INPUT: HL contains key 16-bit value
	ld 	hl, #Key_Return	;; HL = Key_Enter Keycode
	call 	cpct_isKeyPressed_asm
	cp	#0
	jr	z, Enter_not_pressed

		;; Enter is pressed
		call CheckCurrentState		;;
		cp #01				;;
		jr z, Enter_not_pressed		;; Modify state only if in state 0 or 2 (2 == game, don't modify)

		call ModifyCurrentState

	Enter_not_pressed:
ret