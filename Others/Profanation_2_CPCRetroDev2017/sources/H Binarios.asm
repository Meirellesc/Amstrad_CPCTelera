write direct -1,-1,#c0
ORG	DIRECCION_MARCADOR
;el marcador se carga al principio y se queda en la posición de memoria
;no se vuelve a tocar
INCBIN	"marcador/marcadorabu.bmp.bin" 

;se carga el TILESET 1
ORG	DIRECCION_TILES_1
INCBIN	"tiles/tiles-abu-z1.bmp.bin" 
;se carga el TILESET 2
ORG	DIRECCION_TILES_2
INCBIN	"tiles/tiles-abu-z3.bmp.bin" 

ORG	DIRECCION_T_MASCARAS
TABLA_MASCARAS	
;;LOADER
INCBIN  "cargador/tablas-2.bin"
	
ORG	DIRECCION_MUSICA
SNG_MENU
INCBIN  "musica/Pro2-Menu.bin"
SNG_INGAME
INCBIN  "musica/Pro2-ingame.bin"
SNG_FX
INCBIN  "musica/Pro2-FX.bin"


;ORG	DIRECCION_PANTALLAS
;se cargan los datos de las pantallas
PANTALLA_04
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,03,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla4_zona1.txt"
	DB 255
	DB 40,36,16,30
	DW TIPO_FLECHA_DERECHA
	DB 104,16,16,2
	DW TIPO_SERPIENTE_DERECHA
	db 40,52,40,1
	DW TIPO_GOTA
	DB 8,10,56,3
	DW TIPO_ARANA
	;  fin enemigos
	DB 255				
	DB 3,STA_LLAVE,32,104
	DW dSTILE_t86,Objeto_Trama_Cons,Objeto_Trama_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_21
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 16,#FF,20,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla8_zona2.txt"
	DB 255
	DB 56,8,20,1
	DW TIPO_SERPIENTE_DERECHA
	;DB 104,46,0,20
	;DW TIPO_PINCHOS
	;DB 104,18,0,30
	;DW TIPO_PINCHOS
	DB 112,20,26,0
	DW TIPO_CUCA_ABA_DERECHA
	DB 80,20,27,1
	DW TIPO_CUCA_ARR_DERECHA
	DB 8,25,0,15
	DW TIPO_PINCHOS
	DB 8,44,0,40
	DW TIPO_PINCHOS
	DB 32,8,6,1
	DW TIPO_HACHA_DERECHA		;SuperSprite
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_23
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 18,24,22,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla10_zona2.txt"
	DB 255
	DB 24,54,0,20
	DW TIPO_NULO
	DB 80-32,6,32+24,0
	DW TIPO_PIRANA
	DB 80-32,21,32+24,2
	DW TIPO_PIRANA
	DB 40,46,0,40
	DW TIPO_PINCHOS
	DB 72,38,24+16,0
	DW TIPO_GOTA
	DB 64,50,10,30			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	;  fin enemigos
	DB 255		
	DB 24,STA_LLAVE,80-24,24
	DW dSTILE_t85,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_25
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 24,26,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla12_zona2.txt"
	DB 255
	DB 8,18,32+16,0
	DW TIPO_NULO
	DB 96,12,12,2
	DW TIPO_SERPIENTE_DERECHA
	DB 8,8,32+16,0
	DW TIPO_GOTA
	DB #30+16,20,8,1			;y,x,desp,velocidad
	DW TIPO_LAPIDA_DERECHA		;ID,SuperSprite
	DB #30+32,44,9,1			;y,x,desp,velocidad
	DW TIPO_BOLA_DERECHA
	;  fin enemigos
	DB 255		
	DB 25,STA_LLAVE,80-24-32,24+56
	DW dSTILE_t85,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 29,STA_PUERTA,152,8
	DW &8000 or dSTILE_126,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	DB 28,STA_PUERTA,136,8
	DW dSTILE_126,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_30
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,33,#ff,31
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla1_zona3.txt"
	DB 255
	DB 8,#11,#50-8,0
	DW TIPO_GOTA
	DB 8,#19,#50-24,1
	DW TIPO_GOTA
	DB 8,#21,#50-40,1
	DW TIPO_GOTA
	DB #18,#26,0,30
	DW TIPO_PINCHOS
	DB #18-2,#38,64-16,2
	DW TIPO_LAPIDA_ABAJO
	DB #68,#2e,14,30			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_34
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 31,37,#ff,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla5_zona3.txt"
	DB 255
	DB #20,#0e,0,30
	DW TIPO_PINCHOS
	DB #8,#06,106,0
	DW TIPO_GOTA
	DB #8,#0a,96,0
	DW TIPO_GOTA
	DB #18,#24,0,25
	DW TIPO_PINCHOS
	DB #68-32,#2b,32,0
	DW TIPO_PIRANA
	DB #68-32-16,#1b,32+16,1
	DW TIPO_PIRANA
	;  fin enemigos
	DB 255		
	DB 48,STA_LLAVE,8,#8
	DW dstile_00,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger
	DB 0
	;  fin objetos
	DB 255
