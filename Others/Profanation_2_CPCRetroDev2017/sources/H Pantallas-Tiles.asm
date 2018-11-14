;;----------------------------------------------
;;Pinta_Pantalla
;;Pinta la pantalla dada en A
;;----------------------------------------------
;;Coge_Supertiles
;;Coge los STiles de la pantalla y manda dibujarlos en la posición
;;----------------------------------------------
;;Borra_Pantalla
;;Rellena la pantalla con BYTE_FONDO_PANTALLA
;;----------------------------------------------
;;Borra_Mapa_Durezas
;;Borra la zona del Mapa de Durezas
;;----------------------------------------------
;;Pinta_Supertile
;;Pinta en pantalla el STile E en BC (Y,X)
;;----------------------------------------------
;;Pinta_Supertile_Rotado
;;Pinta en pantalla el STile E en BC (Y,X) ROTADO
;;----------------------------------------------
;;write_tile_screen_YX
;;escribe un tile en pantalla
;;----------------------------------------------
;;write_tile_screen_rotado_YX
;;escribe un tile en pantalla ROTADO
;;----------------------------------------------
;;Asigna_Durezas
;;Asigna las durezas del mapa en BC
;;----------------------------------------------
;;Lee_Durezas
;;Lee las durezas del mapa en BC y las devuelve en A
;;----------------------------------------------

;;
;;Pinta la pantalla sin enemigos dada en A
;;
;;ENTRADA
;;A: pantalla a pintar
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
Pinta_Pantalla_SE
	CP	#FF
	RET	Z
	PUSH	AF
        ;LD      HL,TINTAS_Negro
	;CALL    Cambia_Tintas_Juego
	CALL	fadeout
	LD	A,0
	LD	(CHECK_ASIGNA_DUREZAS),A
	CALL    Borra_Pantalla
        POP	AF

	PUSH	AF
	CALL	Tramas_PuzzlesP1
	POP	AF
	LD	HL,MAPA_PANTALLAS
	RLCA
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD   	A,(HL)
  	LD	E,A
  	INC  	HL
  	LD	A,(HL)
  	LD   	D,A			
  	EX	DE,HL			;dejo en HL la posición de la pantalla (PANTALLA_XX)

  	LD	BC,4
  	ADD     HL,BC			;salto los datos iniciales de la pantalla
  	;A partir de aquí leo los STiles y los voy pintando y apuntando su dureza
inicio_stiles_ppse
  	LD	A,(HL)
  	INC     HL
  	CP	255
  	JR	Z,fin_stiles_ppse
  	LD	E,A			;en E dejoel STile
  	CALL	Coge_Supertiles
  	JR	inicio_stiles_ppse
fin_stiles_ppse
	;A partir de aquí leo los SSprites para los enemigos
	LD	B,1
otro_enemigo_ppse
  	LD	A,(HL)
  	CP	255
  	JR	Z,fin_ssprites_ppse
  	LD	BC,6
  	ADD	HL,BC
  	JR	otro_enemigo_ppse
fin_ssprites_ppse
	INC	HL
	;a partir de aqui cojo el objeto de la pantalla, si lo hay
	LD	IX,STATIC0
otro_static_ppse
  	LD	A,(HL)
  	INC     HL
  	CP	255
  	JR	Z,espera_CFP_ppse
 	
 	CALL    comun_otro_statics

  	LD	BC,LONG_STATICS
  	ADD 	IX,BC
  	JR	otro_static_ppse
espera_CFP_ppse
	LD	A,(Sig_Interrupcion)
	CP	0
	JR	NZ,espera_CFP_ppse

salir_ppse
        ;LD      HL,TINTAS_JUEGO
	;CALL    Cambia_Tintas_Juego
	CALL	fadein

	;si hay una puerta y está abierta, la subo con scroll
fin_ppse
	XOR	A
	LD	(Pas_Interrupcion),A
	RET
