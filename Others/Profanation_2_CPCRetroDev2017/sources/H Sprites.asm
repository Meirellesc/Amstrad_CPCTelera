;;----------------------------------------------
;;Ajusta el sprite al tile siguiente
;;Ajusta_Sprite
;;----------------------------------------------
;;Pasa al siguiente sprite
;;Siguiente_Sprite
;;----------------------------------------------
;;Ejecuta_Rutina_Sprite
;;Ejecuta la rutina de un sprite dado en IX
;;----------------------------------------------
;;Inicializa_Sprite
;;Inicializa los datos de los sprites
;;----------------------------------------------
;;Actualiza_Tabla_INT_cfp
;;Asigna al sprite A, para que capture el fondo de pantalla (cfp)
;;----------------------------------------------
;;Actualiza_Tabla_INT_UPD
;;Asigna al sprite A, para que ejecute rutina de UPDATE
;;----------------------------------------------
;;Asigna_Sprite_ID
;;Devuelve en IX el puntero al sprite A
;;----------------------------------------------
;;Actualiza_Tabla_INT_isp
;;Asigna al sprite A, para que imprima el sprite en pantalla (isp)
;;----------------------------------------------
;;Actualiza_Tabla_INT_ibp
;;Asigna al sprite A, para que imprima el buffer en pantalla (ibp)
;;----------------------------------------------
;;Puede ir hacia derecha A px el sprite
;;Puedo_Ir_a_Derecha
;;----------------------------------------------
;;Puede ir hacia izquierda A px el sprite
;;Puedo_Ir_a_Izquierda
;;----------------------------------------------
;;Puede ir hacia abajo A px el sprite
;;Puedo_Ir_a_Abajo
;;----------------------------------------------
;;Puede ir hacia arriba A px el sprite
;;Puedo_Ir_a_Arriba
;;----------------------------------------------


;;
;;Ajusta el sprite al tile siguiente
;;
;;ENTRADA
;;IX:Sprite
;;SALIDA
;;nada
;;destruye B,AF
;;
Ajusta_Sprite
	XOR	A
	LD	B,(IX+_Y)
	SRL	B
	RRA
	SRL	B
	RRA
	SRL	B	;Y/8
	RRA
	SCF
	CCF
	RRA
	RRA
	RRA
	RRA
	RRA
	OR	A
	RET	Z
	LD	B,A
	LD	A,(IX+_Y)
	ADD	A,8
	SUB	A,B
	LD	(IX+_Y),A
	RET

;;
;;Pasa al siguiente sprite
;;
;;ENTRADA
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	INC	A
	CP	(IX+_SPR)
	JR	C,salir_SS
	JR	Z,salir_SS
	XOR	A
salir_SS
	LD	(IX+_SPR_A),A
	RET


;;
;;Ejecuta la rutina de imprime_sprite_pantalla de IX
;;
;;ENTRADA
;;HL:SPRITEX_INT
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_ISP
	LD	A,(HL)
	AND	BIT_isp
	RET	Z
	LD      A,BIT_NEG_isp
	AND     (HL)
	LD      (HL),A
	JP	Imprime_Sprite_Pantalla

;;
;;Ejecuta la rutina de Imprime_buffer_pantalla de IX
;;
;;ENTRADA
;;HL:SPRITEX_INT
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_IBP
	LD	A,(HL)
	AND	BIT_ibp
	RET	Z
	LD      A,BIT_NEG_ibp
	AND     (HL)
	LD      (HL),A
	LD	A,(IX+_ID)
	CP	0
	JP	Z,Imprime_Buffer_Pantalla
	JP	Imprime_Bloque_Buffer_Pantalla

;;
;;Ejecuta la rutina de Captura_Fondo_Pantalla de IX
;;
;;ENTRADA
;;HL:SPRITEX_INT
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_CFP
	LD	A,(HL)
	AND	BIT_cfp
	RET	Z
	LD      A,BIT_NEG_cfp
	AND     (HL)
	LD      (HL),A
	JP      Captura_Fondo_Pantalla

