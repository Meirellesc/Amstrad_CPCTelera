; MACROS

; Escribe un valor en un registro del CRTC

MACRO	SET_CRTC_REG	_reg, _value	; 14c

	LD	BC,#BC00+_reg	; 3c
	OUT	(C),C		; 4C
	LD	BC,#BD00+_value	; 3c
	OUT	(C),C		; 4c

MEND

; Pone el border de un color

MACRO	BORDER_COLOR	_value	; 14c

	LD	BC,#7F10
	OUT	(C),C
	LD	C,_value
	OUT	(C),C

MEND

; Espera n ciclos (maximo 1024)

MACRO	WAIT_CYCLES _cycles

	@loops		equ	_cycles-1/4
	@loopsx4	equ	@loops*4
	@nops		equ	_cycles-@loopsx4-1

	LD	B,@loops
	@change_waitLoop
	DJNZ	@change_waitLoop

	defs	@nops,0

MEND

;retación de A de DE en modo 0
MACRO rota_a_de_de

	LD	A,(DE)
	AND	%01010101
	RLCA
	LD 	C,A
	LD	A,(DE)
	AND	%10101010
	RRCA
	OR	C

MEND