;;
;;Pinta la pantalla dada en A
;;
;;ENTRADA
;;A: pantalla a pintar
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
Pinta_Pantalla
	CP	#FF
	RET	Z
	PUSH	AF
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	LD	HL,SPRITE0_CHECKS
	BIT     CHECK_MUERTE,(HL)
	CALL	Z,fadeout
        LD      HL,TINTAS_Negro
	CALL    Z,Cambia_Tintas_Juego
	CALL	imprime_vidas
	LD	HL,SPRITE0_CHECKS
	RES     CHECK_MUERTE,(HL)
	LD	A,1
	LD	(CHECK_ASIGNA_DUREZAS),A
        POP	AF
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
	LD 	HL,STATIC0_ID
	LD	(HL),#FF
	LD 	HL,STATIC1_ID
	LD	(HL),#FF
	LD 	HL,STATIC2_ID
	LD	(HL),#FF
	LD 	HL,STATIC3_ID
	LD	(HL),#FF
	LD 	HL,STATIC4_ID
	LD	(HL),#FF

	LD	HL,BUFFER
	LD	(Buffer_actual),HL

	PUSH	AF
	CALL	Borra_Mapa_Durezas		;no haría falta, pero es más limpio así
	CALL    Borra_Pantalla
	POP	AF
	PUSH	AF
	CALL	Tramas_PuzzlesP1
	POP	AF

  	LD	HL,PANTALLA_ACTUAL
  	LD	(HL),A
	LD	HL,MAPA_PANTALLAS
	RLCA
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD   	A,(HL)
  	LD	E,A
  	INC  	HL
  	LD	A,(HL)
  	LD   	D,A			
  	EX	DE,HL			;dejo en HL la posición de la pantalla (PANTALLA_XX)

  	LD	DE,DATOS_PANTALLA_ACTUAL
  	LD	BC,4
  	LDIR				;vuelco los datos iniciales de la pantalla
  					;IZQ,DER,ARR,ABA,PUERTA,PosXPuerta,PosYPuerta
  	;A partir de aquí leo los STiles y los voy pintando y apuntando su dureza
  	LD	A,(HL)
  	CP	255
  	JR	NZ,inicio_stiles_pp
  	INC	HL
  	LD	A,(HL)
  	INC	HL
  	PUSH	HL
  	LD	H,(HL)
  	LD	L,A
inicio_stiles_bucle_pp
  	LD	A,(HL)
  	INC     HL
  	CP	255
  	JR	Z,fin_stiles_bucle_pp
  	LD	E,A			;en E dejoel STile
  	CALL	Coge_Supertiles
  	JR	inicio_stiles_bucle_pp
fin_stiles_bucle_pp
  	POP     HL
  	INC	HL
  	JR	fin_stiles_pp
inicio_stiles_pp
  	LD	A,(HL)
  	INC     HL
  	CP	255
  	JR	Z,fin_stiles_pp
  	LD	E,A			;en E dejoel STile
  	CALL	Coge_Supertiles
  	JR	inicio_stiles_pp
fin_stiles_pp
	;A partir de aquí leo los SSprites para los enemigos
	LD	IX,SPRITE1
	LD	B,1
otro_enemigo_pp
	PUSH	HL
	POP	IY
  	LD	A,(HL)
  	CP	255
  	JR	Z,fin_ssprites_pp
  	PUSH	BC
  	CALL	Coge_Supersprites	;en B va el sprite_ID
  	LD	BC,LONG_SPRITES
  	ADD	IX,BC			;siguiente sprite
  	PUSH	IY
  	POP	HL
  	LD	BC,6
  	ADD	HL,BC
  	POP	BC
  	INC	B
  	JR	otro_enemigo_pp
fin_ssprites_pp
	LD	A,B
	DEC	A
	LD	(SPRITES_PANTALLA),A
	INC	HL
	;a partir de aqui cojo el objeto de la pantalla, si lo hay
	LD	IX,STATIC0
otro_statics_pp
  	LD	A,(HL)
  	INC     HL
  	CP	255
  	JR	Z,espera_CFP_pp

  	CALL    comun_otro_statics

  	LD	BC,LONG_STATICS
  	ADD	IX,BC
  	JR	otro_statics_pp

espera_CFP_pp
	LD	A,(Sig_Interrupcion)
	CP	0
	JR	NZ,espera_CFP_pp

	LD	A,(PANTALLA_ACTUAL)
	CP	PANTALLA_MENU
	JR	Z,salir_pp

	LD	A,%00001101
	LD	(SPRITE0_INT),A

	LD	HL,(Buffer_actual)
	LD	(SPRITE0_BUFF),HL

	LD	IX,SPRITE0
	CALL	Bck_Sprite0

	LD	HL,SPRITE0_CHECKS
	RES	CHECK_CAMBIO,(HL)
salir_pp
        ;LD      HL,TINTAS_JUEGO
	;CALL    Cambia_Tintas_Juego
	LD	A,(PANTALLA_ACTUAL)
	CP	PANTALLA_MENU
	CALL	NZ,fadein

	XOR	A
	LD	(Pas_Interrupcion),A
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;activo int de cfp por primera vez	
				;luego de capturar buffers se pondrá a #00
	;una vez que disparo la captura de los bufferes,
	;en la Int5 activo el resto de interrupciones
	;así se produce en el orden correcto
	RET


comun_otro_statics
 	LD	(IX+S_ID),A	;ID
 	;LD	E,A
  	LD	A,(HL)
  	INC     HL
  	LD	(IX+S_TIPO),A	;tipo
  	LD	A,(HL)
  	INC     HL
  	LD	(IX+S_X),A	;X
  	LD	C,A
  	LD	A,(HL)
  	INC     HL
  	LD	(IX+S_Y),A	;Y
  	LD	B,A
  	LD	A,(HL)
  	INC     HL
  	LD	(IX+S_STILE),A
  	LD	A,(HL)
  	LD	E,A
  	LD	(IX+S_STILE+1),A
  	INC	HL
  	LD	A,(HL)
  	LD	(IX+S_CONS),A
  	INC	HL
  	LD	A,(HL)
  	LD	(IX+S_CONS+1),A
  	INC	HL
  	LD	A,(HL)
  	LD	(IX+S_TRIGGER),A
  	INC	HL
  	LD	A,(HL)
  	LD	(IX+S_TRIGGER+1),A
	INC	HL  	
	LD	A,(HL)
  	LD	(IX+S_TAG),A
	INC	HL  	
  	JP	Ejecuta_Constructores_Statics



