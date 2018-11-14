;;----------------------------------------------
;;Read_Keys
;;Lee el estado del teclado, devolviéndolo en DE
;;----------------------------------------------
;;Cambia_Tintas_Juego
;;Pone el borde y las tintas del juego
;;Las coge de HL
;;----------------------------------------------
;;Cambia_Tintas_Marcador        
;;Pone las tintas del marcador (el borde NO)
;;Las coge de HL
;;----------------------------------------------

;;
;;Lee el estado del teclado, devolviéndolo en DE
;;
;;ENTRADA
;;nada
;;SALIDA
;;DE con las teclas pulsadas
;;------------D
;; JOY_UP              EQU 0
;; JOY_DOWN            EQU 1
;; JOY_LEFT            EQU 2
;; JOY_RIGHT           EQU 3
;; JOY_FIRE1           EQU 4
;; JOY_FIRE2           EQU 5
;; KEY_F2              EQU 6
;; KEY_ESCAPE          EQU 7
;;------------E
;; KEY_F8              EQU 0
;; KEY_1               EQU 1
;; KEY_2               EQU 2
;; KEY_3               EQU 3
;; KEY_4               EQU 4
;; KEY_5               EQU 5
;; KEY_F6              EQU 6
;; KEY_F4              EQU 7
;;destruye BC,A
;;
Read_Keys
        LD      BC,PPI_A + PSG_REG_0E          	; (3) Registro
        OUT     (C),C                          	; (4)
        LD      BC,PPI_C + PPI_PSG_SELECT      	; (3)
        OUT     (C),C                          	; (4)

        DEFB    #ED,#71                        	; (4) PSG Inactivo (CPC+) / OUT (C),0
 
        LD      BC,PPI_CONTROL + %10010010     	; (3) Valor
        OUT     (C),C                         	; (4)
 
        LD      A,%01001001            		; 5є Lнnea de la matriz del teclado a comprobar (bits 3-0 del PPI Port C)
        DEC     B                      
        OUT     (C),A                  		; 6є Operaciуn- Leer registro del PSG
    
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						;7є Leemos la lнnea de la matriz del teclado desde el PPI Port A
    
        XOR     A
        LD      D,A
        LD      E,A

        ; Comprobamos la línea 9
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE9
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
test_joy0_up
        RRA
        JR      C,test_joy0_down
        SET     JOY_UP,D
test_joy0_down
        RRA
        JR      C,test_joy0_left
        SET     JOY_DOWN,D
test_joy0_left
        RRA
        JR      C,test_joy0_right
        SET     JOY_LEFT,D
test_joy0_right
        RRA
        JR      C,test_joy0_fire2
        SET     JOY_RIGHT,D
test_joy0_fire2
        RRA
        JR      C,test_joy0_fire1
        SET     JOY_FIRE1,D
test_joy0_fire1
        RRA
        JR      C,test_keyboard
        SET     JOY_UP,D
test_keyboard

        ; Comprobamos la línea 0
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE0
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
        					; A contiene el valor de la lнnea
test_cursor_up
        RRA
        JR      C,test_cursor_right
        SET     JOY_UP,D
test_cursor_right
        RRA
        JR      C,test_cursor_down
        SET     JOY_RIGHT,D
test_cursor_down
        RRA
        JR      C,test_f6
        SET     JOY_DOWN,D
test_f6
        RRA
        RRA
        JR      C,test_cursor_left_and_copy
        SET     KEY_F6,E    

        ; Comprobamos la linea 1
test_cursor_left_and_copy
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE1
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                  ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
                                                ; A contiene el valor de la lнnea
test_cursor_left
        RRA
        JR      C,test_copy
        SET     JOY_LEFT,D
test_copy
        RRA
        JR      C,test_F8
        SET     JOY_FIRE1,D
test_F8
        RRA
        RRA
        JR      C,test_F2
        SET     KEY_F8,E
test_F2
        RRA
        RRA
        RRA
        JR      C,test_F4d
        SET     KEY_F2,D

        ; Comprobamos la línea 2
test_F4d
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE2
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
	               				; A contiene el valor de la lнnea
test_enter
        RRA
        RRA
        RRA
        ;JR      C,test_f4
        ;SET     KEY_ENTER,E
test_f4
        RRA
        RRA
        JR      C,test_space
        SET     KEY_F4,E

        ; Comprobamos la línea 5
test_space
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE5
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RLA
        JR      C,test_5
        SET     JOY_FIRE1,D

        ; Comprobamos la línea 6
test_5
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE6
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RRA
        RRA
        JR      C,test_p
        SET     KEY_5,E

        ; Comprobamos la línea 3
test_p
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE3
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RRA
        RRA
        RRA
        RRA
        JR      C,test_o
        SET     JOY_RIGHT,D

        ; Comprobamos la línea 4
test_o
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE4
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RRA
        RRA
        RRA
        JR      C,test_x
        SET     JOY_LEFT,D

        ; Comprobamos la línea 7
test_x
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE7
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A          			; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RLA
        JR      C,test_4
        SET     JOY_FIRE2,D
test_4
        RRA
        RRA
        JR      C,test_3
        SET     KEY_4,E
test_3
        RRA
        JR      C,test_z
        SET     KEY_3,E
    
        ; Comprobamos la línea 8
test_z
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE8
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   	; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RLA
        JR      C,test_12esc
        SET     JOY_FIRE1,D
test_12esc
  	RRA
  	RRA										;1
        JR      C,test_2
        SET     KEY_1,E
