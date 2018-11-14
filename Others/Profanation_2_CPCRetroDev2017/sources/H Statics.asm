Ejecuta_Constructores_Statics
	LD	A,(IX+S_ID)
	CP	#FF
	RET	Z
	LD	A,(IX+S_CONS)
	LD	(sm_ECS+1),A
	LD	A,(IX+S_CONS+1)
	LD	(sm_ECS+2),A
sm_ECS
	JP	0

Ejecuta_Triggers_Statics
	LD	A,(IY+S_ID)
	CP	#FF
	RET	Z
	LD	A,(IY+S_TRIGGER)
	LD	(sm_ETS+1),A
	LD	A,(IY+S_TRIGGER+1)
	LD	(sm_ETS+2),A
sm_ETS
	JP	0

Final_Cons
	LD	A,63 ;puerta final
	CALL	Lee_Estado_Objeto_A
	OR	A
	RET	NZ
	JR	Objeto_TT_Cons
Objeto_Normal_Cons
	LD	A,(IX+S_ID)
	CALL	Lee_Estado_Objeto_A
	OR	A
	RET	Z
Objeto_TT_Cons
Objeto_Trama_Cons
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL	Pinta_Supertile_HL_Objeto
	POP	HL
Objeto_Nulo_Cons
	RET

;Imprime las tramas del puzzle 2 
Objeto_T2_Cons
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL	Pinta_Supertile_HL_Objeto
	CALL	Objeto_T2_Superior
	POP	HL
	RET

;imprime el objeto de arriba de las tramas del puzzle 2
Objeto_T2_Superior
	LD	A,(IX+S_ID)
	SUB     36		;para posicionarme en la tabla temp
	LD	B,0
	LD	C,A
	LD	HL,temp_puzzle11
	ADD	HL,BC
	LD	A,(HL)
	DEC	A
	SLA	A
	LD	C,A
	LD	HL,tabla_puzzle2
	ADD	HL,BC
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	LD	B,(IX+S_Y)
	LD	A,B
	SUB 	32
	LD	B,A
	LD	C,(IX+S_X)
	CALL	Pinta_Supertile_HL
	LD	A,SND_SELECCION
	JP	Toca_FX

Objeto_T3_Cons
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL	Pinta_Supertile_HL_Objeto
	CALL	Objeto_T3_Superior
	POP	HL
	RET

;imprime el objeto de arriba de las tramas del puzzle 2
Objeto_T3_Superior
	LD	A,(IX+S_ID)
	SUB     53		;para posicionarme en la tabla temp
	LD	B,0
	LD	C,A
	LD	HL,temp_puzzle21
	ADD	HL,BC
	LD	A,(HL)
	DEC	A
	SLA	A
	LD	C,A
	LD	HL,tabla_puzzle3
	ADD	HL,BC
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	LD	B,(IX+S_Y)
	LD	A,B
	SUB 	16
	LD	B,A
	LD	C,(IX+S_X)
	CALL	Pinta_Supertile_HL
	LD	A,SND_SELECCION
	JP	Toca_FX

Objeto_Aleatorio_Trigger
Objeto_Normal_Trigger
	;Borrar SuperTile
	CALL	Borro_Objeto
	CALL	Imprimo_Objeto_Marcador
	LD	A,SND_COGER
	CALL	Toca_FX
Objeto_Nulo_Trigger
Objeto_Puzzle_Trigger
	RET


Objeto_CierraPuzzle3_Trigger
	LD	IX,objeto_puzzle21
	LD	IY,temp_puzzle21
	LD	A,(IX+0)
	CP	(IY+0)
	JP	NZ,muere_OCP2T
	LD	A,(IX+1)
	CP	(IY+1)
	JP	NZ,muere_OCP2T
	LD	A,(IX+2)
	CP	(IY+2)
	JP	NZ,muere_OCP2T
	LD	A,(IX+3)
	CP	(IY+3)
	JP	NZ,muere_OCP2T
	;pasa a cuarta fase
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	PUSH	IX
	LD	IX,STATIC0
	LD	(IX+S_X),0
	LD	(IX+S_Y),8
	LD	(IX+S_TIPO),STA_PUERTA
	LD	DE,dstile_126
	LD	(IX+S_STILE),E
	LD	(IX+S_STILE+1),D
	LD	A,1
	LD	(IX+S_TAG),A
	CALL	Scroll_Puerta
	LD	HL,SPRITE0_CHECKS
	POP	IX
	RES	CHECK_PATH,(HL)
	LD	HL,SPRITE0_X
	LD	(HL),#1C
	LD	HL,SPRITE0_Y
	LD	(HL),#58
	LD	A,46
	LD	(Pantalla_Siguiente),A
	LD	HL,SPRITE0_CHECKS
	SET	CHECK_CAMBIO,(HL)
	LD	A,(Zonas_Liberadas)
	OR	%00000111
	LD	(Zonas_Liberadas),A
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;desactivo int de cfp
	RET

