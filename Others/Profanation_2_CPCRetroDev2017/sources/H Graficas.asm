;;----------------------------------------------
;;Captura_Fondo_Pantalla
;;Captura el buffer del sprite IX
;;----------------------------------------------
;;Incrementa_Buffer
;;Actualiza el buffer al nuevo buffer para el siguiente sprite
;;----------------------------------------------

;;
;;Actualiza el buffer al nuevo buffer para el siguiente sprite
;;
;;ENTRADA
;;IX:dirección del objeto sprite
;;SALIDA
;;Nada
;;destruye BC,HL,DE,A
;;
Incrementa_Buffer
    LD      HL,(Buffer_actual)
    LD      A,(IX+_IDESP)
    CP      #ff                 ;si es #FF captura "normal"
    JR      NZ,inc_fondo_IB
    LD      B,(IX+_ANCHO)
    DEC     B
    LD      C,(IX+_ALTO)
    LD      A,C
otro_IB
    ADD     A,C
    DJNZ    otro_IB
    LD      C,A
    ADD     HL,BC
    JR      fin_IB
inc_fondo_IB
    ;si no es #FF, captura todo el fondo
    ;hay que modificarlo para movimientos verticales
    LD      A,(IX+_MIRADA)
    CP      ARRIBA
    JR      Z,inc_fondo_vert_IB
    CP      ABAJO
    JR      Z,inc_fondo_vert_IB
    LD      A,(IX+_IDESP)
    LD      C,A
    LD		A,(IX+_ANCHO)
    ADD		A,C
    LD		C,A
    LD      B,0
    LD      E,(IX+_ALTO)
otro1_IB
    ADD     HL,BC
    DEC     E
    JR      NZ,otro1_IB
    JR      fin_IB
inc_fondo_vert_IB
    LD      A,(IX+_IDESP)
    LD      C,A
    LD      A,(IX+_ALTO)
    ADD     A,C
    LD      C,A
    LD      B,0
    LD      E,(IX+_ANCHO)
otro2_IB
    ADD     HL,BC
    DEC     E
    JR      NZ,otro2_IB
fin_IB
    LD      (Buffer_actual),HL
;temporal para calcular el máximo buffer
;     LD      DE,(Buffer_Mayor)
;     LD      A,H
;     CP      D
;     JR      Z,bajo_IB
;     JR      NC,mayor_IB
; bajo_IB
;     LD      A,L
;     CP      E
;     JR      C,salir_IB
; mayor_IB
;     LD      (Buffer_Mayor),HL
; salir_IB
    JP      Captura_Bloque_Fondo_Pantalla

;;
;;Captura_Bloque_Fondo_Pantalla
;;
;;ENTRADA
;;IX:dirección del objeto sprite
;;SALIDA
;;Nada
;;destruye 
;;
Captura_Bloque_Fondo_Pantalla
    LD      B,(IX+_Y)
    LD      C,(IX+_X)
    LD      HL,TABLA_SCANLINES
    LD      D,0
    AND     A
    RL      B
    LD      E,B
    ADD     HL,DE
    LD      A,(HL)
    ADD     A,C
    LD      E,A
    INC     HL
    LD      A,(HL)
    LD      D,A     ;DE screen address
    EX      DE,HL

    LD      A,(IX+_MIRADA)
    CP      DERECHA
    JP      Z,horizontal_CBFP
    CP      IZQUIERDA
    JP      Z,horizontal_i_CBFP
    JP      vertical_CBFP

horizontal_i_CBFP
    LD      D,0
    LD      E,(IX+_DESP)
    SBC     HL,DE
horizontal_CBFP
    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

	LD		B,(IX+_ALTO)	;ALTO  a capturar
	SRL		B
	SRL		B
	SRL		B				;alto/8

	LD		A,(IX+_IDESP)	;ANCHO a capturar
	CP		#FF
	JR		NZ,ancho_DESP_CBFP
	XOR		A
ancho_DESP_CBFP
	ADD		A,(IX+_ANCHO)
	EX		AF,AF'

    LD		A,8
ocho_veces_CBFP
	PUSH	BC
	PUSH	HL