;;
;;Ejecuta la rutina de un sprite dado en IX
;;
;;ENTRADA
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_Rutina_Sprite
	LD	A,(HL)
	AND	BIT_UPD
	RET	Z
	LD      A,(IX+_UPD)
	LD      (sm_rut_spr0+1),A
	LD      A,(IX+_UPD+1)
	LD      (sm_rut_spr0+2),A
sm_rut_spr0
	JP      0

;;
;;Inicializa los datos de los sprites
;;
;;ENTRADA
;;HL':UPDATE
;;D':Mirada
;;E':desplazamiento
;;B':cadencia o velocidad
;;BC:(y,x)
;;HL:Dirección del sprite
;;A:ID del sprite
;;A':numero de sprites
;;D:ANCHO
;;E:ALTO
;;SALIDA
;;nada
;;destruye Nada
;;
Inicializa_Sprite
	LD	(IX+_ID),A;
	LD	(IX+_UPD),L;
	LD	(IX+_UPD+1),H;
	LD	(IX+_MIRADA),D;
	CP	0
	JR	Z,prota_IS
	LD	(IX+_IDESP),E;
	LD	(IX+_DESP),0;
	LD	(IX+_ADESP),0;
	LD	(IX+_ICAD),B;
	LD	(IX+_CAD),B;
	JR	sigue_IS
prota_IS
	LD	(IX+_PATH),0
	LD	(IX+_PATH+1),0
	LD	(IX+_CHECKS),0
sigue_IS
	EXX
	LD	(IX+_ANTX),C;
	LD	(IX+_X),C;
	LD	(IX+_ANTY),B;
	LD	(IX+_Y),B;
	LD	(IX+_DSPR),L;
	LD	(IX+_DSPR+1),H;
	EX	AF,AF'
	LD	(IX+_SPR),A;
	LD	(IX+_SPR_A),0;
	LD	(IX+_ANCHO),D;
	LD	(IX+_ALTO),E;
	EX	AF,AF'
	CALL	Actualiza_Tabla_INT_cfp
	CALL	Actualiza_Tabla_INT_UPD
	JP	Actualiza_Tabla_INT_isp

;;
;;Asigna al sprite A, para que capture el fondo de pantalla (cfp)
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_cfp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_cfp
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que ejecute rutina de UPDATE
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_UPD
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_UPD
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que imprima el sprite en pantalla (isp)
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_isp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_isp
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que imprima el buffer en pantalla (ibp)
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_ibp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_ibp
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Devuelve en IX el puntero al sprite A
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;IX:dirección del sprite
;;destruye BC,HL,DE
;;
Asigna_Sprite_ID
	LD	HL,SPRITE0_ID
	LD	DE,LONG_SPRITES
	LD	B,NUMERO_SPRITES
otro_asID
	LD	C,(HL)
	CP	C
	JR	Z,fin_asID
	ADD	HL,DE
	DJNZ	otro_asID
fin_asID
	PUSH	HL
	POP	IX
	RET

;;
;;Puede ir hacia izquierda A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede
;;destruye HL,BC,DE,AF
;;
Puedo_Ir_a_Izquierda
	LD	L,(IX+_ALTO)
	SRL	L
	SRL	L
	SRL	L
	LD	D,A
	LD	A,(IX+_X)
	SUB	A,D
	CP	ANCHO_MAPA_BYTES
	RET	NC
	LD	C,A
	LD	H,(IX+_Y)
	XOR	A
	SRL	H
	RL	A
	SRL	H
	RL	A
	SRL	H
	RL	A
	OR	A
	JR	Z,sigue_PIAI
	INC	L
sigue_PIAI
	LD	H,0
