;Parámetros propios del juego
;****************************
MODO_MARCADOR		EQU	0		;mode del marcador
ZONA_MARCADOR		EQU	%00010000	;&4000
DIRECCION_MARCADOR	EQU	#4000
MODO_JUEGO		EQU	0		;mode del juego
ZONA_JUEGO		EQU     %00110000	;&c000
DIRECCION_JUEGO		EQU	#C000

BYTE_FONDO_PANTALLA	EQU	#FF		;color para borrar fondo de pantallas

NUMERO_PANTALLAS	EQU	55+1		;número de pantallas del juego (se añade una pq empieza de 0)
NUMERO_STILES		EQU	126+1		;número de SuperTiles
NUMERO_OBJETOS		EQU	66		;número de objetos del recorrido

NUMERO_DE_TINTAS	EQU	16		;16 tintas en mode 0

DIRECCION_TILES		EQU	#5000		;dirección de los TILES
JUEGO_TILES_1		EQU	5
DIRECCION_TILES_1	EQU	#5000		;dirección del juego 1 de TILES
JUEGO_TILES_2		EQU	6
DIRECCION_TILES_2	EQU	#6000		;dirección del juego 2 de TILES
DIRECCION_T_MASCARAS	EQU	#7000
TABLA_MASCARASH		EQU	#70
DIRECCION_MUSICA	EQU	#7100		;dirección de los mapas de pantallas
DIRECCION_PANTALLAS 	EQU     #9000		;dirección de los mapas de pantallas

;Pantalla significativas
PANTALLA_MENU		EQU	0
PANTALLA_INICIO		EQU	1
PANTALLA_INTRO		EQU     27

;Dimensiones del mapa en tiles y en pixeles
ALTO_MAPA_TILES		EQU	16
ANCHO_MAPA_TILES	EQU	32
ALTO_MAPA_BYTES		EQU	ALTO_MAPA_TILES*8
ANCHO_MAPA_BYTES	EQU	ANCHO_MAPA_TILES*2
ALTO_MAPA_PX		EQU	ALTO_MAPA_TILES*8
ANCHO_MAPA_PX		EQU	ANCHO_MAPA_TILES*8

BITS_DUREZAS		EQU	2		;número de bits de durezas para el mapa
DIVBITS_DUREZAS		EQU	8/BITS_DUREZAS	;número de tiles por byte

DUREZAS_TOTAL		EQU	136		;hasta que tile son durezas totales (no se pueden traspasar)
DUREZAS_MATAN		EQU	143		;hasta que tile son durezas que matan

TILE_FONDO		EQU	147
TILE_FONDO_PAPIRO	EQU	148

CORRECTOR_NUMEROS	EQU	86
CORRECTOR_TEXTO		EQU     -14

GRAVEDAD		EQU	8
	
;CHECKS del PROTA
CHECK_PATH		EQU	0	;bit 0 controla si está en un camino o no
CHECK_REPOSO		EQU	1	;bit 1 controla si el prota está en reposo o no
CHECK_ANDAR		EQU	2	;bit 2 controla si el prota está andando o no
CHECK_CAYENDO		EQU	3	;bit 3 controla si el prota está cayendo o no
CHECK_MUERTE		EQU	4	;bit 4 controla si hemos chocado con alguna dureza que mata o no
CHECK_AGACHAR		EQU	5	;bit 5 controla si está aterrizando o no 
CHECK_CAMBIO		EQU	6	;bit 6 controla si cambia de pantalla o no
;CHECKS de los malos
CHECK_ACTIVAR		EQU	5	;bit 5 activa rutina de animación (PIEDRAS)
CHECK_MATA		EQU	6	;bit 6 si mata o no el sprite al chocar
;CHECKS comunes
CHECK_SIMETRIA		EQU	7	;bit 7 para simetricos o no
;combinaciones de bits para las durezas en el mapa
BIT_TOTAL		EQU	%01
BIT_MATAN		EQU	%10
BIT_VACIO		EQU	%00
BIT_OBJETO		EQU	%11
;combinaciones de bits para las interrupciones
;Captura Fondo Pantalla
BIT_cfp			EQU	%00000100
BIT_NEG_cfp		EQU	%11111011
;UPDATE
BIT_UPD			EQU	%00001000
BIT_NEG_UPD		EQU	%11110111
;Imprime Sprite Pantalla
BIT_isp			EQU	%00000001
BIT_NEG_isp		EQU	%11111110
;Imprime buffer Pantalla
BIT_ibp			EQU	%00000010
BIT_NEG_ibp		EQU	%11111101