alto_CBFP
	PUSH	BC
	EX		AF,AF'
	LD		C,A
	LD		B,0
	EX		AF,AF'
	PUSH	HL
	LDIR
	POP		HL
    LD      BC,ANCHO_MAPA_BYTES
    ADD     HL,BC
	POP		BC
	DJNZ	alto_CBFP

	POP		HL
    LD      BC,#800
    ADD     HL,BC
    JR      NC,siguiente_scanline_CBFP
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline_CBFP
	POP		BC

	DEC		A
	JR 		NZ,ocho_veces_CBFP
	RET

vertical_CBFP
    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

    LD      A,(IX+_ANCHO)   ;ANCHO a capturar
    EX      AF,AF'
    
    LD      B,(IX+_ALTO)    ;ALTO  a capturar

    LD      A,(IX+_IDESP)   
    CP      #FF
    JR      NZ,alto_DESP_CBFP
    XOR     A
alto_DESP_CBFP
    ADD     A,(IX+_ALTO)
    ADD     A,B
    LD      B,A

balto_CBFP
    PUSH    BC
    EX      AF,AF'
    LD      C,A
    LD      B,0
    EX      AF,AF'
    PUSH    HL
    LDIR
    POP     HL
    LD      BC,#800
    ADD     HL,BC
    JR      NC,siguiente_scanline1_CBFP
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline1_CBFP
    POP     BC
    DJNZ    balto_CBFP
    RET


;;
;;Captura el buffer del sprite IX
;;
;;ENTRADA
;;IX:dirección del objeto sprite
;;SALIDA
;;Nada
;;destruye BC,HL,DE,A
;;
Captura_Fondo_Pantalla
    LD      (Stack_Anterior),SP

    LD      HL,ANCHO_MAPA_BYTES
    LD      B,0
    LD      C,(IX+_ANCHO)  ;6, 4 o 2
    XOR     A
    SBC     HL,BC
    LD      SP,HL

    LD      B,(IX+_Y)
    LD      C,(IX+_X)
    LD      HL,TABLA_SCANLINES
    LD      D,0
    AND     A
    RL      B
    LD      E,B
    ADD     HL,DE
    LD      A,(HL)
    ADD     A,C
    LD      E,A
    INC     HL
    LD      A,(HL)
    LD      D,A     ;DE screen address
    EX      DE,HL

    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

bucle4_bytes
    LD      A,8			; número de líneas a dibujar
bucle_y_cfp_16_4
    LDI					; paso 4 bytes
    LDI
    LDI
    LDI
  
    ADD     HL,SP

    LDI         ; paso 4 bytes
    LDI
    LDI
    LDI

    LD      BC,#800-68
    ADD     HL,BC
    JR      NC,siguiente_scanline_cfp_16_4
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline_cfp_16_4

    DEC     A
    JR      NZ,bucle_y_cfp_16_4

    LD      SP,(Stack_Anterior)

    RET  

Imprime_Bloque_Buffer_Pantalla
    LD      (stack_anterior),SP

    LD      HL,ANCHO_MAPA_BYTES
    LD      B,0
    LD      C,(IX+_ANCHO)  ;6, 4 o 2
    XOR     A
    SBC     HL,BC
    LD      SP,HL

    LD      B,(IX+_ANTY)
    LD      C,(IX+_ANTX)
    LD      HL,TABLA_SCANLINES
    LD      D,0
    AND     A
    RL      B
    LD      E,B
    ADD     HL,DE
    LD      A,(HL)
    ADD     A,C
    LD      E,A
    INC     HL
    LD      A,(HL)
    LD      D,A    			;DE screen address

    LD      L,(IX+_BUFF)
    LD      H,(IX+_BUFF+1)
    LD		C,(IX+_DESP)
    LD      A,(IX+_MIRADA)
    CP      ARRIBA
    JR      NC,vertical_IBBP
    LD		B,0
    ADD		HL,BC

    EX		DE,HL			;HL screen address

    LD      A,(IX+_ANCHO)
    CP      4
    JR      Z,bucle4_bytes_IBBP
    JR      bucle2_bytes_IBBP

