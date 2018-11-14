;
;Aquí empieza la DATA DIVISION propia del juego
;
TINTAS_JUEGO
  DB  #54
  DB  #56,#5c,#4c,#4e,#4a,#5e,#52,#58
  DB  #4d,#4f,#44,#57,#53,#4b,#40,#54
TINTAS_JUEGO1
  DB      #54
  DB      #56,#5c,#5c,#4c,#4e,#5e,#52,#58
  DB      #45,#47,#44,#57,#53,#4b,#40,#54
TINTAS_JUEGO2
  DB      #54
  DB      #56,#54,#5c,#5c,#5e,#54,#56,#44
  DB      #5d,#4d,#54,#55,#57,#40,#54,#54
TINTAS_JUEGO3
  DB      #54
  DB      #56,#54,#54,#54,#56,#54,#54,#54
  DB      #58,#45,#54,#44,#55,#54,#54,#54
TINTAS_JUEGO4
  DB      #54
  DB      #56,#54,#54,#54,#54,#54,#54,#54
  DB      #44,#58,#54,#54,#54,#54,#54,#54
TINTAS_BLANCO
  DB      #4B
  DB      #4B,#4B,#4B,#4B,#4B,#4B,#4B,#4B
  DB      #4B,#4B,#4B,#4B,#4B,#4B,#4B,#4B
TINTAS_NEGRO
  DB      #54
  DB      #54,#54,#54,#54,#54,#54,#54,#54
  DB      #54,#54,#54,#54,#54,#54,#54,#54

Texto_Intro72 DM T_ESPACIO,"IN",T_ESPACIO,"MEMORIAM",255
              DM 255
              DM T_MA,"LFONSO",T_ESPACIO,T_MA,"ZPIRI",255

Texto_Outtro2   DM "GAME",T_ESPACIO,"OVER",255

Texto_End8  DM T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO
            DM "GAME",T_ESPACIO,"OVER"
            DM T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,255

Texto_Intro71 DM "TEST",T_ESPACIO,"METR",T_8,T_1,255
              DM T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,"J",T_PUNTO,"CORTAZAR",255
              DM "RRSS",T_ESPACIO,"JULIAROSES",255

Texto_Intro4  DM T_MP,"ROFANATION",T_ESPACIO,T_2,255
              DM T_ESPACIO,T_ME,"SCAPE",T_ESPACIO,"FROM",255
              DM T_ESPACIO,T_MA,"BU",T_ESPACIO,T_ESPACIO,T_MS,"IMBEL",255

Texto_Menu15  DM T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,T_ESPACIO,255

Texto_Intro0  DM T_1,T_9,T_8,T_5,255

Caer_Intro    DB  0

;definición de las direcciones de los sprites
DSPR_PROTA_ANDAR        DW PROAND,PROAND+64,PROAND+128,PROAND+192,PROAND+256,PROAND+320,PROAND+384,PROAND+448 ;8
DSPR_PROTA_REPOSO       DW PROREP,PROREP,PROREP,PROREP,PROREP,PROREP,PROREP,PROREP,PROREP,PROREP,PROREP,PROREP ;12
                        DW PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64,PROREP+64 ;12
                        DW PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128,PROREP+128 ;12
                        DW PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192,PROREP+192 ;12
DSPR_PROTA_CAYENDO      DW PROCAY ;1
DSPR_PROTA_SALTAR       DW PROSAL,PROSAL+64,PROSAL+128,PROSAL+128+64,PROSAL+128+64,PROSAL+256,PROSAL+256,PROSAL+256,PROSAL+256+64,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
DSPR_PROTA_SALTAR_CORTO DW PROSAL,PROSAL+64,PROSAL+128,PROSAL+128+64,PROSAL+128+64,PROSAL+256,PROSAL+256+64,PROSAL+256+128
DSPR_PROTA_AGACHAR      DW PROAGA,PROAGA,PROAGA+64,PROAGA+64
DSPR_PROTA_SALTAR_VL    DW PROSAL,PROSAL+64,PROSAL+64,PROSAL+128,PROSAL+128+64,PROSAL+256
                        DW PROSAL+256+64,PROSAL+256+128,PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128
DSPR_PROTA_SALTAR_CVL   DW PROSAL,PROSAL+64,PROSAL+64,PROSAL+128,PROSAL+128+64
                        DW PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128
                        DW PROSAL+256+128,PROSAL+256+128,PROSAL+256+128

DSPR_PAJARO             DW PAJARO,PAJARO+64,PAJARO+128,PAJARO+192
DSPR_HACHA              DW HACHA,HACHA+64,HACHA+128,HACHA+192,HACHA+256,HACHA+320
DSPR_GOTA_INI           DW GOTA,GOTA,GOTA+16
DSPR_GOTA               DW GOTA_CAE
DSPR_GOTA_FIN           DW GOTA_ADIOS,GOTA_ADIOS,GOTA_ADIOS,GOTA_ADIOS+16,GOTA_ADIOS+16,GOTA_ADIOS+32,GOTA_ADIOS+32,GOTA_ADIOS+48,GOTA_ADIOS+48,GOTA_ADIOS+64,GOTA_ADIOS+64
DSPR_LAPIDA             DW LAPIDA,LAPIDA,LAPIDA+64,LAPIDA+64,LAPIDA+128,LAPIDA+128,LAPIDA+192,LAPIDA+192,LAPIDA+256,LAPIDA+256
                        DW LAPIDA+320,LAPIDA+320,LAPIDA+384,LAPIDA+384,LAPIDA+448,LAPIDA+448
DSPR_ANILLO             DW ANILLO,ANILLO+64,ANILLO+128,ANILLO+192,ANILLO+256,ANILLO+320
DSPR_BOLA               DW BOLA,BOLA+64,BOLA+128,BOLA+192,BOLA+256,BOLA+320
DSPR_RAYO               DW RAYO_MEDIO,RAYO_MEDIO+64,RAYO_MEDIO+128,RAYO_MEDIO+192
DSPR_RAYO_VERTICAL      DW RAYO_VERTICAL,RAYO_VERTICAL+64,RAYO_VERTICAL+128,RAYO_VERTICAL+192
DSPR_FLECHA_INI         DW FLECHA,FLECHA,FLECHA,FLECHA
DSPR_FLECHA_MOV         DW FLECHA+64
DSPR_FLECHA_FIN         DW FLECHA+128,FLECHA+128
DSPR_ARANA              DW ARANA,ARANA+64,ARANA+128,ARANA+192
DSPR_MOMIA              DW MOMIA,MOMIA+64,MOMIA+128
DSPR_PINCHOS            DW PINCHOS,PINCHOS,PINCHOS+128,PINCHOS+64,PINCHOS+128,PINCHOS
DSPR_SERPIENTE          DW SERPIENTE,SERPIENTE+64,SERPIENTE+128
DSPR_ESCORPION          DW ESCORPION,ESCORPION+64,ESCORPION+128,ESCORPION+192
DSPR_PIEDRA             DW PIEDRA
DSPR_PIEDRA_FIN         DW PIEDRA,PIEDRA+96,PIEDRA+96,PIEDRA+96,PIEDRA+192,PIEDRA+192,PIEDRA+192
                        DW PIEDRA+288,PIEDRA+288,PIEDRA+288,PIEDRA+384,PIEDRA+384,PIEDRA+384,PIEDRA+384,PIEDRA+384,PIEDRA+384,PIEDRA+384,PIEDRA+384
                        DW PIEDRA+480,PIEDRA+480,PIEDRA+480,PIEDRA+480,PIEDRA+480,PIEDRA+480,PIEDRA+480,PIEDRA+480
