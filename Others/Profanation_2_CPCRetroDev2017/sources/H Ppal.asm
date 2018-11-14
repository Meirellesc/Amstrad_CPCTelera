
; CONFIGURACION DE ENSAMBLADOR

WRITE DIRECT -1,-1,#c0
run	start

NOLIST

READ	"H Constantes.asm"
READ	"H macros.asm"

ORG	INICIO_CODIGO

inicio_menu
	;inicializa
	CALL	fadeout
	LD	A,(Hay_Musica)
	OR	A
	LD	DE,SNG_MENU
	CALL	NZ,PLY_Init

inicio_menu_sm
        LD      HL,TINTAS_NEGRO
	CALL    Cambia_Tintas_Marcador

	LD      A,PANTALLA_MENU
	CALL	Pinta_Pantalla
	CALL	Vuelca_Marcador
	CALL	fadein

	LD	HL,Texto_Menu1
	LD	BC,#5858
	CALL	Imprime_Texto
	LD	HL,Texto_Menu2
	LD	BC,#6858
	CALL	Imprime_Texto
	LD	HL,Texto_Menu
	LD	BC,#7858
	CALL	Imprime_Texto

inicio_bucle_menu
	LD	A,31
	LD	HL,Texto_Marcador
	LD	BC,#0800
	CALL	Scroll_Texto
	LD   	A,(TECLADO1)
	BIT	KEY_1,A
	JP	NZ,INTRO_Chorra_Celemin
	BIT	KEY_2,A
	CALL	NZ,Alterna_Musica
	LD   	A,(TECLADO1)
  	BIT     KEY_3,A
	JR	Z,inicio_bucle_menu  

	LD	A,(Zonas_Liberadas)
	OR	A
	JR	Z,inicio_normal_juego

	CALL	nuevo_menu
	JR	inicio_check

inicio_normal_juego
	LD	A,PANTALLA_INICIO
	LD	BC,#0008
inicio_check
	PUSH	BC
	PUSH	AF
	CALL	fadeout

        LD      HL,TINTAS_JUEGO
	CALL    Cambia_Tintas_Marcador

	;inicializo los objetos para que aparezcan cogidos
	LD	HL,TABLA_OBJETOS
	LD	DE,TABLA_OBJETOS+1
	LD	(HL),1
	LD      BC,NUMERO_OBJETOS-1
	LDIR

	LD	HL,CHECK_MARCADOR0
	LD	C,14
	CALL	sigue_BOM
	LD	HL,CHECK_MARCADOR1
	LD	C,17
	CALL	sigue_BOM

	;inicio tramas aleatorias
	CALL	Inicializa_tramas_aleatorias

	POP	AF
	CALL	Pinta_Pantalla

	POP	BC

	LD	HL,0
	LD	(CHECK_MARCADOR0),HL
	LD	(CHECK_MARCADOR1),HL

	LD	IX,SPRITE0
	;LD	BC,#0008		;posición (y,x)=(0,8)
	LD	HL,DSPR_PROTA_ANDAR	;posición del sprite
	LD	DE,#0410		;ancho y alto
	LD	A,7			;número de sprites
	EX	AF,AF'
	LD	A,0			;ID del sprite
	EXX
	LD	HL,Update_Prota		;rutina de UPDATE del prota
	LD	D,DERECHA
	LD	E,#FF			;no captura buffer de fondo
	LD	B,#FF
	CALL	Inicializa_Sprite
	CALL	Bck_Sprite0
	LD	A,9
	LD	(SPRITE0_VIDAS),A
	CALL	imprime_vidas

	LD	A,(Hay_Musica)
	OR	A
	LD	DE,SNG_INGAME
	CALL	NZ,PLY_Init

inicio_bucle_juego

	LD	HL,SPRITE0_CHECKS
	BIT	CHECK_CAMBIO,(HL)
	LD	A,(Pantalla_Siguiente)
	CALL	NZ,Pinta_Pantalla

	CALL    Prota_Toca_Objeto

	LD	HL,TECLADO0
	BIT	KEY_ESCAPE,(HL)
	JP	NZ,OUTTRO
	LD	A,(SPRITE0_VIDAS)
	OR	A
	JP	Z,OUTTRO
	JP	inicio_bucle_juego