FT_Inicia_Spr
	LD	(IX+_SPR_A),A
	LD	(IX+_DSPR+1),H
	LD	(IX+_DSPR),L
	XOR     A
	LD	(IX+_SPR),A
	LD	HL,Update_Camelot_Phantis
	LD	(IX+_UPD+1),H
	LD	(IX+_UPD),L
	LD	(IX+_MIRADA),DERECHA
	LD	(IX+_ANCHO),4
	LD	(IX+_ALTO),16
	LD	(IX+_CHECKS),%10000000
	LD	(IX+_DESP),0;
	LD	(IX+_ADESP),0;
	LD	(IX+_IDESP),0
	LD	HL,BUFFER+64
	LD	(IX+_BUFF),L
	LD	(IX+_BUFF+1),H
	RET

Pinta_Camelot_Phantis
	LD	IX,SPRITE1
	PUSH	HL
	LD	A,0
	CALL 	FT_Inicia_Spr
	LD	(IX+_X),#1C
	LD	(IX+_Y),#58
	LD	(IX+_ANTX),#1C
	LD	(IX+_ANTY),#58

	LD	IX,SPRITE2
	POP	HL
	PUSH	HL
	LD	A,1
	CALL 	FT_Inicia_Spr
	LD	(IX+_X),#1C+4
	LD	(IX+_Y),#58
	LD	(IX+_ANTX),#1C+4
	LD	(IX+_ANTY),#58

	LD	IX,SPRITE3
	POP	HL
	PUSH	HL
	LD	A,2
	CALL 	FT_Inicia_Spr
	LD	(IX+_X),#1C
	LD	(IX+_Y),#68
	LD	(IX+_ANTX),#1C
	LD	(IX+_ANTY),#68

	LD	IX,SPRITE4
	POP	HL
	LD	A,3
	CALL 	FT_Inicia_Spr
	LD	(IX+_X),#1C+4
	LD	(IX+_Y),#68
	LD	(IX+_ANTX),#1C+4
	LD	(IX+_ANTY),#68
	LD	A,3
Pon_CFP_ISP
	LD	HL,SPRITE1_INT
	LD	(HL),A
	INC	HL
	LD	(HL),A
	INC	HL
	LD	(HL),A
	INC	HL
	LD	(HL),A
	RET

Final_Trigger
	LD	HL,BUFFER+64
	LD	DE,BUFFER+65
	LD	(HL),#FF
	LD	BC,63
	LDIR

	CALL	Borro_Objeto

	LD	HL,Update_Nulo
	LD	A,H
	LD	(SPRITE0_UPD+1),A
	LD	A,L
	LD	(SPRITE0_UPD),A
	LD	HL,SPRITE0_INT
	LD	(HL),2

	CALL	Terremoto

	LD	HL,Texto_End1		;Enhorabuena
	CALL	Scroll_Ending

	CALL	Terremoto

	LD	HL,DSPR_PHANTIS
	CALL	Pinta_Camelot_Phantis

	CALL	Espera_Ending

	LD	HL,Texto_End2		;sueño hecho realidad
	LD	BC,#0800
	CALL	Imprime_Texto

	CALL	Espera_Ending

	LD	HL,Texto_End21		;no quiero despertar
	LD	BC,#0800
	CALL	Imprime_Texto

	CALL	Espera_Ending

	LD	HL,Texto_End5		;perdon
	CALL	Scroll_Ending

	CALL	Terremoto

	LD	HL,DSPR_CAMELOT
	CALL	Pinta_Camelot_Phantis

	CALL	Espera_Ending

	LD	HL,Texto_End6		;bueno va, no está mal
	LD	BC,#0818
	CALL	Imprime_Texto

	CALL	Espera_Ending

	CALL	Terremoto

	LD	A,55
	CALL	Pinta_Pantalla_SE

	CALL	Espera_Ending

	LD	HL,Texto_End7		;perdon, camelot
	LD	BC,#0000
	CALL	Imprime_Texto
	CALL	Espera_Ending
	LD	HL,Texto_End8		;game over
	LD	BC,#0000
	CALL	Imprime_Texto
	CALL	fadein

