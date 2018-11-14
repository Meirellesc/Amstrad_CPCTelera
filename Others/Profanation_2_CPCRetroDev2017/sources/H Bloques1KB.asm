ORG	#C400
PANTALLA_32
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,35,31,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla3_zona3.txt"
	DB 255
	DB 8,#34+5,24,2
	DW TIPO_GOTA
	DB #48-18,#22,20,10
	DW TIPO_ARANA
	DB 72-32,24,40+32,0
	DW TIPO_GOTA
	DB 24,#34-5,40,0
	DW TIPO_GOTA
	DB 72,18,40,0
	DW TIPO_GOTA
	DB #28,#8,10,1
	DW TIPO_SERPIENTE_DERECHA
	;  fin enemigos
	DB 255		
	DB 42,STA_LLAVE,168+40,104					;ID,Tipo,x,y,STILE
	DW dstile_00,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger
	DB 0
	DB 43,STA_PUERTA,88,8
	DW dSTILE_t7211,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_19
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,20
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla6_zona2.txt"
	DB 255
	DB 8,38,72,1
	DW TIPO_GOTA
	DB 40,34,12,1
     	DW TIPO_BOLA_DERECHA
	DB 8,44,72,0
	DW TIPO_GOTA
	DB 40,8,10,1			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB 72,8,18,1
     	DW TIPO_BOLA_DERECHA
	DB 104,50,0,20
	DW TIPO_PINCHOS
	;  fin enemigos
	DB 255		
	DB 19,STA_LLAVE,192,8
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 23,STA_LLAVE,80,8
	DW dSTILE_t85,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_16
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,21,15,17
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla3_zona2.txt"
	DB 255
	DB 22,46,44,3
	DW TIPO_ARANA
	DB 64,38,40,1
	DW TIPO_GOTA
	DB 104,40,20,2
	DW TIPO_MOMIA_DERECHA
	DB 40,54,0,30
	DW TIPO_PINCHOS
	;  fin enemigos
	DB 255		
	DB 33,STA_PUERTA,56+56,80
	DW dSTILE_t127,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_27
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\intro1.txt"
	DB 255
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
FIN_BLOQUE01

ORG	#CC00
PANTALLA_26
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 25,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla13_zona2.txt"
	DB 255
	;  fin enemigos
	DB 255		
	DB 36,STA_LLAVE,#38,#38
	DW dstile_mt21,Objeto_T2_Cons,Objeto_Puzzle2_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 37,STA_LLAVE,#58,#38
	DW dstile_mt21,Objeto_T2_Cons,Objeto_Puzzle2_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 38,STA_LLAVE,#78,#38
	DW dstile_mt21,Objeto_T2_Cons,Objeto_Puzzle2_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 39,STA_LLAVE,#98,#38
	DW dstile_mt21,Objeto_T2_Cons,Objeto_Puzzle2_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 40,STA_LLAVE,#C0,#28
	DW dstile_mt21,Objeto_TT_Cons,Objeto_CierraPuzzle2_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	;DB 31,STA_PUERTA,240,8
	;DW &8000 or dSTILE_t126,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	;DB 4 	;tag
	;DB 30,STA_PUERTA,224,8
	;DW dSTILE_t126,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	;DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_28
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\intro2.txt"
	DB 255
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_33
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 30,36,#FF,#ff
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla4_zona3.txt"
	DB 255
	DB #50,#18,16,1
	DW TIPO_CUCA_ABA_DERECHA
	DB #58,#08,24,2
	DW TIPO_GOTA
	DB #18,#0f,88,0
	DW TIPO_GOTA
	DB #38,#2d,0,30
	DW TIPO_PINCHOS
	DB #10,#14,24,1
     	DW TIPO_BOLA_DERECHA
	DB #68,#24,20,3
	DW TIPO_LAPIDA_DERECHA
	;  fin enemigos
	DB 255		
	DB 45,STA_LLAVE,#1c*4,#68
	DW dstile_00,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger
	DB 0
	DB 46,STA_PUERTA,196+12,8
	DW dSTILE_t72,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	DB 47,STA_LLAVE,24,16					;ID,Tipo,x,y,STILE
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger
	DB 0
	;  fin objetos
	DB 255
