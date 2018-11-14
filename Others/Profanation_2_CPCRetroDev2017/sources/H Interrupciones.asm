; Interrupciones -----------------------------------------------------

; Int 0 ----------------------

; prepara la pantalla superior

myInt0
        PUSH    BC
        PUSH    AF 

        LD      BC,myInt1
        LD      (&39),BC

        ;modo pantalla juego
        LD      BC,#7F8C + MODO_JUEGO
        OUT     (C),C

        LD      A,1
        LD      (Sig_Interrupcion),A


        CALL set_crtc_screen_address

;       habilitar para poner al prota a 25fps
;        LD      A,(Pas_Interrupcion)
;        OR      A
;        JR      Z,salir_myInt0

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JR      Z,salir_myInt0

        PUSH HL

        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'
        PUSH AF
        PUSH IX
        PUSH IY 

        LD      IX,SPRITE0
        LD      HL,SPRITE0_INT
        CALL    Ejecuta_IBP  ;z,
        LD      HL,SPRITE0_INT
        CALL    Ejecuta_Rutina_Sprite
        LD      HL,SPRITE0_INT
        CALL    Ejecuta_CFP
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_CHECKS)
        BIT     CHECK_CAMBIO,A
        LD      HL,SPRITE0_INT
        CALL    Z,Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
salir_myInt01
        POP  HL
salir_myInt0
        POP     AF
        POP     BC
        EI
        RETI

; Int 1 ----------------------

; no hace nada

myInt1
        PUSH    BC

        LD      BC,myInt2
        LD      (&39),BC

        PUSH    AF

        LD      A,2
        LD      (Sig_Interrupcion),A

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'
        PUSH AF
        PUSH IX
        PUSH IY 

        ld      bc,#7f10
        out     (c),c
sm_border0
        ld    c,0
        out     (c),c
  
        xor a
        ld      bc,#7f40
        out (c),a
sm_tinta0
        ld   c,0      
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta1      
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta5
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta6
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta7
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta8
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta9
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta10
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta11
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta12
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta13
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta14
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta15
        ld  c,0
        OUT  (C),C

        ;LD   A,(Hay_Musica)
        ;OR   A
        CALL PLY_Play
        ;CALL PLY_SFX_Play

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

        POP     AF
        POP     BC

        EI
        RETI

; Int 2 ----------------------

; no hace nada

myInt2
        PUSH    BC

        LD      BC,myInt3
        LD      (&39),BC

        PUSH    AF

        LD      A,3
        LD      (Sig_Interrupcion),A

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'
        PUSH AF
        PUSH IX
        PUSH IY 

        CALL    Read_Keys
        LD      A,D
        LD      (TECLADO0),A
        LD      A,E
        LD      (TECLADO1),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JP      Z,salir_myInt2

        LD      A,(TRUCO_NO_MUERES)
        CP      1
        JP      Z,salir_myInt2

        ;BIT     CHECK_MUERTE,(IX+_CHECKS)
        ;JP      NZ,salir_myInt2

        LD      IX,SPRITE0
        LD      HL,SPRITE0_INT
        LD      A,(HL)
        AND     BIT_UPD
        JP      Z,no_muerte_myInt2
        LD      IY,SPRITE1
        LD      A,(SPRITE1_INT)
        AND     BIT_UPD
        CALL    NZ,rectangles_collide
        JR      C,muerte_myInt2
        LD      IY,SPRITE2
        LD      A,(SPRITE2_INT)
        AND     BIT_UPD
        CALL    NZ,rectangles_collide
        JR      C,muerte_myInt2
        LD      IY,SPRITE3
        LD      A,(SPRITE3_INT)
        AND     BIT_UPD
        CALL    NZ,rectangles_collide
        JR      C,muerte_myInt2
        LD      IY,SPRITE4
        LD      A,(SPRITE4_INT)
        AND     BIT_UPD
        CALL    NZ,rectangles_collide
        JR      C,muerte_myInt2
        LD      IY,SPRITE5
        LD      A,(SPRITE5_INT)
        AND     BIT_UPD
        CALL    NZ,rectangles_collide
        JR      C,muerte_myInt2
        LD      IY,SPRITE6
        LD      A,(SPRITE6_INT)
        AND     BIT_UPD
        CALL    NZ,rectangles_collide
        JR      C,muerte_myInt2
        BIT     CHECK_MUERTE,(IX+_CHECKS)
        JR      Z,no_muerte_myInt2
muerte_myInt2
        ;LD      (IX+_X),8
        ;LD      (IX+_Y),0
        LD      A,(PANTALLA_ACTUAL)
        LD      (Pantalla_Siguiente),A
        XOR     A
        CALL    Actualiza_Tabla_INT_ibp
        LD      IX,SPRITE0
        CALL    Rst_Sprite0
        SET     CHECK_MUERTE,(IX+_CHECKS)
        SET     CHECK_CAMBIO,(IX+_CHECKS)
        LD      A,(TRUCO_NO_MUERES)
        CP      2
        JR      Z,no_decrementes_myInt2
        DEC     (IX+_VIDAS)
no_decrementes_myInt2
        LD      HL,TINTAS_BLANCO
        CALL    Cambia_Tintas_Juego
        LD      A,SND_MUERTE
        CALL    Toca_FX
no_muerte_myInt2
salir_myInt2
        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

        POP     AF
        POP     BC

        EI
        RETI

; Int 3 ----------------------

; no hace nada

