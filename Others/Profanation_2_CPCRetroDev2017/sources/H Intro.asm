INTRO_Chorra_Celemin

	LD	HL,SPRITE0_INT
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0

	CALL	Borra_Pantalla

;        LD      HL,TINTAS_NEGRO
;	CALL    Cambia_Tintas_Marcador

	CALL	fadeout
	LD	HL,Texto_Intro0		;1985...
	LD	BC,#5070
	CALL	Imprime_Texto
	CALL	fadein

	CALL	Espera_Creditos

	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm


	CALL	fadeout
	LD	HL,Texto_Intro01	;Templo
	LD	BC,#5038
	CALL	Imprime_Texto
	CALL	fadein

	CALL	Espera_Creditos

	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm

	CALL	fadeout
	LD	A,PANTALLA_INTRO
	CALL	Pinta_Pantalla_SE
	CALL	fadein

	XOR	A
	LD	(Caer_Intro),A

	LD	HL,Texto_Intro1		;Polo
	CALL	Scroll_Creditos

	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm

	LD	HL,Texto_Intro2		;Vidas
	CALL	Scroll_Creditos

	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm

	CALL	Terremoto

	LD	IX,SPRITE0
	LD	BC,#000C		;posición (y,x)=(0,8)
	LD	HL,DSPR_PROTA_ANDAR	;posición del sprite
	LD	DE,#0410		;ancho y alto
	LD	A,7			;número de sprites
	EX	AF,AF'
	LD	A,0			;ID del sprite
	EXX
	LD	HL,Update_Prota_Intro	;rutina de UPDATE del prota
	LD	D,DERECHA
	LD	E,#FF			;no captura buffer de fondo
	LD	B,#FF
	CALL	Inicializa_Sprite

	LD	HL,Texto_Intro3		;credito 1
	CALL	Credito

	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm

	LD	HL,Texto_Intro4		;credito 2
	CALL	Credito1
	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm
	LD	HL,Texto_Intro5		;credito 2
	CALL	Credito
	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm
	LD	HL,Texto_Intro6		;credito 2
	CALL	Credito1
	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm
	LD	HL,Texto_Intro7		;credito 2
	CALL	Credito
	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm
	LD	HL,Texto_Intro71	;credito 2
	CALL	Credito1
	LD	A,(Pulsa_Escape)
	OR	A
	JP	NZ,inicio_menu_sm
	LD	HL,Texto_Intro72	;credito 2
	CALL	Credito

	LD	HL,SPRITE0_INT
	LD	(HL),0

;        LD      HL,TINTAS_JUEGO
;	CALL    Cambia_Tintas_Marcador

	JP	inicio_menu_sm

Scroll_Creditos
	LD	BC,#0800
	LD	A,31
	JP	Scroll_texto

Scroll_Ending
	LD	BC,#0800
scroll_outtro
	LD	A,31
	JP	Scroll_Texto_STEC

Credito
	PUSH	HL
	LD	A,PANTALLA_INTRO+1
	CALL	Pinta_Pantalla
	JR	Inicio_C
Credito1
	PUSH	HL
	LD	A,PANTALLA_INTRO+2
	CALL	Pinta_Pantalla
Inicio_C
	;CALL	fadein
	LD	A,1
	LD	(Caer_Intro),A
sigue_C
	LD	A,(Caer_Intro)
	OR	A
	JR	NZ,sigue_C
	LD	IY,SPRITE0_INT
	LD      (IY+00),4
	LD	B,3
	CALL	muchisimo_ICC
	POP	HL

	LD	A,(SPRITE0_X)
	CP	12
	JR	Z,pon_112_C
	LD	C,0
	JR	pon_0_C
pon_112_C
	LD	C,120