DSPR_PIRANA             DW PIRANA_ABA,PIRANA_ABA+64,PIRANA_ABA+128,PIRANA_ABA+192
DSPR_CUCA_ABA           DW CUCA_ABA
DSPR_CUCA_ARR           DW CUCA_ARR
DSPR_CAMELOT            DW CAMELOT,CAMELOT+64,CAMELOT+128,CAMELOT+192
DSPR_PHANTIS            DW PHANTIS,PHANTIS+64,PHANTIS+128,PHANTIS+192
DSPR_NULO               DW DSPR_NULO

                        ;objeto a comprobar,
                        ;se tiene este objeto?,
                        ;puerta que se abre,
                        ;pantalla donde está la puerta o static de la puerta si es en la misma pantalla,
                        ;pantalla actual
TABLA_MOV_OBJETOS       DB 3,0,1,2,4
                        DB 5,2,9,0,1
                        DB 6,4,10,7,9
                        DB 7,8,12,0,2
                        DB 22,18,32,17,20
                        DB 23,19,33,16,19
                        DB 24,20,26,24,23
                        DB 25,21,28,0,2
                        DB 42,41,43,0,1
                        DB 45,44,46,0,1
                        DB 48,47,49,37,34
                        DB 51,50,52,40,36
                        DB 60,59,61,0,1
                        DB 62,58,63,53,54
                        DB 255

;definición de los caminos del sprite
PATH_SALTO_VERTICAL
                       ;L   R   - U   D
;                  DB   %00000000,%00000000
                  DB   %00000000,%10000000
                  DB   %00000000,%10000000
                  DB   %00000000,%10000000
                  DB   %00000000,%10000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00001000
                  DB   %00000000,%00001000
                  DB   %00000000,%00001000
                  DB   %00000000,%00001000
                  DB   %11111111
PATH_SALTO_VERTICAL_IZQDA
                       ;L   R   - U   D
;                  DB   %00000000,%00000000
                  DB   %00000000,%10000000
                  DB   %00010000,%10000000
                  DB   %00010000,%10000000
                  DB   %00010000,%10000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %11111111
PATH_SALTO_VERTICAL_DCHA
                       ;L   R   - U   D
;                  DB   %00000000,%00000000
                  DB   %00000000,%10000000
                  DB   %00000001,%10000000
                  DB   %00000001,%10000000
                  DB   %00000001,%10000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %11111111
PATH_SALTO_VERTICAL_CORTO 
                       ;L   R   - U   D
;                  DB   %00000000,%00000000
                  DB   %00000000,%10000000
                  DB   %00000000,%10000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00000000
                  DB   %00000000,%00001000
                  DB   %00000000,%00001000
                  DB   %11111111
PATH_SALTO_VERTICAL_IZQDA_CORTO
                       ;L   R   - U   D
;                  DB   %00000000,%00000000
                  DB   %00000000,%10000000
                  DB   %00010000,%10000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00000000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %00010000,%00001000
                  DB   %11111111
PATH_SALTO_VERTICAL_DCHA_CORTO
                       ;L   R   - U   D
;                  DB   %00000000,%00000000
                  DB   %00000000,%10000000
                  DB   %00000001,%10000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00000000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %00000001,%00001000
                  DB   %11111111

;a continuación de definen los SuperSprites
TIPO_PAJARO_DERECHA
        DB  _4x16,_03SPR OR _DER OR %01         ;#4,#10,3,DERECHA,%01000000
        DW  DSPR_PAJARO,Update_Malo_Px
;TIPO_PAJARO_ABAJO
;        DB  _4x16,_03SPR OR _DER OR %01        ;#4,#10,3,ABAJO,%01000000
;        DW  DSPR_PAJARO,Update_Malo_Px
TIPO_HACHA_DERECHA
        DB  _4x16,_05SPR OR _DER OR %11        ;#4,#10,5,DERECHA,%11000000
        DW  DSPR_HACHA,Update_Malo_Px
TIPO_GOTA
        DB  _2x08,_02SPR OR _ABA OR %11         ;#2,#08,2,ABAJO,%11000000
        DW  DSPR_GOTA_INI,Update_Gota_Ini
TIPO_LAPIDA_DERECHA
        DB  _4x16,_15SPR OR _DER OR %11        ;#4,#10,15,DERECHA,%11000000
        DW  DSPR_LAPIDA,Update_Malo_Px
TIPO_LAPIDA_ABAJO
        DB  _4x16,_15SPR OR _ABA OR %11        ;#4,#10,15,ABAJO,%11000000
        DW  DSPR_LAPIDA,Update_Malo_Px
TIPO_ANILLO_ABAJO
        DB  _4x16,_05SPR OR _ABA OR %11        ;#4,#10,5,ABAJO,%11000000
        DW  DSPR_ANILLO,Update_Malo_Px
TIPO_ANILLO_DERECHA
        DB  _4x16,_05SPR OR _DER OR %11        ;#4,#10,5,DERECHA,%11000000
        DW  DSPR_ANILLO,Update_Malo_Px
TIPO_ANILLO_IZQUIERDA
        DB  _4x16,_05SPR OR _IZQ OR %11        ;#4,#10,5,DERECHA,%11000000
        DW  DSPR_ANILLO,Update_Malo_Px
TIPO_BOLA_DERECHA
        DB  _4x16,_05SPR OR _DER OR %11        ;#4,#10,5,DERECHA,%11000000
        DW  DSPR_BOLA,Update_Malo_Px
TIPO_BOLA_ABAJO
        DB  _4x16,_05SPR OR _ABA OR %11        ;#4,#10,5,ABAJO,%11000000
        DW  DSPR_BOLA,Update_Malo_Px
TIPO_CUCA_ABA_DERECHA
        DB  _4x16,_00SPR OR _DER OR %11        ;#4,#10,2,DERECHA,%01000000
        DW  DSPR_CUCA_ABA,Update_Malo_Px
TIPO_CUCA_ARR_DERECHA
        DB  _4x16,_00SPR OR _DER OR %11        ;#4,#10,2,DERECHA,%01000000
        DW  DSPR_CUCA_ARR,Update_Malo_Px
TIPO_PIEDRA
        DB  _6x16,_01SPR OR _ABA OR %10        ;#6,16,1,ABAJO,%10000000
        DW  DSPR_PIEDRA,Update_Piedra
TIPO_RAYO_DERECHA
        DB  _4x16,_03SPR OR _DER OR %11        ;#4,#10,3,DERECHA,%11000000
        DW  DSPR_RAYO,Update_Malo_Px
TIPO_RAYO_VERTICAL
        DB  _4x16,_03SPR OR _ABA OR %11        ;#4,#10,3,ABAJO,%11000000
        DW  DSPR_RAYO_VERTICAL,Update_Malo_Px
