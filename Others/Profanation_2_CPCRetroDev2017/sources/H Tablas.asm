;;----------------------------------------------
;;Genera_Stiles
;;Genera mapa de SuperTiles
;;----------------------------------------------
;;Genera_Mapa
;;Genera mapa de pantallas
;;----------------------------------------------

;cuando se ejecuten estas subrutinas se podrá
;reutilizar el espacio con buffers intermedios
BUFFER 
start   ; AQUI  EMPIEZA LA EJECUCION

        ;posiciono la pila. De momento debajo de la pantalla
        DI
        LD      SP,#C000
        LD      HL,#C9FB
        LD      (#38),HL

        ; cambia a pantalla con split
        CALL    toSplitScreen
        ;cambia las tintas del juego
        CALL    Borra_Pantalla
        LD      HL,TINTAS_NEGRO
        CALL    Cambia_Tintas_Juego
        LD      HL,TINTAS_NEGRO
        CALL    Cambia_Tintas_Marcador
        ;Para Loader quitar las 4 CALL
        ;genera tabla de ScanLines
        ;LOADER
        CALL    Genera_ScanLines
        ;genera mapa de pantallas
        ;LOADER
        CALL    Genera_Mapa
        ;genera mapa de SuperTiles
        ;LOADER
        CALL    Genera_Stiles
        ;genera tabla de mascaras
        ;LOADER
        CALL    Genera_Tabla_Mascaras
        ;inicializa la musica
        LD      DE,SNG_FX
        CALL    PLY_SFX_Init
        LD      DE,SNG_MENU
        CALL    PLY_Init
        ;Intro
        CALL    INTRO_Chorra_Celemin
        JP      inicio_menu
;;
;;Genera tabla de scanlines
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye A,BC,DE,HL,IX
;;
Genera_ScanLines
        LD      IX,TABLA_SCANLINES
        LD      HL,DIRECCION_JUEGO
        LD      DE,#800
        LD      BC,#C040
        LD      A,128
loop_gs
        LD      (IX+0),L
        LD      (IX+1),H
        INC     IX
        INC     IX
        ADD     HL,DE
        JR      NC,siguiente_scanline_gs
        ADD     HL,BC
siguiente_scanline_gs
        DEC     A
        JR      NZ,loop_gs
        RET

;genero la tabla de bytes con sus mascaras
;de esta manera no tengo que guardar mascaras
;pues las tengo precalculadas
;rutina de cesar nicolas (se nota en los comentarios)
Genera_Tabla_Mascaras
        LD   HL,TABLA_MASCARAS  
PRECALCULAR: 
        LD   A,L                                        ; como TABLADEBYTES esta alineada a 256, en su primera iteracion vale 0 - esto nos ahorra un registro que vaya de 0 a 255
        AND  #AA
        JR   Z,PRECALCULAR1
        LD   A,#AA                                      ; mascara del primer pixel
PRECALCULAR1:
        LD   C,A                                        ; primer pixel final
  
        LD   A,L
        AND  #55
        JR   Z,PRECALCULAR2
        LD   A,#55
        OR   C
        LD   C,A                                        ; segundo pixel final
  
PRECALCULAR2:
        OR   C                                          ; ya tenemos los cuatro pixeles del sprite...
        CPL                                             ; ...y los negamos binariamente, porque lo que queremos es la mascara para respetar el fondo.
        LD   (HL),A
        INC  L                                          ; gracias a la alineaci?n tambi?n nos ahorramos un contador de vueltas de 255 a 0.
        JR   NZ,PRECALCULAR
        RET
;write direct -1,-1,#c0

        ; Cambia del modo de pantalla standar a modo split

toSplitScreen
        DI
        LD      HL,#C9FB
        LD      (#38),HL

        ; DIMENSIONES Y POSICION DEL AREA DE JUEGO

        CALL    wVb

        LD      HL,#2A20        ; H = X, L = W
        LD      DE,#1F10        ; D = Y, E = H
        CALL    redim_screen

        ; interrupcion

        LD      A,#C3
        LD      (#38),A
        LD      HL,myInt0
        LD      (#39),HL

        CALL    wVb

        SET_CRTC_REG    7,48    ; se puede sacar fuera porque no cambia

        LD      A,48
        LD      (currentR7+1),A

        EI
        RET


; Redimensiona el tamanyo y posicion de la pantalla manteniendo los 50hz
; h = x, l = w
; d = y, e = h

redim_screen
        LD      BC,#BC01        ; W
        OUT     (C),C
        INC     B
        OUT     (C),L

        LD      BC,#BC02        ; X
        OUT     (C),C
        INC     B
        OUT     (C),H

        LD      BC,#BC06        ; H
        OUT     (C),C
        INC     B
        OUT     (C),E

currentR7
        LD      A,CURRENT_R7_VALUE
        SUB     D
        JR      Z,screen_ok

        ADD     38              ; A = R4 VALUE

        LD      BC,#BC04
        OUT     (C),C
        INC     B
        OUT     (C),A           ; R4 = A

        EI

        LD      A,D
        LD      C,2
        CP      33
        JR      NC,wait_halts
        INC     C
        CP      27
        JR      NC,wait_halts
        INC     C
        CP      21
        JR      NC,wait_halts
        INC     C
        CP      14
        JR      NC,wait_halts
        INC     C
wait_halts
        HALT
        DEC     C
        JR      NZ,wait_halts

        DI

        LD      C,38
        OUT     (C),C           ; R4 = 38
        LD      BC,#BC07
        OUT     (C),C
        INC     B
        OUT     (C),D           ; R7 = D
        LD      A,D
        LD      (currentR7+1),A
screen_ok
        RET
;;
;;Genera mapa de SuperTiles
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye HL
;;
Genera_Stiles
        LD      HL,dstile_00
        LD      (MAPA_STILES+00),HL
	LD	HL,dstile_01
        LD      (MAPA_STILES+02),HL
        LD      HL,dstile_02
        LD      (MAPA_STILES+04),HL
        LD      HL,dstile_03
        LD      (MAPA_STILES+06),HL
        LD      HL,dstile_04
        LD      (MAPA_STILES+08),HL
        LD      HL,dstile_05
        LD      (MAPA_STILES+10),HL
        LD      HL,dstile_06
        LD      (MAPA_STILES+12),HL
        LD      HL,dstile_07
        LD      (MAPA_STILES+14),HL
        LD      HL,dstile_08
        LD      (MAPA_STILES+16),HL
        LD      HL,dstile_09
        LD      (MAPA_STILES+18),HL
        LD      HL,dstile_10
        LD      (MAPA_STILES+20),HL
        LD      HL,dstile_11
        LD      (MAPA_STILES+22),HL
        LD      HL,dstile_12
        LD      (MAPA_STILES+24),HL
        LD      HL,dstile_13
        LD      (MAPA_STILES+26),HL
        LD      HL,dstile_14
        LD      (MAPA_STILES+28),HL
        LD      HL,dstile_15
        LD      (MAPA_STILES+30),HL
        LD      HL,dstile_16
        LD      (MAPA_STILES+32),HL
        LD      HL,dstile_17
        LD      (MAPA_STILES+34),HL
        LD      HL,dstile_18
        LD      (MAPA_STILES+36),HL
        LD      HL,dstile_19
        LD      (MAPA_STILES+38),HL
        LD      HL,dstile_20
        LD      (MAPA_STILES+40),HL
        LD      HL,dstile_21
        LD      (MAPA_STILES+42),HL
        LD      HL,dstile_22
        LD      (MAPA_STILES+44),HL
        LD      HL,dstile_23
        LD      (MAPA_STILES+46),HL
        LD      HL,dstile_24
        LD      (MAPA_STILES+48),HL
        LD      HL,dstile_25
        LD      (MAPA_STILES+50),HL
        LD      HL,dstile_26
        LD      (MAPA_STILES+52),HL
        LD      HL,dstile_27
        LD      (MAPA_STILES+54),HL
        LD      HL,dstile_28
        LD      (MAPA_STILES+56),HL
        LD      HL,dstile_29
        LD      (MAPA_STILES+58),HL
        LD      HL,dstile_30
        LD      (MAPA_STILES+60),HL
        LD      HL,dstile_31
        LD      (MAPA_STILES+62),HL
        LD      HL,dstile_32
        LD      (MAPA_STILES+64),HL
        LD      HL,dstile_33
        LD      (MAPA_STILES+66),HL
        LD      HL,dstile_34
        LD      (MAPA_STILES+68),HL
        LD      HL,dstile_35
        LD      (MAPA_STILES+70),HL
        LD      HL,dstile_36
        LD      (MAPA_STILES+72),HL
        LD      HL,dstile_37
        LD      (MAPA_STILES+74),HL
        LD      HL,dstile_38
        LD      (MAPA_STILES+76),HL
        LD      HL,dstile_39
        LD      (MAPA_STILES+78),HL
        LD      HL,dstile_40
        LD      (MAPA_STILES+80),HL
        LD      HL,dstile_41
        LD      (MAPA_STILES+82),HL
        LD      HL,dstile_42
        LD      (MAPA_STILES+84),HL
        LD      HL,dstile_43
        LD      (MAPA_STILES+86),HL
        LD      HL,dstile_44
        LD      (MAPA_STILES+88),HL
        LD      HL,dstile_45
        LD      (MAPA_STILES+90),HL
        LD      HL,dstile_46
        LD      (MAPA_STILES+92),HL
        LD      HL,dstile_47
        LD      (MAPA_STILES+94),HL
        LD      HL,dstile_48
        LD      (MAPA_STILES+96),HL
        LD      HL,dstile_49
        LD      (MAPA_STILES+98),HL
        LD      HL,dstile_50
        LD      (MAPA_STILES+100),HL
        LD      HL,dstile_51
        LD      (MAPA_STILES+102),HL
        LD      HL,dstile_52
        LD      (MAPA_STILES+104),HL
        LD      HL,dstile_53
        LD      (MAPA_STILES+106),HL
        LD      HL,dstile_54
        LD      (MAPA_STILES+108),HL
        LD      HL,dstile_55
        LD      (MAPA_STILES+110),HL
        LD      HL,dstile_56
        LD      (MAPA_STILES+112),HL
        LD      HL,dstile_57
        LD      (MAPA_STILES+114),HL
        LD      HL,dstile_58
        LD      (MAPA_STILES+116),HL
        LD      HL,dstile_59
        LD      (MAPA_STILES+118),HL
        LD      HL,dstile_60
        LD      (MAPA_STILES+120),HL
        LD      HL,dstile_61
        LD      (MAPA_STILES+122),HL
        LD      HL,dstile_62
        LD      (MAPA_STILES+124),HL
        LD      HL,dstile_63
        LD      (MAPA_STILES+126),HL
        LD      HL,dstile_64
        LD      (MAPA_STILES+128),HL
        LD      HL,dstile_65
        LD      (MAPA_STILES+130),HL
        LD      HL,dstile_66
        LD      (MAPA_STILES+132),HL
        LD      HL,dstile_67
        LD      (MAPA_STILES+134),HL
        LD      HL,dstile_68
        LD      (MAPA_STILES+136),HL
        LD      HL,dstile_69
        LD      (MAPA_STILES+138),HL
        LD      HL,dstile_70
        LD      (MAPA_STILES+140),HL
        LD      HL,dstile_71
        LD      (MAPA_STILES+142),HL
        LD      HL,dstile_72
        LD      (MAPA_STILES+144),HL
        LD      HL,dstile_73
        LD      (MAPA_STILES+146),HL
        
        LD      HL,dstile_74
        LD      (MAPA_STILES+148),HL
        LD      HL,dstile_75
        LD      (MAPA_STILES+150),HL
        LD      HL,dstile_76
        LD      (MAPA_STILES+152),HL
        LD      HL,dstile_77
        LD      (MAPA_STILES+154),HL
        LD      HL,dstile_78
        LD      (MAPA_STILES+156),HL
        LD      HL,dstile_79
        LD      (MAPA_STILES+158),HL
        LD      HL,dstile_80
        LD      (MAPA_STILES+160),HL
        LD      HL,dstile_81
        LD      (MAPA_STILES+162),HL
        LD      HL,dstile_82
        LD      (MAPA_STILES+164),HL
        LD      HL,dstile_83
        LD      (MAPA_STILES+166),HL
        LD      HL,dstile_84
        LD      (MAPA_STILES+168),HL
        LD      HL,dstile_85
        LD      (MAPA_STILES+170),HL
        LD      HL,dstile_86
        LD      (MAPA_STILES+172),HL
        LD      HL,dstile_87
        LD      (MAPA_STILES+174),HL
        LD      HL,dstile_88
        LD      (MAPA_STILES+176),HL
        LD      HL,dstile_89
        LD      (MAPA_STILES+178),HL
        LD      HL,dstile_90
        LD      (MAPA_STILES+180),HL
        LD      HL,dstile_91
        LD      (MAPA_STILES+182),HL
        LD      HL,dstile_92
        LD      (MAPA_STILES+184),HL
        LD      HL,dstile_93
        LD      (MAPA_STILES+186),HL
        LD      HL,dstile_94
        LD      (MAPA_STILES+188),HL
        LD      HL,dstile_95
        LD      (MAPA_STILES+190),HL
        LD      HL,dstile_96
        LD      (MAPA_STILES+192),HL
        LD      HL,dstile_97
        LD      (MAPA_STILES+194),HL
        LD      HL,dstile_98
        LD      (MAPA_STILES+196),HL
        LD      HL,dstile_99
        LD      (MAPA_STILES+198),HL
        LD      HL,dstile_100
        LD      (MAPA_STILES+200),HL

        LD      HL,dstile_101
        LD      (MAPA_STILES+202),HL
        LD      HL,dstile_102
        LD      (MAPA_STILES+204),HL
        LD      HL,dstile_103
        LD      (MAPA_STILES+206),HL
        LD      HL,dstile_104
        LD      (MAPA_STILES+208),HL
        LD      HL,dstile_105
        LD      (MAPA_STILES+210),HL
        LD      HL,dstile_106
        LD      (MAPA_STILES+212),HL
        LD      HL,dstile_107
        LD      (MAPA_STILES+214),HL
        LD      HL,dstile_108
        LD      (MAPA_STILES+216),HL
        LD      HL,dstile_109
        LD      (MAPA_STILES+218),HL
        LD      HL,dstile_110
        LD      (MAPA_STILES+220),HL
        LD      HL,dstile_111
        LD      (MAPA_STILES+222),HL
        LD      HL,dstile_112
        LD      (MAPA_STILES+224),HL
        LD      HL,dstile_113
        LD      (MAPA_STILES+226),HL
        LD      HL,dstile_114
        LD      (MAPA_STILES+228),HL
        LD      HL,dstile_115
        LD      (MAPA_STILES+230),HL
        LD      HL,dstile_116
        LD      (MAPA_STILES+232),HL
        LD      HL,dstile_117
        LD      (MAPA_STILES+234),HL
        LD      HL,dstile_118
        LD      (MAPA_STILES+236),HL
        LD      HL,dstile_119
        LD      (MAPA_STILES+238),HL
        LD      HL,dstile_120
        LD      (MAPA_STILES+240),HL
        LD      HL,dstile_121
        LD      (MAPA_STILES+242),HL
        LD      HL,dstile_122
        LD      (MAPA_STILES+244),HL
        LD      HL,dstile_123
        LD      (MAPA_STILES+246),HL
        LD      HL,dstile_124
        LD      (MAPA_STILES+248),HL
        LD      HL,dstile_125
        LD      (MAPA_STILES+250),HL
        LD      HL,dstile_126
        LD      (MAPA_STILES+252),HL
        RET

;;
;;Genera mapa de pantallas
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye HL
;;
Genera_Mapa
	LD	HL,PANTALLA_00
	LD	(MAPA_PANTALLAS+00),HL
        LD      HL,PANTALLA_01
        LD      (MAPA_PANTALLAS+02),HL
        LD      HL,PANTALLA_02
        LD      (MAPA_PANTALLAS+04),HL
        LD      HL,PANTALLA_03
        LD      (MAPA_PANTALLAS+06),HL
        LD      HL,PANTALLA_04
        LD      (MAPA_PANTALLAS+08),HL
        LD      HL,PANTALLA_05
        LD      (MAPA_PANTALLAS+10),HL
        LD      HL,PANTALLA_06
        LD      (MAPA_PANTALLAS+12),HL
        LD      HL,PANTALLA_07
        LD      (MAPA_PANTALLAS+14),HL
        LD      HL,PANTALLA_08
        LD      (MAPA_PANTALLAS+16),HL
        LD      HL,PANTALLA_09
        LD      (MAPA_PANTALLAS+18),HL
        LD      HL,PANTALLA_10
        LD      (MAPA_PANTALLAS+20),HL
        LD      HL,PANTALLA_11
        LD      (MAPA_PANTALLAS+22),HL
        LD      HL,PANTALLA_12
        LD      (MAPA_PANTALLAS+24),HL
        LD      HL,PANTALLA_13
        LD      (MAPA_PANTALLAS+26),HL
        LD      HL,PANTALLA_14
        LD      (MAPA_PANTALLAS+28),HL
        LD      HL,PANTALLA_15
        LD      (MAPA_PANTALLAS+30),HL
        LD      HL,PANTALLA_16
        LD      (MAPA_PANTALLAS+32),HL
        LD      HL,PANTALLA_17
        LD      (MAPA_PANTALLAS+34),HL
        LD      HL,PANTALLA_18
        LD      (MAPA_PANTALLAS+36),HL
        LD      HL,PANTALLA_19
        LD      (MAPA_PANTALLAS+38),HL
        LD      HL,PANTALLA_20
        LD      (MAPA_PANTALLAS+40),HL
        LD      HL,PANTALLA_21
        LD      (MAPA_PANTALLAS+42),HL
        LD      HL,PANTALLA_22
        LD      (MAPA_PANTALLAS+44),HL
        LD      HL,PANTALLA_23
        LD      (MAPA_PANTALLAS+46),HL
        LD      HL,PANTALLA_24
        LD      (MAPA_PANTALLAS+48),HL
        LD      HL,PANTALLA_25
        LD      (MAPA_PANTALLAS+50),HL
        LD      HL,PANTALLA_26
        LD      (MAPA_PANTALLAS+52),HL
        LD      HL,PANTALLA_27
        LD      (MAPA_PANTALLAS+54),HL
        LD      HL,PANTALLA_28
        LD      (MAPA_PANTALLAS+56),HL
        LD      HL,PANTALLA_29
        LD      (MAPA_PANTALLAS+58),HL
        LD      HL,PANTALLA_30
        LD      (MAPA_PANTALLAS+60),HL
        LD      HL,PANTALLA_31
        LD      (MAPA_PANTALLAS+62),HL
        LD      HL,PANTALLA_32
        LD      (MAPA_PANTALLAS+64),HL
        LD      HL,PANTALLA_33
        LD      (MAPA_PANTALLAS+66),HL
        LD      HL,PANTALLA_34
        LD      (MAPA_PANTALLAS+68),HL
        LD      HL,PANTALLA_35
        LD      (MAPA_PANTALLAS+70),HL
        LD      HL,PANTALLA_36
        LD      (MAPA_PANTALLAS+72),HL
        LD      HL,PANTALLA_37
        LD      (MAPA_PANTALLAS+74),HL
        LD      HL,PANTALLA_38
        LD      (MAPA_PANTALLAS+76),HL
        LD      HL,PANTALLA_39
        LD      (MAPA_PANTALLAS+78),HL
        LD      HL,PANTALLA_40
        LD      (MAPA_PANTALLAS+80),HL
        LD      HL,PANTALLA_41
        LD      (MAPA_PANTALLAS+82),HL
        LD      HL,PANTALLA_42
        LD      (MAPA_PANTALLAS+84),HL
        LD      HL,PANTALLA_43
        LD      (MAPA_PANTALLAS+86),HL
        LD      HL,PANTALLA_44
        LD      (MAPA_PANTALLAS+88),HL
        LD      HL,PANTALLA_45
        LD      (MAPA_PANTALLAS+90),HL
        LD      HL,PANTALLA_46
        LD      (MAPA_PANTALLAS+92),HL
        LD      HL,PANTALLA_47
        LD      (MAPA_PANTALLAS+94),HL
        LD      HL,PANTALLA_48
        LD      (MAPA_PANTALLAS+96),HL
        LD      HL,PANTALLA_49
        LD      (MAPA_PANTALLAS+98),HL
        LD      HL,PANTALLA_50
        LD      (MAPA_PANTALLAS+100),HL
        LD      HL,PANTALLA_51
        LD      (MAPA_PANTALLAS+102),HL
        LD      HL,PANTALLA_51
        LD      (MAPA_PANTALLAS+104),HL
        LD      HL,PANTALLA_53
        LD      (MAPA_PANTALLAS+106),HL
        LD      HL,PANTALLA_54
        LD      (MAPA_PANTALLAS+108),HL
        LD      HL,PANTALLA_55
        LD      (MAPA_PANTALLAS+110),HL

        RET

