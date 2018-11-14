ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "main.h.s"
                              1 ;; 
                              2 ;; Declare all function entry points as global symbols for the compiler.
                              3 ;; (The linker will know what to do with them)
                              4 ;; WARNING: Every global symbol declared will be linked, so DO NOT declare 
                              5 ;; symbols for functions you do not use.
                              6 ;;
                              7 .globl cpct_disableFirmware_asm
                              8 .globl cpct_drawSolidBox_asm
                              9 .globl cpct_getScreenPtr_asm
                             10 .globl cpct_waitVSYNC_asm
                             11 .globl cpct_scanKeyboard_asm
                             12 .globl cpct_isKeyPressed_asm
                             13 .globl cpct_setVideoMode_asm
                             14 .globl cpct_drawSprite_asm
                             15 .globl cpct_setPalette_asm
                             16 .globl cpct_setPALColour_asm
                             17 .globl cpct_drawSpriteMasked_asm 
                             18 .globl cpct_drawStringM0_asm
                             19 .globl cpct_setDrawCharM0_asm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "numbers.h.s"
                              1 .globl draw_numbers
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 .include "disparo.h.s"
                              1 .macro DefineDisparo _name, _x, _y, _vx, _vy, _w, _h, _sprite
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db	 _vx, _vy	  ;;vX, vY
                              5    .db	 _w, _h		  ;;W, H
                              6    .dw	 _sprite		  ;;Color
                              7 
                              8 .endm
                              9 
                             10 
                     0000    11 s_x = 0
                     0001    12 s_y = 1
                     0002    13 s_vx = 2
                     0003    14 s_vy = 3
                     0004    15 s_w = 4
                     0005    16 s_h = 5
                     0006    17 s_sp_l = 6
                     0007    18 s_sp_h = 7
                             19 
                             20 .globl shotControl
                             21 .globl startShot
                             22 .globl shot_data
                             23 .globl hero_shot
                             24 
                             25 .globl shot_direction
                             26 .globl munition
                             27 .globl s_background
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              4 
   82E5 03                    5 thenumber: 	.db 	#3
   82E6 00                    6 thenumber_l: 	.db 	#0
   82E7 00                    7 thenumber_h: 	.db 	#0
                              8 
   82E8                       9 selectNumber:
                             10 
   82E8 32 E5 82      [13]   11 ld 	(thenumber), 	a
   82EB FE 00         [ 7]   12 cp #0
   82ED C2 FC 82      [10]   13 jp 	nz, 	nocero
   82F0 21 84 3F      [10]   14 ld 	hl, 	#_numbers_sp_00
   82F3 7D            [ 4]   15 ld 	a,	l 	
   82F4 32 E6 82      [13]   16 ld 	(thenumber_l),	a 	
   82F7 7C            [ 4]   17 ld  a, 	h
   82F8 32 E7 82      [13]   18 ld  (thenumber_h), 	a
   82FB C9            [10]   19 ret
   82FC                      20 nocero:
   82FC 3A E5 82      [13]   21 ld 	a, 	(thenumber)
   82FF FE 01         [ 7]   22 cp #1
   8301 C2 10 83      [10]   23 jp 	nz, 	nouno
   8304 21 A4 3F      [10]   24 ld 	hl, 	#_numbers_sp_01
   8307 7D            [ 4]   25 ld 	a,	l 	
   8308 32 E6 82      [13]   26 ld 	(thenumber_l),	a 	
   830B 7C            [ 4]   27 ld  a, 	h
   830C 32 E7 82      [13]   28 ld  (thenumber_h), 	a
   830F C9            [10]   29 ret
   8310                      30 nouno:
   8310 3A E5 82      [13]   31 ld 	a, 	(thenumber)
   8313 FE 02         [ 7]   32 cp #2
   8315 C2 24 83      [10]   33 jp 	nz, 	nodos
   8318 21 C4 3F      [10]   34 ld 	hl, 	#_numbers_sp_02
   831B 7D            [ 4]   35 ld 	a,	l 	
   831C 32 E6 82      [13]   36 ld 	(thenumber_l),	a 	
   831F 7C            [ 4]   37 ld  a, 	h
   8320 32 E7 82      [13]   38 ld  (thenumber_h), 	a
   8323 C9            [10]   39 ret
   8324                      40 nodos:
   8324 3A E5 82      [13]   41 ld 	a, 	(thenumber)
   8327 FE 03         [ 7]   42 cp #3
   8329 C2 38 83      [10]   43 jp 	nz, 	notres
   832C 21 E4 3F      [10]   44 ld 	hl, 	#_numbers_sp_03
   832F 7D            [ 4]   45 ld 	a,	l 	
   8330 32 E6 82      [13]   46 ld 	(thenumber_l),	a 	
   8333 7C            [ 4]   47 ld  a, 	h
   8334 32 E7 82      [13]   48 ld  (thenumber_h), 	a
   8337 C9            [10]   49 ret
   8338                      50 notres:
   8338 3A E5 82      [13]   51 ld 	a, 	(thenumber)
   833B FE 04         [ 7]   52 cp #4
   833D C2 4C 83      [10]   53 jp 	nz, 	nocuatro
   8340 21 04 40      [10]   54 ld 	hl, 	#_numbers_sp_04
   8343 7D            [ 4]   55 ld 	a,	l 	
   8344 32 E6 82      [13]   56 ld 	(thenumber_l),	a 	
   8347 7C            [ 4]   57 ld  a, 	h
   8348 32 E7 82      [13]   58 ld  (thenumber_h), 	a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   834B C9            [10]   59 ret
   834C                      60 nocuatro:
   834C 3A E5 82      [13]   61 ld 	a, 	(thenumber)
   834F FE 05         [ 7]   62 cp #5
   8351 C2 60 83      [10]   63 jp 	nz, 	nocinco
   8354 21 24 40      [10]   64 ld 	hl, 	#_numbers_sp_05
   8357 7D            [ 4]   65 ld 	a,	l 	
   8358 32 E6 82      [13]   66 ld 	(thenumber_l),	a 	
   835B 7C            [ 4]   67 ld  a, 	h
   835C 32 E7 82      [13]   68 ld  (thenumber_h), 	a
   835F C9            [10]   69 ret
   8360                      70 nocinco:
   8360 3A E5 82      [13]   71 ld 	a, 	(thenumber)
   8363 FE 06         [ 7]   72 cp #6
   8365 C2 74 83      [10]   73 jp 	nz, 	noseis
   8368 21 44 40      [10]   74 ld 	hl, 	#_numbers_sp_06
   836B 7D            [ 4]   75 ld 	a,	l 	
   836C 32 E6 82      [13]   76 ld 	(thenumber_l),	a 	
   836F 7C            [ 4]   77 ld  a, 	h
   8370 32 E7 82      [13]   78 ld  (thenumber_h), 	a
   8373 C9            [10]   79 ret
   8374                      80 noseis:
   8374 3A E5 82      [13]   81 ld 	a, 	(thenumber)
   8377 FE 07         [ 7]   82 cp #7
   8379 C2 88 83      [10]   83 jp 	nz, 	nosiete
   837C 21 64 40      [10]   84 ld 	hl, 	#_numbers_sp_07
   837F 7D            [ 4]   85 ld 	a,	l 	
   8380 32 E6 82      [13]   86 ld 	(thenumber_l),	a 	
   8383 7C            [ 4]   87 ld  a, 	h
   8384 32 E7 82      [13]   88 ld  (thenumber_h), 	a
   8387 C9            [10]   89 ret
   8388                      90 nosiete:
   8388 3A E5 82      [13]   91 ld 	a, 	(thenumber)
   838B FE 08         [ 7]   92 cp #8
   838D C2 9C 83      [10]   93 jp 	nz, 	noocho
   8390 21 84 40      [10]   94 ld 	hl, 	#_numbers_sp_08
   8393 7D            [ 4]   95 ld 	a,	l 	
   8394 32 E6 82      [13]   96 ld 	(thenumber_l),	a 	
   8397 7C            [ 4]   97 ld  a, 	h
   8398 32 E7 82      [13]   98 ld  (thenumber_h), 	a
   839B C9            [10]   99 ret
   839C                     100 noocho:
   839C 21 A4 40      [10]  101 ld 	hl, 	#_numbers_sp_09
   839F 7D            [ 4]  102 ld 	a,	l 	
   83A0 32 E6 82      [13]  103 ld 	(thenumber_l),	a 	
   83A3 7C            [ 4]  104 ld  a, 	h
   83A4 32 E7 82      [13]  105 ld  (thenumber_h), 	a
                            106 
   83A7 C9            [10]  107 ret
                            108 
   83A8                     109 draw_numbers:
                            110 
   83A8 CD E8 82      [17]  111 	call selectNumber
   83AB 11 00 C0      [10]  112 	ld    de, #0xC000         ;; Comienzo de memoria de video
   83AE 0E 4B         [ 7]  113 	ld    c, 	#75          ;; Entidad X
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   83B0 06 04         [ 7]  114 	ld    b, 	#4          ;; Entidad Y
   83B2 CD 38 8A      [17]  115 	call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla
                            116 
                            117 	;;;HL -> Memoria de video
                            118 
   83B5 EB            [ 4]  119 	ex    de, hl         ;; Cambio lo de HL a DE
   83B6 3A E6 82      [13]  120 	ld    a, (thenumber_l)
   83B9 6F            [ 4]  121 	ld    l, a
   83BA 3A E7 82      [13]  122 	ld    a, (thenumber_h)
   83BD 67            [ 4]  123 	ld    h, a
                            124 	;;;ld    hl, #_hero_sp_0  
   83BE 0E 08         [ 7]  125 	ld    c, #8     ;; Alto
   83C0 06 04         [ 7]  126 	ld    b, #4     ;; Ancho
   83C2 CD ED 89      [17]  127    call cpct_drawSpriteBlended_asm
   83C5 C9            [10]  128 ret