Coge_Supersprites
	LD	(IX+_ID),B		;ID del sprite
	LD	A,(IY+0)
		LD	(IX+_Y),A
		LD	(IX+_ANTY),A
	LD	A,(IY+1)
		LD	(IX+_X),A
		LD	(IX+_ANTX),A
	LD	A,(IY+2)
		LD	(IX+_IDESP),A
		LD	(IX+_DESP),0
		LD	(IX+_ADESP),0
	LD	A,(IY+3)
		LD	(IX+_ICAD),A
		LD	(IX+_CAD),A
	LD	L,(IY+4)
	LD	H,(IY+5)
	LD	A,(HL)
		AND	%11100000
		SRL     A
		SRL     A
		SRL     A
		SRL     A
		SRL     A
		LD	(IX+_ANCHO),A
	LD	A,(HL)
		AND	%00011111
		LD	(IX+_ALTO),A
	INC	HL
	LD	A,(HL)
		AND	%11110000
		SRL     A
		SRL     A
		SRL     A
		SRL     A
		LD	(IX+_SPR),A
		LD	(IX+_SPR_A),0

	LD	A,(HL)
		AND	%00001100
		SRL     A
		SRL     A
		LD	(IX+_MIRADA),A
		CP	IZQUIERDA
		JR	NZ,normal_CS
		LD	C,(IX+_IDESP)
		LD	(IX+_DESP),C
		LD	(IX+_ADESP),C
		LD	A,(IX+_X)
		ADD	A,C
		LD	(IX+_X),A
normal_CS
	LD	A,(HL)
		AND	%00000011
		SLA	A
		SLA	A
		SLA	A
		SLA	A
		SLA	A
		SLA	A
		LD	(IX+_CHECKS),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_DSPR),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_DSPR+1),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_UPD),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_UPD+1),A
	LD	A,(IX+_ANCHO)
	OR	A
	RET	Z			;si es un enemigo NULO no lo añado a la lista
	LD	A,B
	CALL	Actualiza_Tabla_INT_cfp
	CALL	Actualiza_Tabla_INT_UPD
	CALL	Actualiza_Tabla_INT_isp
	LD	A,(IX+_IDESP)
	LD	DE,(Buffer_actual)
	LD	(IX+_BUFF),E
	LD	(IX+_BUFF+1),D
	JP	Incrementa_Buffer

;;
;;Coge el STile A en las posiciones hasta encontrar 255
;;y manda pintarlo
;;
;;ENTRADA
;;E: STILE
;;SALIDA
;;Nada
;;destruye A,HL,BC
;;
Coge_Supertiles
	LD      C,(HL)		;en C las X del STile E
	INC	HL
	LD	A,(HL)		;en B las Y del STile E
	INC     HL
	PUSH	AF
	AND	%01111111
	LD	B,A	
	PUSH    DE
	BIT	7,E
	JR	NZ,rotado_cs
	CALL	Pinta_Supertile		;pinto el STile E en BC
	JR	fin_cs
rotado_cs
	CALL	Pinta_Supertile_Rotado	;pinto el STile E en BC ROTADO
fin_cs
	POP     DE
	POP	AF
	AND	#80
	JR	Z,Coge_Supertiles
	RET

;;
;;Asigna las durezas del mapa en BC
;;
;;ENTRADA
;;BC:Coordenadas (Y,X)
;;A':tile
;;E:tile u objeto?
;;SALIDA
;;Nada
;;destruye BC,HL,A
;;
Asigna_Durezas
	SRL	C
	SRL	C
	SRL	C

	PUSH	DE
        LD      HL,MAPA_DUREZAS
        LD      D,0
        LD      E,B
        ADD     HL,DE           ;primera posición de las Y recibidas del array
        XOR	A
        LD      E,C
        SRL     E
        RLA
        SRL     E
        RLA
        ADD     HL,DE           ;me posiciono en el byte a tocar
                                ;ahora toca cambiar los bits correspondientes
                           	;en A queda el resto para elegir la pareja de bits
        POP	DE
        EX	AF,AF'
        CP	DUREZAS_TOTAL
        JR	C,durezas_total_ad
        CP	DUREZAS_MATAN
        JR	C,durezas_matan_ad
        LD	B,BIT_VACIO
        JR	asigna_durezas_ad
durezas_total_ad
	LD	B,BIT_TOTAL
	JR	asigna_durezas_ad
durezas_matan_ad
	LD	B,BIT_MATAN
asigna_durezas_ad
	PUSH	AF
	LD	A,E
	AND	%10000000	;si en el juego de tiles del STILE lleva #80, es un objeto
	CP	#80
	JR	NZ,normal_AD
	LD	B,BIT_OBJETO