bucle4_bytes_IBBP
    LD      A,8								               ; n�mero de l�neas a dibujar
bucle_y_IBBP_4
    EX      HL,DE

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI

    LD		B,0
    LD		C,(IX+_IDESP)
    ADD		HL,BC

    EX      HL,DE

    ADD     HL,SP

    EX      DE,HL

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI

    LD		B,0
    LD		C,(IX+_IDESP)
    ADD		HL,BC

    EX      HL,DE
    LD      BC,#800-68
    ADD     HL,BC
    JR      NC,siguiente_scanline_IBBP_4
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline_IBBP_4

    DEC     A
    JR      NZ,bucle_y_IBBP_4

    LD      SP,(stack_anterior)

    RET  

bucle2_bytes_IBBP
    LD      A,8                                            ; n�mero de l�neas a dibujar
bucle_y_IBBP_2
    EX      HL,DE

    LDI          ; paso 2 bytes
    LDI

    LD      B,0
    LD      C,(IX+_IDESP)
    ADD     HL,BC

    EX      HL,DE
    LD      BC,#800-66
    ADD     HL,BC
    JR      NC,siguiente_scanline_IBBP_2
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline_IBBP_2

    DEC     A
    JR      NZ,bucle_y_IBBP_2

    LD      SP,(stack_anterior)

    RET  

vertical_IBBP

    LD      A,(IX+_ANCHO)
    CP      4
    JR      Z,vertical4_IBBP
    CP      6
    JR      Z,vertical6_IBBP
    JR      vertical2_IBBP

vertical4_IBBP
    SLA     C
    SLA     C
    LD      B,0
    ADD     HL,BC
    EX      HL,DE   ;;HL:pant DE:buff

    LD      SP,#800-4
    LD      A,(IX+_ALTO)
bucle_ancho_IBBP
    EX      DE,HL
    LDI
    LDI
    LDI
    LDI
    EX      DE,HL
    ADD     HL,SP
    JR      NC,siguiente_scanline1_IBBP
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline1_IBBP
    DEC     A
    JR      NZ,bucle_ancho_IBBP

    LD      SP,(stack_anterior)
    RET

vertical6_IBBP
    XOR     A
    LD      B,6
multi6_IBBP
    ADD     A,C
    DJNZ    multi6_IBBP
    LD      C,A
    LD      B,0
    ADD     HL,BC
    EX      HL,DE   ;;HL:pant DE:buff

    LD      SP,#800-6
    LD      A,(IX+_ALTO)
bucle_ancho6_IBBP
    EX      DE,HL
    LDI
    LDI
    LDI
    LDI
    LDI
    LDI
    EX      DE,HL
    ADD     HL,SP
    JR      NC,siguiente_scanline6_IBBP
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline6_IBBP
    DEC     A
    JR      NZ,bucle_ancho6_IBBP

    LD      SP,(stack_anterior)
    RET

vertical2_IBBP
    SLA     C
    LD      B,0
    ADD     HL,BC
    EX      HL,DE   ;;HL:pant DE:buff

    LD      SP,#800-2
    LD      A,(IX+_ALTO)
bucle_ancho2_IBBP
    EX      DE,HL
    LDI
    LDI
    EX      DE,HL
    ADD     HL,SP
    JR      NC,siguiente_scanline12_IBBP
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline12_IBBP
    DEC     A
    JR      NZ,bucle_ancho2_IBBP

    LD      SP,(stack_anterior)
    RET


Imprime_Buffer_Pantalla
    LD      (stack_anterior),SP

    LD      HL,ANCHO_MAPA_BYTES
    LD      B,0
    LD      C,(IX+_ANCHO)  ;6, 4 o 2
    XOR     A
    SBC     HL,BC
    LD      SP,HL

    LD      B,(IX+_ANTY)
    LD      C,(IX+_ANTX)
    LD      HL,TABLA_SCANLINES
    LD      D,0
    AND     A
    RL      B
    LD      E,B
    ADD     HL,DE
    LD      A,(HL)
    ADD     A,C
    LD      E,A
    INC     HL
    LD      A,(HL)
    LD      D,A    			;DE screen address

    LD      L,(IX+_BUFF)
    LD      H,(IX+_BUFF+1)

    EX		DE,HL			;HL screen address

    LD      A,8								               ; n�mero de l�neas a dibujar