TIPO_FLECHA_DERECHA
        DB  _4x16,_03SPR OR _DER OR %00        ;#4,#10,3,DERECHA,%00000000
        DW  DSPR_FLECHA_INI,Update_Flecha_Ini
TIPO_FLECHA_IZQUIERDA
        DB  _4x16,_03SPR OR _IZQ OR %00        ;#4,#10,3,IZQUIERDA,%00000000
        DW  DSPR_FLECHA_INI,Update_Flecha_Ini
;TIPO_LAPIDA_ABAJO_PAUSA
;        DB  _4x16,_07SPR OR _ABA OR %11       ;#4,#10,7,ABAJO,%11000000
;        DW  DSPR_LAPIDA,Update_Malo_Px_Wait
TIPO_ARANA
        DB  _4x16,_03SPR OR _ARR OR %11        ;#4,#10,3,ARRIBA,%11000000
        DW  DSPR_ARANA,Update_Malo_Px_Wait
TIPO_PIRANA
        DB  _4x16,_03SPR OR _ARR OR %01        ;#4,#10,3,ARRIBA,%01000000
        DW  DSPR_PIRANA,Update_Malo_Px_Wait
TIPO_SERPIENTE_DERECHA
        DB  _4x16,_02SPR OR _DER OR %01        ;#4,#10,2,DERECHA,%01000000
        DW  DSPR_SERPIENTE,Update_Malo_Px
TIPO_SERPIENTE_IZQUIERDA
        DB  _4x16,_02SPR OR _IZQ OR %01        ;#4,#10,2,IZQUIERDA,%01000000
        DW  DSPR_SERPIENTE,Update_Malo_Px
TIPO_MOMIA_DERECHA
        DB  _4x16,_02SPR OR _DER OR %01        ;#4,#10,2,DERECHA,%01000000
        DW  DSPR_MOMIA,Update_Malo_Px
TIPO_MOMIA_IZQUIERDA
        DB  _4x16,_02SPR OR _IZQ OR %01        ;#4,#10,2,DERECHA,%01000000
        DW  DSPR_MOMIA,Update_Malo_Px
TIPO_ESCORPION_DERECHA
        DB  _4x16,_03SPR OR _DER OR %01        ;#4,#10,3,DERECHA,%01000000
        DW  DSPR_ESCORPION,Update_Malo_Px
TIPO_ESCORPION_IZQUIERDA
        DB  _4x16,_03SPR OR _IZQ OR %01        ;#4,#10,3,IZQUIERDA,%01000000
        DW  DSPR_ESCORPION,Update_Malo_Px
TIPO_PINCHOS
        DB  _4x16,_05SPR OR _DER OR %11        ;#4,#10,5,DERECHA,%10000000
        DW  DSPR_PINCHOS,Update_Pinchos_Ini
TIPO_NULO
        DB  0,0     ;0,0,0,DERECHA,%10000000
        DW  DSPR_NULO,Update_Nulo
TIPO_CAMELOT
        DB  _4x16,_00SPR OR _DER OR %10     ;0,0,0,DERECHA,%10000000
        DW  DSPR_CAMELOT,Update_Camelot_Phantis
TIPO_PHANTIS
        DB  _4x16,_00SPR OR _DER OR %10     ;0,0,0,DERECHA,%10000000
        DW  DSPR_PHANTIS,Update_Camelot_Phantis

;a continuación se definen los SuperTiles
;TILESET
;ANCHO,ALTO
;Tiles ANCHO*ALTO
dstile_00
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  TILE_FONDO,TILE_FONDO
        DB  TILE_FONDO,TILE_FONDO

dstile_01
        ;DB  JUEGO_TILES_1
        ;DB      4,2
        DB  %01000010
        DB  9,13,26,19
        DB  1,21,2,3

dstile_02
        ;DB  JUEGO_TILES_1
        ;DB      4,14
        DB  %01001110
        DB  7,75,76,8
        DB  1,77,78,113
        DB  63,64,79,114
        DB  1,65,66,115
        DB  63,64,67,116
        DB  16,68,69,117
        DB  63,70,71,62
        DB  1,80,72,73
        DB  22,81,72,82
        DB  1,83,84,85
        DB  25,86,84,85
        DB  1,29,87,88
        DB  22,29,74,148
        DB  1,29,89,90

dstile_03
        ;DB  JUEGO_TILES_1
        ;DB      2,3
        DB  %00100011
        DB  142,141
        DB  31,30
        DB  30,30

dstile_04
        ;DB  JUEGO_TILES_1
        ;DB      2,3
        DB  %00100011
        DB  141,142
        DB  30,31
        DB  30,30

dstile_05
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  154,155
        DB  158,159

dstile_06
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  20,14,15
        DB  21,2,3

dstile_07
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  174,175,162
        DB  176,177,178

dstile_08
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  196,194,195
        DB  200,201,202

dstile_09 
        ;DB  JUEGO_TILES_1
        ;DB      3,3
        DB  %00110011
        DB  165,151,150
        DB  166,153,152
        DB  148,157,156

dstile_10
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  13,14,15
        DB  21,2,3

dstile_11 
        ;DB  JUEGO_TILES_1
        ;DB      1,2
        DB  %00010010
        DB  9
        DB  1

dstile_12
        ;DB  JUEGO_TILES_1
        ;DB      4,2
        DB  %01000010
        DB  148,160,161,162
        DB  158,163,149,164

dstile_13 
        ;DB  JUEGO_TILES_1
        ;DB      3,6
        DB  %00110110
        DB  160,179,180    
        DB  181,182,183    
        DB  184,185,186    
        DB  184,187,188    
        DB  184,189,190    
        DB  191,192,193    

dstile_14
        ;DB  JUEGO_TILES_1
        ;DB      1,2
        DB  %00010010
        DB  7
        DB  1

dstile_15
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  10,11,19
        DB  17,18,3

dstile_16
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  13,26,19
        DB  21,2,3

dstile_17
        ;DB  JUEGO_TILES_1
        ;DB      1,2
        DB  %00010010
        DB  169
        DB  158

dstile_18 
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  23,24
        DB  2,4

dstile_19
        ;DB  JUEGO_TILES_1
        ;DB      4,2
        DB  %01000010
        DB  13,26,26,19
        DB  21,2,2,3

dstile_20
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  13,26,12
        DB  21,2,5

dstile_21
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  21,2,3

dstile_22
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  2,4,5

dstile_23
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  32,33,34

dstile_24
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  23,24,12
        DB  2,4,5

dstile_25
        ;DB  JUEGO_TILES_1
        ;DB      4,1
        DB  %01000001
        DB  21,6,21,3

dstile_26
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  26,19
        DB  2,3

dstile_27
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  13,19
        DB  21,6

dstile_28
        ;DB  JUEGO_TILES_1
        ;DB      4,2
        DB  %01000010
        DB  7,20,14,15
        DB  1,21,2,3

dstile_29
        ;DB  JUEGO_TILES_1
        ;DB      2,1
        DB  %00100001
        DB  171,172

dstile_30
        ;DB  JUEGO_TILES_1
        ;DB      4,2
        DB  %01000010
        DB  35,36,36,37
        DB  39,40,40,41