normal_AD
	POP	AF
        EX	AF,AF'
	LD	C,%11111100
;si el resto es 3 no muevo B
        CP	3
        JR	Z,fin_ad
	LD	C,%11110011
        SLA	B
        SLA	B
;si el resto es 2 muevo B dos veces
	CP	2
        JR	Z,fin_ad
	LD	C,%11001111
        SLA	B
        SLA	B
;si el resto es 1 muevo B cuatro veces
	CP	1
        JR	Z,fin_ad
	LD	C,%00111111
        SLA	B
        SLA	B
;si el resto es 0 muevo B seis veces
fin_ad
	LD	A,C		;si hay alguna dureza anterior la borro
	AND	(HL)		;por si hay dos stiles en el mismo sitio con distintas durezas
	OR	B		;añado la dureza actual
	LD	(HL),A		;lo guardo en el mapa
        RET

;;
;;lees las durezas del mapa en BC
;;
;;ENTRADA
;;BC:Coordenadas (Y,X)
;;SALIDA
;;A:dureza según las constantes BIT_
;;destruye BC,DE,HL,A
;;
Lee_Durezas
	XOR	A
	SRL	C	;X/2
	SRL	B
	RL	A
	SRL	B
	RL	A
	SRL	B	;Y/8
	RL	A	;resto en A
	XOR	E	;C=0
	SLA	B
	SLA	B
	SLA	B	;Y=Y*8+A
; 	OR	A	;si hay resto sumo 8 a las Y
; 	JR	Z,esta_en_posY_LD
; 	LD	A,B
; 	ADD	A,8
; 	LD	B,A
; esta_en_posY_LD

        LD      HL,MAPA_DUREZAS
        LD      D,0
        LD      E,B
        ADD     HL,DE           ;primera posición de las Y recibidas del array
        XOR	A
        LD      E,C
        SRL     E
        RLA
        SRL     E
        RLA
        ADD     HL,DE           ;me posiciono en el byte a tocar
                                ;ahora toca cambiar los bits correspondientes
                           	;en A queda el resto para elegir la pareja de bits
	OR	A
	JR	Z,pareja_0_ld
	CP	1
	JR	Z,pareja_1_ld
	CP	2
	JR	Z,pareja_2_ld
pareja_3_ld
	LD	A,(HL)
	AND	%00000011
        RET
pareja_2_ld
	LD	A,(HL)
	AND	%00001100
	SRL	A
	SRL	A
	RET
pareja_1_ld
	LD	A,(HL)
	AND	%00110000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	RET
pareja_0_ld
	LD	A,(HL)
	AND	%11000000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	RET

;;
;;Pinta en pantalla el STile E en BC (Y,X)
;;
;;ENTRADA
;;E:STile
;;BC:Coordenadas (Y,X)
;;SALIDA
;;Nada
;;destruye A,A',DE
;;
Pinta_Supertile_HL_Objeto
	PUSH	HL
	LD	E,#80
	JR	Pinta_Supertile1_HL
Pinta_Supertile_HL
	PUSH	HL
	LD	E,0
	JR	Pinta_Supertile1_HL
Pinta_Supertile
	PUSH	HL
	LD	HL,MAPA_STILES
	AND     A
	LD	D,0
	;DEC	E		;resto 1 al stile para empezar desde 0
	RL	E
	ADD	HL,DE
	LD	E,(HL)
	INC     HL
	LD      D,(HL)
	EX      HL,DE		;en HL tengo la direccion del STile
	LD	E,0
Pinta_Supertile1_HL
	LD	A,(HL)
	AND	%10000000
	RLA
	RLA
	ADD	A,5
	OR	E		;si tiene el #80 es objeto
	LD	E,A		;juego de Tiles
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
alto_ps
	PUSH	AF
	PUSH	BC
ancho_ps
	PUSH    AF	
	LD	A,(HL)		;tile
	EX	AF,AF'
	PUSH	HL
	PUSH	BC
	PUSH	DE
	LD	A,(CHECK_ASIGNA_DUREZAS)
	CP	1
	CALL	Z,Asigna_Durezas
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,E
	AND     %01111111
	LD	E,A
	LD	A,C
	CP	255
	CALL	NZ,write_tile_screen_YX
	POP	DE
	POP	BC
	POP	HL
	LD 	A,C
	CP	ANCHO_MAPA_PX-8
	JR      C,sin_desborde_x_ps
	LD      C,255
	JR	con_desborde_x_ps
sin_desborde_x_ps
	ADD	A,8
	LD	C,A
con_desborde_x_ps
	INC	HL
	POP	AF
	DEC	A
	JR      NZ,ancho_ps

	POP	BC
	LD	A,B
	ADD	A,8
	LD	B,A
	CP	128
	JR      C,salida_sin_desborde_y_ps
	LD	D,1
salida_sin_desborde_y_ps
	POP	AF
	DEC	D
	JR	NZ,alto_ps


	POP	HL
	RET