comprueba_teclado2
	LD	A,(TECLADO0)
	LD	L,A
	LD      A,(TECLADO1)
	OR	L
	JR	Z,comprueba_teclado2

	JP	inicio_menu

Espera_Ending
	LD	B,100
	JP	muchisimo_STEC

Objeto_CierraPuzzle2_Trigger
	LD	IX,objeto_puzzle11
	LD	IY,temp_puzzle11
	LD	A,(IX+0)
	CP	(IY+0)
	JR	NZ,muere_OCP2T
	LD	A,(IX+1)
	CP	(IY+1)
	JR	NZ,muere_OCP2T
	LD	A,(IX+2)
	CP	(IY+2)
	JR	NZ,muere_OCP2T
	LD	A,(IX+3)
	CP	(IY+3)
	JR	NZ,muere_OCP2T
	;pasa a tercera fase
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	PUSH	IX
	LD	IX,STATIC0
	LD	(IX+S_X),224
	LD	(IX+S_Y),8
	LD	(IX+S_TIPO),STA_PUERTA
	LD	DE,dstile_126
	LD	(IX+S_STILE),E
	LD	(IX+S_STILE+1),D
	LD	A,4
	LD	(IX+S_TAG),A
	CALL	Scroll_Puerta
	LD	HL,SPRITE0_CHECKS
	POP	IX
	RES	CHECK_PATH,(HL)
	LD	HL,SPRITE0_X
	LD	(HL),#4
	LD	HL,SPRITE0_Y
	LD	(HL),#58
	LD	A,32
	LD	(Pantalla_Siguiente),A
	LD	HL,SPRITE0_CHECKS
	SET	CHECK_CAMBIO,(HL)
	LD	A,(Zonas_Liberadas)
	OR	%00000011
	LD	(Zonas_Liberadas),A
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;desactivo int de cfp
	RET
muere_OCP2T
        LD      A,(PANTALLA_ACTUAL)
        LD      (Pantalla_Siguiente),A
        XOR     A
        CALL    Actualiza_Tabla_INT_ibp
        LD      IX,SPRITE0
        CALL    Rst_Sprite0
        SET     CHECK_MUERTE,(IX+_CHECKS)
        SET     CHECK_CAMBIO,(IX+_CHECKS)
        DEC     (IX+_VIDAS)
        LD      HL,TINTAS_BLANCO
	CALL   	Cambia_Tintas_Juego
        LD      A,SND_MUERTE
        JP      Toca_FX

Objeto_Aleatorio_Cons
	LD	A,(IX+S_ID)
	CALL	Lee_Estado_Objeto_A
	OR	A
	RET	Z
Objeto_Aleatorio_T_Cons
	LD	A,(IX+S_ID)
	CALL	Tramas_PuzzlesP2
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL	Pinta_Supertile_HL_Objeto
	POP	HL
	RET

Objeto_TramaPuzzle_Cons
	LD	A,(IX+S_ID)
	CALL	Lee_Estado_Objeto_A
	OR	A
	RET	Z
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL	Pinta_Supertile_HL_Objeto
	POP	HL
	RET

Objeto_Puzzle_Cons
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	LD	A,(HL)
	INC	HL
	LD	H,(HL)
	LD	L,A
	CALL	Pinta_Supertile_HL_Objeto
	POP	HL
	RET

Objeto_TT_Trigger
Objeto_Aleatorio_T_Trigger
Objeto_Trama_Trigger
	LD	IX,TABLA_MOV_OBJETOS
Otro_OTT
	LD	A,(IX+0)
	CP	255
	JR	Z,TeleTransporteZona
	CP	(IY+S_ID)
	JR	Z,Abre_Puerta_OTT
	LD	BC,5
	ADD     IX,BC
	JR	Otro_OTT
Abre_Puerta_OTT
	LD	A,(IX+1)
	CALL	Lee_Estado_Objeto_A
	CP	0
	RET	NZ
	PUSH	IY
	LD	A,(IX+1)
        CALL	Borro_Objeto_Marcador
	LD	A,(IX+2)
	CALL	Desactiva_Objeto_A_SND
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	LD	A,(IX+3)
	OR	A
	JR	Z,misma_pantalla_OTT
	PUSH	IX
	CALL	Pinta_Pantalla_SE
	POP	IX
	LD	A,(IX+4)
	CALL	Pinta_Pantalla_SE