MAX_INT			EQU     3       ;Maximo numero de sprites por interrupcion

SND_SALTO		EQU	1
SND_MUERTE		EQU	2
SND_GOTA		EQU	3
SND_ABRIR		EQU	4
SND_PLATAFORMA		EQU	5
SND_COGER		EQU	6
SND_SELECCION		EQU	7
SND_SUELO		EQU	8

STA_LLAVE		EQU	3
STA_OBJETO		EQU	2
STA_PUERTA		EQU	1

STILE_00		EQU     0
STILE_01 		EQU 	1		;codigo de cada supertile
STILE_02 		EQU 	2		;para leer bien las pantallas
STILE_03 		EQU 	3		;realmente no haría falta
STILE_04 		EQU 	4
STILE_05 		EQU 	5
STILE_06 		EQU 	6
STILE_07 		EQU 	7
STILE_08 		EQU 	8
STILE_09 		EQU 	9
STILE_10 		EQU 	10
STILE_11 		EQU 	11
STILE_12 		EQU 	12
STILE_13 		EQU 	13
STILE_14 		EQU 	14
STILE_15 		EQU 	15
STILE_16 		EQU 	16
STILE_17 		EQU 	17
STILE_18 		EQU 	18
STILE_19 		EQU 	19
STILE_20 		EQU 	20
STILE_21 		EQU 	21
STILE_22 		EQU 	22
STILE_23 		EQU 	23
STILE_24 		EQU 	24
STILE_25 		EQU 	25
STILE_26 		EQU 	26
STILE_27 		EQU 	27
STILE_28 		EQU 	28
STILE_29 		EQU 	29
STILE_30 		EQU 	30
STILE_31 		EQU 	31
STILE_32 		EQU 	32
STILE_33 		EQU 	33
STILE_34 		EQU 	34
STILE_35 		EQU 	35
STILE_36 		EQU 	36
STILE_37 		EQU 	37
STILE_38 		EQU 	38
STILE_39 		EQU 	39
STILE_40		EQU 	40
STILE_41 		EQU 	41
STILE_42 		EQU 	42
STILE_43 		EQU 	43
STILE_44 		EQU 	44
STILE_45 		EQU 	45
STILE_46 		EQU 	46
STILE_47 		EQU 	47
STILE_48 		EQU 	48
STILE_49 		EQU 	49
STILE_50 		EQU 	50
STILE_51 		EQU 	51
STILE_52 		EQU 	52
STILE_53 		EQU 	53
STILE_54 		EQU 	54
STILE_55 		EQU 	55
STILE_56 		EQU 	56
STILE_57 		EQU 	57
STILE_58 		EQU 	58
STILE_59 		EQU 	59
STILE_60 		EQU 	60
STILE_61 		EQU 	61
STILE_62 		EQU 	62
STILE_63 		EQU 	63
STILE_64 		EQU 	64
STILE_65 		EQU 	65
STILE_66 		EQU 	66
STILE_67 		EQU 	67
STILE_68 		EQU 	68
STILE_69 		EQU 	69
STILE_70 		EQU 	70
STILE_71 		EQU 	71
STILE_72 		EQU 	72
STILE_73		EQU	73
STILE_74		EQU	74
STILE_75		EQU	75
STILE_76		EQU	76
STILE_77		EQU	77
STILE_78		EQU	78
STILE_79		EQU	79
STILE_80		EQU	80
STILE_81		EQU	81
STILE_82		EQU	82
STILE_83		EQU	83
STILE_84		EQU	84
STILE_85		EQU	85
STILE_86		EQU	86
STILE_87		EQU	87
STILE_88		EQU	88
STILE_89		EQU	89
STILE_90		EQU	90
STILE_91		EQU	91
STILE_92		EQU	92
STILE_93		EQU	93
STILE_94		EQU	94
STILE_95		EQU	95
STILE_96		EQU	96
STILE_97		EQU	97
STILE_98		EQU	98
STILE_99		EQU	99
STILE_100		EQU	100
STILE_101		EQU	101
STILE_102		EQU	102
STILE_103		EQU	103
STILE_104		EQU	104
STILE_105		EQU	105
STILE_106		EQU	106
STILE_107		EQU	107
STILE_108		EQU	108
STILE_109		EQU	109
STILE_110		EQU	110
STILE_111		EQU	111
STILE_112		EQU	112
STILE_113		EQU	113
STILE_114		EQU	114
STILE_115		EQU	115
STILE_116		EQU	116
STILE_117		EQU	117
STILE_118		EQU	118
STILE_119		EQU	119
STILE_120		EQU	120
STILE_121		EQU	121
STILE_122		EQU	122
STILE_123		EQU	123
STILE_124		EQU	124
STILE_125		EQU	125
STILE_126		EQU	126