;;
;;Pinta en pantalla el STile E en BC (Y,X) ROTADO
;;
;;ENTRADA
;;E:STile
;;BC:Coordenas (Y,X)
;;SALIDA
;;Nada
;;destruye A,A',DE,BC
;;
Pinta_Supertile_HL_Rotado
	PUSH    HL
	JR	Pinta_Supertile1_HL_Rotado
Pinta_Supertile_Rotado
	PUSH	HL
	LD	HL,MAPA_STILES
	AND     A
	LD	D,0
	;DEC	E		;resto 1 al stile para empezar desde 0
	RL	E
	ADD	HL,DE
	LD	E,(HL)
	INC     HL
	LD      D,(HL)
	EX      HL,DE		;en HL tengo la direccion del STile
Pinta_Supertile1_HL_Rotado
	LD	A,(HL)
	AND	%10000000
	RLA
	RLA
	ADD	A,5
	LD	E,A		;juego de Tiles
	;ancho
	LD      A,(HL)
	AND	%01110000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	DEC	A
	RLA
	RLA
	RLA
	ADD	A,C
	LD	C,A
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

alto_psr
	PUSH	AF
	PUSH	DE
	PUSH	BC
ancho_psr
	PUSH    AF	
	LD	A,(HL)		;tile
	EX	AF,AF'
	PUSH	HL
	PUSH	BC
	PUSH	DE
	LD	A,(CHECK_ASIGNA_DUREZAS)
	CP	1
	CALL	Z,Asigna_Durezas
	POP	DE
	POP	BC
	PUSH	BC
	LD	A,C
	CP	255
	PUSH	DE
	CALL	NZ,write_tile_screen_rotado_YX
	POP	DE
	POP	BC
	POP	HL
	LD 	A,C
	CP	0
	JR      NZ,sin_desborde_x_psr
	LD      C,255
	JR	con_desborde_x_psr
sin_desborde_x_psr
	SUB	A,8
	LD	C,A
con_desborde_x_psr
	INC	HL
	POP	AF
	DEC	A
	JR      NZ,ancho_psr

	POP	BC
	POP	DE
	LD	A,B
	ADD	A,8
	LD	B,A
	CP	ALTO_MAPA_PX
	JR      C,salida_sin_desborde_y_psr
	LD	D,1
salida_sin_desborde_y_psr
	POP	AF
	DEC	D
	JR	NZ,alto_psr


	POP	HL
	RET

;;Borra la zona del Mapa de Durezas
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye HL,BC,DE
;;
Borra_Mapa_Durezas
	LD	HL,MAPA_DUREZAS
	LD	DE,MAPA_DUREZAS+1
	LD	BC,ALTO_MAPA_TILES*ANCHO_MAPA_TILES/DIVBITS_DUREZAS
	LD	(HL),0
	LDIR
	RET


;;Borra la pantalla con el fondo
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye A,HL,DE,BC
;;
Borra_Pantalla
	LD	A,8
  	LD	HL,DIRECCION_JUEGO
bucle_bp
	LD   	D,H
	LD   	E,L
	INC  	DE
	LD   	(HL),BYTE_FONDO_PANTALLA
	LD   	BC,1023                 
	PUSH 	HL
	LDIR                                    ; Vuelca la primera linea
	POP  	HL
	LD   	BC,#800
	ADD  	HL,BC
	DEC  	A					; Así hasta 8
	JR   	NZ,bucle_bp
	RET

;;
;;escribe un tile en pantalla
;;
;;ENTRADA
;;A' Tile
;;BC  Tile Coords (Y,X)
;;E  Juego de Tiles
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
write_tile_screen_YX
	PUSH	DE
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
	POP	BC
	LD	A,C
	AND	%01111111
	LD	H,A
	; Get the tile address ($4000 + tile_number << 4)
	EX   	AF,AF'								; A TILE
	DEC  	A			;resto 1 para empezar desde el tile 0
	SLA  	A          
	RL   	H      
	RLA             
	RL   	H          
	RLA             
	RL   	H          
	RLA             
	RL   	H  
	LD   	L,A                  ; HL Tile address
	EX   	DE,HL                ; HL screen address
				     ; DE TILE address
	; 1º Scanline
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	3,H
	
	; 2º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 4º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	RES  	3,H

	; 3º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	5,H

	; 7º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	RES  	4,H

	; 5º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 6º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 8º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD   	(HL),A

	RET

