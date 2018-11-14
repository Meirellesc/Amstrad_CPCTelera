Update_Prota_Intro
	LD	A,(Caer_Intro)
	OR	A
	JR	Z,salir_UPIntro
	LD	A,3
	CALL	Puedo_Ir_a_Abajo
	JR	NC,inicio_cambio_pantalla_Ab_UPIntro
	;JR	NZ,inicio_UPI
	LD	A,(IX+_Y)
	ADD	A,3
	LD	(IX+_Y),A
	LD	A,3
	CALL	Estado_Cayendo
salir_UPIntro
	JP	salir2_UP
inicio_cambio_pantalla_Ab_UPIntro
	XOR	A
	LD	(Caer_Intro),A
	LD	(IX+_Y),A
	RET

Update_Prota
	LD	A,(DIFICULTAD)
	LD	B,A
        LD      A,(SEMAFORO_SPR_INT_PROTA)
        CP	B
        JP	NZ,salir1_UP
        XOR     A
        LD	(SEMAFORO_SPR_INT_PROTA),A

	BIT	CHECK_PATH,(IX+_CHECKS)
	JP	NZ,salir_path_UP
	LD	A,GRAVEDAD
	CALL	Puedo_Ir_a_Abajo
	JR	NC,inicio_cambio_pantalla_Ab_UP
	JR	NZ,inicio_UP
	LD	A,(IX+_Y)
	ADD	A,GRAVEDAD
	LD	(IX+_Y),A
	LD	A,GRAVEDAD
	CALL	Estado_Cayendo
	CALL	Puedo_Ir_a_Abajo
	JP	Z,salir_UP
	JP	NC,salir_UP
	CALL	Ajusta_Sprite
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	CALL	Estado_Aterrizando
	JP	salir2_UP
inicio_cambio_pantalla_ab_UP
	LD	A,(DATOS_PANTALLA_ACTUAL+3)
	CP	#FF
	JR	Z,derecha_UP
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	(IX+_Y),0
	LD	(IX+_ANTY),0
	JP	salir_UP
inicio_UP
	BIT	CHECK_AGACHAR,(IX+_CHECKS)
	JP	NZ,Estado_Aterrizando
derecha_UP
	LD	HL,TECLADO0
	BIT	JOY_RIGHT,(HL)
	JR	Z,izquierda_UP
	LD	(IX+_MIRADA),DERECHA
	BIT	JOY_UP,(HL)
	JR	NZ,derecha_arriba_UP
	BIT	JOY_DOWN,(HL)
	JP	NZ,derecha_abajo_UP
	LD	A,1
	CALL	Puedo_Ir_a_Derecha
	JR	NC,inicio_cambio_pantalla_De_UP
	JP	NZ,salir_UP
	CALL	Estado_Andar
	INC	(IX+_X)
 	JP	salir2_UP
izquierda_UP
	LD	HL,TECLADO0
	BIT	JOY_LEFT,(HL)
	JP	Z,no_mueve_der_e_izq_UP
	LD	(IX+_MIRADA),IZQUIERDA
	BIT	JOY_UP,(HL)
	JR	NZ,izquierda_arriba_UP
	BIT	JOY_DOWN,(HL)
	JR	NZ,izquierda_abajo_UP
	LD	A,1
	CALL	Puedo_Ir_a_Izquierda
	JR	NC,inicio_cambio_pantalla_Iz_UP
	JP	NZ,salir_UP
	CALL	Estado_Andar
	DEC	(IX+_X)
	JP	salir2_UP
inicio_cambio_pantalla_Iz_UP
	LD	A,(DATOS_PANTALLA_ACTUAL+0)
	CP	#FF
	JR	Z,arriba_UP
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	A,ANCHO_MAPA_BYTES
	SUB	(IX+_ANCHO)
	LD	(IX+_X),A
	LD	(IX+_ANTX),A
	JR	arriba_UP
inicio_cambio_pantalla_De_UP
	LD	A,(DATOS_PANTALLA_ACTUAL+1)
	CP	#FF
	JR	Z,arriba_UP
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	(IX+_X),0
	LD	(IX+_ANTX),0
	JR	arriba_UP
