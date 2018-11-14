ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;|0x00	0
                              2 ;|0x04	1
                              3 ;|0x08 	2
                              4 ;|0x0C 	3
                              5 ;|0x10 	4
                              6 ;|0x14
                              7 ;|0x18
                              8 ;|0x1C
                              9 ;|0x20
                             10 ;|0x24
                             11 ;|0x28 	10
                             12 ;|0x2C
                             13 ;|0x30
                             14 ;|0x34
                             15 ;|0x38
                             16 ;|0x3C 	15
                             17 ;|0x40
                             18 ;|0x44
                             19 ;|0x48
                             20 ;|0x4C
                             21 ;|0x50 	20
                             22 ;|0x54
                             23 ;|0x58
                             24 ;|0x5C
                             25 ;|0x60 
                             26 ;|0x64 	25
                             27 ;|0x68
                             28 ;|0x6C
                             29 ;|0x70
                             30 ;|0x74
                             31 ;|0x78 	30
                             32 ;|0x7C
                             33 ;|0x80
                             34 ;|0x84
                             35 ;|0x88
                             36 ;|0x8C 	35
                             37 ;|0x90
                             38 ;|0x94
                             39 ;|0x98
                             40 ;|0x9C
                             41 ;|0xA0 	40
                             42 ;|0xA4
                             43 ;|0xA8
                             44 ;|0xAC
                             45 ;|0xB0
                             46 ;|0xB4 	46
                             47 ;|0xB8
                             48 ;|0xBC
                             49 ;|0xC0
                             50 ;|0xC4
                             51 ;|0xC8 	50
                             52 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             53 .include "load_level.h.s"
                              1 .globl load_level1
                              2 .globl load_level2
                              3 .globl load_level3
                              4 .globl load_level8
                              5 .globl load_level9
                              6 .globl load_level10
                              7 
                              8 .globl n_plat
                              9 .globl n_enem
                             10 .globl hero_x
                             11 .globl hero_y
                             12 
                             13 .globl load_level0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             54 .include "platform.h.s"
                              1 .macro DefinePlatform _name, _x, _y, _vx, _vy, _w, _h
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db	 _vx, _vy		  ;;W, H
                              5    .db	 _w, _h		  ;;W, H
                              6 
                              7 .endm
                              8 
                              9 
                             10 
                     0000    11 p_x = 0
                     0001    12 p_y = 1
                     0002    13 p_vx = 2
                     0003    14 p_vy = 3
                     0004    15 p_w = 4
                     0005    16 p_h = 5
                             17 
                             18 
                             19 
                             20 .globl platform_datas 
                             21 .globl platform_data 
                             22 .globl platform_data2 
                             23 .globl platform_data3
                             24 .globl platform_data4
                             25 .globl platform_data5
                             26 .globl platform_data6
                             27 .globl platform_data7
                             28 .globl platform_data8
                             29 .globl platform_data9
                             30 .globl platform_data10
                             31 .globl platform_data11
                             32 
                             33 .globl plat_checkAll
                             34 .globl ent_fall
                             35 .globl plat_checkAll_border
                             36 .globl k_plat_size
                             37 .globl check_platform_enemy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             55 .include "objects.h.s"
                              1 .macro DefineObjects _name, _x, _y, _w, _h, _sprite, _tipo, _open
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _w, _h       ;;W, H
                              5    .dw   _sprite      ;;Puntero al sprite
                              6    .db   _tipo        ;;Enemy life
                              7    .db 	 _open
                              8    _name'_size = . - _name
                              9 .endm
                             10 
                     0000    11 obj_x 		= 0
                     0001    12 obj_y 		= 1
                     0002    13 obj_w 		= 2
                     0003    14 obj_h 		= 3
                     0004    15 obj_sp_l 	= 4
                     0005    16 obj_sp_h 	= 5
                     0006    17 obj_tipo 	= 6
                     0007    18 obj_open 	= 7
                             19 
                             20 .globl 	main_obj
                             21 .globl 	draw_obj
                             22 .globl 	bala
                             23 .globl 	puerta
                             24 .globl 	llave
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             56 .include "enemy.h.s"
                              1 .macro DefineEnemy _name, _x, _y, _vx, _vy, _w, _h, _sprite, _life, _slow, _slowReference, _canMove, _tipo
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _vx, _vy     ;;VX, VY
                              5    .db   _w, _h       ;;W, H
                              6    .dw   _sprite      ;;Puntero al sprite
                              7    .db   _life        ;;Enemy life
                              8    .db   _slow        ;;enemy slow
                              9    .db   _slowReference        ;;enemy slow
                             10    .db 	 _canMove
                             11    .db   _tipo
                             12    _name'_size = . - _name
                             13 .endm
                             14 
                     0000    15 en_x = 0
                     0001    16 en_y = 1
                     0002    17 en_vx = 2
                     0003    18 en_vy = 3
                     0004    19 en_w = 4
                     0005    20 en_h = 5
                     0006    21 en_sp_l = 6
                     0007    22 en_sp_h = 7
                     0008    23 en_life = 8
                     0009    24 en_slow = 9
                     000A    25 en_slowReference = 10
                     000B    26 en_canMove = 11
                     000C    27 en_tipo = 12
                             28 
                             29 
                             30 .globl enemy_interaction
                             31 .globl enemy_vector 
                             32 .globl k_enemy_size 
                             33 
                             34 .globl enemy_data0
                             35 .globl enemy_data1
                             36 .globl enemy_data2
                             37 .globl enemy_data3
                             38 .globl enemy_data4
                             39 .globl init_enemy
                             40 
                             41 .globl pos_y_en
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             57 .include "entity.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             58 .include "main.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             59 
   7CBB 00                   60 n_plat: 	.db	#0
   7CBC 00                   61 n_enem: 	.db	#0
   7CBD 00                   62 hero_x:		.db #0
   7CBE 00                   63 hero_y:		.db #0
                             64 
                             65 ;/////////////////////////////////////////////////////////////////
                             66 ; 					LEVEL 			0
                             67 ;/////////////////////////////////////////////////////////////////
   7CBF                      68 load_level0:
   7CBF 3E 06         [ 7]   69 ld 	a, 	#6
   7CC1 32 BB 7C      [13]   70 ld 	(n_plat), 	a
   7CC4 3E 00         [ 7]   71 ld 	a, 	#0
   7CC6 32 BC 7C      [13]   72 ld 	(n_enem), 	a
                             73 
   7CC9 DD 21 61 79   [14]   74 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   7CCD 3E 01         [ 7]   75 ld 	a, 	#0x01
   7CCF 32 BD 7C      [13]   76 ld 	(hero_x), 	a
   7CD2 DD 77 00      [19]   77 ld 	e_x(ix), 	a
   7CD5 3E A8         [ 7]   78 ld 	a, 	#0xA8
   7CD7 32 BE 7C      [13]   79 ld 	(hero_y), 	a
   7CDA DD 77 01      [19]   80 ld 	e_y(ix), 	a
                             81 
   7CDD DD 21 DE 84   [14]   82 ld ix, 	#platform_datas	;;
   7CE1 3E 00         [ 7]   83 ld 	a, 	#0x00
   7CE3 06 B8         [ 7]   84 ld 	b, 	#0xB8
   7CE5 0E 16         [ 7]   85 ld 	c, 	#0x16
   7CE7 16 0C         [ 7]   86 ld 	d, 	#0x0C
   7CE9 CD F7 81      [17]   87 call cargar_plataforma
                             88 
   7CEC DD 21 E4 84   [14]   89 ld ix, 	#platform_data
   7CF0 3E 3E         [ 7]   90 ld 	a, 	#0x3E
   7CF2 06 B8         [ 7]   91 ld 	b, 	#0xB8
   7CF4 0E 12         [ 7]   92 ld 	c, 	#0x12
   7CF6 16 0C         [ 7]   93 ld 	d, 	#0x0C
   7CF8 CD F7 81      [17]   94 call cargar_plataforma
                             95 
   7CFB DD 21 EA 84   [14]   96 ld ix, 	#platform_data2
   7CFF 3E 20         [ 7]   97 ld 	a, 	#0x20
   7D01 06 98         [ 7]   98 ld 	b, 	#0x98
   7D03 0E 1E         [ 7]   99 ld 	c, 	#0x1E
   7D05 16 0C         [ 7]  100 ld 	d, 	#0x0C
   7D07 CD F7 81      [17]  101 call cargar_plataforma
                            102 
   7D0A DD 21 F0 84   [14]  103 ld ix, 	#platform_data3
   7D0E 3E 00         [ 7]  104 ld 	a, 	#0x00
   7D10 06 78         [ 7]  105 ld 	b, 	#0x78
   7D12 0E 16         [ 7]  106 ld 	c, 	#0x16
   7D14 16 0C         [ 7]  107 ld 	d, 	#0x0C
   7D16 CD F7 81      [17]  108 call cargar_plataforma
                            109 
   7D19 DD 21 F6 84   [14]  110 ld ix, 	#platform_data4
   7D1D 3E 20         [ 7]  111 ld 	a, 	#0x20
   7D1F 06 58         [ 7]  112 ld 	b, 	#0x58
   7D21 0E 16         [ 7]  113 ld 	c, 	#0x16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   7D23 16 0C         [ 7]  114 ld 	d, 	#0x0C
   7D25 CD F7 81      [17]  115 call cargar_plataforma
                            116 
   7D28 DD 21 FC 84   [14]  117 ld ix, 	#platform_data5
   7D2C 3E 3E         [ 7]  118 ld 	a, 	#0x3E
   7D2E 06 38         [ 7]  119 ld 	b, 	#0x38
   7D30 0E 12         [ 7]  120 ld 	c, 	#0x12
   7D32 16 0C         [ 7]  121 ld 	d, 	#0x0C
   7D34 CD F7 81      [17]  122 call cargar_plataforma
                            123 
   7D37 DD 21 02 85   [14]  124 ld ix, 	#platform_data6
   7D3B 3E 3E         [ 7]  125 ld 	a, 	#62
   7D3D 06 38         [ 7]  126 ld 	b, 	#56
   7D3F 0E 12         [ 7]  127 ld 	c, 	#18
   7D41 16 0C         [ 7]  128 ld 	d, 	#12
   7D43 CD F7 81      [17]  129 call cargar_plataforma
                            130 
                            131 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            132 ; OBJETOS
                            133 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            134 ; OBJETOS
   7D46 DD 21 C6 83   [14]  135 ld ix, 	#llave
   7D4A 3E 4A         [ 7]  136 ld 	a, 	#0x4A
   7D4C 06 A8         [ 7]  137 ld 	b, 	#0xA8
   7D4E 0E 01         [ 7]  138 ld 	c, 	#1
   7D50 CD 04 82      [17]  139 call cargar_objetos
                            140 
   7D53 DD 21 CE 83   [14]  141 ld ix, 	#puerta
   7D57 3E 48         [ 7]  142 ld 	a, 	#0x48
   7D59 06 28         [ 7]  143 ld 	b, 	#0x28
   7D5B 0E 00         [ 7]  144 ld 	c, 	#0
   7D5D CD 04 82      [17]  145 call cargar_objetos
                            146 
   7D60 C9            [10]  147 ret
                            148 
                            149 ;/////////////////////////////////////////////////////////////////
                            150 ; 					LEVEL 			1
                            151 ;/////////////////////////////////////////////////////////////////
   7D61                     152 load_level1:
   7D61 3E 05         [ 7]  153 ld 	a, 	#5
   7D63 32 BB 7C      [13]  154 ld 	(n_plat), 	a
                            155 
   7D66 3E 01         [ 7]  156 ld 	a, 	#1
   7D68 32 BC 7C      [13]  157 ld 	(n_enem), 	a
   7D6B 3E 01         [ 7]  158 ld 	a, 	#1
   7D6D 32 90 77      [13]  159 ld 	(init_enemy), 	a
                            160 
   7D70 DD 21 61 79   [14]  161 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   7D74 3E 01         [ 7]  162 ld 	a, 	#0x01
   7D76 32 BD 7C      [13]  163 ld 	(hero_x), 	a
   7D79 DD 77 00      [19]  164 ld 	e_x(ix), 	a
   7D7C 3E A8         [ 7]  165 ld 	a, 	#0xA8
   7D7E 32 BE 7C      [13]  166 ld 	(hero_y),	a
   7D81 DD 77 01      [19]  167 ld 	e_y(ix), 	a
                            168 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   7D84 DD 21 DE 84   [14]  169 ld ix, 	#platform_datas
   7D88 3E 00         [ 7]  170 ld 	a, 	#0x00
   7D8A 06 B8         [ 7]  171 ld 	b, 	#0xB8
   7D8C 0E 50         [ 7]  172 ld 	c, 	#0x50
   7D8E 16 0C         [ 7]  173 ld 	d, 	#0x0C
   7D90 CD F7 81      [17]  174 call cargar_plataforma
                            175 
   7D93 DD 21 E4 84   [14]  176 ld ix, 	#platform_data
   7D97 3E 32         [ 7]  177 ld 	a, 	#0x32
   7D99 06 98         [ 7]  178 ld 	b, 	#0x98
   7D9B 0E 1E         [ 7]  179 ld 	c, 	#0x1E
   7D9D 16 0C         [ 7]  180 ld 	d, 	#0x0C
   7D9F CD F7 81      [17]  181 call cargar_plataforma
                            182 
   7DA2 DD 21 EA 84   [14]  183 ld ix, 	#platform_data2
   7DA6 3E 1A         [ 7]  184 ld 	a, 	#0x1A
   7DA8 06 80         [ 7]  185 ld 	b, 	#0x80
   7DAA 0E 12         [ 7]  186 ld 	c, 	#0x12
   7DAC 16 0C         [ 7]  187 ld 	d, 	#0x0C
   7DAE CD F7 81      [17]  188 call cargar_plataforma
                            189 
   7DB1 DD 21 F0 84   [14]  190 ld ix, 	#platform_data3
   7DB5 3E 32         [ 7]  191 ld 	a, 	#0x32
   7DB7 06 64         [ 7]  192 ld 	b, 	#0x64
   7DB9 0E 0C         [ 7]  193 ld 	c, 	#0x0C
   7DBB 16 0C         [ 7]  194 ld 	d, 	#0x0C
   7DBD CD F7 81      [17]  195 call cargar_plataforma
                            196 
   7DC0 DD 21 F6 84   [14]  197 ld ix, 	#platform_data4
   7DC4 3E 00         [ 7]  198 ld 	a, 	#0x00
   7DC6 06 50         [ 7]  199 ld 	b, 	#0x50
   7DC8 0E 2A         [ 7]  200 ld 	c, 	#0x2A
   7DCA 16 0C         [ 7]  201 ld 	d, 	#0x0C
   7DCC CD F7 81      [17]  202 call cargar_plataforma
                            203 
                            204 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            205 ; OBJETOS
                            206 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            207 ; OBJETOS
   7DCF DD 21 C6 83   [14]  208 ld ix, 	#llave
   7DD3 3E 48         [ 7]  209 ld 	a, 	#0x48
   7DD5 06 2C         [ 7]  210 ld 	b, 	#0x2C
   7DD7 0E 01         [ 7]  211 ld 	c, 	#1
   7DD9 CD 04 82      [17]  212 call cargar_objetos
                            213 
   7DDC DD 21 CE 83   [14]  214 ld ix, 	#puerta
   7DE0 3E 00         [ 7]  215 ld 	a, 	#0x00
   7DE2 06 A8         [ 7]  216 ld 	b, 	#0xA8
   7DE4 0E 00         [ 7]  217 ld 	c, 	#0
   7DE6 CD 04 82      [17]  218 call cargar_objetos
                            219 
                            220 ;/////////////////// ENEMY
   7DE9 DD 21 4F 77   [14]  221 ld 	ix, 	#enemy_data0
   7DED 3E 3E         [ 7]  222 ld 	a, 	#0x3E
   7DEF 06 A8         [ 7]  223 ld  b, 	#0xA8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   7DF1 0E 03         [ 7]  224 ld 	c, 	#0x03
   7DF3 CD 0E 82      [17]  225 call 	cargar_enemigo
                            226 
   7DF6 C9            [10]  227 ret
                            228 
                            229 
                            230 
                            231 ;/////////////////////////////////////////////////////////////////
                            232 ; 					LEVEL 			2
                            233 ;/////////////////////////////////////////////////////////////////
   7DF7                     234 load_level2:
                            235 
   7DF7 3E 06         [ 7]  236 ld 	a, 	#6
   7DF9 32 BB 7C      [13]  237 ld 	(n_plat), 	a
   7DFC 3E 00         [ 7]  238 ld 	a, 	#0
   7DFE 32 BC 7C      [13]  239 ld 	(n_enem), 	a
                            240 
   7E01 DD 21 61 79   [14]  241 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   7E05 3E 01         [ 7]  242 ld 	a, 	#0x01
   7E07 32 BD 7C      [13]  243 ld 	(hero_x), 	a
   7E0A DD 77 00      [19]  244 ld 	e_x(ix), 	a
   7E0D 3E A8         [ 7]  245 ld 	a, 		#0xA8
   7E0F 32 BE 7C      [13]  246 ld 	(hero_y), 	a
   7E12 DD 77 01      [19]  247 ld 	e_y(ix), 	a
                            248 
   7E15 DD 21 DE 84   [14]  249 ld ix, 	#platform_datas
   7E19 3E 00         [ 7]  250 ld 	a, 	#0
   7E1B 06 B8         [ 7]  251 ld 	b, 	#184
   7E1D 0E 12         [ 7]  252 ld 	c, 	#18
   7E1F 16 0C         [ 7]  253 ld 	d, 	#12
   7E21 CD F7 81      [17]  254 call cargar_plataforma
                            255 
   7E24 DD 21 E4 84   [14]  256 ld ix, 	#platform_data
   7E28 3E 22         [ 7]  257 ld 	a, 	#34
   7E2A 06 B8         [ 7]  258 ld 	b, 	#184
   7E2C 0E 12         [ 7]  259 ld 	c, 	#18
   7E2E 16 0C         [ 7]  260 ld 	d, 	#12
   7E30 CD F7 81      [17]  261 call cargar_plataforma
                            262 
   7E33 DD 21 EA 84   [14]  263 ld ix, 	#platform_data2
   7E37 3E 44         [ 7]  264 ld 	a, 	#68
   7E39 06 B8         [ 7]  265 ld 	b, 	#184
   7E3B 0E 0C         [ 7]  266 ld 	c, 	#12
   7E3D 16 0C         [ 7]  267 ld 	d, 	#12
   7E3F CD F7 81      [17]  268 call cargar_plataforma
                            269 
   7E42 DD 21 F0 84   [14]  270 ld ix, 	#platform_data3
   7E46 3E 00         [ 7]  271 ld 	a, 	#0
   7E48 06 94         [ 7]  272 ld 	b, 	#148
   7E4A 0E 0C         [ 7]  273 ld 	c, 	#12
   7E4C 16 0C         [ 7]  274 ld 	d, 	#12
   7E4E CD F7 81      [17]  275 call cargar_plataforma
                            276 
   7E51 DD 21 F6 84   [14]  277 ld ix, 	#platform_data4
   7E55 3E 00         [ 7]  278 ld 	a, 	#0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   7E57 06 70         [ 7]  279 ld 	b, 	#112
   7E59 0E 06         [ 7]  280 ld 	c, 	#6
   7E5B 16 0C         [ 7]  281 ld 	d, 	#12
   7E5D CD F7 81      [17]  282 call cargar_plataforma
                            283 
   7E60 DD 21 FC 84   [14]  284 ld ix, 	#platform_data5
   7E64 3E 28         [ 7]  285 ld 	a, 	#40
   7E66 06 7C         [ 7]  286 ld 	b, 	#124
   7E68 0E 06         [ 7]  287 ld 	c, 	#6
   7E6A 16 48         [ 7]  288 ld 	d, 	#72
   7E6C CD F7 81      [17]  289 call cargar_plataforma
                            290 
                            291 
                            292 ; OBJETOS
   7E6F DD 21 C6 83   [14]  293 ld ix, 	#llave
   7E73 3E 00         [ 7]  294 ld 	a, 	#0
   7E75 06 60         [ 7]  295 ld 	b, 	#96
   7E77 0E 01         [ 7]  296 ld 	c, 	#1
   7E79 CD 04 82      [17]  297 call cargar_objetos
                            298 
   7E7C DD 21 CE 83   [14]  299 ld ix, 	#puerta
   7E80 3E 44         [ 7]  300 ld 	a, 	#68
   7E82 06 A8         [ 7]  301 ld 	b, 	#168
   7E84 0E 00         [ 7]  302 ld 	c, 	#0
   7E86 CD 04 82      [17]  303 call cargar_objetos
                            304 
   7E89 DD 21 D6 83   [14]  305 ld ix, 	#bala
   7E8D 3E 40         [ 7]  306 ld 	a, 	#0x40
   7E8F 06 6F         [ 7]  307 ld 	b, 	#0x6F
   7E91 0E 01         [ 7]  308 ld 	c, 	#1
   7E93 CD 04 82      [17]  309 call cargar_objetos
                            310 
   7E96 C9            [10]  311 ret
                            312 
                            313 
                            314 
                            315 ;/////////////////////////////////////////////////////////////////
                            316 ; 					LEVEL 			3   ;;reutlizando lvl 1
                            317 ;/////////////////////////////////////////////////////////////////
   7E97                     318 load_level3:
   7E97 3E 05         [ 7]  319 ld 	a, 	#5
   7E99 32 BB 7C      [13]  320 ld 	(n_plat), 	a
                            321 
   7E9C 3E 02         [ 7]  322 ld 	a, 	#2
   7E9E 32 BC 7C      [13]  323 ld 	(n_enem), 	a
   7EA1 3E 01         [ 7]  324 ld 	a, 	#1
   7EA3 32 90 77      [13]  325 ld 	(init_enemy), 	a
                            326 
   7EA6 DD 21 61 79   [14]  327 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   7EAA 3E 01         [ 7]  328 ld 	a, 	#0x01
   7EAC 32 BD 7C      [13]  329 ld 	(hero_x), 	a
   7EAF DD 77 00      [19]  330 ld 	e_x(ix), 	a
   7EB2 3E A8         [ 7]  331 ld 	a, 	#0xA8
   7EB4 32 BE 7C      [13]  332 ld 	(hero_y),	a
   7EB7 DD 77 01      [19]  333 ld 	e_y(ix), 	a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            334 
   7EBA DD 21 DE 84   [14]  335 ld ix, 	#platform_datas
   7EBE 3E 00         [ 7]  336 ld 	a, 	#0x00
   7EC0 06 B8         [ 7]  337 ld 	b, 	#0xB8
   7EC2 0E 50         [ 7]  338 ld 	c, 	#0x50
   7EC4 16 0C         [ 7]  339 ld 	d, 	#0x0C
   7EC6 CD F7 81      [17]  340 call cargar_plataforma
                            341 
   7EC9 DD 21 E4 84   [14]  342 ld ix, 	#platform_data
   7ECD 3E 32         [ 7]  343 ld 	a, 	#0x32
   7ECF 06 98         [ 7]  344 ld 	b, 	#0x98
   7ED1 0E 1E         [ 7]  345 ld 	c, 	#0x1E
   7ED3 16 0C         [ 7]  346 ld 	d, 	#0x0C
   7ED5 CD F7 81      [17]  347 call cargar_plataforma
                            348 
   7ED8 DD 21 EA 84   [14]  349 ld ix, 	#platform_data2
   7EDC 3E 1A         [ 7]  350 ld 	a, 	#0x1A
   7EDE 06 80         [ 7]  351 ld 	b, 	#0x80
   7EE0 0E 12         [ 7]  352 ld 	c, 	#0x12
   7EE2 16 0C         [ 7]  353 ld 	d, 	#0x0C
   7EE4 CD F7 81      [17]  354 call cargar_plataforma
                            355 
   7EE7 DD 21 F0 84   [14]  356 ld ix, 	#platform_data3
   7EEB 3E 32         [ 7]  357 ld 	a, 	#0x32
   7EED 06 64         [ 7]  358 ld 	b, 	#0x64
   7EEF 0E 0C         [ 7]  359 ld 	c, 	#0x0C
   7EF1 16 0C         [ 7]  360 ld 	d, 	#0x0C
   7EF3 CD F7 81      [17]  361 call cargar_plataforma
                            362 
   7EF6 DD 21 F6 84   [14]  363 ld ix, 	#platform_data4
   7EFA 3E 00         [ 7]  364 ld 	a, 	#0x00
   7EFC 06 50         [ 7]  365 ld 	b, 	#0x50
   7EFE 0E 2A         [ 7]  366 ld 	c, 	#0x2A
   7F00 16 0C         [ 7]  367 ld 	d, 	#0x0C
   7F02 CD F7 81      [17]  368 call cargar_plataforma
                            369 
                            370 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            371 ; OBJETOS
                            372 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            373 ; OBJETOS
   7F05 DD 21 C6 83   [14]  374 ld ix, 	#llave
   7F09 3E 02         [ 7]  375 ld 	a, 	#0x02
   7F0B 06 38         [ 7]  376 ld 	b, 	#0x38
   7F0D 0E 01         [ 7]  377 ld 	c, 	#1
   7F0F CD 04 82      [17]  378 call cargar_objetos
                            379 
   7F12 DD 21 CE 83   [14]  380 ld ix, 	#puerta
   7F16 3E 00         [ 7]  381 ld 	a, 	#0x00
   7F18 06 A8         [ 7]  382 ld 	b, 	#0xA8
   7F1A 0E 00         [ 7]  383 ld 	c, 	#0
   7F1C CD 04 82      [17]  384 call cargar_objetos
                            385 
                            386 ;/////////////////// ENEMY
   7F1F DD 21 4F 77   [14]  387 ld 	ix, 	#enemy_data0
   7F23 3E 3E         [ 7]  388 ld 	a, 	#0x3E
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   7F25 06 A8         [ 7]  389 ld  b, 	#0xA8
   7F27 0E 03         [ 7]  390 ld 	c, 	#0x03
   7F29 CD 0E 82      [17]  391 call 	cargar_enemigo
                            392 
   7F2C DD 21 5C 77   [14]  393 ld 	ix, 	#enemy_data1
   7F30 3E 10         [ 7]  394 ld 	a, 	#0x10
   7F32 06 40         [ 7]  395 ld  b, 	#0x40
   7F34 0E 03         [ 7]  396 ld 	c, 	#0x03
   7F36 CD 0E 82      [17]  397 call 	cargar_enemigo
                            398 
                            399 
   7F39 C9            [10]  400 ret
                            401 
                            402 
                            403 
                            404 
                            405 ;/////////////////////////////////////////////////////////////////
                            406 ; 					LEVEL 			8
                            407 ;/////////////////////////////////////////////////////////////////
                            408 
   7F3A                     409 load_level8:
                            410 
   7F3A 3E 0C         [ 7]  411 ld 	a, 	#12
   7F3C 32 BB 7C      [13]  412 ld 	(n_plat), 	a
   7F3F 3E 01         [ 7]  413 ld 	a, 	#1
   7F41 32 BC 7C      [13]  414 ld 	(n_enem), 	a
   7F44 3E 01         [ 7]  415 ld 	a, 	#1
   7F46 32 90 77      [13]  416 ld 	(init_enemy), 	a
                            417 
   7F49 DD 21 61 79   [14]  418 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   7F4D 3E 01         [ 7]  419 ld 	a, 	#0x01
   7F4F 32 BD 7C      [13]  420 ld 	(hero_x), 	a
   7F52 DD 77 00      [19]  421 ld 	e_x(ix), 	a
   7F55 3E A8         [ 7]  422 ld 	a, 	#0xA8
   7F57 32 BE 7C      [13]  423 ld 	(hero_y),	a
   7F5A DD 77 01      [19]  424 ld 	e_y(ix), 	a
                            425 
   7F5D DD 21 DE 84   [14]  426 ld ix, 	#platform_datas
   7F61 3E 00         [ 7]  427 ld 	a, 	#0
   7F63 06 B8         [ 7]  428 ld 	b, 	#184
   7F65 0E 0C         [ 7]  429 ld 	c, 	#12
   7F67 16 0C         [ 7]  430 ld 	d, 	#12
   7F69 CD F7 81      [17]  431 call cargar_plataforma
                            432 
   7F6C DD 21 E4 84   [14]  433 ld ix, 	#platform_data
   7F70 3E 0C         [ 7]  434 ld 	a, 	#12
   7F72 06 A4         [ 7]  435 ld 	b, 	#164
   7F74 0E 02         [ 7]  436 ld 	c, 	#2
   7F76 16 08         [ 7]  437 ld 	d, 	#8
   7F78 CD F7 81      [17]  438 call cargar_plataforma
                            439 
   7F7B DD 21 EA 84   [14]  440 ld ix, 	#platform_data2
   7F7F 3E 18         [ 7]  441 ld 	a, 	#24
   7F81 06 A4         [ 7]  442 ld 	b, 	#164
   7F83 0E 02         [ 7]  443 ld 	c, 	#2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   7F85 16 08         [ 7]  444 ld 	d, 	#8
   7F87 CD F7 81      [17]  445 call cargar_plataforma
                            446 
   7F8A DD 21 F0 84   [14]  447 ld ix, 	#platform_data3
   7F8E 3E 24         [ 7]  448 ld 	a, 	#36
   7F90 06 A4         [ 7]  449 ld 	b, 	#164
   7F92 0E 02         [ 7]  450 ld 	c, 	#2
   7F94 16 08         [ 7]  451 ld 	d, 	#8
   7F96 CD F7 81      [17]  452 call cargar_plataforma
                            453 
   7F99 DD 21 F6 84   [14]  454 ld ix, 	#platform_data4
   7F9D 3E 30         [ 7]  455 ld 	a, 	#48
   7F9F 06 A4         [ 7]  456 ld 	b, 	#164
   7FA1 0E 02         [ 7]  457 ld 	c, 	#2
   7FA3 16 08         [ 7]  458 ld 	d, 	#8
   7FA5 CD F7 81      [17]  459 call cargar_plataforma
                            460 
   7FA8 DD 21 FC 84   [14]  461 ld ix, 	#platform_data5
   7FAC 3E 3C         [ 7]  462 ld 	a, 	#60
   7FAE 06 A4         [ 7]  463 ld 	b, 	#164
   7FB0 0E 02         [ 7]  464 ld 	c, 	#2
   7FB2 16 08         [ 7]  465 ld 	d, 	#8
   7FB4 CD F7 81      [17]  466 call cargar_plataforma
                            467 
                            468 
   7FB7 DD 21 02 85   [14]  469 ld ix, 	#platform_data6
   7FBB 3E 44         [ 7]  470 ld 	a, 	#68
   7FBD 06 A0         [ 7]  471 ld 	b, 	#160
   7FBF 0E 0C         [ 7]  472 ld 	c, 	#12
   7FC1 16 0C         [ 7]  473 ld 	d, 	#12
   7FC3 CD F7 81      [17]  474 call cargar_plataforma
                            475 
                            476 
   7FC6 DD 21 08 85   [14]  477 ld ix, 	#platform_data7
   7FCA 3E 4A         [ 7]  478 ld 	a, 	#74
   7FCC 06 84         [ 7]  479 ld 	b, 	#132
   7FCE 0E 06         [ 7]  480 ld 	c, 	#6
   7FD0 16 08         [ 7]  481 ld 	d, 	#8
   7FD2 CD F7 81      [17]  482 call cargar_plataforma
                            483 
                            484 
   7FD5 DD 21 0E 85   [14]  485 ld ix, 	#platform_data8
   7FD9 3E 00         [ 7]  486 ld 	a, 	#0
   7FDB 06 78         [ 7]  487 ld 	b, 	#120
   7FDD 0E 42         [ 7]  488 ld 	c, 	#66
   7FDF 16 0C         [ 7]  489 ld 	d, 	#12
   7FE1 CD F7 81      [17]  490 call cargar_plataforma
                            491 
   7FE4 DD 21 14 85   [14]  492 ld ix, 	#platform_data9
   7FE8 3E 00         [ 7]  493 ld 	a, 	#0
   7FEA 06 58         [ 7]  494 ld 	b, 	#88
   7FEC 0E 06         [ 7]  495 ld 	c, 	#6
   7FEE 16 0C         [ 7]  496 ld 	d, 	#12
   7FF0 CD F7 81      [17]  497 call cargar_plataforma
                            498 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   7FF3 DD 21 1A 85   [14]  499 ld ix, 	#platform_data10
   7FF7 3E 06         [ 7]  500 ld 	a, 	#6
   7FF9 06 40         [ 7]  501 ld 	b, 	#64
   7FFB 0E 06         [ 7]  502 ld 	c, 	#6
   7FFD 16 0C         [ 7]  503 ld 	d, 	#12
   7FFF CD F7 81      [17]  504 call cargar_plataforma
                            505 
   8002 DD 21 20 85   [14]  506 ld ix, 	#platform_data11
   8006 3E 14         [ 7]  507 ld 	a, 	#20
   8008 06 34         [ 7]  508 ld 	b, 	#52
   800A 0E 3C         [ 7]  509 ld 	c, 	#60
   800C 16 08         [ 7]  510 ld 	d, 	#8
   800E CD F7 81      [17]  511 call cargar_plataforma
                            512 
                            513 
                            514 
                            515 ; OBJETOS
   8011 DD 21 C6 83   [14]  516 ld ix, 	#llave
   8015 3E 48         [ 7]  517 ld 	a, 	#72
   8017 06 24         [ 7]  518 ld 	b, 	#36
   8019 0E 01         [ 7]  519 ld 	c, 	#1
   801B CD 04 82      [17]  520 call cargar_objetos
                            521 
   801E DD 21 CE 83   [14]  522 ld ix, 	#puerta
   8022 3E 00         [ 7]  523 ld 	a, 	#0
   8024 06 A8         [ 7]  524 ld 	b, 	#168
   8026 0E 00         [ 7]  525 ld 	c, 	#0
   8028 CD 04 82      [17]  526 call cargar_objetos
                            527 
   802B DD 21 D6 83   [14]  528 ld ix, 	#bala
   802F 3E 40         [ 7]  529 ld 	a, 	#0x40
   8031 06 6C         [ 7]  530 ld 	b, 	#0x6C
   8033 0E 01         [ 7]  531 ld 	c, 	#1
   8035 CD 04 82      [17]  532 call cargar_objetos
                            533 
                            534 
                            535 ;/////////////////// ENEMY
   8038 DD 21 4F 77   [14]  536 ld 	ix, 	#enemy_data0
   803C 3E 00         [ 7]  537 ld 	a, 	#0
   803E 06 68         [ 7]  538 ld  b, 	#104
   8040 0E 03         [ 7]  539 ld 	c, 	#0x03
   8042 CD 0E 82      [17]  540 call 	cargar_enemigo
                            541 
   8045 DD 21 5C 77   [14]  542 ld 	ix, 	#enemy_data1
   8049 3E 02         [ 7]  543 ld 	a, 	#0x02
   804B 06 2C         [ 7]  544 ld  b, 	#0x2C
   804D 0E 03         [ 7]  545 ld 	c, 	#0x03
   804F CD 0E 82      [17]  546 call 	cargar_enemigo
                            547 
   8052 DD 21 69 77   [14]  548 ld 	ix, 	#enemy_data2
   8056 3E 12         [ 7]  549 ld 	a, 	#0x12
   8058 06 46         [ 7]  550 ld  b, 	#0x46
   805A 0E 03         [ 7]  551 ld 	c, 	#0x03
   805C CD 0E 82      [17]  552 call 	cargar_enemigo
                            553 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   805F DD 21 76 77   [14]  554 ld 	ix, 	#enemy_data3
   8063 3E 26         [ 7]  555 ld 	a, 	#0x26
   8065 06 56         [ 7]  556 ld  b, 	#0x56
   8067 0E 03         [ 7]  557 ld 	c, 	#0x03
   8069 CD 0E 82      [17]  558 call 	cargar_enemigo
                            559 
   806C C9            [10]  560 ret
                            561 
                            562 ;/////////////////////////////////////////////////////////////////
                            563 ; 					LEVEL 			9
                            564 ;/////////////////////////////////////////////////////////////////
   806D                     565 load_level9:
   806D 3E 09         [ 7]  566 ld 	a, 	#9
   806F 32 BB 7C      [13]  567 ld 	(n_plat), 	a
   8072 3E 00         [ 7]  568 ld 	a, 	#0
   8074 32 BC 7C      [13]  569 ld 	(n_enem), 	a
                            570 
   8077 DD 21 61 79   [14]  571 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   807B 3E 01         [ 7]  572 ld 	a, 	#0x01
   807D 32 BD 7C      [13]  573 ld 	(hero_x), 	a
   8080 DD 77 00      [19]  574 ld 	e_x(ix), 	a
   8083 3E 34         [ 7]  575 ld 	a, 	#0x34
   8085 32 BE 7C      [13]  576 ld 	(hero_y), 	a
   8088 DD 77 01      [19]  577 ld 	e_y(ix), 	a
                            578 
                            579 ;;las de 2
   808B DD 21 DE 84   [14]  580 ld ix, 	#platform_datas	;;
   808F 3E 00         [ 7]  581 ld 	a, 	#0
   8091 06 50         [ 7]  582 ld 	b, 	#80
   8093 0E 0C         [ 7]  583 ld 	c, 	#12
   8095 16 0C         [ 7]  584 ld 	d, 	#0x0C
   8097 CD F7 81      [17]  585 call cargar_plataforma
                            586 
   809A DD 21 E4 84   [14]  587 ld ix, 	#platform_data	;;
   809E 3E 44         [ 7]  588 ld 	a, 	#68
   80A0 06 6C         [ 7]  589 ld 	b, 	#108
   80A2 0E 0C         [ 7]  590 ld 	c, 	#12
   80A4 16 0C         [ 7]  591 ld 	d, 	#0x0C
   80A6 CD F7 81      [17]  592 call cargar_plataforma
                            593 
                            594 
   80A9 DD 21 EA 84   [14]  595 ld ix, 	#platform_data2	;;
   80AD 3E 1A         [ 7]  596 ld 	a, 	#26
   80AF 06 40         [ 7]  597 ld 	b, 	#64
   80B1 0E 06         [ 7]  598 ld 	c, 	#6
   80B3 16 0C         [ 7]  599 ld 	d, 	#0x0C
   80B5 CD F7 81      [17]  600 call cargar_plataforma
                            601 
   80B8 DD 21 F0 84   [14]  602 ld ix, 	#platform_data3
   80BC 3E 00         [ 7]  603 ld 	a, 	#0
   80BE 06 A0         [ 7]  604 ld 	b, 	#160
   80C0 0E 06         [ 7]  605 ld 	c, 	#6
   80C2 16 0C         [ 7]  606 ld 	d, 	#0x0C
   80C4 CD F7 81      [17]  607 call cargar_plataforma
                            608 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   80C7 DD 21 F6 84   [14]  609 ld ix, 	#platform_data4
   80CB 3E 14         [ 7]  610 ld 	a, 	#20
   80CD 06 84         [ 7]  611 ld 	b, 	#132
   80CF 0E 06         [ 7]  612 ld 	c, 	#6
   80D1 16 0C         [ 7]  613 ld 	d, 	#0x0C
   80D3 CD F7 81      [17]  614 call cargar_plataforma
                            615 
   80D6 DD 21 FC 84   [14]  616 ld ix, 	#platform_data5
   80DA 3E 14         [ 7]  617 ld 	a, 	#20
   80DC 06 B8         [ 7]  618 ld 	b, 	#184
   80DE 0E 06         [ 7]  619 ld 	c, 	#6
   80E0 16 0C         [ 7]  620 ld 	d, 	#0x0C
   80E2 CD F7 81      [17]  621 call cargar_plataforma
                            622 
   80E5 DD 21 02 85   [14]  623 ld ix, 	#platform_data6
   80E9 3E 2E         [ 7]  624 ld 	a, 	#46
   80EB 06 78         [ 7]  625 ld 	b, 	#120
   80ED 0E 06         [ 7]  626 ld 	c, 	#6
   80EF 16 0C         [ 7]  627 ld 	d, 	#0x0C
   80F1 CD F7 81      [17]  628 call cargar_plataforma
                            629 
   80F4 DD 21 08 85   [14]  630 ld ix, 	#platform_data7
   80F8 3E 2E         [ 7]  631 ld 	a, 	#46
   80FA 06 B8         [ 7]  632 ld 	b, 	#184
   80FC 0E 06         [ 7]  633 ld 	c, 	#6
   80FE 16 0C         [ 7]  634 ld 	d, 	#0x0C
   8100 CD F7 81      [17]  635 call cargar_plataforma
                            636 
   8103 DD 21 0E 85   [14]  637 ld ix, 	#platform_data8
   8107 3E 4A         [ 7]  638 ld 	a, 	#74
   8109 06 B8         [ 7]  639 ld 	b, 	#184
   810B 0E 06         [ 7]  640 ld 	c, 	#6
   810D 16 0C         [ 7]  641 ld 	d, 	#0x0C
   810F CD F7 81      [17]  642 call cargar_plataforma
                            643 
                            644 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            645 ; OBJETOS
                            646 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            647 ; OBJETOS
   8112 DD 21 C6 83   [14]  648 ld ix, 	#llave
   8116 3E 4A         [ 7]  649 ld 	a, 	#0x4A
   8118 06 A8         [ 7]  650 ld 	b, 	#0xA8
   811A 0E 01         [ 7]  651 ld 	c, 	#1
   811C CD 04 82      [17]  652 call cargar_objetos
                            653 
   811F DD 21 CE 83   [14]  654 ld ix, 	#puerta
   8123 3E 46         [ 7]  655 ld 	a, 	#70
   8125 06 5C         [ 7]  656 ld 	b, 	#92
   8127 0E 00         [ 7]  657 ld 	c, 	#0
   8129 CD 04 82      [17]  658 call cargar_objetos
                            659 
   812C DD 21 D6 83   [14]  660 ld ix, 	#bala
   8130 3E 1A         [ 7]  661 ld 	a, 	#26
   8132 06 30         [ 7]  662 ld 	b, 	#48
   8134 0E 01         [ 7]  663 ld 	c, 	#1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   8136 CD 04 82      [17]  664 call cargar_objetos
                            665 
   8139 C9            [10]  666 ret
                            667 
                            668 
                            669 ;/////////////////////////////////////////////////////////////////
                            670 ; 					LEVEL 			10
                            671 ;/////////////////////////////////////////////////////////////////
                            672 
   813A                     673 load_level10:
   813A 3E 05         [ 7]  674 ld 	a, 	#5
   813C 32 BB 7C      [13]  675 ld 	(n_plat), 	a
                            676 
   813F 3E 04         [ 7]  677 ld 	a, 	#4
   8141 32 BC 7C      [13]  678 ld 	(n_enem), 	a
   8144 3E 01         [ 7]  679 ld 	a, 	#1
   8146 32 90 77      [13]  680 ld 	(init_enemy), 	a
                            681 
   8149 DD 21 61 79   [14]  682 ld 	ix, #hero_data   	;; INICIALIZA HEROE
   814D 3E 01         [ 7]  683 ld 	a, 	#0x01
   814F 32 BD 7C      [13]  684 ld 	(hero_x), 	a
   8152 DD 77 00      [19]  685 ld 	e_x(ix), 	a
   8155 3E A8         [ 7]  686 ld 	a, 	#0xA8
   8157 32 BE 7C      [13]  687 ld 	(hero_y), 	a
   815A DD 77 01      [19]  688 ld 	e_y(ix), 	a
                            689 
   815D DD 21 DE 84   [14]  690 ld ix, 	#platform_datas	;;
   8161 3E 00         [ 7]  691 ld 	a, 	#0x00
   8163 06 B8         [ 7]  692 ld 	b, 	#0xB8
   8165 0E 4C         [ 7]  693 ld 	c, 	#0x4C
   8167 16 0C         [ 7]  694 ld 	d, 	#0x0C
   8169 CD F7 81      [17]  695 call cargar_plataforma
                            696 
   816C DD 21 E4 84   [14]  697 ld ix, 	#platform_data
   8170 3E 00         [ 7]  698 ld 	a, 	#0x00
   8172 06 98         [ 7]  699 ld 	b, 	#0x98
   8174 0E 40         [ 7]  700 ld 	c, 	#0x40
   8176 16 0C         [ 7]  701 ld 	d, 	#0x0C
   8178 CD F7 81      [17]  702 call cargar_plataforma
                            703 
   817B DD 21 EA 84   [14]  704 ld ix, 	#platform_data2
   817F 3E 10         [ 7]  705 ld 	a, 	#0x10
   8181 06 78         [ 7]  706 ld 	b, 	#0x78
   8183 0E 4E         [ 7]  707 ld 	c, 	#0x4E
   8185 16 0C         [ 7]  708 ld 	d, 	#0x0C
   8187 CD F7 81      [17]  709 call cargar_plataforma
                            710 
   818A DD 21 F0 84   [14]  711 ld ix, 	#platform_data3
   818E 3E 00         [ 7]  712 ld 	a, 	#0x00
   8190 06 58         [ 7]  713 ld 	b, 	#0x58
   8192 0E 40         [ 7]  714 ld 	c, 	#0x40
   8194 16 0C         [ 7]  715 ld 	d, 	#0x0C
   8196 CD F7 81      [17]  716 call cargar_plataforma
                            717 
   8199 DD 21 F6 84   [14]  718 ld ix, 	#platform_data4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   819D 3E 20         [ 7]  719 ld 	a, 	#0x20
   819F 06 38         [ 7]  720 ld 	b, 	#0x38
   81A1 0E 4E         [ 7]  721 ld 	c, 	#0x4E
   81A3 16 0C         [ 7]  722 ld 	d, 	#0x0C
   81A5 CD F7 81      [17]  723 call cargar_plataforma
                            724 
                            725 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            726 ; OBJETOS
                            727 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   81A8 DD 21 C6 83   [14]  728 ld ix, 	#llave
   81AC 3E 4A         [ 7]  729 ld 	a, 	#0x4A
   81AE 06 50         [ 7]  730 ld 	b, 	#80
   81B0 0E 01         [ 7]  731 ld 	c, 	#1
   81B2 CD 04 82      [17]  732 call cargar_objetos
                            733 
   81B5 DD 21 CE 83   [14]  734 ld ix, 	#puerta
   81B9 3E 48         [ 7]  735 ld 	a, 	#0x48
   81BB 06 28         [ 7]  736 ld 	b, 	#0x28
   81BD 0E 00         [ 7]  737 ld 	c, 	#0
   81BF CD 04 82      [17]  738 call cargar_objetos
                            739 
                            740 
                            741 ;/////////////////// ENEMY
   81C2 DD 21 4F 77   [14]  742 ld 	ix, 	#enemy_data0
   81C6 3E 30         [ 7]  743 ld 	a, 	#0x30
   81C8 06 A8         [ 7]  744 ld  b, 	#168
   81CA 0E 03         [ 7]  745 ld 	c, 	#0x03
   81CC CD 0E 82      [17]  746 call 	cargar_enemigo
                            747 
   81CF DD 21 5C 77   [14]  748 ld 	ix, 	#enemy_data1
   81D3 3E 12         [ 7]  749 ld 	a, 	#0x12
   81D5 06 88         [ 7]  750 ld  b, 	#136
   81D7 0E 03         [ 7]  751 ld 	c, 	#0x03
   81D9 CD 0E 82      [17]  752 call 	cargar_enemigo
                            753 
   81DC DD 21 69 77   [14]  754 ld 	ix, 	#enemy_data2
   81E0 3E 30         [ 7]  755 ld 	a, 	#0x30
   81E2 06 68         [ 7]  756 ld  b, 	#104
   81E4 0E 03         [ 7]  757 ld 	c, 	#0x03
   81E6 CD 0E 82      [17]  758 call 	cargar_enemigo
                            759 
   81E9 DD 21 76 77   [14]  760 ld 	ix, 	#enemy_data3
   81ED 3E 12         [ 7]  761 ld 	a, 	#0x12
   81EF 06 48         [ 7]  762 ld  b, 	#72
   81F1 0E 03         [ 7]  763 ld 	c, 	#0x03
   81F3 CD 0E 82      [17]  764 call 	cargar_enemigo
                            765 
                            766 
   81F6 C9            [10]  767 ret
                            768 
   81F7                     769 cargar_plataforma:
                            770 
   81F7 DD 77 00      [19]  771 ld 	p_x(ix), 	a
   81FA DD 70 01      [19]  772 ld 	p_y(ix), 	b
   81FD DD 71 04      [19]  773 ld 	p_w(ix), 	c
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



   8200 DD 72 05      [19]  774 ld 	p_h(ix), 	d
                            775 
   8203 C9            [10]  776 ret
                            777 
   8204                     778 cargar_objetos:
                            779 
   8204 DD 77 00      [19]  780 ld 	obj_x(ix), 	a
   8207 DD 70 01      [19]  781 ld 	obj_y(ix), 	b
   820A DD 71 07      [19]  782 ld 	obj_open(ix), 	c
   820D C9            [10]  783 ret
                            784 
   820E                     785 cargar_enemigo:
   820E DD 77 00      [19]  786 ld 	en_x(ix),		a 	
   8211 DD 70 01      [19]  787 ld 	en_y(ix),		b
   8214 DD 71 08      [19]  788 ld 	en_life(ix),	c
   8217 C9            [10]  789 ret