fin_OTT
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;desactivo int de cfp
	POP	IY
	CALL	Bck_Sprite0
	LD	A,(IY+S_ID)
	JP	Desactiva_Objeto_A
	RET
misma_pantalla_OTT
	LD	A,(IX+4)
	CP	1
	JR      NZ,stat2_OTT
	LD      IX,STATIC1
	JR	sigue_OTT
stat2_OTT
	LD      IX,STATIC2
sigue_OTT
 	CALL	Scroll_Puerta
 	JR	fin_OTT

TeleTransporteZona
	LD	A,(IY+S_ID)
	CP	34
	JR	Z,TeleTransporteZona2
	CP	35
	JR	NZ,fin_DOA
TeleTransporteZona2
	LD	A,SND_SELECCION
	CALL	Toca_FX
	LD	A,18
	CALL	Lee_Estado_Objeto_A
	OR	A
	JR	NZ,salta_pantalla_1DOA
	LD	A,19
	CALL	Lee_Estado_Objeto_A
	OR	A
	JR	NZ,salta_pantalla_2DOA
	LD	HL,SPRITE0_X
	LD	(HL),#22
	LD	HL,SPRITE0_Y
	LD	(HL),#18
	LD	A,16
	JR	salta_pant_DOA
salta_pantalla_2DOA
	LD	HL,SPRITE0_X
	LD	(HL),#22
	LD	HL,SPRITE0_Y
	LD	(HL),#18
	LD	A,15
	JR	salta_pant_DOA
salta_pantalla_1DOA
	LD	HL,SPRITE0_X
	LD	(HL),#3A
	LD	HL,SPRITE0_Y
	LD	(HL),#08
	LD	A,14
salta_pant_DOA
	LD	(Pantalla_Siguiente),A
	LD	HL,SPRITE0_CHECKS
	RES	CHECK_PATH,(HL)
	;LD	HL,SPRITE0_CHECKS
	SET	CHECK_CAMBIO,(HL)
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;desactivo int de cfp
	RET
fin_DOA
        ;borro el objeto de pantalla si no era de los que abren puertas o puzzles
        CALL	Imprimo_Objeto_Marcador
        JP	Borro_Objeto

Anterior_toque db 0
;Trigger de las tramas del puzzle 2
Objeto_Puzzle2_Trigger
	LD	A,(Anterior_toque)
	LD	B,A
	LD	A,(Pas_Interrupcion)
	SUB	B
	CP	30
	JP	NC,puzzle_parte2
	RET

Objeto_Puzzle3_Trigger
	LD	A,(Anterior_toque)
	LD	B,A
	LD	A,(Pas_Interrupcion)
	SUB	B
	CP	30
	JP	NC,puzzle_parte3
	RET

Objeto_Puerta_Cons
	;Pintar SuperTile
	LD	B,(IX+S_Y)
	LD	C,(IX+S_X)
	PUSH	HL
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	LD	A,H
	AND	%10000000
	JR	NZ,rotado_OPS
	CALL	Pinta_Supertile_HL
	JR	sigue_OPS
rotado_OPS
	LD	A,H
	AND	%01111111
	LD	H,A
	CALL	Pinta_Supertile_HL_Rotado
sigue_OPS
	LD	A,(IX+S_ID)
	CALL	Lee_Estado_Objeto_A
	OR	A
	CALL	Z,Scroll_Puerta
	POP	HL
Objeto_Puerta_Trigger
	RET
	
Lee_Estado_Objeto_A
	PUSH	HL
	PUSH	BC
        LD	C,A
        LD	B,0
        LD	HL,TABLA_OBJETOS
	ADD	HL,BC
	LD	A,(HL)
	POP	BC
	POP	HL
	RET

Activa_Objeto_A
        LD	C,A
        LD	B,0
        LD	HL,TABLA_OBJETOS
	ADD	HL,BC
	LD	(HL),1
	RET

Desactiva_Objeto_A_SND
	PUSH	AF
	LD	A,SND_COGER
	CALL	Toca_FX
	POP	AF
Desactiva_Objeto_A
        LD	C,A
        LD	B,0
        LD	HL,TABLA_OBJETOS
	ADD	HL,BC
	LD	(HL),0
	RET