derecha_arriba_UP
	BIT	CHECK_PATH,(IX+_CHECKS)
	JR	NZ,salir_path_UP
	CALL	Estado_Saltar_Derecha
	LD	HL,PATH_SALTO_VERTICAL_DCHA
	CALL	Asigna_Path
 	JR	salir2_UP
derecha_abajo_UP
	BIT	CHECK_PATH,(IX+_CHECKS)
	JR	NZ,salir_path_UP
	CALL	Estado_Saltar_Derecha_Corto
	LD	HL,PATH_SALTO_VERTICAL_DCHA_CORTO
	CALL	Asigna_Path
 	JR	salir2_UP
izquierda_arriba_UP
	BIT	CHECK_PATH,(IX+_CHECKS)
	JR	NZ,salir_path_UP
	CALL	Estado_Saltar_Izquierda
	LD	HL,PATH_SALTO_VERTICAL_IZQDA
	CALL	Asigna_Path
 	JR	salir2_UP
izquierda_abajo_UP
	BIT	CHECK_PATH,(IX+_CHECKS)
	JR	NZ,salir_path_UP
	CALL	Estado_Saltar_Izquierda_Corto
	LD	HL,PATH_SALTO_VERTICAL_IZQDA_CORTO
	CALL	Asigna_Path
 	JR	salir2_UP
no_mueve_der_e_izq_UP
	RES	CHECK_ANDAR,(IX+_CHECKS)
	CALL	Estado_Reposo
arriba_UP
	LD	HL,TECLADO0
	BIT	JOY_UP,(HL)
	JR	Z,abajo_UP
	;salto largo
	BIT	CHECK_PATH,(IX+_CHECKS)
	JR	NZ,salir_path_UP
	CALL	Estado_Saltar_Vert
	LD	HL,PATH_SALTO_VERTICAL
	CALL	Asigna_Path
 	JR	salir_UP
abajo_UP
	LD	HL,TECLADO0
	BIT	JOY_DOWN,(HL)
	JR	Z,salir_UP
	;salto corto
	BIT	CHECK_PATH,(IX+_CHECKS)
	JR	NZ,salir_UP
	CALL	Estado_Saltar_Vert_Corto
	LD	HL,PATH_SALTO_VERTICAL_CORTO
	CALL	Asigna_Path
	JR	salir_UP
salir_path_UP
	CALL	Haz_Camino
	BIT	CHECK_AGACHAR,(IX+_CHECKS)
	JR	NZ,salir2_UP
salir_UP
	CALL	Estado_Reposo
salir2_UP
	LD	A,(IX+_ID)
 	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

salir1_UP
        LD      HL,SEMAFORO_SPR_INT_PROTA
        INC	(HL)
        JR	salir2_UP

Asigna_Path
	LD	(IX+_PATH),L
	LD	(IX+_PATH+1),H
	SET	CHECK_PATH,(IX+_CHECKS)
	RET
	
Haz_Camino
	LD   	L,(IX+ _PATH)
	LD  	H,(IX+ _PATH+1)

 	LD   	A,(HL)
 	CP   	255
 	JP   	Z,fin_HC
 	;en A tengo los movs horitontales
horizontal_HC
 	OR	A
 	JR	Z,vertical_HC
derecha_HC
	AND	%00001111
	OR	A
	JR	Z,izquierda_HC
	EXX
	CALL	Puedo_Ir_a_Derecha
	EXX
	JR	C,no_cambio_pantalla_De_HC
	;cambio de pantalla derecha
	LD	A,(DATOS_PANTALLA_ACTUAL+1)
	CP	#FF
	JR	Z,vertical_HC
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	(IX+_X),0
	LD	(IX+_ANTX),0
	INC	HL
	JP	fin1_HC
no_cambio_pantalla_De_HC
	JR	NZ,vertical_HC
	LD	A,(HL)
	AND	%00001111
  	ADD 	A,(IX+_X)
  	LD	(IX+_X),A