; mira_F2_ibj
; 	BIT	KEY_F2,(HL)
; 	JR	Z,mira_F8_ibj
; 	LD	A,(DATOS_PANTALLA_ACTUAL+3)
; 	CP	#FF
; 	JR	Z,mira_F8_ibj
; 	LD	IX,SPRITE0
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	(Pantalla_Siguiente),A
; mira_F8_ibj
; 	LD	HL,TECLADO1
; 	BIT	KEY_F8,(HL)
; 	JR	Z,mira_F6_ibj
; 	LD	A,(DATOS_PANTALLA_ACTUAL+2)
; 	CP	#FF
; 	JR	Z,mira_F6_ibj
; 	LD	IX,SPRITE0
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	(Pantalla_Siguiente),A
; mira_F6_ibj
; 	BIT	KEY_F6,(HL)
; 	JR	Z,mira_F4_ibj
; 	LD	A,(DATOS_PANTALLA_ACTUAL+1)
; 	CP	#FF
; 	JR	Z,mira_F4_ibj
; 	LD	IX,SPRITE0
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	(Pantalla_Siguiente),A
; mira_F4_ibj
; 	BIT	KEY_F4,(HL)
; 	JR	Z,mira_1_ibj
; 	LD	A,(DATOS_PANTALLA_ACTUAL+0)
; 	CP	#FF
; 	JR	Z,mira_1_ibj
; 	LD	IX,SPRITE0
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	(Pantalla_Siguiente),A
; mira_1_ibj
; 	BIT	KEY_1,(HL)
; 	JR	Z,mira_2_ibj
; ;	LD	HL,DIFICULTAD 
; ;	DEC	(HL)
; ;	JP	inicio_menu
; ;;	CALL	fadein
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#08
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#00
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	A,1
; 	LD	(Pantalla_Siguiente),A
; 	JP	inicio_bucle_juego
; mira_2_ibj
; 	BIT	KEY_2,(HL)
; 	JR	Z,mira_3_ibj
; ;	LD	HL,DIFICULTAD
; ;	INC	(HL)
; ;	JP	inicio_menu
; ;;	CALL	fadeout
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#3A
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#08
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	A,14
; 	LD	(Pantalla_Siguiente),A
; 	JP	inicio_bucle_juego
; mira_3_ibj
; 	BIT	KEY_3,(HL)
; 	JR	Z,mira_4_ibj
; ;	LD	HL,DIFICULTAD
; ;	INC	(HL)
; ;	JP	inicio_menu
; ;;	CALL	fadeout
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#04
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#58
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	A,32
; 	LD	(Pantalla_Siguiente),A
; 	JP	inicio_bucle_juego
; mira_4_ibj
; 	BIT	KEY_4,(HL)
; 	JR	Z,mira_5_ibj
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#1C
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#58
; 	SET	CHECK_CAMBIO,(IX+_CHECKS)
; 	LD	A,46
; 	LD	(Pantalla_Siguiente),A
; 	JP	inicio_bucle_juego
; mira_5_ibj
; 	BIT	KEY_5,(HL)
; 	JP	Z,inicio_bucle_juego
; 	LD	A,SND_COGER
; 	CALL	Toca_FX
; 	LD	A,(TRUCO_NO_MUERES)
; 	CP	2
; 	JR	Z,desactiva_ibj
; 	INC	A
; sal_ibj
; 	LD	(TRUCO_NO_MUERES),A
; 	LD	HL,SPRITE0_CHECKS
; 	RES	CHECK_MUERTE,(HL)
;         LD      B,10
;         CALL    muchisimo_STEC
; 	JP	inicio_bucle_juego
; desactiva_ibj
; 	LD	A,0
;	JR	sal_ibj	

	READ	"H Interrupciones.asm"
	READ	"H Pantallas-Tiles.asm"
	READ	"H Graficas.asm"
	READ	"H Prota.asm"
	READ	"H Malos.asm"
	READ	"H Data.asm"
	READ	"H Statics.asm"
	READ	"H Intro.asm"
	READ	"H Colisiones.asm"

	READ	"H Tablas.asm"
	READ	"H Split.asm"
FIN_BUFFER
	READ	"H Binarios.asm"

	READ	"H ArkosTrackerPlayer_CPC_MSX.asm"
	READ	"H Marcador.asm"
	READ	"H Sprites.asm"
	READ    "H TecSoundOtros.asm"
	READ	"H DataSup.asm"

fin_codigo_alto
	READ	"H Bloques1KB.asm"