myInt3
        PUSH    BC

        LD      BC,myInt4
        LD      (&39),BC

        PUSH    AF
        LD      A,4
        LD      (Sig_Interrupcion),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JR      Z,salir_myInt3

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'
        PUSH AF
        PUSH IX
        PUSH IY 

        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt3
        LD      IX,SPRITE1
        LD      HL,SPRITE1_INT
        JR      primera_pasada_myInt3
segunda_pasada_myInt3
        LD      IX,SPRITE4
        LD      HL,SPRITE4_INT
primera_pasada_myInt3
        PUSH    HL
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        CALL    Z,Ejecuta_IBP
        POP     HL
        PUSH    HL
        CALL    Ejecuta_Rutina_Sprite
        POP     HL
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_DESP)
        LD      (IX+_ADESP),A
        CALL    Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

salir_myInt3

        POP     AF

        POP     BC

        EI
        RETI

; Int 4 ----------------------

; prepara la pantalla inferior

myInt4
        PUSH    BC

        LD      BC,myInt5
        LD      (&39),BC

;modo pantalla inferior
        LD      BC,#7F8C + MODO_MARCADOR
        OUT     (C),C           ;MODE 0
                    
        PUSH    AF
;         xor a
;         ld      bc,#7f40
;         out (c),a
; sm_tinta0_m
;         ld   c,0      
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta1_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta2_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta3_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta4_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta5_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta6_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta7_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta8_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta9_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta10_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta11_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta12_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta13_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta14_m
;         ld  c,0
;         OUT  (C),C

;         inc a
;         out     (c),a
; sm_tinta15_m
;         ld  c,0
;         OUT  (C),C

    LD   A,0
sm_tinta0_m
    LD   BC,#7f40    ;
    OUT  (C),A
    OUT  (C),C
    INC  A
sm_tinta1_m
    LD   BC,#7f40    
    OUT  (C),A 
    OUT  (C),C
    INC  A
sm_tinta2_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta3_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta4_m 
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta5_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta6_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta7_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta8_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta9_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta10_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta11_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta12_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta13_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta14_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C
          INC  A
sm_tinta15_m
    LD   BC,#7f40    
    OUT  (C),A
    OUT  (C),C

	SET_CRTC_REG	4,#12		; ajusta el final de la pantalla del juego
	SET_CRTC_REG	12,ZONA_MARCADOR; marcador en #4000
	SET_CRTC_REG	13,0
	SET_CRTC_REG	6,#20		; 32*2 = 64 pixeles de alto del marcador

	
        WAIT_CYCLES	140;220-80;113             ; espera hasta que VCC=0 y VLC = 0 CUAUTHEMOC 140

	SET_CRTC_REG	9,1		; marcador con caracteres de 2 pixeles de alto
	SET_CRTC_REG	4,48+7+3	; ajusta para cuando volvera a empezar la pantalla del juego en el siguiente frame

        LD      A,5
        LD      (Sig_Interrupcion),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JP      Z,salir_myInt4

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'
        PUSH AF
        PUSH IX
        PUSH IY 

        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt4
        LD      IX,SPRITE2
        LD      HL,SPRITE2_INT
        JR      primera_pasada_myInt4
segunda_pasada_myInt4
        LD      IX,SPRITE5
        LD      HL,SPRITE5_INT
primera_pasada_myInt4
        PUSH    HL
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        CALL    Z,Ejecuta_IBP
        POP     HL
        PUSH    HL
        CALL    Ejecuta_Rutina_Sprite
        POP     HL
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_DESP)
        LD      (IX+_ADESP),A
        CALL    Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

salir_myInt4
        POP     AF

        POP     BC

        EI
        RETI

; Int 5 ----------------------

myInt5
        PUSH    BC

        LD      BC,myInt0
        LD      (&39),BC

        PUSH    AF
        XOR     A
        LD      (Sig_Interrupcion),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JP      Z,salir_myInt5

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'
        PUSH AF
        PUSH IX
        PUSH IY 

        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt5
        LD      IX,SPRITE3
        LD      HL,SPRITE3_INT
        LD      A,(SEMAFORO_SPR_INT)
        JR      primera_pasada_myInt5
segunda_pasada_myInt5
        LD      IX,SPRITE6
        LD      HL,SPRITE6_INT
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        JR      Z,primera_pasada_myInt5
activar_CFP_myInt5
        XOR     A
        LD      (SEMAFORO_SPR_INT),A
        LD      A,#FE
primera_pasada_myInt5
        PUSH    HL
        OR      A
        CALL    Z,Ejecuta_IBP
        POP     HL
        PUSH    HL
        CALL    Ejecuta_Rutina_Sprite
        POP     HL
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_DESP)
        LD      (IX+_ADESP),A
        CALL    Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

salir_myInt5
        LD      A,(Pas_Interrupcion)
        INC     A
        LD      (Pas_Interrupcion),A

        POP     AF
        POP     BC

        EI
        RETI

set_crtc_screen_address
        ;fija zona de memoria de la pantalla 
        SET_CRTC_REG 6,#10
        SET_CRTC_REG #0C,ZONA_JUEGO

        LD      BC,#BC0D        ; 3c
        OUT     (C),C           ; 4C
Offset_Terremoto
        LD      BC,#BD00        ; 3c
        OUT     (C),C           ; 4c

        WAIT_CYCLES  342;384-42;310  ; espera 6 scanlines (el equivalente al +3 que se le da al r4 al final del halt 4)

        ;caracter de 8 pixeles de alto
        SET_CRTC_REG 9,7
        RET