PANTALLA_36
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 33,#FF,#FF,37
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla7_zona3.txt"
	DB 255
	DB #8,19,37,60			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_IZQUIERDA
	DB #40,#0c,32,1
	DW TIPO_LAPIDA_ABAJO
	DB #28,#2A,72,0
	DW TIPO_GOTA
	DB #38,#34,4,30			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	DB #38,#02,28,30			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	;  fin enemigos
	DB 255		
	DB 51,STA_LLAVE,16,#68
	DW dstile_00,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger
	DB 0
	;  fin objetos
	DB 255
PANTALLA_38
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 35,41,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla9_zona3.txt"
	DB 255
	DB #18,#14,26,2
	DW TIPO_ESCORPION_DERECHA
	DB #50,#04,18,0
	DW TIPO_CUCA_ARR_DERECHA
	DB #48,#38,32,3
	DW TIPO_LAPIDA_ABAJO
	DB #38,#1a,26,1			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB #58,#20,0,25
	DW TIPO_PINCHOS
	DB #68,#18,0,15
	DW TIPO_PINCHOS
	;  fin enemigos
	DB 255		
	DB 41,STA_LLAVE,128+48,88
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	;  fin objetos
	DB 255
PANTALLA_41
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 38,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla12_zona3.txt"
	DB 255
	DB #48,#23,0,30
	DW TIPO_PINCHOS
	DB #28,#3B,38,3
	DW TIPO_GOTA
	DB #68,#0C,18,2
	DW TIPO_ANILLO_IZQUIERDA
	;DB #28,#4,34,16			;y,x,desp,espera al ppio
    	;DW TIPO_FLECHA_DERECHA
    	DB #28,14,19,1
    	DW TIPO_PAJARO_DERECHA
	DB #68-32,#34,32,2
	DW TIPO_PIRANA
	DB #08,#00,32,31			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_42
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,46,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla1_zona4.txt"
	DB 255
	DB #20,#6,54,16			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	;DB #58,#6,42,24			;y,x,desp,espera al ppio
    	;DW TIPO_FLECHA_DERECHA
	DB #10,#1C,24,2
	DW TIPO_GOTA
	DB #30,#16,0,30
	DW TIPO_PINCHOS
	DB #20,#26,32,0
	DW TIPO_BOLA_ABAJO
    	DB #58,#2A,0,30
    	DW TIPO_PINCHOS
	DB #48,#19,24,3
	DW TIPO_GOTA
	;  fin enemigos
	DB 255		
	DB 58,STA_LLAVE,208,64+16
	DW dSTILE_Llave_Azul,Objeto_Normal_Cons,Objeto_Normal_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_43
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,53,#FF,51
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla2_zona4.txt"
	DB 255
	DB #48,#1A,8,2
	DW TIPO_SERPIENTE_DERECHA
	DB 16,#2E,96,0
	DW TIPO_GOTA
	;  fin enemigos
	DB 255		
	DB 60,STA_LLAVE,#c0+8,16
	DW dSTILE_Llave_Amarilla,Objeto_Trama_Cons,Objeto_Trama_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 61,STA_PUERTA,224+8,32-16
	DW dSTILE_t72,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 3 	;tag
	;  fin objetos
	DB 255