pon_0_c
	LD	B,#30
	PUSH	BC
	CALL	Imprime_Texto
	POP	BC
	LD	A,B
	ADD	A,8
	LD	B,A
	INC     HL
	PUSH	BC
	CALL	Imprime_Texto
	POP	BC
	LD	A,B
	ADD	A,8
	LD	B,A
	INC     HL
	CALL	Imprime_Texto

	LD	A,0
	LD	(Caer_Intro),A

	CALL	Espera_Creditos

	CALL	fadeout

	LD	A,(SPRITE0_X)
	CP	12
	JR	Z,pon_48_C
	LD	A,12
	JR	pon_12_C
pon_48_C
	LD	A,48
pon_12_c
	LD	(SPRITE0_X),A

	RET

Espera_Creditos
	LD	B,25
muchisimo_ICC
	PUSH	BC
	CALL	espera_mucho_TEC
	POP	BC
	DJNZ	muchisimo_ICC
	RET

muchisimo_STEC
	PUSH	BC
	CALL	espera_mucho
	POP	BC
	DJNZ	muchisimo_STEC
	RET


OUTTRO
	LD	HL,SPRITE0_INT
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0
	INC	HL
	LD	(HL),0

	CALL	fadeout

	CALL	Borra_Pantalla

        LD      HL,TINTAS_NEGRO
	CALL    Cambia_Tintas_Marcador

	CALL	fadein

	LD	HL,Texto_Outtro10		;eres muy malo
	LD	BC,#5800
	CALL	scroll_outtro

	CALL	fadeout
	CALL	Borra_Pantalla
	LD	HL,Texto_Outtro2		;game over
	LD	BC,#5860
	CALL	Imprime_Texto
	CALL	fadein

	LD	B,50
	CALL	muchisimo_STEC

        ;LD      HL,TINTAS_JUEGO
	;CALL    Cambia_Tintas_Marcador

	JP	inicio_menu

terremoto
	LD	B,50
terremoto_ICC
	LD	A,(offset_Terremoto+1)
	XOR	%00000001
	LD	(offset_Terremoto+1),A
	PUSH	BC
	LD	B,15
	CALL	espera_mucho_SP
	POP	BC
	DJNZ	terremoto_ICC
	RET

nuevo_menu
	call	fadeout
	LD	HL,Texto_Menu15
	LD	BC,#5858
	CALL	Imprime_Texto
	LD	HL,Texto_Menu15
	LD	BC,#6858
	CALL	Imprime_Texto
	LD	HL,Texto_Menu15
	LD	BC,#7858
	CALL	Imprime_Texto
	LD	HL,Texto_Menu+2
	LD	BC,#7868

	CALL	Imprime_Texto
	LD	HL,Texto_Menu11
	LD	BC,#5830
	CALL	Imprime_Texto
	LD	HL,Texto_Menu12
	LD	BC,#5890
	CALL	Imprime_Texto
	LD	HL,Texto_Menu13
	LD	BC,#6830
	LD	A,(Zonas_Liberadas)
	BIT	1,A
	CALL	NZ,Imprime_Texto
	LD	HL,Texto_Menu14
	LD	BC,#6890
	LD	A,(Zonas_Liberadas)
	BIT	2,A
	CALL	NZ,Imprime_Texto

	call	fadein

bucle_NM
	LD	A,31
	LD	HL,Texto_NuevoMenu
	LD	BC,#0800
	CALL	Scroll_Texto
	LD   	A,(TECLADO1)
	BIT	KEY_1,A
	JR	NZ,fase_1
	BIT	KEY_2,A
	JR	NZ,fase_2
  	BIT     KEY_3,A
	JR	NZ,fase_3
  	BIT     KEY_4,A
  	JR	NZ,fase_4
  	LD	A,(TECLADO0)
  	BIT     KEY_ESCAPE,A
  	JR	Z,bucle_NM
  	POP	HL		;anulo el RET
  	JP	inicio_menu
fase_4
	LD	A,46
	LD	BC,#581c
	RET

fase_1
	LD	A,PANTALLA_INICIO
	LD	BC,#0008
	RET
fase_2
	LD	A,14
	LD	BC,#083A
	RET
fase_3
	LD	A,32
	LD	BC,#5804
	RET