Borro_Objeto
	LD	L,(IY+S_STILE)
	LD	H,(IY+S_STILE+1)
	LD	A,(HL)
	;ancho
	LD      A,(HL)
	AND	%01110000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	EX	AF,AF'
	;alto
	LD      A,(HL)
	AND	%00001111
	LD      D,A
	INC     HL
	EX	AF,AF'
	;;A:ancho
	;;D:alto
	LD	B,(IY+S_Y)
	LD	C,(IY+S_X)
alto_bo
	PUSH	AF
	PUSH	BC
ancho_bo
	PUSH    AF	
	PUSH	BC
	PUSH	DE
	LD	A,TILE_FONDO
	EX	AF,AF'
	LD	E,JUEGO_TILES_1
	CALL	write_tile_screen_YX
	POP	DE
	POP	BC
	LD 	A,C
	ADD	A,8
	LD	C,A
	POP	AF
	DEC	A
	JR      NZ,ancho_bo

	POP	BC
	LD	A,B
	ADD	A,8
	LD	B,A
	POP	AF
	DEC	D
	JR	NZ,alto_bo

        ;desactivo objeto
        LD	A,(IY+S_ID)
        CALL	Desactiva_Objeto_A
        ;quitar las durezas
        CALL	Quitar_Durezas_Static
	LD	(IY+S_ID),#FF

	RET

Quitar_Durezas_Static
	LD	L,(IY+S_STILE)
	LD	H,(IY+S_STILE+1)

	LD	A,(IY+S_TIPO)
	CP	STA_PUERTA
	JR	Z,coge_tag_QDS
	;ancho
	LD      A,(HL)
	AND	%01110000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	LD	E,A
	SLA	E
	JR	sigue_QDS
coge_tag_QDS
	LD	E,(IY+S_TAG)
	SLA	E
sigue_QDS
	;alto
	LD      A,(HL)
	AND	%00001111
	LD      D,A
	;;E:ancho
	;;D:alto

	LD	A,(IY+S_X)
	LD	C,A

	LD	A,(IY+S_Y)
	LD	B,A
alto_QDS
	PUSH	DE
	PUSH	BC
ancho_QDS
	PUSH	DE
	LD	A,#FF
	EX	AF,AF'
	LD	E,0			;para que asigne dureza normal
	PUSH	BC
	LD	A,(CHECK_ASIGNA_DUREZAS)
	OR	A
	CALL	NZ,Asigna_Durezas
	POP	BC
	LD	A,C
	ADD	A,4
	LD	C,A
	POP	DE
	DEC	E
	JR	NZ,ancho_QDS
	POP	BC
	POP	DE
	LD	A,B
	ADD	A,8
	LD	B,A
	DEC	D
	JR	NZ,alto_QDS

	RET

Imprimo_Objeto_Marcador
	LD	C,14
	LD	HL,CHECK_MARCADOR0
	LD	A,(HL)
	INC	HL
	OR	(HL)
	JR      Z,ini_iom
	LD	C,17
	INC	HL
	INC	HL
oo1_iom
ini_iom
	LD	A,(IY+S_STILE+1)
	LD	(HL),A
	LD	A,(IY+S_STILE)
	DEC	HL
	LD	(HL),A
	LD	H,(IY+S_STILE+1)
	LD	L,A
	LD	B,1
	JP  	Pinta_Supertile_Marcador_HL

Borro_Objeto_Marcador
	LD	HL,CHECK_MARCADOR0
	LD	A,(HL)
	CP	(IY+S_STILE)
	JR	NZ,ini_bom
	INC	HL
	LD	A,(HL)
	CP	(IY+S_STILE+1)
	JR	NZ,ini_bom
	LD	HL,CHECK_MARCADOR0
	LD	C,14
	JR	sigue_BOM
ini_bom
	LD	HL,CHECK_MARCADOR1
	LD	C,17
sigue_BOM
	XOR	A
	LD	(HL),A
	INC	HL
	LD	(HL),A
	LD	A,(IY+S_ID)
	LD	HL,dstile_fp
	LD	B,1
	JP  	Pinta_Supertile_Marcador_HL

anula_puerta_64
	LD	A,64
	JP	Desactiva_Objeto_A