izquierda_HC
	LD	A,(HL)
	AND  	%11110000
	RRA
	RRA
	RRA
	RRA
	EXX
	CALL	Puedo_Ir_a_Izquierda
	EXX
	JR	C,no_cambio_pantalla_Iz_HC
	;cambio de pantalla izquierda
	LD	A,(DATOS_PANTALLA_ACTUAL+0)
	CP	#FF
	JR	Z,vertical_HC
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	A,ANCHO_MAPA_BYTES
	SUB	(IX+_ANCHO)
	LD	(IX+_X),A
	LD	(IX+_ANTX),A
	INC	HL
	JR	fin1_HC
no_cambio_pantalla_Iz_HC
	JR	NZ,vertical_HC
	LD	A,(HL)
	AND  	%11110000
	RRA
	RRA
	RRA
	RRA
  	LD 	B,A
  	LD 	A,(IX+_X)
  	SUB	A,B
  	LD	(IX+_X),A

vertical_HC
 	INC 	HL
 	LD   	A,(HL)
 	;en A cojo los movs verticales
 	OR	A
 	JR	Z,fin1_HC
abajo_HC
	AND	%00001111
	OR	A
	JR	Z,arriba_HC
	EXX
	CALL	Puedo_Ir_a_Abajo
	EXX
	JR	C,no_cambio_pantalla_Ab_HC
	;cambio de pantalla abajo
	LD	A,(DATOS_PANTALLA_ACTUAL+3)
	CP	#FF
	JR	Z,fin1_HC
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	(IX+_Y),0
	LD	(IX+_ANTY),0
	JR	fin1_HC
no_cambio_pantalla_Ab_HC
	JR	NZ,fin_HC
	LD	A,(HL)
	AND	%00001111
  	ADD 	A,(IX+_Y)
  	LD	(IX+_Y),A
arriba_HC
	LD	A,(HL)
	AND  	%11110000
	RRA
	RRA
	RRA
	RRA
	EXX
	CALL	Puedo_Ir_a_Arriba
	EXX
	JR	C,no_cambio_pantalla_Ar_HC
	;cambio de pantalla arriba
	LD	A,(DATOS_PANTALLA_ACTUAL+2)
	CP	#FF
	JR	Z,fin1_HC
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	A,ALTO_MAPA_BYTES
	SUB	(IX+_ALTO)
	LD	(IX+_Y),A
	LD	(IX+_ANTY),A
	JR	fin1_HC
no_cambio_pantalla_Ar_HC
	JR	NZ,fin1_HC
	LD	A,(HL)
	AND  	%11110000
	RRA
	RRA
	RRA
	RRA
  	LD 	B,A
  	LD 	A,(IX+_Y)
  	SUB	A,B
  	LD	(IX+_Y),A

fin1_HC
 	INC	HL
	LD   	(IX+ _PATH),L
	LD  	(IX+ _PATH+1),H
	JP	Siguiente_Sprite
fin_HC
	RES	CHECK_PATH,(IX+_CHECKS)
	JR	Estado_Aterrizando

Estado_Reposo
	LD	A,(IX+_CHECKS)
	BIT	CHECK_PATH,A		;si está saltando no reposa
	RET	NZ
	;BIT	CHECK_ANDAR,A		;si está andando no reposa
	;RET	NZ
	BIT	CHECK_CAYENDO,A		;si ya está cayendo no inicia
	RET	NZ
	BIT	CHECK_REPOSO,A		;si ya está reposando no inicia
	JR	NZ,sal_ER
	LD	(IX+_SPR),47
	LD	(IX+_SPR_A),0
	LD	HL,DSPR_PROTA_REPOSO
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	SET	CHECK_REPOSO,(IX+_CHECKS)
	BIT	CHECK_AGACHAR,(IX+_CHECKS)
	RES	CHECK_AGACHAR,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	RET	Z
	JP	salir2_UP
sal_ER
	LD	A,(Pas_Interrupcion)
	RRA
	RET	NC
	JP	Siguiente_Sprite