dstile_31
        ;DB  JUEGO_TILES_1
        ;DB      4,2
        DB  %01000010
        DB  36,38,38,37
        DB  40,42,42,41

dstile_32
        ;DB  JUEGO_TILES_1
        ;DB      2,3
        DB  %00100011
        DB  35,37
        DB  39,41
        DB  57,58

dstile_33
        ;DB  JUEGO_TILES_1
        ;DB      2,1
        DB  %00100001
        DB  27,28

dstile_34
        ;DB  JUEGO_TILES_1
        ;DB      2,1
        DB  %00100001
        DB  59,60

dstile_35
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  2,2,6

dstile_36
        ;DB  JUEGO_TILES_1
        ;DB      5,1
        DB  %01010001
        DB  148,160,161,161,162

dstile_37
        ;DB  JUEGO_TILES_1
        ;DB      4,1
        DB  %01000001
        DB  57,61,61,58

dstile_38
        ;DB  JUEGO_TILES_1
        ;DB      4,1
        DB  %01000001
        DB  1,21,2,3

dstile_39
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  13,12
        DB  21,5

dstile_40 
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  24,12
        DB  4,5

dstile_41
        ;DB  JUEGO_TILES_1
        ;DB      1,2
        DB  %00010010
        DB  154
        DB  158

dstile_42
        ;DB  JUEGO_TILES_1
        ;DB      2,1
        DB  %00100001
        DB  57,58

dstile_43
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  133,134
        DB  135,136

dstile_44
        ;DB  JUEGO_TILES_1
        ;DB      1,5
        DB  %00010101
        DB  156
        DB  156
        DB  156
        DB  156
        DB  156
dstile_45
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  112,108
        DB  2,3
dstile_46
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  111,108
        DB  109,5
    
dstile_47
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  107,113
        DB  2,4
    
dstile_48
        ;DB  JUEGO_TILES_1
        ;DB      1,2
        DB  %00010010
        DB  106
        DB  1
    
dstile_49
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  107,108
        DB  109,3

dstile_50
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  104,103 
        DB  95,93

dstile_51
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  98,105
        DB  95,93
    
dstile_52
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  100,104
        DB  101,95
    
dstile_53
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  102,103
        DB  94,93
    
dstile_54
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  107,112,108
        DB  21,2,6

dstile_55
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  107,111,108
        DB  21,2,3

dstile_56
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  107,108
        DB  109,6

dstile_57
        ;DB  JUEGO_TILES_1
        ;DB      1,5
        DB  %00010101
        DB  203
        DB  207
        DB  203
        DB  207
        DB  203

dstile_58
        ;DB  JUEGO_TILES_1
        ;DB      1,2
        DB  %00010010
        DB  203
        DB  206
  
dstile_59
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  147,210,147
        DB  206,168,172
    
dstile_60
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  98,97
        DB  91,92
    
dstile_61
        ;DB  JUEGO_TILES_1
        ;DB      2,1
        DB  %00100001
        DB  204,205

dstile_62
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  98,110,97
        DB  95,94,93

dstile_63
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  95,94,93

dstile_64
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  95,91,92

dstile_65
        ;DB  JUEGO_TILES_1
        ;DB      2,1
        DB  %00100001
        DB  95,93

dstile_66
        ;DB  JUEGO_TILES_1
        ;DB      5,1
        DB  %01010001
        DB  137,137,138,137,139

dstile_67
        ;DB  JUEGO_TILES_1
        ;DB      3,1
        DB  %00110001
        DB  140,140,140

dstile_68
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  198,197,197
        DB  197,197,198
    
dstile_69
        ;DB  JUEGO_TILES_1
        ;DB      3,2
        DB  %00110010
        DB  199,199,198
        DB  197,197,197

dstile_70
        ;DB  JUEGO_TILES_1
        ;DB      2,2
        DB  %00100010
        DB  98,96
        DB  91,99

dstile_71
        ;DB  JUEGO_TILES_1
        ;DB      2,4
        DB  %00100100
        DB 121,122
        DB 123,124
        DB 125,126
        DB 127,128

dstile_72
        ;DB  JUEGO_TILES_1
        ;DB      4,4
        DB  %01000100
        DB 44,45,46,47
        DB 48,49,50,51
        DB 44,49,50,52
        DB 53,54,55,56

dstile_73
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 13,14
    DB 11,8

dstile_74
    ;DB  JUEGO_TILES_2
    ;DB 3,1
    DB %10110001
    DB 2,3,6

dstile_75
    ;DB  JUEGO_TILES_2
    ;DB 1,2
    DB %10010010
    DB 19
    DB 7

dstile_76
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 19,24
    DB 7,6
    
dstile_77
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 19,18
    DB 7,7

dstile_78
    ;DB  JUEGO_TILES_2
    ;DB 3,1
    DB %10110001
    DB 24,24,24
    
dstile_79
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 19,24
    DB 7,10
    
dstile_80
    ;DB  JUEGO_TILES_2
    ;DB 2,3
    DB %10100011
    DB 43,44
    DB 15,16
    DB 26,27
    
dstile_81
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 24,32
    DB 5,5
    
dstile_82
    ;DB  JUEGO_TILES_2
    ;DB 4,1
    DB %11000001
    DB 9,6,9,7
    
dstile_83
    ;DB  JUEGO_TILES_2
    ;DB 1,2
    DB %10010010
    DB 14
    DB 8

dstile_84
    ;DB  JUEGO_TILES_2
    ;DB 2,1
    DB %10100001
    DB 165,166

dstile_85
    ;DB  JUEGO_TILES_1
    ;DB 3,1
    DB %10110001
    DB 167,168,167

dstile_86
    ;DB  JUEGO_TILES_1
    ;DB 1,1
    DB %10010001
    DB 168

dstile_87
    ;DB  JUEGO_TILES_1
    ;DB 1,1
    DB %10010001
    DB 167

dstile_88
    ;DB  JUEGO_TILES_1
    ;DB 2,1
    DB %10100001
    DB 178,179 ;179,180
    
dstile_89
    ;DB  JUEGO_TILES_1
    ;DB 4,1
    DB %11000001
    DB 37, 81, 82, 84

dstile_90
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 147,147,167,168,167,167,168
    DB 142,141,141,142,141,141,141

dstile_91
    ;DB  JUEGO_TILES_1
    ;DB 3,16
    DB %10111111
    DB 37,38,39;48,48,81
    DB 30,31,147
    DB 28,29,147
    DB 33,34,30
    DB 35,36,28
    DB 47,33,147
    DB 33,34,30
    DB 35,36,28
    DB 35,33,147
    DB 28,29,147
    DB 30,31,147
    DB 28,29,147
    DB 33,34,30
    DB 35,36,28
    DB 35,33,147
    ;DB 28,285,147
    
dstile_92
    ;DB  JUEGO_TILES_1
    ;DB 3,2
    DB %00110010
    DB 35,36,37
    DB 39,40,41

dstile_93
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 24,13
    DB 6,11

dstile_94
    ;DB  JUEGO_TILES_2
    ;DB 3,2
    DB %10110010
    DB 24,24,24
    DB 78,4,4