;;
;;escribe un tile en pantalla ROTADO
;;
;;ENTRADA
;;A' Tile
;;BC  Tile Coords (Y,X)
;;E  Juego de Tiles
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
write_tile_screen_rotado_YX 

	PUSH	DE

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

	POP	BC
	
	LD	A,C
	AND	%01111111
	LD	H,A

	; Get the tile address ($4000 + tile_number << 4)
	EX   	AF,AF'								; A TILE
	DEC  	A			;resto 1 para empezar desde el tile 0
	SLA  	A          
	RL   	H      
	RLA             
	RL   	H          
	RLA             
	RL   	H          
	RLA             
	RL   	H  
	LD   	L,A                  ; HL Tile address
	EX   	DE,HL                ; HL screen address
									; ; DE TILE address
  ; 1º Scanline
	INC  	L  
  	rota_a_de_de  
  	INC  	DE
  	LD   	(HL),A
  	DEC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	SET  3,H

	; 2º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC 	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 4º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	RES  	3,H

	; 3º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	SET  	5,H

	; 7º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	RES  	4,H

	; 5º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 6º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 8º Scanline
	INC  	L
	rota_a_de_de  
	INC  	DE
	LD   	(HL),A
	DEC  	L
	rota_a_de_de  
	LD   	(HL),A

	RET

Tramas_PuzzlesP1
	CP	4
	JR	NZ,otra_TP
	LD	HL,(dstile_pantalla4)
	LD	BC,#6018
	JP	Pinta_Supertile_HL
otra_TP
	CP	8
	JR	NZ,otra1_TP
	LD	HL,(dstile_pantalla8)
	LD	BC,#30D0
	JP	Pinta_Supertile_HL
otra1_TP
	CP	9
	JR	NZ,otra2_TP
	LD	HL,(dstile_pantalla9)
	LD	BC,#0020
	JP	Pinta_Supertile_HL
otra2_TP
	CP	11
	JR	NZ,otra3_TP
	LD	HL,(dstile_pantalla11)
	LD	BC,#00A8
	JP	Pinta_Supertile_HL
otra3_TP
	CP	19
	JR	NZ,otra5_TP
	LD	HL,dstile_t1		;rojo
	LD	BC,#0048
	JP	Pinta_Supertile_HL
otra5_TP
	CP	20
	JR	NZ,otra6_TP
	LD	HL,dstile_t4		;naranja
	LD	BC,#60A0
	JP	Pinta_Supertile_HL
otra6_TP
	CP	23
	JR	NZ,otra7_TP
	LD	HL,dstile_t3		;rosa
	LD	BC,#1030
	JP	Pinta_Supertile_HL
otra7_TP
	CP	25
	JR	NZ,otra8_TP
	LD	HL,dstile_t2		;azul
	LD	BC,#4810
	JP	Pinta_Supertile_HL
otra8_TP
	CP	32
	JR	NZ,otra9_TP
	LD	HL,dstile_t2		;azul
	LD	BC,#60C8
	JP	Pinta_Supertile_HL
otra9_TP
	CP	33
	JR	NZ,otra10_TP
	LD	HL,dstile_t3		;azul
	LD	BC,#6068; ,#1c*4,#68
	JP	Pinta_Supertile_HL
otra10_TP
	CP	34
	JR	NZ,otra11_TP
	LD	HL,dstile_t1		;azul
	LD	BC,0; ,#1c*4,#68
	JP	Pinta_Supertile_HL
otra11_TP
	CP	36
	JR	NZ,otra12_TP
	LD	HL,dstile_t3		;azul
	LD	BC,#6008; ,#1c*4,#68
	JP	Pinta_Supertile_HL
otra12_TP
	CP	43
	JR	NZ,otra13_TP
	LD	HL,dstile_t1		;rojo
	LD	BC,#08C0; ,#1c*4,#68
	JP	Pinta_Supertile_HL
otra13_TP
	CP	54
	RET	NZ
	LD	HL,dstile_t3		
	LD	BC,#20C0; ,#1c*4,#68
	JP	Pinta_Supertile_HL

Inicializa_tramas_aleatorias
	LD	A,STILE_85			
	LD	(dstile_puzzle13),A
	LD	HL,dstile_t85
	LD	(dstilet_puzzle13),HL
	LD	HL,temp_puzzle11
	LD	(HL),1
	LD	DE,temp_puzzle11+1
	LD	BC,7
	LDIR
	;INC	HL
	;LD	(HL),1
	;INC	HL
	;LD	(HL),1
	;INC	HL
	;LD	(HL),1

	LD	A,(Pas_Interrupcion)		;es "aleatorio"
	AND	%00000011
	CP	1
	JR	NZ,sig0_ibm
sig_ibm
	LD	HL,sig_ibm_data
	JR	salir_sig_IBM
; 	LD	HL,dstile_t1
; 	LD	(dstile_pantalla4),HL
; 	LD	HL,dstile_t2
; 	LD	(dstile_pantalla8),HL
; 	LD	HL,dstile_t3
; 	LD	(dstile_pantalla9),HL
; 	LD	HL,dstile_t4
; 	LD	(dstile_pantalla11),HL

; 	LD	HL,dSTILE_diamante_rojo
; 	LD	(dstile_pantalla14),HL
; 	LD	HL,dSTILE_Bombona
; 	LD	(dstile_pantalla19),HL
; 	LD	HL,dSTILE_Mosca
; 	LD	(dstile_pantalla22),HL
; 	LD	HL,dSTILE_Cucaracha
; 	LD	(dstile_pantalla24),HL