Estado_Aterrizando
	BIT	CHECK_AGACHAR,(IX+_CHECKS)
	JP	NZ,Siguiente_Sprite_EA
	;LD	A,(PLY_SFX_Track3_Pitch+PLY_SFX_OffsetNote)
	;CP	60
	LD	A,SND_SUELO
	CALL	NZ,Toca_FX
	LD	(IX+_SPR),3
	LD	(IX+_SPR_A),0
	LD	HL,DSPR_PROTA_AGACHAR
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	RES	CHECK_PATH,(IX+_CHECKS)
	SET	CHECK_AGACHAR,(IX+_CHECKS)
	JP	salir2_UP
Siguiente_Sprite_EA
	LD	HL,TECLADO0
	BIT	JOY_DOWN,(HL)
	JR	NZ,fin_EA
	BIT	JOY_UP,(HL)
	JR	NZ,fin_EA
	BIT	JOY_LEFT,(HL)
	JR	NZ,fin_EA
	BIT	JOY_RIGHT,(HL)
	JR	NZ,fin_EA
	CALL	Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	OR	A
	JP	NZ,salir2_UP

	JP	Estado_Reposo
fin_EA
	RES	CHECK_AGACHAR,(IX+_CHECKS)
	JP	inicio_UP

Estado_Andar
	BIT	CHECK_ANDAR,(IX+_CHECKS)		;si está andando no inicia
	JP	NZ,Siguiente_Sprite
	LD	(IX+_SPR),7
	LD	(IX+_SPR_A),0
	LD	HL,DSPR_PROTA_ANDAR
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	SET	CHECK_ANDAR,(IX+_CHECKS)
	RET

Estado_Cayendo
	BIT	CHECK_CAYENDO,(IX+_CHECKS)		;si está andando no inicia
	RET	NZ
	LD	(IX+_SPR),0
	LD	(IX+_SPR_A),0
	LD	HL,DSPR_PROTA_CAYENDO
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	SET	CHECK_CAYENDO,(IX+_CHECKS)
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	RET

Estado_Saltar_Derecha
Estado_Saltar_Izquierda
	LD	HL,DSPR_PROTA_SALTAR_VL
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),22
	LD	(IX+_SPR_A),0
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	LD	A,SND_SALTO
	JP	Toca_FX
Estado_Saltar_Derecha_Corto
Estado_Saltar_Izquierda_Corto
	LD	HL,DSPR_PROTA_SALTAR_CVL
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),19
	LD	(IX+_SPR_A),0
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	LD	A,SND_SALTO
	JP	Toca_FX
Estado_Saltar_Vert
	LD	HL,DSPR_PROTA_SALTAR
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),12
	LD	(IX+_SPR_A),0
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	LD	A,SND_SALTO
	JP	Toca_FX
Estado_Saltar_Vert_Corto
	LD	HL,DSPR_PROTA_SALTAR_CORTO
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),7
	LD	(IX+_SPR_A),0
	RES	CHECK_CAYENDO,(IX+_CHECKS)
	RES	CHECK_REPOSO,(IX+_CHECKS)
	RES	CHECK_ANDAR,(IX+_CHECKS)
	LD	A,SND_SALTO
	JP	Toca_FX

Bck_Sprite0
	LD	A,(SPRITE0_ID)
	LD	(SPRITEB_ID),A
	LD	A,(SPRITE0_ANCHO)
	LD	(SPRITEB_ANCHO),A
	LD	A,(SPRITE0_ALTO)
	LD	(SPRITEB_ALTO),A
	LD	A,(SPRITE0_X)
	LD	(SPRITEB_X),A
	LD	A,(SPRITE0_Y)
	LD	(SPRITEB_Y),A
	LD	A,(SPRITE0_DSPR)
	LD	(SPRITEB_DSPR),A
	LD	A,(SPRITE0_DSPR+1)
	LD	(SPRITEB_DSPR+1),A
	LD	A,(SPRITE0_SPR)
	LD	(SPRITEB_SPR),A
	LD	A,(SPRITE0_SPR_A)
	LD	(SPRITEB_SPR_A),A
	LD	HL,SPRITE0_BUFF
	LD	DE,SPRITEB_BUFF
	LD	BC,8
	LDIR
	RET