Scroll_Puerta
	LD	A,(IX+S_ID)
	CP	63		;esa puerta no lleva scroll
	CALL	Z,anula_puerta_64
	LD	A,(IX+S_ID)
	CP	64		;esa puerta no lleva scroll
	RET	Z

	LD	A,(Sig_Interrupcion)
	CP	5
	JR	NZ,Scroll_Puerta
	CALL	fadein
	LD	A,4
	CALL	Toca_FX

	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	;ancho
	LD	A,(IX+S_TAG)
	LD	E,A
	SLA	E
	;alto
	LD      A,(HL)
	AND	%00001111
	LD      D,A
	SLA	D
	SLA	D
	SLA	D
	DEC	D

otro_mas_SP
	PUSH	DE
	EXX

	LD	A,(IX+S_X)
	LD	C,A
	LD	A,(IX+S_Y)
	LD	B,A

	LD	HL,TABLA_SCANLINES
	LD   	D,0
	AND  	A
	RL   	B
	LD   	E,B
	ADD  	HL,DE
	LD   	A,(HL)
	RR   	C
	RR   	C
	ADD  	A,C
	LD   	E,A
	INC  	HL
	LD   	A,(HL)
	LD   	D,A		;DE screen address
otro_alto_SP
	LD	L,E
	LD	H,D
	LD	BC,#800
	ADD	HL,BC
	JR      NC,siguiente_scanline_SP
	LD      BC,#C040
	ADD     HL,BC
siguiente_scanline_SP
	EXX	
	LD	A,E		;ancho
	EXX
	LD	C,A
	LD	B,0
	PUSH	HL

	LD	A,(offset_Terremoto+1)
	XOR	%00000001
	LD	(offset_Terremoto+1),A

	LDIR

	POP	DE
	EXX	
	DEC	D
	EXX
	JR	NZ,otro_alto_SP
	;ahora elimino la ultima linea
	LD	L,E
	LD	H,D
	INC	DE
	LD	(HL),BYTE_FONDO_PANTALLA
	EXX	
	LD	A,E
	DEC	A
	EXX
	LD	C,A
	LD	B,0
	LDIR

	CALL	espera_mucho

	EXX
	POP	DE

	DEC	D
	JP	NZ,otro_mas_SP

	LD	A,0
	LD	(Offset_Terremoto+1),A

	PUSH	IX
	POP	IY 

	JP	Quitar_Durezas_Static

;trigger de las tramas del puzzle 1
Objeto_TramaPuzzle_Trigger
puzzle_parte1
	;LD	HL,SEMAFORO_SPR_INT
	;LD	(HL),#FE	;desactivo int de cfp
	LD	A,(dstile_puzzle13)
	LD	C,85
	SUB     C
	LD      B,0
	LD      C,A
	LD	HL,objeto_puzzle1
	ADD     HL,BC
	LD	A,(IY+S_ID)
	CP	(HL)
	JP	NZ,muere_por_puzzle
	;JR	pasa_parte_2
pasa_parte_2
        CALL	Borro_Objeto
	LD	A,(dstile_puzzle13)
	CP	88
	JR      Z,fin_puzzle13
	CP	85
	JR      NZ,_86_pp2
	LD	HL,dSTILE_t86
	JR	sigue_pp2
_86_pp2
	CP	86
	JR      NZ,_87_pp2
	LD	HL,dSTILE_t87
	JR	sigue_pp2
_87_pp2
	CP	87
	JR      NZ,sigue_pp2
	LD	HL,dSTILE_t88
sigue_pp2
	LD	(dstilet_puzzle13),HL
	INC	A
	LD	(dstile_puzzle13),A
	;LD      A,13
	;__________________CALL	salta4_TP	;Tramas_Puzzles
	;llamar al constructor de STATIC4
	PUSH	IX
	LD	IX,STATIC4
	CALL	Objeto_Puzzle_Cons
	POP	IX
	;LD	HL,SEMAFORO_SPR_INT
	;LD	(HL),#FF	;desactivo int de cfp
	LD	A,SND_SELECCION
	JP	Toca_FX
fin_puzzle13
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	PUSH	IX
	LD	IX,STATIC0
	LD	(IX+S_X),224
	LD	(IX+S_Y),8
	LD	(IX+S_TIPO),STA_PUERTA
	LD	DE,dstile_02
	LD	(IX+S_STILE),E
	LD	(IX+S_STILE+1),D
	LD	A,4
	LD	(IX+S_TAG),A
	CALL	Scroll_Puerta
	LD	HL,SPRITE0_CHECKS
	POP	IX
	RES	CHECK_PATH,(HL)
	LD	HL,SPRITE0_X
	LD	(HL),#3A
	LD	HL,SPRITE0_Y
	LD	(HL),#08
	LD	A,14
	LD	(Pantalla_Siguiente),A
	LD	HL,SPRITE0_CHECKS
	SET	CHECK_CAMBIO,(HL)
	LD	A,(Zonas_Liberadas)
	OR	%00000001
	LD	(Zonas_Liberadas),A
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;desactivo int de cfp
	RET
