; Update_Malo_Hor
; 	LD	A,(IX+_MIRADA)
; 	OR	A
; 	JR	NZ,mueve_izqda_UMH
; mueve_derecha_UMH
; 	LD	A,1
; 	CALL	Puedo_Ir_a_Derecha
; 	JR	NZ,cambio_dir_I_UMH
; 	INC	(IX+_X)
; 	JR	salir_UMH
; cambio_dir_I_UMH
; 	LD	A,IZQUIERDA
; 	LD	(IX+_MIRADA),A
; 	JR	salir_UMH
; mueve_izqda_UMH
; 	LD	A,1
; 	CALL	Puedo_Ir_a_Izquierda
; 	JR	NZ,cambio_dir_D_UMH
; 	DEC	(IX+_X)
; 	JR	salir_UMH
; cambio_dir_D_UMH
; 	LD	A,DERECHA
; 	LD	(IX+_MIRADA),A
; salir_UMH
; 	LD	A,(IX+_ID)
;   	CALL	Actualiza_Tabla_INT_cfp
;  	CALL	Actualiza_Tabla_INT_isp
;  	CALL	Actualiza_Tabla_INT_ibp
; 	RET

Update_Malo_Px_Wait
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UMPW
	DEC	(IX+_CAD)
	JP	salir_UMPW
mueve_UMPW
	LD	A,(IX+_MIRADA)
	CP	DERECHA
	JR	Z,mueve_derecha_UMPW
	CP	IZQUIERDA
	JR	Z,mueve_izqda_UMPW
	CP	ARRIBA
	JR	Z,mueve_arriba_UMPW
	CP	ABAJO
	JR	Z,mueve_abajo_UMPW
mueve_derecha_UMPW
	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,cambio_dir_I_UMPW
	INC	(IX+_DESP)
	INC	(IX+_X)
	JR	salir_UMPW
cambio_dir_I_UMPW
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,IZQUIERDA
	JR	salir1_UMPW
mueve_izqda_UMPW
	LD	A,(IX+_DESP)
	OR	A
	JR	Z,cambio_dir_D_UMPW
	DEC	(IX+_DESP)
	DEC	(IX+_X)
	JR	salir_UMPW
cambio_dir_D_UMPW
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,DERECHA
	JR	salir1_UMPW
mueve_abajo_UMPW
	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,cambio_dir_Arr_UMPW
	INC	(IX+_DESP)
	INC	(IX+_Y)
	INC	(IX+_DESP)
	INC	(IX+_Y)
	JR	salir_UMPW
cambio_dir_Arr_UMPW
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,ARRIBA
	JR	salir1_UMPW
mueve_arriba_UMPW
	LD	A,(IX+_DESP)
	OR	A
	JR	Z,cambio_dir_Aba_UMPW
	DEC	(IX+_DESP)
	DEC	(IX+_Y)
	DEC	(IX+_DESP)
	DEC	(IX+_Y)
	JR	salir_UMPW
cambio_dir_Aba_UMPW
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,ABAJO
	JR	salir1_UMPW
salir1_UMPW
	LD	(IX+_MIRADA),A
salir_UMPW
	CALL	Siguiente_Sprite
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Malo_Px
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UMP
	DEC	(IX+_CAD)
	JR	salir_UMP
mueve_UMP
	CALL	Siguiente_Sprite
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,(IX+_MIRADA)
	CP	DERECHA
	JR	Z,mueve_derecha_UMP
	CP	IZQUIERDA
	JR	Z,mueve_izqda_UMP
	CP	ARRIBA
	JR	Z,mueve_arriba_UMP
	CP	ABAJO
	JR	Z,mueve_abajo_UMP
mueve_derecha_UMP
	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,cambio_dir_I_UMP
	INC	(IX+_DESP)
	INC	(IX+_X)
	JR	salir_UMP
cambio_dir_I_UMP
	LD	A,IZQUIERDA
	JR	salir1_UMP
mueve_izqda_UMP
	LD	A,(IX+_DESP)
	OR	A
	JR	Z,cambio_dir_D_UMP
	DEC	(IX+_DESP)
	DEC	(IX+_X)
	JR	salir_UMP
cambio_dir_D_UMP
	LD	A,DERECHA
	JR	salir1_UMP