Rst_Sprite0
	LD	A,(SPRITEB_ID)
	LD	(IX+_ID),A
	LD	A,(SPRITEB_ANCHO)
	LD	(IX+_ANCHO),A
	LD	A,(SPRITEB_ALTO)
	LD	(IX+_ALTO),A
	LD	A,(SPRITEB_X)
	LD	(IX+_X),A
	LD	A,(SPRITEB_Y)
	LD	(IX+_Y),A
	LD	A,(SPRITEB_DSPR)
	LD	(IX+_DSPR),A
	LD	A,(SPRITEB_DSPR+1)
	LD	(IX+_DSPR+1),A
	LD	A,(SPRITEB_SPR)
	LD	(IX+_SPR),A
	LD	A,(SPRITEB_SPR_A)
	LD	(IX+_SPR_A),A
	LD	DE,SPRITE0_BUFF
	LD	HL,SPRITEB_BUFF
	LD	BC,8
	LDIR
	RET

Prota_Toca_Objeto
	LD	A,(Sig_Interrupcion)
	CP	2
	RET	NZ
	LD	A,(CHECK_OBJETO)
	OR	A
	RET	Z
	XOR	A
	LD	(CHECK_OBJETO),A
        LD	IX,SPRITE0
        LD	IY,STATIC0
        CALL	Statics_collide
        JR	C,objeto_PTO
        LD	IX,SPRITE0
        LD	IY,STATIC1
        CALL	Statics_collide
        JR	C,objeto_PTO
        LD	IX,SPRITE0
        LD	IY,STATIC2
        CALL	Statics_collide
        JR	C,objeto_PTO
        LD	IX,SPRITE0
        LD	IY,STATIC3
        CALL	Statics_collide
        JR	C,objeto_PTO
        LD	IX,SPRITE0
        LD	IY,STATIC4
        CALL	Statics_collide
        RET	NC
objeto_PTO
	JP	Ejecuta_Triggers_Statics