PANTALLA_40
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 37,#FF,39,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla11_zona3.txt"
	DB 255
	DB #28-4,#16,36,3
	DW TIPO_LAPIDA_ABAJO
	DB #68,#28,10,1
	DW TIPO_SERPIENTE_DERECHA
	DB #68-32,#0E,32,2
	DW TIPO_ANILLO_ABAJO
	DB #28-4,#26,52,2
	DW TIPO_LAPIDA_ABAJO
	DB #28,#3A,40,3
	DW TIPO_GOTA
	;  fin enemigos
	DB 255		
	DB 50,STA_LLAVE,8,8					;ID,Tipo,x,y,STILE
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger
	DB 0
	DB 52,STA_PUERTA,112,40
	DW dSTILE_t72,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
FIN_BLOQUE02

ORG	#D400
PANTALLA_03
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,02,04
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla3_zona1.txt"
	DB 255
	DB 72,36,16,15			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	DB 8,48,40,2
    	DW TIPO_GOTA
	DB 88,12,9,1
    	DW TIPO_RAYO_DERECHA
	DB 40,24,40,1
    	DW TIPO_GOTA
	;  fin enemigos
	DB 255				
	DB 2,STA_LLAVE,208,8
	DW dSTILE_t85,Objeto_Normal_Cons,Objeto_Normal_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_08
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,10,07,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla8_zona1.txt"
	DB 255
	DB 24,20,16,5			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB 48,32,64,0
	DW TIPO_GOTA
	DB 104,34,14,2
	DW TIPO_ESCORPION_DERECHA
	;  fin enemigos
	DB 255				
	DB 5,STA_LLAVE,216,56
	DW dSTILE_t85,Objeto_Trama_Cons,Objeto_Trama_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 9,STA_PUERTA,224,8
	dw dSTILE_t72,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_20
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 15,#FF,19,21
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla7_zona2.txt"
	DB 255
	DB 56,29,24,2
	DW TIPO_GOTA
	DB 8,34,22,15			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	DB 24,12,10,2
	DW TIPO_ANILLO_IZQUIERDA
	;DB 8,20,56,0
	;DW TIPO_GOTA
	DB 8,4,18,25			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_DERECHA
	DB 8,48,40,0
	DW TIPO_GOTA
	DB 96,4,18,1
	DW TIPO_ANILLO_DERECHA
	;  fin enemigos
	DB 255		
	DB 22,STA_LLAVE,168,104
	DW dSTILE_t85,Objeto_Aleatorio_T_Cons,Objeto_Aleatorio_T_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_31
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,34,30,32
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla2_zona3.txt"
	DB 255
	DB #37,#08,18,3
	DW TIPO_PIEDRA			;SuperSprite
	DB #58,#8,12,1
	DW TIPO_SERPIENTE_DERECHA
	DB #38,#38-6,6,3
	DW TIPO_LAPIDA_DERECHA
	DB #38-16,#20,24,1
	DW TIPO_GOTA
	DB #28-32,#2E,6,1
	DW TIPO_HACHA_DERECHA		;SuperSprite
	;  fin enemigos
	DB 255		
	DB 44,STA_LLAVE,32,8
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	;  fin objetos
	DB 255
FIN_BLOQUE03

ORG	#DC00
PANTALLA_02
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,05,01,03
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla2_zona1.txt"
	DB 255
	DB 40,14,32,1
     	DW TIPO_BOLA_DERECHA
	DB 56,20,22,3
     	DW TIPO_BOLA_DERECHA
	DB #30,#34,56,1			;y,x,desp,velocidad
	DW TIPO_LAPIDA_ABAJO		;ID,SuperSprite
	;  fin enemigos
	DB 255				
	DB 1,STA_PUERTA,224,56
	DW dSTILE_t72,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_09
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 07,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla9_zona1.txt"
	DB 255
	DB 8,58,72,0
	DW TIPO_GOTA
	DB 88,16,36,15
	DW TIPO_FLECHA_IZQUIERDA
	DB 104,20,28,25
	DW TIPO_FLECHA_IZQUIERDA
	DB 40,20,0,30
	DW TIPO_PINCHOS
	DB 24,16,0,40
	DW TIPO_PINCHOS
	DB 56,36,0,50
	DW TIPO_PINCHOS
	;faltan tres pinchos
	;  fin enemigos
	DB 255				
	DB 6,STA_LLAVE,40,8
	DW dSTILE_t87,Objeto_Trama_Cons,Objeto_Trama_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_22
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,23
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla9_zona2.txt"
	DB 255
	DB 8,34,20,30			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_IZQUIERDA
	;DB 87,46,18,3
	;DW TIPO_PIEDRA			;SuperSprite
	DB 87-32,54,18,3
	DW TIPO_PIEDRA			;SuperSprite
	DB 87-16,48,6,15			;y,x,desp,espera al ppio
    	DW TIPO_FLECHA_IZQUIERDA
	DB 40,22,72,0
	DW TIPO_GOTA
	DB 104,4,22,2
	DW TIPO_ESCORPION_DERECHA
	;  fin enemigos
	DB 255		
	DB 20,STA_LLAVE,56+72,72
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_39
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,40
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla10_zona3.txt"
	DB 255
	;  fin enemigos
	DB 255		
	DB 53,STA_LLAVE,#40,#20
	DW dstile_mt21,Objeto_T3_Cons,Objeto_Puzzle3_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 54,STA_LLAVE,#58,#20
	DW dstile_mt21,Objeto_T3_Cons,Objeto_Puzzle3_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 55,STA_LLAVE,#88,#20
	DW dstile_mt21,Objeto_T3_Cons,Objeto_Puzzle3_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 56,STA_LLAVE,#A0,#20
	DW dstile_mt21,Objeto_T3_Cons,Objeto_Puzzle3_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 57,STA_LLAVE,#70,#18
	DW dstile_mt21,Objeto_TT_Cons,Objeto_CierraPuzzle3_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	;  fin objetos
	DB 255