; 	LD	HL,objeto_puzzle1
; 	LD	(HL),15
; 	INC	HL
; 	LD	(HL),14
; 	INC	HL
; 	LD	(HL),16
; 	INC	HL
; 	LD	(HL),17

; 	LD	HL,objeto_puzzle11
; 	LD	(HL),1
; 	INC	HL
; 	LD	(HL),3
; 	INC	HL
; 	LD	(HL),2
; 	INC	HL
; 	LD	(HL),4
;	RET
sig0_ibm
	CP	2
	JR	NZ,sig1_ibm
	LD	HL,sig0_ibm_data
	JR	salir_sig_IBM
; 	LD	HL,dstile_t2
; 	LD	(dstile_pantalla4),HL
; 	LD	HL,dstile_t3
; 	LD	(dstile_pantalla8),HL
; 	LD	HL,dstile_t4
; 	LD	(dstile_pantalla9),HL
; 	LD	HL,dstile_t1
; 	LD	(dstile_pantalla11),HL

; 	LD	HL,dSTILE_diamante_rojo
; 	LD	(dstile_pantalla24),HL
; 	LD	HL,dSTILE_Bombona
; 	LD	(dstile_pantalla14),HL
; 	LD	HL,dSTILE_Mosca
; 	LD	(dstile_pantalla19),HL
; 	LD	HL,dSTILE_Cucaracha
; 	LD	(dstile_pantalla22),HL

; 	LD	HL,objeto_puzzle1
; 	LD	(HL),16
; 	INC	HL
; 	LD	(HL),15
; 	INC	HL
; 	LD	(HL),17
; 	INC	HL
; 	LD	(HL),14

; 	LD	HL,objeto_puzzle11
; 	LD	(HL),3
; 	INC	HL
; 	LD	(HL),2
; 	INC	HL
; 	LD	(HL),4
; 	INC	HL
; 	LD	(HL),1
;	RET
sig1_ibm
	CP	3
	JR	NZ,sig2_ibm
	LD	HL,sig1_ibm_data
	JR	salir_sig_IBM
; 	LD	HL,dstile_t3
; 	LD	(dstile_pantalla4),HL
; 	LD	HL,dstile_t2
; 	LD	(dstile_pantalla8),HL
; 	LD	HL,dstile_t1
; 	LD	(dstile_pantalla9),HL
; 	LD	HL,dstile_t4
; 	LD	(dstile_pantalla11),HL

; 	LD	HL,dSTILE_diamante_rojo
; 	LD	(dstile_pantalla22),HL
; 	LD	HL,dSTILE_Bombona
; 	LD	(dstile_pantalla24),HL
; 	LD	HL,dSTILE_Mosca
; 	LD	(dstile_pantalla14),HL
; 	LD	HL,dSTILE_Cucaracha
; 	LD	(dstile_pantalla19),HL

; 	LD	HL,objeto_puzzle1
; 	LD	(HL),15
; 	INC	HL
; 	LD	(HL),16
; 	INC	HL
; 	LD	(HL),14
; 	INC	HL
; 	LD	(HL),17

; 	LD	HL,objeto_puzzle11
; 	LD	(HL),2
; 	INC	HL
; 	LD	(HL),4
; 	INC	HL
; 	LD	(HL),1
; 	INC	HL
; 	LD	(HL),3
; 	RET
sig2_ibm
	LD	HL,sig2_ibm_data
; 	LD	HL,dstile_t4
; 	LD	(dstile_pantalla4),HL
; 	LD	HL,dstile_t2
; 	LD	(dstile_pantalla8),HL
; 	LD	HL,dstile_t1
; 	LD	(dstile_pantalla9),HL
; 	LD	HL,dstile_t3
; 	LD	(dstile_pantalla11),HL

; 	LD	HL,dSTILE_diamante_rojo
; 	LD	(dstile_pantalla19),HL
; 	LD	HL,dSTILE_Bombona
; 	LD	(dstile_pantalla22),HL
; 	LD	HL,dSTILE_Mosca
; 	LD	(dstile_pantalla24),HL
; 	LD	HL,dSTILE_Cucaracha
; 	LD	(dstile_pantalla14),HL

; 	LD	HL,objeto_puzzle1
; 	LD	(HL),15
; 	INC	HL
; 	LD	(HL),17
; 	INC	HL
; 	LD	(HL),14
; 	INC	HL
; 	LD	(HL),16

; 	LD	HL,objeto_puzzle11
; 	LD	(HL),4
; 	INC	HL
; 	LD	(HL),1
; 	INC	HL
; 	LD	(HL),3
; 	INC	HL
; 	LD	(HL),2
salir_sig_IBM
	LD	DE,dstile_pantalla4
	LD	BC,36
	LDIR
	RET

fadeout
	LD	A,(sm_tinta0+1)
	CP	#54
	RET	Z
	LD	HL,TINTAS_JUEGO
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO1
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO2
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO3
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO4
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_NEGRO
	JP	Cambia_Tintas_Juego