PANTALLA_44
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,48,45
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
    	DB 255
    	DW Comun_44
	;READ "pant\pantalla3_zona4.txt"
	;DB 255
	DB #8,#30,40,2
	DW TIPO_GOTA
	DB #8,#36,40,1
	DW TIPO_GOTA
	DB 8,22,16,3			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB #48,#1A,8,2
	DW TIPO_MOMIA_DERECHA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_45
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,44,46
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
    	DB 255
    	DW Comun_45
	;READ "pant\pantalla4_zona4.txt"
	;DB 255
	DB #38,#1B,24,2
	DW TIPO_GOTA
	DB #38,#23,24,1
	DW TIPO_GOTA
	DB #20,#10,40,1			;y,x,desp,velocidad
	DW TIPO_LAPIDA_ABAJO		;ID,SuperSprite
	DB 8,#1A,8,2
	DW TIPO_ESCORPION_IZQUIERDA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_46
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 42,47,45,#ff
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla5_zona4.txt"
	DB 255
	DB #18,#28+4,56,0
	DW TIPO_BOLA_ABAJO
	DB #40,#1A,32,2
	DW TIPO_GOTA
	DB #40,#24,32,1
	DW TIPO_GOTA
	DB #18,#10,56,1
	DW TIPO_BOLA_ABAJO
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_47
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 46,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla6_zona4.txt"
	DB 255
	DB 16,#1E,24,2
	DW TIPO_GOTA
	DB #20,0,54,16			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_IZQUIERDA
	DB #20,#16,32,0
	DW TIPO_BOLA_ABAJO
;	DB #58,12,42,24			;y,x,desp,espera al ppio
;    	DW TIPO_FLECHA_IZQUIERDA
    	DB #58,#12,0,30
    	DW TIPO_PINCHOS
	DB #48,#23,24,2
	DW TIPO_GOTA
	;  fin enemigos
	DB 255		
	DB 59,STA_LLAVE,16+16,64+16
	DW dSTILE_Llave_Amarilla,Objeto_Normal_Cons,Objeto_Normal_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_48
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,49,44
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
    	DB 255
    	DW Comun_45
	;READ "pant\pantalla4_zona4.txt"
	;DB 255
	DB #38,#1B,24,2
	DW TIPO_GOTA
	DB #38,#23,24,1
	DW TIPO_GOTA
	DB #20,#10,40,1			;y,x,desp,velocidad
	DW TIPO_BOLA_ABAJO		;ID,SuperSprite
	DB 8,#1A,8,2
	DW TIPO_MOMIA_IZQUIERDA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_49
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,50,48
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
    	DB 255
    	DW Comun_44
	;READ "pant\pantalla3_zona4.txt"
	;DB 255
	DB #8,#30,40,2
	DW TIPO_GOTA
	DB #8,#36,40,1
	DW TIPO_GOTA
	DB 8,22,16,3			;y,x,desp,velocidad
	DW TIPO_LAPIDA_DERECHA		;SuperSprite
	DB #48,#1A,8,2
	DW TIPO_BOLA_DERECHA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_50
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,51,49
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
    	DB 255
    	DW Comun_45
	;READ "pant\pantalla4_zona4.txt"
	;DB 255
	DB #38,#1B,24,2
	DW TIPO_GOTA
	DB #38,#23,24,1
	DW TIPO_GOTA
	DB #20,#10,40,1			;y,x,desp,velocidad
	DW TIPO_LAPIDA_ABAJO		;ID,SuperSprite
	DB 8,#1A,8,2
	DW TIPO_SERPIENTE_IZQUIERDA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_51
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,43,50
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
    	DB 255
    	DW Comun_44
	;READ "pant\pantalla3_zona4.txt"
	;DB 255
	DB #8,#30,40,2
	DW TIPO_GOTA
	DB #8,#36,40,1
	DW TIPO_GOTA
	DB 8,22,16,3			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB #48,#1A,8,2
	DW TIPO_ESCORPION_DERECHA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
; PANTALLA_52
; 	;  NAVEGACION
; 	;  IZQ,DER,ARR,ABA,PUERTA
;     	DB 43,53,#FF,#FF
;     	;  SuperTiles que componen la pantalla
;     	;  identificador del SuperTile
; 	READ "pant\pantalla7_zona4.txt"
; 	DB 255
; 	;  fin enemigos
; 	DB 255
; 	;  fin objetos
; 	DB 255
PANTALLA_53
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 43,54,55,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla8_zona4.txt"
	DB 255
	;  fin enemigos
	DB 255
	DB 64,STA_PUERTA,128,80
	DW &8000 or dSTILE_barbilla,Objeto_Puerta_Cons,Objeto_Nulo_Trigger
	DB 0 	;tag
	DB 63,STA_PUERTA,128-16,80
	DW dSTILE_barbilla,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	DB 65,STA_LLAVE,128-8,104-8
	DW dSTILE_Bombona,Final_Cons,Final_Trigger
	DB 0
	;  fin objetos
	DB 255