FIN_BLOQUE04

ORG	#E400
PANTALLA_05
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 02,06,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla5_zona1.txt"
	DB 255
	DB 72,0,26,15
	DW TIPO_FLECHA_IZQUIERDA
	DB 24,16,48,3
	DW TIPO_ARANA
	DB 5,52,18,3
	DW TIPO_ANILLO_ABAJO
	DB 24,30,40,1
	DW TIPO_GOTA
	;  fin enemigos
	DB 255				
	DB 4,STA_LLAVE,184,104
	DW dSTILE_t87,Objeto_Normal_Cons,Objeto_Normal_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_10
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 08,12,#FF,11
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla10_zona1.txt"
	DB 255
	DB 40,8,14,2
	DW TIPO_RAYO_DERECHA
	DB 8,8,64,2
	DW TIPO_LAPIDA_ABAJO
	DB 72,30,12,1
	DW TIPO_ANILLO_DERECHA
	DB 40,57,24,0
	DW TIPO_GOTA
	DB 40,50,24,1
	DW TIPO_GOTA
	DB 56,26,32,1
	DW TIPO_RAYO_VERTICAL
	;  fin enemigos
	DB 255				
	;  fin objetos
	DB 255
PANTALLA_12
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 10,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla12_zona1.txt"
	DB 255
	DB 8,18,48,1
	DW TIPO_LAPIDA_ABAJO
	DB 8,32,24,1
	DW TIPO_GOTA
	DB 8,40,24,3
	DW TIPO_GOTA
	DB 24,12,56,0
	DW TIPO_GOTA
	;  fin enemigos
	DB 255				
	DB 8,STA_LLAVE,224,8
	DW dSTILE_t88,Objeto_Normal_Cons,Objeto_Normal_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_15
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,20,14,16
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla2_zona2.txt"
	DB 255
	DB 72,40,10,1
	DW TIPO_ESCORPION_DERECHA
	DB 88,28,24,1
	DW TIPO_GOTA
	DB 104,26,30,1
	DW TIPO_SERPIENTE_IZQUIERDA
	DB 32,40,12,3
	DW TIPO_LAPIDA_DERECHA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
FIN_BLOQUE05

ORG	#EC00
PANTALLA_06
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 05,#FF,#FF,07
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla6_zona1.txt"
	DB 255
	DB 71,12,15,3
	DW TIPO_PIEDRA
	DB 71-16,28,16,3
	DW TIPO_PIEDRA
	DB 24,22,8,2
	DW TIPO_BOLA_DERECHA
	db 56,42,4,2
	DW TIPO_HACHA_DERECHA
	db 88,48,4,2
	DW TIPO_HACHA_DERECHA
	;  fin enemigos
	DB 255				
	;  fin objetos
	DB 255
