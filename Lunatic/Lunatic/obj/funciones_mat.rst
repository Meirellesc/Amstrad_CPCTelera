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



                              2 .include "entity.h.s"
                              1 .macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _sprite, _upd, _life 
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _vx, _vy     ;;VX, VY
                              5    .db   _w, _h       ;;W, H
                              6    .dw   _sprite      ;;Puntero al sprite
                              7    .dw   _upd         ;;Update 
                              8    .db   _life        ;;Life
                              9    _name'_size = . - _name
                             10 .endm
                             11 
                             12 ;;.macro DefineEntityDefault _name, _suf
                             13 ;;   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, 
                             14 ;;.endm
                             15 
                             16 ;;.macro DefineNEntities _name, _n
                             17 ;;   _c = 0
                             18 ;;   .rept _n
                             19 ;;      DefineEntityDefault _name, \_c
                             20 ;;      _c = _c + 1
                             21 ;;   .endm
                             22 ;;.endm
                             23 
                     0000    24 e_x      = 0
                     0001    25 e_y      = 1
                     0002    26 e_vx     = 2
                     0003    27 e_vy     = 3
                     0004    28 e_w      = 4
                     0005    29 e_h      = 5
                     0006    30 e_sp_l   = 6
                     0007    31 e_sp_h	 = 7
                     0008    32 e_upd_l  = 8
                     0009    33 e_upd_h  = 9
                     000A    34 e_life   = 10
                             35 
                             36 
                             37 .globl ent_update
                             38 .globl ent_draw
                             39 .globl update_draw_life
                             40 
                             41 
                             42 .globl hero_data
                             43 .globl jumpControl
                             44 .globl ent_isJumping_or_canFall
                             45 .globl hero_fall
                             46 .globl hero_dispara
                             47 .globl hero_jump
                             48 
                             49 
                             50 .globl	ent_background
                             51 .globl 	pos_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 .include "funciones_mat.h.s"
                              1 
                              2 .globl 	multiplicar_2
                              3 .globl 	multiplicar_4
                              4 .globl 	dividir_4
                              5 .globl 	dividir_2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              4 
   7C65 C8                    5 posicionY: 	.db 	#200
   7C66                       6 multiplicar_2:
   7C66 87            [ 4]    7 add a, a
   7C67 C9            [10]    8 ret
                              9 
   7C68                      10 multiplicar_4:
   7C68 47            [ 4]   11 ld 	b, 	a
                             12 
   7C69 0E 04         [ 7]   13 ld 	c, 	#4
   7C6B 16 00         [ 7]   14 ld 	d, 	#0
   7C6D                      15 multiplica:
   7C6D 4F            [ 4]   16 	ld 	c, 	a
   7C6E 7A            [ 4]   17 	ld 	a, 	d
   7C6F 80            [ 4]   18 	add	a, 	b
   7C70 57            [ 4]   19 	ld 	d, 	a
                             20 
   7C71 79            [ 4]   21 	ld 	a, 	c
   7C72 3D            [ 4]   22 	dec 	a
   7C73 C2 6D 7C      [10]   23 jp 	nz, multiplica
                             24 
   7C76 7A            [ 4]   25 ld 	a, 	d
                             26 
   7C77 C9            [10]   27 ret
                             28 
   7C78                      29 dividir_2:
   7C78 47            [ 4]   30 ld 	b, 	a 			;12
                             31 
   7C79 0E 02         [ 7]   32 ld 	c, 	#2			;/2
   7C7B 16 00         [ 7]   33 ld 	d, 	#0
   7C7D                      34 divide2:
   7C7D 78            [ 4]   35 	ld 	a, 	b		; A = 12
   7C7E 91            [ 4]   36 	sub	a, 	c		; A = A-2
   7C7F FA 8D 7C      [10]   37 	jp 	m, fin_div2
   7C82 47            [ 4]   38 	ld 	b, 	a 		; B = A
   7C83 7A            [ 4]   39 	ld 	a, 	d 		; A = RESULT
   7C84 C6 01         [ 7]   40 	add a,	#1		; A = A+1
   7C86 57            [ 4]   41 	ld 	d, 	a
   7C87 78            [ 4]   42 	ld 	a, 	b
   7C88 FE 00         [ 7]   43 	cp 	#0
   7C8A C2 7D 7C      [10]   44 	jp	nz, divide2
   7C8D                      45 fin_div2:
   7C8D 7A            [ 4]   46 ld 	a, 	d
   7C8E C9            [10]   47 ret
                             48 
   7C8F                      49 dividir_4:
   7C8F 57            [ 4]   50 ld 	d, 	a 			;+128 	no lo hace
                             51 
   7C90 0E 04         [ 7]   52 ld 	c, 	#4			;/2
   7C92 06 00         [ 7]   53 ld 	b, 	#0
   7C94                      54 divide:
   7C94 7A            [ 4]   55 	ld 	a, 	d		; A = 12
   7C95 91            [ 4]   56 	sub	a, 	c		; A = A-2
   7C96 57            [ 4]   57 	ld 	d, 	a 		; B = A
   7C97 7A            [ 4]   58 	ld 	a, 	d		; A = 12
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   7C98 FE 03         [ 7]   59 	cp 	#3
   7C9A CA B9 7C      [10]   60 	jp 	z, fin_div
   7C9D 7A            [ 4]   61 	ld 	a, 	d		; A = 12
   7C9E FE 02         [ 7]   62 	cp 	#2
   7CA0 CA B9 7C      [10]   63 	jp 	z, fin_div
   7CA3 7A            [ 4]   64 	ld 	a, 	d		; A = 12
   7CA4 FE 01         [ 7]   65 	cp 	#1
   7CA6 CA B9 7C      [10]   66 	jp 	z, fin_div
   7CA9 7A            [ 4]   67 	ld 	a, 	d		; A = 12
   7CAA FE 00         [ 7]   68 	cp 	#0
   7CAC CA B9 7C      [10]   69 	jp 	z, fin_div
   7CAF 78            [ 4]   70 	ld 	a, 	b 		; A = RESULT
   7CB0 C6 01         [ 7]   71 	add a,	#1		; A = A+1
   7CB2 47            [ 4]   72 	ld 	b, 	a
   7CB3 7A            [ 4]   73 	ld 	a, 	d
   7CB4 FE 00         [ 7]   74 	cp 	#0
   7CB6 C2 94 7C      [10]   75 	jp	nz, divide
   7CB9                      76 fin_div:
   7CB9 78            [ 4]   77 ld 	a, 	b
   7CBA C9            [10]   78 ret