dstile_95
    ;DB  JUEGO_TILES_2
    ;DB 1,2
    DB %10010010
    DB 1
    DB 1
    
dstile_96
    ;DB  JUEGO_TILES_2
    ;DB 4,10
    DB %11001010
    DB 147,36,34,35
    DB 147,55,47,48
    DB 50,51,52,53
    DB 54,55,56,57
    DB 54,58,59,60
    DB 61,62,63,62
    DB 65,66,67,68
    DB 65,66,72,73
    DB 74,75,76,77
    DB 79,80,81,82

dstile_97
    ;DB  JUEGO_TILES_2
    ;DB 2,1
    DB %10100001
    DB 11,8

dstile_98
    ;DB  JUEGO_TILES_2
    ;DB 2,3
    DB %10100011
    DB 149,150
    DB 151,152
    DB 153,154

dstile_99
    ;DB  JUEGO_TILES_2
    ;DB 2,3
    DB %10100011
    DB 155,156
    DB 157,158
    DB 159,160

dstile_100
    ;DB  JUEGO_TILES_2
    ;DB 2,2
    DB %10100010
    DB 161,162
    DB 163,164

dstile_101
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 37,38,39,40,37,38,39
    DB 147,147,147,147,147,147,147

dstile_102
    ;DB  JUEGO_TILES_1
    ;DB 4,2
    DB %11000010
    DB 20,50,79,80
    DB 37,81,82,84
    
dstile_103
    ;DB  JUEGO_TILES_1
    ;DB 3,1
    DB %10110001
    DB 170,171,171

dstile_104
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 20,21,22,23,38,39,37
    DB 37,38,39,40,38,39,40
dstile_105
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 38,39,40,20,21,22,37
    DB 178,179,147,37,38,39,40
dstile_106
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 38,39,20,21,22,23,37
    DB 178,179,37,38,39,40,147
dstile_107
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11000010
    DB 38,39,40,37
    DB 147,147,147,147
dstile_108
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 167,167,168,167,147,147,147
    DB 141,141,142,141,141,141,141
dstile_109
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 167,147,147,147,167,147,147
    DB 141,141,142,141,141,141,141
dstile_110
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11110010
    DB 147,168,167,167,147,167,168
    DB 141,142,141,141,141,141,141
dstile_111
    ;DB  JUEGO_TILES_1
    ;DB 32,2
    DB %11000010
    DB 167,147,147,147
    DB 141,142,141,141
dstile_112
    ;DB  JUEGO_TILES_1
    ;DB 7,16
    DB %01111111
    DB 147,147,147,213,215,214,216
    DB 147,147,213,219,214,214,216
    DB 147,217,222,219,214,214,220
    DB 147,218,222,223,224,225,226
    DB 147,227,222,223,228,229,214
    DB 221,222,230,231,232,233,234
    DB 227,222,235,231,236,237,238
    DB 213,222,239,240,241,242,243
    DB 227,222,222,222,244,236,245
    DB 213,226,226,222,246,247,248
    DB 227,222,222,226,249,250,251
    DB 213,222,222,222,249,250,251
    DB 227,226,222,222,249,250,251
    DB 213,222,222,222,249,250,251
    DB 227,222,222,222,249,250,251
    ;DB 9,13,239,240,241,242,243
    ;DB 1,222,222,222,244,236,245
    ;DB 7,222,26,222,246,247,248
    ;
    ;DB 1,222,222,222,249,250,251
    ;DB 9,13,14,222,249,250,251
    ;DB 1,222,222,222,249,250,251
    ;DB 9,13,222,26,249,250,251
    ;DB 1,21,26,274,33,34,251
    ;;DB 33,34,274,33,34,288,61
dstile_113
    DB %11100100
    DB 181,180,181,180,181,210
    DB 185,186,185,186,188,189
    DB 192,193,192,193,197,198
    DB 202,203,202,203,205,206
dstile_114 
    ;DB  JUEGO_TILES_1
    DB %11100100
    DB 207,207,207,207,207,207
    DB 207,207,207,207,207,207
    DB 207,207,207,207,207,207
    DB 207,207,207,207,207,207
    
dstile_115 
    ;DB  JUEGO_TILES_1
    DB %11100010
    DB 208,208,208,208,208,208
    DB 209,209,209,209,209,209

dstile_116
    ;DB  JUEGO_TILES_1
    DB %11110001
    DB 187,187,187,187,187,187,187

dstile_117 
    ;DB  JUEGO_TILES_1
    DB %10110001
    DB 211,212,213

dstile_118
    ;DB  JUEGO_TILES_1
    DB %11100001
    DB 211,212,213,213,214,211

dstile_119
    ;DB  JUEGO_TILES_1
    DB %10100001
    DB 250,251

dstile_120 
    ;DB  JUEGO_TILES_1
    DB %11110111
    DB 210,210,210,210,210,210,210
    DB 210,210,210,210,210,210,210
    DB 210,210,210,210,210,210,210
    DB 210,210,210,210,210,210,210
    DB 210,210,210,210,210,210,210
    DB 210,210,210,210,210,210,210
    DB 210,210,210,210,210,210,210

dstile_121
    ;DB  JUEGO_TILES_1
    DB %11110100
    DB 210,210,210,107,210,210,210;,210    210
    DB 210,210,108,109,110,210,210;,210    210
    DB 210,111,112,113,113,110,210;,210    210
    DB 241,242,243,248,248,248,110;,210    210
    DB 242,112,113,248,248,248,248;,110    241

dstile_122
    ;DB  JUEGO_TILES_1
    DB %11110100
    DB 210,180,181,180,181,182,180
    DB 183,184,185,186,187,187,187
    DB 190,191,192,193,194,195,196
    DB 200,201,202,203,202,203,204

dstile_123
    ;DB  JUEGO_TILES_1
    DB %11100011
    DB 210,210,240,110,210,210
    DB 210,241,249,248,110,210
    DB 241,112,113,248,248,110

dstile_124
    ;DB  JUEGO_TILES_1
    DB %11000001
    DB 211,212,214,211

dstile_125
        ;DB JUEGO_TILES_1
        ;DB 4,11
        DB %01001011
        DB 1,77,78,120
        DB 63,64,79,122
        DB 1,65,66,124
        DB 63,64,67,126
        DB 16,68,69,128
        DB 63,70,71,130
        DB 1,80,72,73
        DB 22,81,72,82
        DB 1,83,84,85
        DB 25,86,84,85
        DB 1,29,87,88
dstile_126
        DB %00100111
        DB 119,120
        DB 121,122
        DB 123,124
        DB 125,126
        DB 127,128
        DB 129,130
        DB 131,132

sig_ibm_data
  DW dstile_t1
  DW dstile_t2
  DW dstile_t3
  DW dstile_t4

  DW dSTILE_diamante_rojo
  DW dSTILE_Bombona
  DW dSTILE_Mosca
  DW dSTILE_Cucaracha

  DB 15,14,16,17,1,3,2,4

  DW dSTILE_Hoz
  DW dSTILE_Omega
  DW dSTILE_Pajaro
  DW dSTILE_Dolar

  DB 1,2,3,4