test_2
  	RRA										;2
        JR      C,test_esc
        SET     KEY_2,E
test_esc
  	RRA										;ESC
  	JR      C,test_q
  	SET     KEY_ESCAPE,D
test_q
  	RRA										;Q
  	JR      C,test_a
  	SET     JOY_UP,D
test_a
        RRA                                                                             ;Tab
  	RRA										;A
  	JR      C,fin_lee_teclado
  	SET     JOY_DOWN,D
	
fin_lee_teclado
        LD      BC,PPI_CONTROL + %10000010     	; (3) Valor
        OUT     (C),C                          	; (4)
        DEC     B                             	; (1) PPI_CONTROL - 1 => PPI_C
        DEFB    #ED,#71                       	; (4) PSG Inactivo (CPC+) / OUT (C),0
											; 9є y 10є (Destruye BC)
        RET

;;
;;Pone el borde y las tintas del juego
;;Las coge de HL
;;
;;ENTRADA
;;HL: border, tintas del juego (según modo)
;;SALIDA
;;Nada
;;destruye HL,BC,DE,A
;;
Cambia_Tintas_Juego
        ;primera tinta es el border
        LD      A,(HL)
        LD      (sm_border0+1),A
        INC     HL
        ;siguiente tintas según modo
        LD      B,NUMERO_DE_TINTAS
        XOR     A
        LD      DE,sm_tinta0+1
siguiente_tinta_CTJ
        PUSH    BC
        LDI
        EX      HL,DE
        LD      BC,6
        ADD     HL,BC
        POP     BC
        EX      HL,DE
        DJNZ    siguiente_tinta_CTJ

        RET

;;
;;Pone las tintas del marcador (el borde NO)
;;Las coge de HL
;;
;;ENTRADA
;;HL: border, tintas del juego (según modo)
;;SALIDA
;;Nada
;;destruye HL,BC,D,A,A'
;;
Cambia_Tintas_Marcador        
        LD      B,NUMERO_DE_TINTAS
        XOR     A
        LD      DE,sm_tinta0_m+1
        INC     HL  ;salto el border
siguiente_tinta1_CTJ
        PUSH    BC
        LDI
        EX      HL,DE
        LD      BC,7
        ADD     HL,BC
        POP     BC
        EX      HL,DE
        DJNZ    siguiente_tinta1_CTJ

        RET
        
Alterna_Musica
        LD      B,10
        CALL    muchisimo_STEC
        LD      DE,SNG_FX
        CALL    PLY_SFX_Init
        LD      A,(Hay_Musica)
        XOR     #FF
        LD      (Hay_Musica),A
        OR      A
        JR      NZ,menu_AM
        LD      DE,SNG_FX
        JR      sigue_AM
menu_AM
        LD      DE,SNG_MENU
sigue_AM
        JP      PLY_Init

;;
;;Pone las tintas del marcador (el borde NO)
;;Las coge de HL
;;
;;ENTRADA
;;A: Nota
;;SALIDA
;;Nada
;;destruye HL,BC,D,A,A'
;;
Toca_FX
        PUSH    IX
        LD      D,A
        DEC     A
        ;SLA     A
        LD      B,0
        LD      C,A
        LD      HL,SONIDOS
        ADD     HL,BC
        LD      A,(HL)
        AND     %00111111
        LD      E,A
        LD      A,(HL)
        LD      L,D
        AND     %11000000
        SRL     A
        SRL     A
        SRL     A
        SRL     A
        SRL     A
        SRL     A
        LD      H,#F
        LD      D,0
        LD      BC,0
        CALL    PLY_SFX_Play 
        POP     IX
        RET

; Espera el vertical blank -----------------

; completo
.wVb
    call    wVb1

    ; normal

.wVb2
    ld     b,#f5
.vbLoop2
    IN     A,(C)
        RRA
        JR     NC,vbLoop2
    ret

    ; inicial
.wVb1
    ld     b,#f5
.vbLoop1
    IN     A,(C)
        RRA
        JR     C,vbLoop1
    ret

rectangles_collide
;IX rectangle a
;IY rectangle b
;Retorno C si hay colisión
    LD   B,(IX+_ANCHO)
    LD   A,(IX+_X)
    ADD  A,B
    LD   B,A                                ;aRight

    LD   A,(IY+_X)                  ;bLeft
    
    CP   B
    RET  NC                                 ;bLeft<=aRight

    LD   A,(IY+_X)
    LD   B,(IY+_ANCHO)
    ADD  A,B
    LD   B,A                                ;bRight
    
    LD   A,(IX+_X)                  ;aLeft
    
    CP   B
    RET   NC                                ;aLeft<=bRight
    
    LD   A,(IX+_Y)
    LD   B,(IX+_ALTO)
    ADD  A,B
    LD   B,A                                ;aTop
    
    LD   A,(IY+_Y)                  ;bBottom
    
    CP   B
    RET  NC                                 ;bTottom<=aTop
    
    LD   A,(IY+_Y)
    LD   B,(IY+_ALTO)
    ADD  A,B
    LD   B,A                                ;bTop
    
    LD   A,(IX+_Y)                  ;aBottom
    
    CP   B
    RET  NC

    BIT  CHECK_MATA,(IY+_CHECKS)
    RET  NZ
    LD   A,(PANTALLA_ACTUAL)
    CP   13
    JR   Z,no_actives_piedras
    SET  CHECK_ACTIVAR,(IY+_CHECKS)
no_actives_piedras
    SCF
    CCF
    RET