fadein
	LD	A,(sm_tinta0+1)
	CP	#56
	RET	Z
	LD	HL,TINTAS_NEGRO
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO4
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO3
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO2
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO1
	CALL	Cambia_Tintas_Juego
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO
	JP	Cambia_Tintas_Juego

espera_mucho
	LD	BC,3825;7650
	JR	espera_mucho_SP
espera_mucho_80
	LD	BC,12750;25500
espera_mucho_SP
wait_emSP
	DEC	BC
	LD	A,B
	OR	C
	JR	NZ,wait_emSP
	RET

espera_mucho_TEC
	LD	B,30
espera_mucho_SP_TEC
	PUSH	BC
	LD	B,255
wait_TEC
	LD	A,(TECLADO0)
	LD	L,A
	LD      A,(TECLADO1)
	OR	L
	JR	NZ,salir1_TEC
	DJNZ	wait_TEC
	POP	BC
	DJNZ	espera_mucho_SP_TEC
salir_TEC
	LD	A,0
	LD	(Pulsa_Escape),A
	RET
salir1_TEC
	LD	A,(TECLADO0)
	BIT	KEY_ESCAPE,A
	JR	NZ,escape_act
	LD	A,0
	JR	seguir_act
escape_act
	LD	A,1
seguir_act
	LD	(Pulsa_Escape),A
	POP	BC
	RET

;;BC: Y,X
;;HL: puntero a texto (acaba con 255)
Imprime_Texto
	LD	A,(HL)
	CP	#FF
	RET	Z
	PUSH	HL
	ADD	A,CORRECTOR_TEXTO
	EX	AF,AF'
	PUSH	BC
	LD	E,JUEGO_TILES_2
	CALL	write_tile_screen_YX
	CALL	wVb1
	POP	BC
	POP	HL
	LD	A,C
	ADD	8
	LD	C,A
	INC	HL
	JR	Imprime_Texto

;;BC: Y,X
;;HL: Puntero al texto
;;A:  Ancho Scroll
Scroll_Texto_STEC
	PUSH	HL
	PUSH	AF
	LD	HL,espera_mucho_80
	LD	A,0
	JR	sigue_STST
Scroll_texto
	PUSH	HL
	PUSH	AF
	LD	HL,espera_mucho_TEC
	LD	A,%11000000
sigue_STST
	LD	(comprueba_teclado),A
	LD	(comprueba_teclado1),A
	LD	(comprueba_teclado3+1),HL
	LD	(comprueba_teclado4+1),HL
	POP	AF
	PUSH	BC
	LD	HL,Buffer_Scroll
	LD	(HL),T_ESPACIO
	LD	DE,Buffer_Scroll+1
	LD	BC,31
	LDIR
	POP	BC
	POP	HL
scrolea_1_ST
	PUSH	HL
	PUSH    BC
	LD	HL,Buffer_Scroll+1
	LD	DE,Buffer_Scroll
	LD	BC,31
	LDIR
	POP	BC
	POP	HL
	EX	AF,AF'			;salvo el ancho
	LD	A,(TECLADO0)
	LD	E,A
	LD      A,(TECLADO1)
	OR	E
comprueba_teclado
	RET	NZ
	LD	A,(HL)
	CP	#FF
	JR	Z,fin_scroll0_ST
	LD	(Buffer_Scroll+31),A
	PUSH	HL
	PUSH    BC
	LD	HL,Buffer_Scroll
	EX	AF,AF'			;recupero el ancho
	LD	B,A
	LD	C,A
	LD	A,31
	SUB	C
	LD	C,A
	LD	A,B
	LD	B,0
	ADD	HL,BC
	POP	BC
	PUSH	BC
	PUSH	AF
	CALL 	Imprime_Texto
comprueba_teclado3
	CALL	espera_mucho_TEC
	CALL	wVb1
	POP	AF
	POP	BC
	POP	HL
	INC	HL
	JR      scrolea_1_ST
fin_scroll0_ST
	EX	AF,AF'
	LD	D,A
	INC	D
	EX	AF,AF'
fin_scroll_ST
	PUSH	DE
	LD	A,T_ESPACIO
	LD	(Buffer_Scroll+31),A
	PUSH    BC
	LD	HL,Buffer_Scroll
	EX	AF,AF'			;salvo el ancho
	LD	B,A
	LD	C,A
	LD	A,31
	SUB	C
	LD	C,A
	LD	A,B
	LD	B,0
	ADD	HL,BC
	POP	BC
	PUSH	BC
	PUSH	AF
	CALL 	Imprime_Texto
comprueba_teclado4
	CALL	espera_mucho_TEC
	CALL	wVb1
	POP	AF
	EX	AF,AF'
	POP	BC
	PUSH    BC
	LD	HL,Buffer_Scroll+1
	LD	DE,Buffer_Scroll
	LD	BC,31
	LDIR
	POP	BC

	POP	DE
	
	LD	A,(TECLADO0)
	LD	L,A
	LD      A,(TECLADO1)
	OR	L
comprueba_teclado1
	RET	NZ

	DEC	D

	RET	Z
	JR	fin_scroll_ST