sig0_ibm_data
  DW dstile_t2
  DW dstile_t3
  DW dstile_t4
  DW dstile_t1

  DW dSTILE_Bombona
  DW dSTILE_Mosca
  DW dSTILE_Cucaracha
  DW dSTILE_diamante_rojo

  DB 16,15,17,14,3,2,4,1

  DW dSTILE_Omega
  DW dSTILE_Pajaro
  DW dSTILE_Dolar
  DW dSTILE_Hoz

  DB 2,3,4,1

sig1_ibm_data
  DW dstile_t3
  DW dstile_t2
  DW dstile_t1
  DW dstile_t4

  DW dSTILE_Mosca
  DW dSTILE_Cucaracha
  DW dSTILE_diamante_rojo
  DW dSTILE_Bombona

  DB 15,16,14,17,2,4,1,3

  DW dSTILE_Pajaro
  DW dSTILE_Dolar
  DW dSTILE_Hoz
  DW dSTILE_Omega

  DB 3,4,1,2

sig2_ibm_data
  DW dstile_t4
  DW dstile_t2
  DW dstile_t1
  DW dstile_t3

  DW dSTILE_Cucaracha
  DW dSTILE_diamante_rojo
  DW dSTILE_Bombona
  DW dSTILE_Mosca

  DB 15,17,14,16,4,1,3,2

  DW dSTILE_Dolar
  DW dSTILE_Hoz
  DW dSTILE_Omega
  DW dSTILE_Pajaro

  DB 4,1,2,3

dstile_pantalla4  DW dstile_t1
dstile_pantalla8  DW dstile_t2
dstile_pantalla9  DW dstile_t3
dstile_pantalla11 DW dstile_t4
dstile_pantalla14 DW dSTILE_diamante_rojo
dstile_pantalla19 DW dSTILE_Mosca
dstile_pantalla22 DW dSTILE_Bombona
dstile_pantalla24 DW dSTILE_Cucaracha
objeto_puzzle1    DB 14
objeto_puzzle2    DB 15
objeto_puzzle3    DB 16
objeto_puzzle4    DB 17
objeto_puzzle11   DB 1
objeto_puzzle12   DB 2
objeto_puzzle13   DB 3
objeto_puzzle14   DB 4

dstile_pantalla38 DW dSTILE_Hoz
dstile_pantalla31 DW dSTILE_Omega
dstile_pantalla33 DW dSTILE_Pajaro
dstile_pantalla40 DW dSTILE_Dolar
objeto_puzzle21   DB 1
objeto_puzzle22   DB 2
objeto_puzzle23   DB 3
objeto_puzzle24   DB 4

temp_puzzle11     DB 1
temp_puzzle12     DB 1
temp_puzzle13     DB 1
temp_puzzle14     DB 1
temp_puzzle21     DB 1
temp_puzzle22     DB 1
temp_puzzle23     DB 1
temp_puzzle24     DB 1

tabla_puzzle2
   DW dSTILE_diamante_rojo
   DW dSTILE_Mosca
   DW dSTILE_Bombona
   DW dSTILE_Cucaracha
tabla_puzzle3
   DW dSTILE_Hoz
   DW dSTILE_Omega
   DW dSTILE_Pajaro
   DW dSTILE_Dolar
dstile_puzzle13   DB STILE_85
dstilet_puzzle13  DW dstile_t85

;dstile_t00
;        ;DB JUEGO_TILES_1
;        ;DB      2,2
;        DB %00100010
;        DB TILE_FONDO,TILE_FONDO
;        DB TILE_FONDO,TILE_FONDO

dSTILE_barbilla
    DB %00100101
    DB 250,251
    DB 250,251
    DB 250,251
    DB 250,251
    DB 250,251

dstile_t71  ;puerta1
        ;DB JUEGO_TILES_1
        ;DB      2,2
        DB %00100100
        DB 121,122
        DB 123,124
        DB 125,126
        DB 127,128

dSTILE_t721
        ;DB JUEGO_TILES_1
        ;DB      4,2
        DB %00100010
        DB 44,49
        DB 53,54

dSTILE_t7211
        ;DB JUEGO_TILES_1
        ;DB      4,2
        DB %01000010
        DB 44,49,50,52
        DB 53,54,55,56

dstile_t72  ;puerta2
        ;DB JUEGO_TILES_1
        ;DB      4,4
        DB %01000100
        DB 44,45,46,47
        DB 48,49,50,51
        DB 44,49,50,52
        DB 53,54,55,56

; dstile_t125 ;puerta3
;         ;DB JUEGO_TILES_1
;         ;DB      4,11
;         DB %01001011
;         DB 1,77,78,120
;         DB 63,64,79,122
;         DB 1,65,66,124
;         DB 63,64,67,126
;         DB 16,68,69,128
;         DB 63,70,71,130
;         DB 1,80,72,73
;         DB 22,81,72,82
;         DB 1,83,84,85
;         DB 25,86,84,85
;         DB 1,29,87,88

; dstile_t126 ;puerta4
;         ;DB JUEGO_TILES_1
;         ;DB      2,7
;         DB %00100111
;         DB 119,120
;         DB 121,122
;         DB 123,124
;         DB 125,126
;         DB 127,128
;         DB 129,130
;         DB 131,132

dstile_t127 ;puerta5
        ;DB JUEGO_TILES_1
        ;DB      2,4
        DB %00100100
        DB 57,58
        DB 35,37
        DB 39,41
        DB 57,58

dstile_t85 ; ( jarron rosa ) ( objeto de la tercera pantalla )
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 114,115
        db 122,123

dstile_t86 ; ( ojo azul ) ( objeto de la primera )
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 116,117
        db 124,125

dstile_t87 ; ( triangulo amarillo )  ( objeto de la quinta )
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 118,119
        db 126,127

dstile_t88 ; ( cruz amarilla ) ( objeto de la doce )
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 120,121
        db 128,129

dSTILE_diamante_rojo ;diamante rojo
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 134,135
        db 224,225

dSTILE_Bombona ;bombona
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 219,218
        db 222,223

dSTILE_Mosca ;mosca
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 130,131
        db 136,215

dSTILE_Cucaracha
        ;DB JUEGO_TILES_2
        ;db 2,2
        DB %10100010
        db 132,133
        db 216,217

dSTILE_Hoz
        DB %10100010
        DB 252,253
        DB 254,255
dSTILE_Omega
        DB %10100010
        DB 220,221
        DB 230,231
dSTILE_Pajaro
        DB %10100010
        DB 226,227
        DB 232,233
dSTILE_Dolar
        DB %10100010
        DB 228,229
        DB 234,235

dSTILE_Llave_Azul
        DB %10100010
        DB 236,237
        DB 244,245

dSTILE_Llave_Amarilla
        DB %10100010
        DB 238,239
        DB 246,247

dstile_t1                               ;rojo
        ;DB JUEGO_TILES_1
        ;db 4,4
        DB %01000100
        DB 143,143,143,143
        DB 143,TILE_FONDO,TILE_FONDO,143
        DB 143,TILE_FONDO,TILE_FONDO,143
        DB 143,143,143,143
dstile_mt1
        ;DB JUEGO_TILES_1
        ;DB 2,2
        DB %00100010
        DB 143,143,143,143