otro_PIAI
	PUSH	HL
	LD	A,(IX+_Y)
	ADD	A,H
	LD	B,A
	PUSH	BC
	CALL	Lee_Durezas		;;BC,DE,HL
	POP	BC
	POP	HL
	OR	A
	JR	NZ,salir_PIADI
	LD	A,8
	ADD	A,H
	LD	H,A
	DEC	L
	JR	NZ,otro_PIAI
	SCF
	RET

;;
;;Puede ir hacia derecha A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede
;;destruye HL,BC,DE,AF
;;
Puedo_Ir_a_Derecha
	LD	L,(IX+_ALTO)
	SRL	L
	SRL	L
	SRL	L
	LD	D,(IX+_X)
	LD	E,(IX+_ANCHO)
	ADD	A,D
	ADD	A,E
	CP	ANCHO_MAPA_BYTES+1
	RET	NC
	LD	C,A
	DEC	C
	LD	H,(IX+_Y)
	XOR	A
	SRL	H
	RL	A
	SRL	H
	RL	A
	SRL	H
	RL	A
	OR	A
	JR	Z,sigue_PIAD
	INC	L
sigue_PIAD
	LD	H,0
otro_PIAD
	PUSH	HL
	LD	A,(IX+_Y)
	ADD	A,H
	LD	B,A
	PUSH	BC
	CALL	Lee_Durezas		;;BC,DE,HL
	POP	BC
	POP	HL
	OR	A
	JR	NZ,salir_PIADI
	LD	A,8
	ADD	A,H
	LD	H,A
	DEC	L
	JR	NZ,otro_PIAD
	SCF
	RET

salir_PIADI
	PUSH	AF
	CP	BIT_MATAN
	JR	NZ,objetos_PIADI
	SET	CHECK_MUERTE,(IX+_CHECKS)
	JR	salir1_PIADI
objetos_PIADI
	CP	BIT_OBJETO
	JR	NZ,salir1_PIADI
	LD	(CHECK_OBJETO),A
salir1_PIADI
	POP	AF
	SCF
	RET

; salir_PIADI
; 	CP	BIT_MATAN
; 	JR	NZ,salir1_PIADI
; 	SET	CHECK_MUERTE,(IX+_CHECKS)
; 	RET
; salir1_PIADI
; 	CP	BIT_OBJETO
; 	JR	NZ,salir2_PIADI
; 	LD	(CHECK_OBJETO),A
; 	RET
; salir2_PIADI
; 	SCF
; 	RET


;;
;;Puede ir hacia abajo A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede, C: no cambio pantalla NC:cambio pantalla
;;destruye BC,DE,AF
;;
Puedo_Ir_a_Abajo
	LD	E,(IX+_ANCHO)
	LD	D,0
	ADD	A,(IX+_Y)
	ADD	A,(IX+_ALTO)
	CP	ALTO_MAPA_PX+1
	RET	NC
	LD	B,A
	DEC	B
otro_PIAAb
	PUSH	DE
	LD	A,(IX+_X)
	ADD	A,D
	LD	C,A
	PUSH	BC
	CALL	Lee_Durezas		;;BC,DE,HL
	POP	BC
	POP	DE
	OR	A
	JR	NZ,salir_PIADI
	INC	D
	DEC	E
	JR 	NZ,otro_PIAAb
	SCF
	RET

;;
;;Puede ir hacia arriba A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede
;;destruye BC,DE,AF
;;
Puedo_Ir_a_Arriba
	LD	E,(IX+_ANCHO)
	LD	D,0
	LD	B,A
	LD	A,(IX+_Y)
	SUB	B
	CP	ALTO_MAPA_BYTES
	RET	NC
	LD	B,A
otro_PIAAr
	PUSH	DE
	LD	A,(IX+_X)
	ADD	A,D
	LD	C,A
	PUSH	BC
	CALL	Lee_Durezas		;;BC,DE,HL
	POP	BC
	POP	DE
	OR	A
	JP	NZ,salir_PIADI
	INC	D
	DEC	E
	JR 	NZ,otro_PIAAr
	SCF
	RET