mueve_abajo_UMP
	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,cambio_dir_Arr_UMP
	INC	(IX+_DESP)
	INC	(IX+_Y)
	INC	(IX+_DESP)
	INC	(IX+_Y)
	JR	salir_UMP
cambio_dir_Arr_UMP
	LD	A,ARRIBA
	JR	salir1_UMP
mueve_arriba_UMP
	LD	A,(IX+_DESP)
	OR	A
	JR	Z,cambio_dir_Aba_UMP
	DEC	(IX+_DESP)
	DEC	(IX+_Y)
	DEC	(IX+_DESP)
	DEC	(IX+_Y)
	JR	salir_UMP
cambio_dir_Aba_UMP
	LD	A,ABAJO
	JR	salir1_UMP
salir1_UMP
	LD	(IX+_MIRADA),A
salir_UMP
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Gota_Ini
	CALL	Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	CP	0		;ya ha vuelto al ppio de la animación
	JR	NZ,salir_UGI
fin_UGI
	LD	HL,DSPR_GOTA
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),0
	LD	HL,Update_Gota
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
salir_UGI
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Gota
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UG
	DEC	(IX+_CAD)
	JR	salir_UG
mueve_UG
	;no es necesario en esta animación pq solo hay un sprite
	;CALL	Siguiente_Sprite  
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A

	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,animacion_fin_UG
	INC	(IX+_Y)
	INC	(IX+_Y)
	INC	(IX+_DESP)
	INC	(IX+_DESP)
	JR	salir_UG
animacion_fin_UG
	LD	HL,DSPR_GOTA_FIN
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),10
	LD	HL,Update_Gota_Fin
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
	LD	A,(PANTALLA_ACTUAL)
	CP	PANTALLA_MENU
	LD	A,SND_GOTA
	CALL	NZ,Toca_FX
salir_UG
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Gota_Fin
	CALL	Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	CP	0		;ya ha vuelto al ppio de la animación
	JR	NZ,salir_UGF
fin_UGF
	LD	HL,DSPR_GOTA_INI
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),2
	LD	HL,Update_Gota_Ini
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
	LD	B,(IX+_IDESP)
	LD	A,(IX+_Y)
	SUB	B
	LD	(IX+_Y),A
	LD	(IX+_DESP),0
salir_UGF
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Piedra
	BIT	CHECK_ACTIVAR,(IX+_CHECKS)
	JR	NZ,activa_caida_Piedra
	LD	B,(IX+_Y)
	INC	B
	LD	C,(IX+_X)
	RL	C
	RL	C
	LD	A,DUREZAS_TOTAL-1
	EX	AF,AF'
	LD	E,0			;para que asigne dureza normal
	CALL	Asigna_Durezas
	LD	B,(IX+_Y)
	INC	B
	LD	C,(IX+_X)
	INC	C
	INC	C
	INC     C
	INC	C
	RL	C
	RL	C
	LD	A,DUREZAS_TOTAL-1
	EX	AF,AF'
	LD	E,0			;para que asigne dureza normal
	CALL	Asigna_Durezas
salir_UPi
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	CALL	Actualiza_Tabla_INT_ibp
	RET

activa_caida_Piedra
	LD	A,SND_PLATAFORMA
	CALL	Toca_FX
	LD	HL,DSPR_PIEDRA_FIN
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),25
	LD	HL,Update_Piedra_Cayendo
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
	JR 	salir_UPi

Update_Piedra_Cayendo
	LD	A,(IX+_DESP)	
	CP	16
	RET	Z
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UPC
	DEC	(IX+_CAD)
	JR	salir_UPC
mueve_UPC
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	CALL	Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	CP	9
	JR	C,salir_UPC
	INC	(IX+_Y)
	INC	(IX+_DESP)
	INC	(IX+_Y)
	INC	(IX+_DESP)
	LD	A,(IX+_DESP)	
	CP	4			;quito durezas
	JR	NZ,salir_UPC
	CALL	quito_durezas_piedra_UPC
salir_UPC
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