dstile_t2                               ;azul
        ;DB JUEGO_TILES_1
        ;db 4,4
        DB %01000100
        DB 144,144,144,144
        DB 144,TILE_FONDO,TILE_FONDO,144
        DB 144,TILE_FONDO,TILE_FONDO,144
        DB 144,144,144,144
dstile_mt2
        ;DB JUEGO_TILES_1
        ;DB 2,2
        DB %00100010
        DB 144,144,144,144
dstile_mt21
        ;DB JUEGO_TILES_1
        ;DB 2,1
        DB %00100001
        DB 143,143
dstile_mt211
        ;DB JUEGO_TILES_1
        ;DB 2,1
        DB %00110001
        DB 143,143,143
dstile_t3                             ;rosa
        ;DB JUEGO_TILES_1
        ;db 4,4
        DB %01000100
        DB 145,145,145,145
        DB 145,TILE_FONDO,TILE_FONDO,145
        DB 145,TILE_FONDO,TILE_FONDO,145
        DB 145,145,145,145
dstile_mt3
        ;DB JUEGO_TILES_1
        ;DB 2,2
        DB %00100010
        DB 145,145,145,145
dstile_t4                             ;naranja
        ;DB JUEGO_TILES_1
        ;db 4,4
        DB %01000100
        DB 146,146,146,146
        DB 146,TILE_FONDO,TILE_FONDO,146
        DB 146,TILE_FONDO,TILE_FONDO,146
        DB 146,146,146,146
dstile_mt4
        ;DB JUEGO_TILES_1
        ;DB 2,2
        DB %00100010
        DB 146,146,146,146
dstile_fp
        ;DB JUEGO_TILES_2
        ;DB 2,2
        DB %10100010
        DB TILE_FONDO_PAPIRO,TILE_FONDO_PAPIRO
        DB TILE_FONDO_PAPIRO,TILE_FONDO_PAPIRO
;
;Aquí empieza la DATA DIVISION propia del motor
;
TECLADO0    DB  0
TECLADO1    DB  0

PANTALLA_ACTUAL         DB      0
DATOS_PANTALLA_ACTUAL   DS      4
;DUREZAS_PANTALLA_ACTUAL DS      128

;Tablas scanlines
TABLA_SCANLINES  DS  128*2
;LOADER
;incbin "cargador/tablas-1.bin"
 
;define un mapa de pantallas
;en cada word tenemos la dirección de los datos de la pantalla
MAPA_PANTALLAS    DS  NUMERO_PANTALLAS*2
;MAPA_PANTALLAS  EQU #2772
;define un mapa de SuperTiles
;en cada word tenemos la dirección de los datos del SuperTile
MAPA_STILES   DS NUMERO_STILES*2
;MAPA_STILES EQU #27E2
;tabla con los objetos cogidos o no
TABLA_OBJETOS     DS  NUMERO_OBJETOS

;definir arrays de mapa de durezas de 2 bits
;32x16x2bits=
MAPA_DUREZAS            DS ANCHO_MAPA_TILES*ALTO_MAPA_PX/DIVBITS_DUREZAS

Buffer_actual   DW      BUFFER
;Buffer_Mayor    DW      BUFFER
Stack_Anterior  DW      0

Buffer_Scroll   DM      40,40,40,40,40,40,40,40
                DM      40,40,40,40,40,40,40,40
                DM      40,40,40,40,40,40,40,40
                DM      40,40,40,40,40,40,40,40
                DB      255

Zonas_Liberadas DB 0

Pantalla_Siguiente  DB  #ff

Hay_Musica      DB  #ff

Pulsa_Escape    DB  0

CHECK_ASIGNA_DUREZAS DB 1
CHECK_PINTA_TILE     DB 1

SONIDOS  DB %10000000 OR 40
         DB %00000000 OR 56
         DB %10000000 OR 60
         DB %10000000 OR 24
         DB %01000000 OR 60
         DB %00000000 OR 62
         DB %10000000 OR 62
         DB %10000000 OR 60

;definición de los objetos de la pantalla
STATIC0
        STATIC0_ID      DB      0       ;ID del objeto
        STATIC0_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC0_X       DB      0       ;X
        STATIC0_Y       DB      0       ;Y
        STATIC0_STILE   DW      0       ;STile a pintar
        STATIC0_CONS    DW      0       ;código para inicialización del objeto
        STATIC0_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC0_TAG     DB      0       ;para usar a discrección
STATIC1
        STATIC1_ID      DB      0       ;ID del objeto
        STATIC1_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC1_X       DB      0       ;X
        STATIC1_Y       DB      0       ;Y
        STATIC1_STILE   DW      0       ;STile a pintar
        STATIC1_CONS    DW      0       ;código para inicialización del objeto
        STATIC1_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC1_TAG     DB      0       ;para usar a discrección
STATIC2
        STATIC2_ID      DB      0       ;ID del objeto
        STATIC2_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC2_X       DB      0       ;X
        STATIC2_Y       DB      0       ;Y
        STATIC2_STILE   DW      0       ;STile a pintar
        STATIC2_CONS    DW      0       ;código para inicialización del objeto
        STATIC2_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC2_TAG     DB      0       ;para usar a discrección
STATIC3
        STATIC3_ID      DB      0       ;ID del objeto
        STATIC3_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC3_X       DB      0       ;X
        STATIC3_Y       DB      0       ;Y
        STATIC3_STILE   DW      0       ;STile a pintar
        STATIC3_CONS    DW      0       ;código para inicialización del objeto
        STATIC3_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC3_TAG     DB      0       ;para usar a discrección
STATIC4
        STATIC4_ID      DB      0       ;ID del objeto
        STATIC4_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC4_X       DB      0       ;X
        STATIC4_Y       DB      0       ;Y
        STATIC4_STILE   DW      0       ;STile a pintar
        STATIC4_CONS    DW      0       ;código para inicialización del objeto
        STATIC4_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC4_TAG     DB      0       ;para usar a discrección
;definición de los sprites del juego
SPRITEB
        SPRITEB_ID      DB      0       ;identificador del sprite
        SPRITEB_ANCHO   DB      0       ;ancho en bytes
        SPRITEB_ALTO    DB      0       ;alto en bytes
        SPRITEB_X       DB      0       ;X
        SPRITEB_Y       DB      0       ;Y
        SPRITEB_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITEB_SPR     DB      0       ;número de sprites
        SPRITEB_SPR_A   DB      0       ;sprite actual
        SPRITEB_BUFF    DW      0       ;puntero al buffer
        SPRITEB_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITEB_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITEB_PATH    DW      0       ;puntero al camino activo
        SPRITEB_CHECKS  DB      0       ;checks del sprite