muere_por_puzzle
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;desactivo int de cfp
	LD	A,SND_PLATAFORMA
	CALL	Z,Toca_FX
	LD	IY,SPRITE2
	SET	CHECK_ACTIVAR,(IY+_CHECKS)
	LD	IY,SPRITE3
	SET	CHECK_ACTIVAR,(IY+_CHECKS)
	LD	IY,SPRITE5
	SET	CHECK_ACTIVAR,(IY+_CHECKS)
	RET

puzzle_parte2
	LD	A,(Pas_Interrupcion)
	LD	(Anterior_toque),A

	PUSH	IX
	PUSH	IY
	POP	IX
	LD	A,(IX+S_ID)
	SUB     36		;para posicionarme en la tabla temp
	LD	B,0
	LD	C,A
	LD	HL,temp_puzzle11
	ADD	HL,BC
	LD	A,(HL)
	CP	4
	JR	Z,ini_pp2	
	INC	(HL)
	JR	siguet_pp2
ini_pp2
	LD	(HL),1
siguet_pp2
	CALL	Objeto_T2_Superior
	POP	IX
	RET

puzzle_parte3
	LD	A,(Pas_Interrupcion)
	LD	(Anterior_toque),A

	PUSH	IX
	PUSH	IY
	POP	IX
	LD	A,(IX+S_ID)
	SUB     53		;para posicionarme en la tabla temp
	LD	B,0
	LD	C,A
	LD	HL,temp_puzzle21
	ADD	HL,BC
	LD	A,(HL)
	CP	4
	JR	Z,ini_pp3
	INC	(HL)
	JR	siguet_pp3
ini_pp3
	LD	(HL),1
siguet_pp3
	CALL	Objeto_T3_Superior
	POP	IX
	RET

Tramas_PuzzlesP2
 	CP	18
 	JR	Z,_18_TP2
 	CP	22
 	JR	NZ,_sig1_TP2
_18_TP2
 	PUSH	HL
 	LD	HL,(dstile_pantalla14)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
_sig1_TP2
 	CP	19
 	JR	Z,_19_TP2
 	CP	23
 	JR	NZ,_sig2_TP2
_19_TP2
 	PUSH	HL
 	LD	HL,(dstile_pantalla19)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
_sig2_TP2
 	CP	20
 	JR	Z,_20_TP2
 	CP	24
 	JR	NZ,_sig3_TP2
_20_TP2
 	PUSH	HL
 	LD	HL,(dstile_pantalla22)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
_sig3_TP2
 	CP	21
 	JR	Z,_21_TP2
 	CP	25
 	JR	NZ,_sig4_TP2
_21_TP2
 	PUSH	HL
 	LD	HL,(dstile_pantalla24)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
_sig4_TP2
 	CP	41
 	JR	Z,_41_TP2
 	CP	42
 	JR	NZ,_sig5_TP2
 _41_TP2
	PUSH	HL
 	LD	HL,(dstile_pantalla38)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
 _sig5_TP2
 	CP	44
 	JR	Z,_44_TP2
 	CP	45
 	JR	NZ,_sig6_TP2
 _44_TP2
	PUSH	HL
 	LD	HL,(dstile_pantalla31)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
 _sig6_TP2
 	CP	47
 	JR	Z,_47_TP2
 	CP	48
 	JR	NZ,_sig7_TP2
 _47_TP2
	PUSH	HL
 	LD	HL,(dstile_pantalla33)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
 _sig7_TP2
 	CP	50
 	JR	Z,_50_TP2
 	CP	51
 	JR	NZ,_sig8_TP2
 _50_TP2
	PUSH	HL
 	LD	HL,(dstile_pantalla40)
 	EX	AF,AF'
 	LD	A,L
 	LD	(IX+S_STILE),A
 	LD	A,H
 	LD	(IX+S_STILE+1),A
 	EX	AF,AF'
 	POP	HL
 	RET
 _sig8_TP2
fin_TP2
 	RET