quito_durezas_piedra_UPC
	LD	A,(IX+_Y)
	SUB	A,3
	LD	B,A
	LD	C,(IX+_X)
	RL	C
	RL	C
	LD	A,#FF
	EX	AF,AF'
	LD	E,0			;para que asigne dureza normal
	CALL	Asigna_Durezas
	LD	A,(IX+_Y)
	SUB	A,3
	LD	B,A
	LD	C,(IX+_X)
	INC	C
	INC	C
	INC     C
	INC	C
	RL	C
	RL	C
	LD	A,#FF
	EX	AF,AF'
	LD	E,0			;para que asigne dureza normal
	JP	Asigna_Durezas
	

Update_Flecha_Ini
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UFI1
	DEC	(IX+_CAD)
	JR	salir_UFI1
mueve_UFI1
	CALL	Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	CP	0		;ya ha vuelto al ppio de la animación
	JR	NZ,salir_UFI1
fin_UFI1
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,(IX+_CHECKS)
	OR	%01000000
	LD	(IX+_CHECKS),A
	LD	HL,DSPR_FLECHA_MOV
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),0
	LD	HL,Update_Flecha
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
salir_UFI1
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Flecha_Ini1
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UFI11
	DEC	(IX+_CAD)
	CP	1
	JR	Z,salir_UFI1
	RET
mueve_UFI11
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A

fin_UFI11
	LD	A,(IX+_CHECKS)
	OR	%01000000
	LD	(IX+_CHECKS),A
	LD	HL,DSPR_FLECHA_MOV
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),0
	LD	(IX+_SPR_A),0
	LD	HL,Update_Flecha
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
salir_UFI11
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Flecha
	;no es necesario en esta animación pq solo hay un sprite
	LD	A,(IX+_MIRADA)
	CP 	DERECHA
	LD	A,(IX+_DESP)
	JR	Z,der_UF
	CP	0
	JR	sig_UF
der_UF
	CP	(IX+_IDESP)
sig_UF
	JR	Z,animacion_fin_UF
	LD	A,(IX+_MIRADA)
	CP	DERECHA
	JR	NZ,izq_UF
	INC	(IX+_X)
	INC	(IX+_DESP)
	JR	salir_UF
izq_UF
	DEC	(IX+_X)
	DEC	(IX+_DESP)
	JR	salir_UF
animacion_fin_UF
	LD	HL,DSPR_FLECHA_FIN
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),1
	LD	HL,Update_Flecha_Fin
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
salir_UF
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp

Update_Flecha_Fin
	CALL	Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	CP	0		;ya ha vuelto al ppio de la animación
	JR	NZ,salir_UFF
fin_UFF
	LD	A,(IX+_CHECKS)
	XOR	%01000000
	LD	(IX+_CHECKS),A
	LD	HL,DSPR_FLECHA_INI
	LD	(IX+_DSPR),L
	LD	(IX+_DSPR+1),H
	LD	(IX+_SPR),3
	LD	HL,Update_Flecha_Ini1
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
	LD	A,(IX+_MIRADA)
	CP	DERECHA
	JR	NZ,izq_UFF
	LD	B,(IX+_IDESP)
	LD	A,(IX+_X)
	SUB	B
	LD	(IX+_X),A
	LD	(IX+_DESP),0
	RET
izq_UFF
	LD	B,(IX+_IDESP)
	LD	A,(IX+_X)
	ADD	B
	LD	(IX+_X),A
	LD	(IX+_DESP),B
	RET
salir_UFF
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	CALL	Actualiza_Tabla_INT_ibp
	RET

Update_Pinchos_Ini
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UPiI
	DEC	(IX+_CAD)
	JR	salir_UPiI
mueve_UPiI
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	HL,Update_Pinchos
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
	LD	A,(IX+_CHECKS)
	OR	%01000000
	LD	(IX+_CHECKS),A
salir_UPiI
Update_Nulo		;aprovecho un ret cualquiera
Update_Camelot_Phantis
	RET

Update_Pinchos
	CALL	Siguiente_Sprite  
	LD	A,(IX+_SPR_A)
	CP	0
	JR	NZ,salir_UPin
	LD	A,(IX+_CHECKS)
	AND	%10111111
	LD	(IX+_CHECKS),A
	LD	HL,Update_Pinchos_Ini
	LD	(IX+_UPD),L
	LD	(IX+_UPD+1),H
salir_UPin
	LD	A,(IX+_ID)
  	CALL	Actualiza_Tabla_INT_cfp
 	CALL	Actualiza_Tabla_INT_isp
 	JP	Actualiza_Tabla_INT_ibp