T_PUNTO			EQU	96+14
T_COMA			EQU     97+14
T_GUION			EQU	98+14
T_A			EQU     99+14
T_O			EQU	100+14
T_U 			EQU	101+14
T_MA			EQU	102+14
T_ME			EQU	103+14
T_MP			EQU	104+14
T_MR			EQU	105+14
T_MS			EQU	106+14
T_EXCLAMACION		EQU	176+14
T_INTERROGACION		EQU	177+14
T_ESPACIO		EQU 	147+14
T_ENIE			EQU	77+14
T_0			EQU     86+14
T_1			EQU	87+14
T_2			EQU	88+14
T_3			EQU	89+14
T_4			EQU	90+14
T_5			EQU	91+14
T_6			EQU	92+14
T_7			EQU	93+14
T_8			EQU	94+14
T_9			EQU	95+14

;Parámetros propios del motor
;****************************
INICIO_CODIGO		EQU	#0040

CURRENT_R7_VALUE	EQU	#1E	; valor al comienzo del CRTC R7

PPI_A			EQU	#F400
PPI_C               	EQU 	#F600
PPI_CONTROL         	EQU 	#F700

PPI_PSG_READ        	EQU 	%01000000
PPI_PSG_SELECT      	EQU 	%11000000

PSG_REG_0E          	EQU 	#0E

OFFSET_SPRITES		EQU	INICIO_SPRITES_IZQ-INICIO_SPRITES_DER
TAMANO_BUFFER		EQU	FIN_BUFFER-BUFFER

DERECHA			EQU	0
IZQUIERDA		EQU	1
ARRIBA			EQU	2
ABAJO			EQU	3

KEY_LINE0          	EQU 	0
KEY_LINE1           	EQU 	1
KEY_LINE2           	EQU 	2
KEY_LINE3          	EQU 	3
KEY_LINE4           	EQU 	4
KEY_LINE5           	EQU 	5
KEY_LINE6           	EQU 	6
KEY_LINE7           	EQU 	7
KEY_LINE8           	EQU 	8
KEY_LINE9           	EQU 	9

; Direcciones del Joystick
; Bits
JOY_UP              	EQU 	0
JOY_DOWN            	EQU 	1
JOY_LEFT            	EQU 	2
JOY_RIGHT           	EQU 	3
JOY_FIRE1           	EQU 	4
JOY_FIRE2          	EQU 	5

KEY_ESCAPE	    	EQU 	7

KEY_1              	EQU 	1
KEY_2               	EQU 	2
KEY_3			EQU 	3
KEY_4               	EQU 	4
KEY_5               	EQU 	5

KEY_F2  	    	EQU 	6
KEY_F4              	EQU 	7
KEY_F6              	EQU 	6
KEY_F8              	EQU 	0

NUMERO_SPRITES		EQU	6

S_ID			EQU	0	
S_TIPO			EQU	1
S_X			EQU	2
S_Y			EQU	3
S_STILE			EQU	4
S_CONS			EQU	6
S_TRIGGER		EQU	8
S_TAG			EQU	10
LONG_STATICS		EQU	11

_ID			EQU	0
_ANCHO			EQU	1
_ALTO			EQU	2
_X       		EQU     3
_ANTX    		EQU	4
_Y       		EQU     5
_ANTY    		EQU	6
_DSPR    		EQU	7
_SPR     		EQU	9
_SPR_A   		EQU	10
_BUFF    		EQU	11
_UPD			EQU	13
_MIRADA			EQU	15
_IDESP			EQU	16	;de este en adelante de lo enemigos
_DESP			EQU	17
_CHECKS			EQU	18	;checks del PROTA (0-camino)
_ADESP			EQU	19
_ICAD			EQU	20
_CAD			EQU	21
LONG_SPRITES		EQU	22

_PATH			EQU	16	;este es del PROTA
_VIDAS			EQU	19	;vidas del PROTA

_4x16			EQU     %10010000  ;#4 & #10
_2x08			EQU	%01001000  ;#2 & #08
_6x16			EQU	%11010000  ;#6 & #10

_00SPR			EQU     %00000000
_01SPR			EQU	%00010000
_02SPR			EQU	%00100000
_03SPR			EQU	%00110000
_05SPR			EQU	%01010000
_07SPR			EQU	%01110000
_15SPR			EQU	%11110000

_DER			EQU	%00000000
_IZQ			EQU	%00000100
_ARR			EQU	%00001000
_ABA			EQU	%00001100