PANTALLA_11
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,13,10,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla11_zona1.txt"
	DB 255
	DB 24,10,6,2
	DW TIPO_SERPIENTE_IZQUIERDA
	DB 72,40,40,0
	DW TIPO_GOTA
	DB 88,10,16,5			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB 0,0,0,0
	DW TIPO_NULO
	DB 104,16,18,2
	DW TIPO_MOMIA_DERECHA
	;  fin enemigos
	DB 255				
	DB 7,STA_LLAVE,176,8
	DW dSTILE_t88,Objeto_Trama_Cons,Objeto_Trama_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 13,STA_PUERTA,240,8
	DW &8000 or dSTILE_t71,Objeto_Puerta_Cons,Objeto_Nulo_Trigger
	DB 0 	;tag
	DB 12,STA_PUERTA,224,8
	DW dSTILE_t71,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_13
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 11,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla13_zona1.txt"
	DB 255
	DB 0,0,0,0
	DW TIPO_NULO
	DB 87,21,18,0
	DW TIPO_PIEDRA			;SuperSprite
	DB 87,33,18,2
	DW TIPO_PIEDRA			;SuperSprite
	DB 0,0,0,0
	DW TIPO_NULO
	DB 87,27,18,4
	DW TIPO_PIEDRA			;SuperSprite
	;  fin enemigos
	DB 255		
	DB 14,STA_LLAVE,88,32
	DW dSTILE_mt1,Objeto_TramaPuzzle_Cons,Objeto_TramaPuzzle_Trigger		;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 15,STA_LLAVE,88+16,32
	DW dSTILE_mt2,Objeto_TramaPuzzle_Cons,Objeto_TramaPuzzle_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 16,STA_LLAVE,88+32,32
	DW dSTILE_mt3,Objeto_TramaPuzzle_Cons,Objeto_TramaPuzzle_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 17,STA_LLAVE,88+48,32
	DW dSTILE_mt4,Objeto_TramaPuzzle_Cons,Objeto_TramaPuzzle_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 0,STA_LLAVE,#70,#08
	DW dSTILEt_puzzle13,Objeto_Puzzle_Cons,Objeto_Puzzle_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_18
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,23,17,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla5_zona2.txt"
	DB 255
	DB 0,0,0,0
	DW TIPO_NULO
	DB 8,14,56+40,0
	DW TIPO_GOTA
	DB 96,42,14,2
	DW TIPO_ESCORPION_DERECHA
	DB 0,0,0,0
	DW TIPO_NULO
	DB 80,34,32,2
	DW TIPO_PIRANA
	DB 80-16,38,32+16,1
	DW TIPO_PIRANA
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
FIN_BLOQUE06

ORG	#F400
PANTALLA_00
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA
    	DB #FF,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla_menu.txt"
	DB 255
	DB #48,08,48,1			;y,x,desp,velocidad
	DW TIPO_NULO			;SuperSprite
	DB #48,08,48,1			;y,x,desp,velocidad
	DW TIPO_GOTA			;SuperSprite
	DB #42,58,54,0			;y,x,desp,velocidad
	DW TIPO_GOTA			;SuperSprite
	;  fin enemigos
	DB 255				
	;  fin objetos
	DB 255
PANTALLA_17
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,16,18
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla4_zona2.txt"
	DB 255
	DB 8,40,48,0
	DW TIPO_GOTA
	DB 40,9,56,0
	DW TIPO_GOTA
	DB 40,26,72,0
	DW TIPO_GOTA
	DB 8,52,48,1
	DW TIPO_GOTA
	DB 40,32,72,1
	DW TIPO_GOTA
	;DB 64,46,40,1
	;DW TIPO_GOTA
	;  fin enemigos
	DB 255		
	DB 32,STA_PUERTA,56,40
	DW dSTILE_t127,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	DB 34,STA_LLAVE,#98,#50
	DW dstile_mt211,Objeto_TT_Cons,Objeto_TT_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	DB 35,STA_LLAVE,#C8,#50
	DW dstile_mt211,Objeto_TT_Cons,Objeto_TT_Trigger	;ID,Tipo,x,y,STILE
	DB 0
	;  fin objetos
	DB 255
PANTALLA_24
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 23,25,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla11_zona2.txt"
	DB 255
	DB #30-22,#34-6,38,1			;y,x,desp,velocidad
	DW TIPO_LAPIDA_ABAJO		;ID,SuperSprite
	DB 80-8,34-12,32,2
	DW TIPO_PIRANA
	DB 80-24,38-12,32+16,1
	DW TIPO_PIRANA
	DB 8,#34+4,32,0
	DW TIPO_GOTA
	DB 8,34-14,80,0
	DW TIPO_GOTA
	;  fin enemigos
	DB 255		
	DB 21,STA_LLAVE,56+72+56,72+24
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	DB 27,STA_PUERTA,136,8
	DW &8000 or dSTILE_126,Objeto_Puerta_Cons,Objeto_Nulo_Trigger
	DB 0 	;tag
	DB 26,STA_PUERTA,120,8
	DW dSTILE_126,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_29
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\intro3.txt"
	DB 255
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
PANTALLA_35
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 32,38,#FF,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla6_zona3.txt"
	DB 255
	DB #38,#1c,16,2
	DW TIPO_ESCORPION_DERECHA
	DB #58,#1D,24,1
	DW TIPO_GOTA
	DB #58,#2D,24,2
	DW TIPO_GOTA
	DB #38,#10,4,2
	DW TIPO_HACHA_DERECHA		;SuperSprite
	DB #68,4,#14,2
	DW TIPO_MOMIA_DERECHA
	DB #68,#25,0,30
	DW TIPO_PINCHOS
	;  fin enemigos
	DB 255		
	;  fin objetos
	DB 255
