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

videoPtr:	.dw #0x8000

;;=============================================
;; Switches Video Buffers
;; DESTROYS: AF, BC, HL, DE
;;=============================================
switchBuffers::
	modifier = .+1		;;Tiene la direccion de memoria del #0x20
	ld	l, #0x20
	call 	cpct_setVideoMemoryPage_asm
	ld	hl, #modifier
	ld	a, #0x10
	xor	(hl)
	ld	(modifier), a

	ld	hl, #videoPtr+1
	ld	a, #0x40
	xor	(hl)
	ld	(videoPtr+1), a

	ret

;;=============================================
;; Returns video pointer in DE
;; RETURNS: DE --> Pointer to memory video
;; DESTROYS: HL, DE
;;=============================================
getVideoPtr::
	ld	hl, (videoPtr)
	ex	de, hl
	ret


videoInitialize::
	ld	hl, #0x8000
	ld	de, #0x8001
	ld	(hl), #00
	ld	bc, #0x4000
	ldir
	ret