PANTALLA_54
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 53,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla9_zona4.txt"
	DB 255
	;  fin enemigos
	DB 255
	DB 62,STA_LLAVE,#c0+8,#28
	DW dSTILE_Llave_Azul,Objeto_Trama_Cons,Objeto_Trama_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_55
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #ff,#FF,53,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantallafinal.txt"
	DB 255
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

Comun_44
	READ "pant\pantalla3_zona4.txt"
	DB 255
Comun_45
	READ "pant\pantalla4_zona4.txt"
	DB 255

;a continuación se cargan los sprites
;donde acaben las pantallas empezarán
;**************************sprites derecha y no simetricos
INICIO_SPRITES_DER
	PROAND
	INCBIN "sprites/abu_corriendo-der.bmp.bin"
	PROAGA
	INCBIN "sprites/abu_aterriza-der.bmp.bin"
	PROSAL
	INCBIN "sprites/abu_saltando-der.bmp.bin"
	PROCAY
	INCBIN "sprites/abu_cayendo-der.bmp.bin"
	PROREP
	INCBIN "sprites/abu_stand-der.bmp.bin"
	PAJARO
	INCBIN "sprites/pajaro-der.bmp.bin"    
	FLECHA
	INCBIN "sprites/flechader.bmp.bin"
	SERPIENTE
	INCBIN "sprites/serpiente-der.bmp.bin"
	ESCORPION
	INCBIN "sprites/escorpion-der.bmp.bin"
	MOMIA
	INCBIN "sprites/momia1-der.bmp.bin"
	PIRANA_ABA
	INCBIN "sprites/pirana-aba.bmp.bin"
FIN_SPRITE_DER
;**************************sprites izquierda y no simetricos
INICIO_SPRITES_IZQ
	INCBIN "sprites/abu_corriendo-izq.bmp.bin"
	INCBIN "sprites/abu_aterriza-izq.bmp.bin"
	INCBIN "sprites/abu_saltando-izq.bmp.bin"
	INCBIN "sprites/abu_cayendo-izq.bmp.bin"
	INCBIN "sprites/abu_stand-izq.bmp.bin"
	INCBIN "sprites/pajaro-izq.bmp.bin"    
	INCBIN "sprites/flechaizq.bmp.bin"
	INCBIN "sprites/serpiente-izq.bmp.bin"
	INCBIN "sprites/escorpion-izq.bmp.bin"
	INCBIN "sprites/momia1-izq.bmp.bin"
	INCBIN "sprites/pirana-arr.bmp.bin"
FIN_SPRITES_IZQ
;**************************sin rotación
INICIO_SPRITES_SIMETRICOS
	PIEDRA
	INCBIN "sprites/piedra.bmp.bin"
	GOTA
	INCBIN "sprites/gota3_nace.bmp.bin"
	GOTA_CAE
	INCBIN "sprites/gota3_cae.bmp.bin"
	GOTA_ADIOS
	INCBIN "sprites/gota3_salpica.bmp.bin"
	BOLA
	INCBIN "sprites/rayo2.bmp.bin"
	HACHA
	INCBIN "sprites/hacha2.bmp.bin"
	LAPIDA
	INCBIN "sprites/lapida1.bmp.bin"
	ARANA
	INCBIN "sprites/arana2.bmp.bin"
	RAYO_MEDIO
	INCBIN "sprites/rayo5.bmp.bin"
	RAYO_VERTICAL
	INCBIN "sprites/rayo6.bmp.bin"
	PINCHOS
	INCBIN "sprites/pinchos3.bmp.bin"
	ANILLO
	INCBIN "sprites/anillo1.bmp.bin"
	CUCA_ABA
	INCBIN "sprites/cuca-aba-der.bmp.bin"
	CUCA_ARR
	INCBIN "sprites/cuca-arr-der.bmp.bin"
	PHANTIS
	INCBIN "sprites/phantis.bmp.bin"
	CAMELOT
	INCBIN "sprites/camelot.bmp.bin"
FIN_SPRITES_SIMETRICOS