FIN_BLOQUE07

ORG	#FC00
PANTALLA_01
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#FF,02
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla1_zona1.txt"
	DB 255
	;  Empiezan los enemigos que acaban con 255
	DB 08,#18,24,2			;y,x,desp,velocidad
	DW TIPO_GOTA			;SuperSprite
	DB 79,22,18,3
	DW TIPO_PIEDRA			;SuperSprite
	DB 95,32,16,2
	DW TIPO_PIEDRA			;SuperSprite
	DB 24,#1C,18,2			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB 56,#2E,5,1
	DW TIPO_HACHA_DERECHA		;SuperSprite
	;  fin enemigos
	DB 255		
	DB 0,STA_LLAVE,136,56
	DW dSTILE_t86,Objeto_Normal_Cons,Objeto_Normal_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_07
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,09,06,08
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla7_zona1.txt"
	DB 255
	DB 40,42,6,8
	DW TIPO_FLECHA_DERECHA
	DB 104,24,22,2
	DW TIPO_ESCORPION_DERECHA
	DB 72,13,40,1
	DW TIPO_GOTA
	DB 8,8,72,0
	DW TIPO_GOTA
	DB 22,24,26,2
	DW TIPO_LAPIDA_ABAJO
	DB 72,48,0,30
	DW TIPO_PINCHOS
	;  fin enemigos
	DB 255				
	DB 11,STA_PUERTA,80,8
	DW &8000 or dSTILE_t71,Objeto_Puerta_Cons,Objeto_Nulo_Trigger
	DB 0 	;tag
	DB 10,STA_PUERTA,64,8
	DW dSTILE_t71,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 4 	;tag
	;  fin objetos
	DB 255
PANTALLA_14
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB #FF,#FF,#ff,15
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla1_zona2.txt"
	DB 255
	DB 72,48,6,25			;y,x,desp,espera al ppi
    	DW TIPO_FLECHA_DERECHA
	DB 104,26,10,2			;con un uno en la tercera posición, se mueven los pinchos
	DW TIPO_PAJARO_DERECHA
	DB 87,4,18,3
	DW TIPO_PIEDRA			;SuperSprite
	DB 24,49,5,1			;y,x,desp,velocidad
	DW TIPO_HACHA_DERECHA		;SuperSprite
	DB 104,40,18,1
	DW TIPO_SERPIENTE_IZQUIERDA
	DB 104,10,12,1
	DW TIPO_PAJARO_DERECHA
	;  fin enemigos
	DB 255		
	DB 18,STA_LLAVE,16,40
	DW dstile_00,Objeto_Aleatorio_Cons,Objeto_Aleatorio_Trigger	;ID,Tipo,x,y,STILE
	DB 0 	;tag
	;  fin objetos
	DB 255
PANTALLA_37
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
    	DB 34,40,36,#FF
    	;  SuperTiles que componen la pantalla
    	;  identificador del SuperTile
	READ "pant\pantalla8_zona3.txt"
	DB 255
	DB #30,#36,0,30
	DW TIPO_PINCHOS
	DB #68-32+8,12,32,2
	DW TIPO_PIRANA
	DB #68-32-8,16,32+16,1
	DW TIPO_PIRANA
	DB #38,#28,0,25
	DW TIPO_PINCHOS
	DB #68,#1e,26,1			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	DB #58,#1a,30,0			;y,x,desp,velocidad
	DW TIPO_PAJARO_DERECHA		;SuperSprite
	;  fin enemigos
	DB 255		
	DB 49,STA_PUERTA,196+44,40
	DW dSTILE_t721,Objeto_Puerta_Cons,Objeto_Puerta_Trigger
	DB 2 	;tag
	;  fin objetos
	DB 255
FIN_BLOQUE08