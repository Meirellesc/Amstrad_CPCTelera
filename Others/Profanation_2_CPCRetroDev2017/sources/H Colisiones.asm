;rectangles_collide está en tecsound

Statics_collide
;IX	rectangle a
;IY	static b
;Retorno C si hay colisión
	LD   A,(IY+S_ID)
	CP   #ff
	RET  Z
	CALL	Lee_Estado_Objeto_A
	CP	0
	RET	Z

	LD   A,(IX+_X)
	SLA  A
	SLA  A
	LD   B,(IX+_ANCHO)
	SLA  B
	SLA  B
	ADD  A,B
	LD   B,A								;aRight

 	LD   A,(PANTALLA_ACTUAL)
 	CP   13
 	LD   A,(IY+S_X)					;bLeft
 	JR   Z,no_toques_X_SC
	DEC  A
no_toques_X_SC

	CP   B
	RET  NC									;bLeft<=aRight

	LD   A,(PANTALLA_ACTUAL)
	CP   13
	LD   A,(IY+S_X)
	JR   Z,no_toques_X1_SC
	INC  A
no_toques_X1_SC
	ADD  A,16
	LD   B,A								;bRight
	
	LD   A,(IX+_X)					;aLeft
	SLA  A
	SLA  A
	
	CP   B
	RET   NC								;aLeft<=bRight


	LD   A,(IX+_Y)
	LD   B,(IX+_ALTO)
	ADD  A,B
	LD   B,A								;aTop
	
	LD   A,(IY+S_Y)					;bBottom
	DEC  A
	
	CP   B
	RET  NC									;bTottom<=aTop
	
	LD   A,(PANTALLA_ACTUAL)
	CP   26
	LD   A,(IY+S_Y)
	JR   Z,no_toques_Y_SC
	ADD  A,8
no_toques_Y_SC
	ADD  A,9
	LD   B,A								;bRight
	
	LD   A,(IX+_Y)					;aBottom
	
	CP   B
	RET