bucle_y_wsbs816_4
    EX      HL,DE

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI


    EX      HL,DE

    ADD     HL,SP

    EX      DE,HL

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI


    EX      HL,DE
    LD      BC,#800-68
    ADD     HL,BC
    JR      NC,siguiente_scanline_wsbs816_4
    LD      BC,#C040
    ADD     HL,BC
siguiente_scanline_wsbs816_4

    DEC     A
    JR      NZ,bucle_y_wsbs816_4

    LD      SP,(stack_anterior)

    RET  


Imprime_Sprite_Pantalla
    LD      (stack_anterior),SP

    LD      HL,ANCHO_MAPA_BYTES
    LD      B,0
    LD      C,(IX+_ANCHO)  ;6, 4 o 2
    XOR     A
    SBC     HL,BC
    LD      SP,HL

    LD      H,(IX+ _DSPR+1)
    LD      L,(IX+ _DSPR)
    XOR     A
    LD      E,(IX+ _SPR_A) ;antes A
    RL      E
    LD      D,0
    ADD     HL,DE
    LD      E,(HL)
    INC     HL
    LD      D,(HL)
  
    EX      DE,HL 

    BIT     CHECK_SIMETRIA,(IX+_CHECKS)
    JR      NZ,wss_der11
    LD      A,(IX+ _MIRADA)
    OR      A									;CP   MIRO_DER
    JR      Z,wss_der11
    CP      ABAJO
    JR      Z,wss_der11
wss_izq11
    LD      DE,OFFSET_SPRITES
    ADD     HL,DE
wss_der11
;en hl tengo l direccion del sprite
    LD      B,H
    LD      C,L

exx
    LD      B,(IX+_Y)
    LD      C,(IX+_X)
    LD      HL,TABLA_SCANLINES
    LD      D,0
    AND     A
    RL      B
    LD      E,B
    ADD     HL,DE
    LD      A,(HL)
    ADD     A,C
    exx
    LD      E,A
    exx
    INC     HL
    LD      A,(HL)
    exx
    LD      D,A     ;DE screen address
;en DE la direccion de pantalla
    EX      DE,HL

    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    LD      A,(IX+_ANCHO)
    CP      4
    JR      Z,bucle4_bytes_wss
    CP      2
    JP      Z,bucle2_bytes_wss

bucle6_bytes_wss
    EXX
    LD      B,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_6
    EXX
  
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC

    ADD     HL,SP

    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC

    LD      DE,#800-70
    ADD     HL,DE
    JR      NC,siguiente_scanline_wssd23_6
    LD      DE,#C040
    ADD     HL,DE
siguiente_scanline_wssd23_6
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    EXX

    DJNZ    bucle_y_wssd23_6
    LD      SP,(stack_anterior)
    RET 

bucle4_bytes_wss
    EXX
    LD      B,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_4
    EXX

    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC

    ADD     HL,SP

    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC

    LD      DE,#800-68
    ADD     HL,DE
    JR      NC,siguiente_scanline_wssd23_4
    LD      DE,#C040
    ADD     HL,DE
siguiente_scanline_wssd23_4
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    EXX
    DJNZ    bucle_y_wssd23_4
    LD      SP,(stack_anterior)
    RET 

bucle2_bytes_wss
    EXX
    LD      B,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_2
    EXX

    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC
    LD      A,(BC)
    LD      E,A
    LD      A,(DE) 
    AND     (HL)
    OR      E
    LD      (HL),A
    INC     HL                  ;siguiente dirpan   
    INC     BC

    LD      DE,#800-2
    ADD     HL,DE
    JR      NC,siguiente_scanline_wssd23_2
    LD      DE,#C040
    ADD     HL,DE
siguiente_scanline_wssd23_2
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    EXX

    DJNZ    bucle_y_wssd23_2
    LD      SP,(stack_anterior)
    RET 