; Gestiona_Objeto
; 	;a partir de aquí, dependiendo del objeto puerta, abro las puertas
; 	CP	3	;objeto 3 (pantalla 4), abre puerta ID 1 si he cogido el objeto 0
; 	JR	NZ,siguiente_puerta1_DOA
; 	;abro la puerta de la pantalla 2
; 	LD	A,0
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,1
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD	A,2
; 	CALL	Pinta_Pantalla_SE
; 	LD	A,4
; 	CALL	Pinta_Pantalla_SE
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta1_DOA
; 	CP	5	;objeto 5, abre puerta ID 9 si he cogido el objeto 2
; 	JR	NZ,siguiente_puerta2_DOA
; 	;abro la puerta de la misma pantalla
; 	LD	A,2
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,9
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD      IY,STATIC1
; 	CALL	Scroll_Puerta
; 	LD      IY,STATIC0
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; 	;a partir de aquí, si es objeto, lo llevo al marcador
; siguiente_puerta2_DOA
; 	CP	6	;objeto 6, abre puerta ID 10-11 si he cogido el objeto 4
; 	JR	NZ,siguiente_puerta3_DOA
; 	;abro la puerta de la pantalla 2
; 	LD	A,4
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,10
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD	A,7
; 	CALL	Pinta_Pantalla_SE
; 	LD	A,9
; 	CALL	Pinta_Pantalla_SE
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta3_DOA
; 	CP	7	;objeto 6, abre puerta ID 12-13 si he cogido el objeto 8
; 	JR	NZ,siguiente_puerta4_DOA
; 	;abro la puerta de la pantalla 2
; 	LD	A,8
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,12
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD      IY,STATIC1
; 	CALL	Scroll_Puerta
; 	LD      IY,STATIC0
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta4_DOA
; 	CP	14	;objeto 14 del puezzle, abre puerta nueva si es el correcto
; 	JR	NZ,siguiente_puerta5_DOA
; 	JP	puzzle_parte1
; siguiente_puerta5_DOA
; 	CP	15	;objeto 15 del puezzle, abre puerta nueva si es el correcto
; 	JR	NZ,siguiente_puerta6_DOA
; 	JP	puzzle_parte1
; siguiente_puerta6_DOA
; 	CP	16	;objeto 16 del puezzle, abre puerta nueva si es el correcto
; 	JR	NZ,siguiente_puerta7_DOA
; 	JP	puzzle_parte1
; siguiente_puerta7_DOA
; 	CP	17	;objeto 17 del puezzle, abre puerta nueva si es el correcto
; 	JR	NZ,siguiente_puerta8_DOA
; 	JP	puzzle_parte1
; siguiente_puerta8_DOA
; 	CP	22
; 	JR	NZ,siguiente_puerta9_DOA
; 	;abro la puerta de la pantalla 4, zona 2 si se ha cogido el objeto 18
; 	LD	A,18
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,32
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD	A,17
; 	CALL	Pinta_Pantalla_SE
; 	LD	A,20
; 	CALL	Pinta_Pantalla_SE
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta9_DOA
; 	CP	23
; 	JR	NZ,siguiente_puerta10_DOA
; 	;abro la puerta de la pantalla 4, zona 2 si se ha cogido el objeto 18
; 	LD	A,19
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,33
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD	A,16
; 	CALL	Pinta_Pantalla_SE
; 	LD	A,19
; 	CALL	Pinta_Pantalla_SE
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta10_DOA
; 	CP	24
; 	JR	NZ,siguiente_puerta11_DOA
; 	;abro la puerta de la pantalla 4, zona 2 si se ha cogido el objeto 18
; 	LD	A,20
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,26
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD	A,24
; 	CALL	Pinta_Pantalla_SE
; 	LD	A,23
; 	CALL	Pinta_Pantalla_SE
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta11_DOA
; 	CP	25
; 	JR	NZ,siguiente_puerta12_DOA
; 	;abro la puerta de la pantalla 4, zona 2 si se ha cogido el objeto 18
; 	LD	A,21
; 	CALL	Lee_Estado_Objeto_A
; 	CP	0
; 	RET	NZ
; 	PUSH	IY
; 	LD	A,28
; 	CALL	Desactiva_Objeto_A
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FE	;desactivo int de cfp
; 	LD      IY,STATIC1
; 	CALL	Scroll_Puerta
; 	LD      IY,STATIC0
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	POP	IY
;         LD	A,(IY+S_ID)
;         CALL	Desactiva_Objeto_A
;         JP	Borro_Objeto_Marcador
; siguiente_puerta12_DOA
; 	CP	34
; 	JR	Z,TeleTransporteZona2
; 	CP	35
; 	JR	NZ,siguiente_puerta13_DOA
; TeleTransporteZona2
; 	LD	A,18
; 	CALL	Lee_Estado_Objeto_A
; 	OR	A
; 	JR	NZ,salta_pantalla_1DOA
; 	LD	A,19
; 	CALL	Lee_Estado_Objeto_A
; 	OR	A
; 	JR	NZ,salta_pantalla_2DOA
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#22
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#18
; 	LD	A,16
; 	JR	salta_pant_DOA
; salta_pantalla_2DOA
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#22
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#18
; 	LD	A,15
; 	JR	salta_pant_DOA
; salta_pantalla_1DOA
; 	LD	HL,SPRITE0_X
; 	LD	(HL),#3A
; 	LD	HL,SPRITE0_Y
; 	LD	(HL),#08
; 	LD	A,14
; salta_pant_DOA
; 	LD	(Pantalla_Siguiente),A
; 	LD	HL,SPRITE0_CHECKS
; 	SET	CHECK_CAMBIO,(HL)
; 	LD	HL,SEMAFORO_SPR_INT
; 	LD	(HL),#FF	;desactivo int de cfp
; 	RET

; siguiente_puerta13_DOA
; fin_DOA
;         ;borro el objeto de pantalla si no era de los que abren puertas o puzzles
;         CALL	Imprimo_Objeto_Marcador
;         JP	Borro_Objeto