SPRITE0
        SPRITE0_ID      DB      0       ;identificador del sprite
        SPRITE0_ANCHO   DB      0       ;ancho en bytes
        SPRITE0_ALTO    DB      0       ;alto en bytes
        SPRITE0_X       DB      0       ;X
        SPRITE0_ANTX    DB      0       ;X para buffer
        SPRITE0_Y       DB      0       ;Y
        SPRITE0_ANTY    DB      0       ;Y para buffer
        SPRITE0_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE0_SPR     DB      0       ;número de sprites
        SPRITE0_SPR_A   DB      0       ;sprite actual
        SPRITE0_BUFF    DW      0       ;puntero al buffer
        SPRITE0_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE0_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE0_PATH    DW      0       ;puntero al camino activo
        SPRITE0_CHECKS  DB      0       ;checks del sprite
        SPRITE0_VIDAS   DB      5       ;vidas (objeto de pokes ;-)
                        DS      2       ;relleno 
SPRITE1
        SPRITE1_ID      DB      0       ;identificador del sprite
        SPRITE1_ANCHO   DB      0       ;ancho en bytes
        SPRITE1_ALTO    DB      0       ;alto en bytes
        SPRITE1_X       DB      0       ;X
        SPRITE1_ANTX    DB      0       ;X para buffer
        SPRITE1_Y       DB      0       ;Y
        SPRITE1_ANTY    DB      0       ;Y para buffer
        SPRITE1_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE1_SPR     DB      0       ;número de sprites
        SPRITE1_SPR_A   DB      0       ;sprite actual
        SPRITE1_BUFF    DW      0       ;puntero al buffer
        SPRITE1_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE1_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE1_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE1_DESP    DB      0       ;temporal para desplazamiento
        SPRITE1_CHECKS  DB      0       ;checks de los malos
        SPRITE1_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE1_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE1_CAD     DB      0       ;temporal cadencia de ICAD
SPRITE2
        SPRITE2_ID      DB      0       ;identificador del sprite
        SPRITE2_ANCHO   DB      0       ;ancho en bytes
        SPRITE2_ALTO    DB      0       ;alto en bytes
        SPRITE2_X       DB      0       ;X
        SPRITE2_ANTX    DB      0       ;X para buffer
        SPRITE2_Y       DB      0       ;Y
        SPRITE2_ANTY    DB      0       ;Y para buffer
        SPRITE2_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE2_SPR     DB      0       ;número de sprites
        SPRITE2_SPR_A   DB      0       ;sprite actual
        SPRITE2_BUFF    DW      0       ;puntero al buffer
        SPRITE2_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE2_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE2_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE2_DESP    DB      0       ;temporal para desplazamiento
        SPRITE2_CHECKS  DB      0       ;checks de los malos
        SPRITE2_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE2_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE2_CAD     DB      0       ;temporal cadencia de ICAD
SPRITE3
        SPRITE3_ID      DB      0       ;identificador del sprite
        SPRITE3_ANCHO   DB      0       ;ancho en bytes
        SPRITE3_ALTO    DB      0       ;alto en bytes
        SPRITE3_X       DB      0       ;X
        SPRITE3_ANTX    DB      0       ;X para buffer
        SPRITE3_Y       DB      0       ;Y
        SPRITE3_ANTY    DB      0       ;Y para buffer
        SPRITE3_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE3_SPR     DB      0       ;número de sprites
        SPRITE3_SPR_A   DB      0       ;sprite actual
        SPRITE3_BUFF    DW      0       ;puntero al buffer
        SPRITE3_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE3_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE3_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE3_DESP    DB      0       ;temporal para desplazamiento
        SPRITE3_CHECKS  DB      0       ;checks de los malos
        SPRITE3_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE3_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE3_CAD     DB      0       ;temporal cadencia de ICAD
SPRITE4
        SPRITE4_ID      DB      0       ;identificador del sprite
        SPRITE4_ANCHO   DB      0       ;ancho en bytes
        SPRITE4_ALTO    DB      0       ;alto en bytes
        SPRITE4_X       DB      0       ;X
        SPRITE4_ANTX    DB      0       ;X para buffer
        SPRITE4_Y       DB      0       ;Y
        SPRITE4_ANTY    DB      0       ;Y para buffer
        SPRITE4_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE4_SPR     DB      0       ;número de sprites
        SPRITE4_SPR_A   DB      0       ;sprite actual
        SPRITE4_BUFF    DW      0       ;puntero al buffer
        SPRITE4_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE4_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE4_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE4_DESP    DB      0       ;temporal para desplazamiento
        SPRITE4_CHECKS  DB      0       ;checks de los malos
        SPRITE4_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE4_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE4_CAD     DB      0       ;temporal cadencia de ICAD
SPRITE5
        SPRITE5_ID      DB      0       ;identificador del sprite
        SPRITE5_ANCHO   DB      0       ;ancho en bytes
        SPRITE5_ALTO    DB      0       ;alto en bytes
        SPRITE5_X       DB      0       ;X
        SPRITE5_ANTX    DB      0       ;X para buffer
        SPRITE5_Y       DB      0       ;Y
        SPRITE5_ANTY    DB      0       ;Y para buffer
        SPRITE5_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE5_SPR     DB      0       ;número de sprites
        SPRITE5_SPR_A   DB      0       ;sprite actual
        SPRITE5_BUFF    DW      0       ;puntero al buffer
        SPRITE5_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE5_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE5_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE5_DESP    DB      0       ;temporal para desplazamiento
        SPRITE5_CHECKS  DB      0       ;checks de los malos
        SPRITE5_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE5_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE5_CAD     DB      0       ;temporal cadencia de ICAD
SPRITE6
        SPRITE6_ID      DB      0       ;identificador del sprite
        SPRITE6_ANCHO   DB      0       ;ancho en bytes
        SPRITE6_ALTO    DB      0       ;alto en bytes
        SPRITE6_X       DB      0       ;X
        SPRITE6_ANTX    DB      0       ;X para buffer
        SPRITE6_Y       DB      0       ;Y
        SPRITE6_ANTY    DB      0       ;Y para buffer
        SPRITE6_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE6_SPR     DB      0       ;número de sprites
        SPRITE6_SPR_A   DB      0       ;sprite actual
        SPRITE6_BUFF    DW      0       ;puntero al buffer
        SPRITE6_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE6_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE6_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE6_DESP    DB      0       ;temporal para desplazamiento
        SPRITE6_CHECKS  DB      0       ;checks de los malos
        SPRITE6_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE6_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE6_CAD     DB      0       ;temporal cadencia de ICAD
;sprites activos en una pantalla
SPRITES_PANTALLA        DB      0
;tabla de rutinas a llamar desde interrupciones

SEMAFORO_SPR_INT        DB      #FE     ;no procesa nada en INT
SEMAFORO_SPR_INT_PROTA  DB      0       ;para la dificultad del prota
DIFICULTAD              DB      2       ;dificultad inicial
TRUCO_NO_MUERES         DB      0       ;truco sin muerte

CHECK_OBJETO            DB      0       ;activa bandera de toque de objeto
;CHECK_PUZZLE1           DB      0       ;si es uno, se activan las piedras
CHECK_MARCADOR0         DW      0
CHECK_MARCADOR1         DW      0

Sig_Interrupcion        DB      0
Pas_Interrupcion        DB      0

Tabla_INT
SPRITE0_INT             DB      0 
SPRITE1_INT             DB      0 
SPRITE2_INT             DB      0 
SPRITE3_INT             DB      0 
SPRITE4_INT             DB      0 
SPRITE5_INT             DB      0 
SPRITE6_INT             DB      0 
