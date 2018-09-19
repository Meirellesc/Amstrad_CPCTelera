                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _inicializar
                             13 	.globl _ejecutarEstado
                             14 	.globl _andando
                             15 	.globl _andando_animar
                             16 	.globl _prepSalto
                             17 	.globl _prepSalto_animar
                             18 	.globl _saltando
                             19 	.globl _saltando_entrar
                             20 	.globl _ascender
                             21 	.globl _quieto
                             22 	.globl _cayendo
                             23 	.globl _descender
                             24 	.globl _cayendo_entrar
                             25 	.globl _aterrizando
                             26 	.globl _aterrizando_entrar
                             27 	.globl _compruebaTeclas
                             28 	.globl _redibujarProta
                             29 	.globl _moverIzquierda
                             30 	.globl _moverDerecha
                             31 	.globl _retrocederMapa
                             32 	.globl _avanzarMapa
                             33 	.globl _sobreSuelo
                             34 	.globl _ajustarAlSuelo
                             35 	.globl _obtenerTilePtr
                             36 	.globl _borrarProta
                             37 	.globl _dibujarProta
                             38 	.globl _seleccionarSpriteProta
                             39 	.globl _girarFrame
                             40 	.globl _asignarFrame
                             41 	.globl _dibujarMapa
                             42 	.globl _interrupcion
                             43 	.globl _playmusic
                             44 	.globl _cpct_etm_setTileset2x4
                             45 	.globl _cpct_etm_drawTileBox2x4
                             46 	.globl _cpct_akp_musicInit
                             47 	.globl _cpct_getScreenPtr
                             48 	.globl _cpct_setPALColour
                             49 	.globl _cpct_setPalette
                             50 	.globl _cpct_waitVSYNC
                             51 	.globl _cpct_setVideoMode
                             52 	.globl _cpct_hflipSpriteM0
                             53 	.globl _cpct_drawSpriteMaskedAlignedTable
                             54 	.globl _cpct_drawSprite
                             55 	.globl _cpct_get2Bits
                             56 	.globl _cpct_isAnyKeyPressed
                             57 	.globl _cpct_isKeyPressed
                             58 	.globl _cpct_scanKeyboard_if
                             59 	.globl _cpct_setInterruptHandler
                             60 	.globl _cpct_disableFirmware
                             61 	.globl _prota
                             62 	.globl _num_mapa
                             63 	.globl _mapa
                             64 	.globl _EEstados
                             65 	.globl _EEventos
                             66 	.globl _EMirar
                             67 	.globl _g_tablaSalto
                             68 	.globl _anim_caer
                             69 	.globl _anim_saltar
                             70 	.globl _anim_andar
                             71 	.globl _g_frames
                             72 	.globl _mapas
                             73 	.globl _G_song
                             74 	.globl _quieto_entrar
                             75 	.globl _prepSalto_entrar
                             76 	.globl _andando_entrar
                             77 ;--------------------------------------------------------
                             78 ; special function registers
                             79 ;--------------------------------------------------------
                             80 ;--------------------------------------------------------
                             81 ; ram data
                             82 ;--------------------------------------------------------
                             83 	.area _DATA
   4DD5                      84 _EMirar::
   4DD5                      85 	.ds 1
   4DD6                      86 _EEventos::
   4DD6                      87 	.ds 1
   4DD7                      88 _EEstados::
   4DD7                      89 	.ds 1
   4DD8                      90 _mapa::
   4DD8                      91 	.ds 2
   4DDA                      92 _num_mapa::
   4DDA                      93 	.ds 1
   4DDB                      94 _prota::
   4DDB                      95 	.ds 11
   4DE6                      96 _interrupcion_kk_1_78:
   4DE6                      97 	.ds 1
                             98 ;--------------------------------------------------------
                             99 ; ram data
                            100 ;--------------------------------------------------------
                            101 	.area _INITIALIZED
                            102 ;--------------------------------------------------------
                            103 ; absolute external ram data
                            104 ;--------------------------------------------------------
                            105 	.area _DABS (ABS)
                            106 ;--------------------------------------------------------
                            107 ; global & static initialisations
                            108 ;--------------------------------------------------------
                            109 	.area _HOME
                            110 	.area _GSINIT
                            111 	.area _GSFINAL
                            112 	.area _GSINIT
                            113 ;--------------------------------------------------------
                            114 ; Home
                            115 ;--------------------------------------------------------
                            116 	.area _HOME
                            117 	.area _HOME
                            118 ;--------------------------------------------------------
                            119 ; code
                            120 ;--------------------------------------------------------
                            121 	.area _CODE
                            122 ;src/main.c:125: cpctm_createTransparentMaskTable(g_tablatrans, 0x100, M0, 0);
                            123 ;	---------------------------------
                            124 ; Function dummy_cpct_transparentMaskTable0M0_container
                            125 ; ---------------------------------
   4270                     126 _dummy_cpct_transparentMaskTable0M0_container::
                            127 	.area _g_tablatrans_ (ABS) 
   0100                     128 	.org 0x100 
   0100                     129 	 _g_tablatrans::
   0100 FF AA 55 00 AA AA   130 	.db 0xFF, 0xAA, 0x55, 0x00, 0xAA, 0xAA, 0x00, 0x00 
        00 00
   0108 55 00 55 00 00 00   131 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0110 AA AA 00 00 AA AA   132 	.db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00 
        00 00
   0118 00 00 00 00 00 00   133 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0120 55 00 55 00 00 00   134 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0128 55 00 55 00 00 00   135 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0130 00 00 00 00 00 00   136 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0138 00 00 00 00 00 00   137 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0140 AA AA 00 00 AA AA   138 	.db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00 
        00 00
   0148 00 00 00 00 00 00   139 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0150 AA AA 00 00 AA AA   140 	.db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00 
        00 00
   0158 00 00 00 00 00 00   141 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0160 00 00 00 00 00 00   142 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0168 00 00 00 00 00 00   143 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0170 00 00 00 00 00 00   144 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0178 00 00 00 00 00 00   145 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0180 55 00 55 00 00 00   146 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0188 55 00 55 00 00 00   147 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0190 00 00 00 00 00 00   148 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   0198 00 00 00 00 00 00   149 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01A0 55 00 55 00 00 00   150 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01A8 55 00 55 00 00 00   151 	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01B0 00 00 00 00 00 00   152 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01B8 00 00 00 00 00 00   153 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01C0 00 00 00 00 00 00   154 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01C8 00 00 00 00 00 00   155 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01D0 00 00 00 00 00 00   156 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01D8 00 00 00 00 00 00   157 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01E0 00 00 00 00 00 00   158 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01E8 00 00 00 00 00 00   159 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01F0 00 00 00 00 00 00   160 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
   01F8 00 00 00 00 00 00   161 	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
        00 00
                            162 	.area _CSEG (REL, CON) 
                            163 ;src/main.c:131: void playmusic() {
                            164 ;	---------------------------------
                            165 ; Function playmusic
                            166 ; ---------------------------------
   4DE7                     167 _playmusic::
                            168 ;src/main.c:146: __endasm;
   4DE7 D9            [ 4]  169 	exx
   4DE8 08                  170 	.db	#0x08
   4DE9 F5            [11]  171 	push	af
   4DEA C5            [11]  172 	push	bc
   4DEB D5            [11]  173 	push	de
   4DEC E5            [11]  174 	push	hl
   4DED CD F9 44      [17]  175 	call	_cpct_akp_musicPlay
   4DF0 E1            [10]  176 	pop	hl
   4DF1 D1            [10]  177 	pop	de
   4DF2 C1            [10]  178 	pop	bc
   4DF3 F1            [10]  179 	pop	af
   4DF4 08                  180 	.db	#0x08
   4DF5 D9            [ 4]  181 	exx
   4DF6 C9            [10]  182 	ret
                     0200   183 _G_song	=	0x0200
   4DF7                     184 _mapas:
   4DF7 50 1A               185 	.dw _g_map1
   4DF9 28 15               186 	.dw _g_map2
   4DFB 00 10               187 	.dw _g_map3
   4DFD                     188 _g_frames:
   4DFD 00                  189 	.db #0x00	; 0
   4DFE 18 34               190 	.dw _g_hero_00
   4E00 00                  191 	.db #0x00	; 0
   4E01 F0 34               192 	.dw _g_hero_01
   4E03 00                  193 	.db #0x00	; 0
   4E04 C8 35               194 	.dw _g_hero_02
   4E06 00                  195 	.db #0x00	; 0
   4E07 A0 36               196 	.dw _g_hero_03
   4E09 00                  197 	.db #0x00	; 0
   4E0A 78 37               198 	.dw _g_hero_04
   4E0C 00                  199 	.db #0x00	; 0
   4E0D 50 38               200 	.dw _g_hero_05
   4E0F 00                  201 	.db #0x00	; 0
   4E10 28 39               202 	.dw _g_hero_06
   4E12 00                  203 	.db #0x00	; 0
   4E13 00 3A               204 	.dw _g_hero_07
   4E15 00                  205 	.db #0x00	; 0
   4E16 D8 3A               206 	.dw _g_hero_08
   4E18 00                  207 	.db #0x00	; 0
   4E19 B0 3B               208 	.dw _g_hero_09
   4E1B 00                  209 	.db #0x00	; 0
   4E1C 88 3C               210 	.dw _g_hero_10
   4E1E 00                  211 	.db #0x00	; 0
   4E1F 60 3D               212 	.dw _g_hero_11
   4E21 00                  213 	.db #0x00	; 0
   4E22 38 3E               214 	.dw _g_hero_12
   4E24 00                  215 	.db #0x00	; 0
   4E25 10 3F               216 	.dw _g_hero_13
   4E27 00                  217 	.db #0x00	; 0
   4E28 E8 3F               218 	.dw _g_hero_14
   4E2A 00                  219 	.db #0x00	; 0
   4E2B C0 40               220 	.dw _g_hero_15
   4E2D                     221 _anim_andar:
   4E2D 00 4E               222 	.dw (_g_frames + 3)
   4E2F 03 4E               223 	.dw (_g_frames + 6)
   4E31 06 4E               224 	.dw (_g_frames + 9)
   4E33 09 4E               225 	.dw (_g_frames + 12)
   4E35 0C 4E               226 	.dw (_g_frames + 15)
   4E37                     227 _anim_saltar:
   4E37 15 4E               228 	.dw (_g_frames + 24)
   4E39 18 4E               229 	.dw (_g_frames + 27)
   4E3B 1B 4E               230 	.dw (_g_frames + 30)
   4E3D 1E 4E               231 	.dw (_g_frames + 33)
   4E3F                     232 _anim_caer:
   4E3F 27 4E               233 	.dw (_g_frames + 42)
   4E41 2A 4E               234 	.dw (_g_frames + 45)
   4E43                     235 _g_tablaSalto:
   4E43 FF                  236 	.db #0xFF	; 255
   4E44 FA                  237 	.db #0xFA	; 250
   4E45 A9                  238 	.db #0xA9	; 169
   4E46 55                  239 	.db #0x55	; 85	'U'
   4E47 40                  240 	.db #0x40	; 64
   4E48 00                  241 	.db 0x00
                            242 ;src/main.c:149: void interrupcion() {
                            243 ;	---------------------------------
                            244 ; Function interrupcion
                            245 ; ---------------------------------
   4E49                     246 _interrupcion::
                            247 ;src/main.c:152: if (++kk == 5) {
   4E49 21 E6 4D      [10]  248 	ld	hl, #_interrupcion_kk_1_78+0
   4E4C 34            [11]  249 	inc	(hl)
   4E4D 3A E6 4D      [13]  250 	ld	a,(#_interrupcion_kk_1_78 + 0)
   4E50 D6 05         [ 7]  251 	sub	a, #0x05
   4E52 C0            [11]  252 	ret	NZ
                            253 ;src/main.c:153: playmusic();
   4E53 CD E7 4D      [17]  254 	call	_playmusic
                            255 ;src/main.c:154: cpct_scanKeyboard_if();
   4E56 CD 35 44      [17]  256 	call	_cpct_scanKeyboard_if
                            257 ;src/main.c:155: kk = 0;
   4E59 21 E6 4D      [10]  258 	ld	hl,#_interrupcion_kk_1_78 + 0
   4E5C 36 00         [10]  259 	ld	(hl), #0x00
   4E5E C9            [10]  260 	ret
                            261 ;src/main.c:159: void dibujarMapa() {
                            262 ;	---------------------------------
                            263 ; Function dibujarMapa
                            264 ; ---------------------------------
   4E5F                     265 _dibujarMapa::
                            266 ;src/main.c:160: cpct_etm_drawTilemap2x4(g_map1_W, g_map1_H, ORIGEN_MAPA, mapa);
   4E5F 2A D8 4D      [16]  267 	ld	hl,(_mapa)
   4E62 E5            [11]  268 	push	hl
   4E63 21 80 E2      [10]  269 	ld	hl,#0xE280
   4E66 E5            [11]  270 	push	hl
   4E67 21 21 28      [10]  271 	ld	hl,#0x2821
   4E6A E5            [11]  272 	push	hl
   4E6B 2E 00         [ 7]  273 	ld	l, #0x00
   4E6D E5            [11]  274 	push	hl
   4E6E AF            [ 4]  275 	xor	a, a
   4E6F F5            [11]  276 	push	af
   4E70 33            [ 6]  277 	inc	sp
   4E71 CD 44 43      [17]  278 	call	_cpct_etm_drawTileBox2x4
   4E74 C9            [10]  279 	ret
                            280 ;src/main.c:163: void asignarFrame(TFrame **animacion) {
                            281 ;	---------------------------------
                            282 ; Function asignarFrame
                            283 ; ---------------------------------
   4E75                     284 _asignarFrame::
   4E75 DD E5         [15]  285 	push	ix
   4E77 DD 21 00 00   [14]  286 	ld	ix,#0
   4E7B DD 39         [15]  287 	add	ix,sp
                            288 ;src/main.c:164: prota.frame = animacion[prota.nframe / ANIM_PAUSA];
   4E7D 21 E3 4D      [10]  289 	ld	hl, #_prota + 8
   4E80 6E            [ 7]  290 	ld	l,(hl)
   4E81 CB 3D         [ 8]  291 	srl	l
   4E83 CB 3D         [ 8]  292 	srl	l
   4E85 26 00         [ 7]  293 	ld	h,#0x00
   4E87 29            [11]  294 	add	hl, hl
   4E88 4D            [ 4]  295 	ld	c, l
   4E89 44            [ 4]  296 	ld	b, h
   4E8A DD 6E 04      [19]  297 	ld	l,4 (ix)
   4E8D DD 66 05      [19]  298 	ld	h,5 (ix)
   4E90 09            [11]  299 	add	hl,bc
   4E91 4E            [ 7]  300 	ld	c,(hl)
   4E92 23            [ 6]  301 	inc	hl
   4E93 46            [ 7]  302 	ld	b,(hl)
   4E94 ED 43 E1 4D   [20]  303 	ld	((_prota + 0x0006)), bc
   4E98 DD E1         [14]  304 	pop	ix
   4E9A C9            [10]  305 	ret
                            306 ;src/main.c:167: void girarFrame() {
                            307 ;	---------------------------------
                            308 ; Function girarFrame
                            309 ; ---------------------------------
   4E9B                     310 _girarFrame::
                            311 ;src/main.c:168: TFrame* f = prota.frame;
   4E9B ED 4B E1 4D   [20]  312 	ld	bc, (#_prota + 6)
                            313 ;src/main.c:169: if (f->mira != prota.mira) {
   4E9F 0A            [ 7]  314 	ld	a,(bc)
   4EA0 5F            [ 4]  315 	ld	e,a
   4EA1 21 E4 4D      [10]  316 	ld	hl, #(_prota + 0x0009) + 0
   4EA4 56            [ 7]  317 	ld	d,(hl)
   4EA5 7B            [ 4]  318 	ld	a,e
   4EA6 92            [ 4]  319 	sub	a, d
   4EA7 C8            [11]  320 	ret	Z
                            321 ;src/main.c:170: cpct_hflipSpriteM0(G_HERO_00_W, G_HERO_00_H, f->sprite);
   4EA8 69            [ 4]  322 	ld	l, c
   4EA9 60            [ 4]  323 	ld	h, b
   4EAA 23            [ 6]  324 	inc	hl
   4EAB 5E            [ 7]  325 	ld	e,(hl)
   4EAC 23            [ 6]  326 	inc	hl
   4EAD 56            [ 7]  327 	ld	d,(hl)
   4EAE C5            [11]  328 	push	bc
   4EAF D5            [11]  329 	push	de
   4EB0 21 08 1B      [10]  330 	ld	hl,#0x1B08
   4EB3 E5            [11]  331 	push	hl
   4EB4 CD 9D 44      [17]  332 	call	_cpct_hflipSpriteM0
   4EB7 C1            [10]  333 	pop	bc
                            334 ;src/main.c:171: f->mira = prota.mira;
   4EB8 3A E4 4D      [13]  335 	ld	a, (#(_prota + 0x0009) + 0)
   4EBB 02            [ 7]  336 	ld	(bc),a
   4EBC C9            [10]  337 	ret
                            338 ;src/main.c:175: void seleccionarSpriteProta() {
                            339 ;	---------------------------------
                            340 ; Function seleccionarSpriteProta
                            341 ; ---------------------------------
   4EBD                     342 _seleccionarSpriteProta::
                            343 ;src/main.c:176: switch(prota.estado) {
   4EBD 21 E0 4D      [10]  344 	ld	hl, #_prota + 5
   4EC0 5E            [ 7]  345 	ld	e,(hl)
   4EC1 3E 05         [ 7]  346 	ld	a,#0x05
   4EC3 93            [ 4]  347 	sub	a, e
   4EC4 DA 9B 4E      [10]  348 	jp	C,_girarFrame
                            349 ;src/main.c:177: case ST_quieto:      { prota.frame = &g_frames[0];  break; }
                            350 ;src/main.c:176: switch(prota.estado) {
   4EC7 16 00         [ 7]  351 	ld	d,#0x00
   4EC9 21 CF 4E      [10]  352 	ld	hl,#00114$
   4ECC 19            [11]  353 	add	hl,de
   4ECD 19            [11]  354 	add	hl,de
                            355 ;src/main.c:177: case ST_quieto:      { prota.frame = &g_frames[0];  break; }
   4ECE E9            [ 4]  356 	jp	(hl)
   4ECF                     357 00114$:
   4ECF 18 0A         [12]  358 	jr	00101$
   4ED1 18 11         [12]  359 	jr	00102$
   4ED3 18 1A         [12]  360 	jr	00103$
   4ED5 18 23         [12]  361 	jr	00104$
   4ED7 18 2A         [12]  362 	jr	00105$
   4ED9 18 31         [12]  363 	jr	00106$
   4EDB                     364 00101$:
   4EDB 21 FD 4D      [10]  365 	ld	hl,#_g_frames
   4EDE 22 E1 4D      [16]  366 	ld	((_prota + 0x0006)), hl
   4EE1 C3 9B 4E      [10]  367 	jp	_girarFrame
                            368 ;src/main.c:178: case ST_andando:     { asignarFrame(anim_andar);    break; }
   4EE4                     369 00102$:
   4EE4 21 2D 4E      [10]  370 	ld	hl,#_anim_andar
   4EE7 E5            [11]  371 	push	hl
   4EE8 CD 75 4E      [17]  372 	call	_asignarFrame
   4EEB F1            [10]  373 	pop	af
   4EEC C3 9B 4E      [10]  374 	jp	_girarFrame
                            375 ;src/main.c:179: case ST_prepSalto:   { asignarFrame(anim_saltar);   break; }
   4EEF                     376 00103$:
   4EEF 21 37 4E      [10]  377 	ld	hl,#_anim_saltar
   4EF2 E5            [11]  378 	push	hl
   4EF3 CD 75 4E      [17]  379 	call	_asignarFrame
   4EF6 F1            [10]  380 	pop	af
   4EF7 C3 9B 4E      [10]  381 	jp	_girarFrame
                            382 ;src/main.c:180: case ST_saltando:    { prota.frame = &g_frames[12]; break; }
   4EFA                     383 00104$:
   4EFA 21 21 4E      [10]  384 	ld	hl,#(_g_frames + 0x0024)
   4EFD 22 E1 4D      [16]  385 	ld	((_prota + 0x0006)), hl
   4F00 C3 9B 4E      [10]  386 	jp	_girarFrame
                            387 ;src/main.c:181: case ST_cayendo:     { prota.frame = &g_frames[13]; break; }
   4F03                     388 00105$:
   4F03 21 24 4E      [10]  389 	ld	hl,#(_g_frames + 0x0027)
   4F06 22 E1 4D      [16]  390 	ld	((_prota + 0x0006)), hl
   4F09 C3 9B 4E      [10]  391 	jp	_girarFrame
                            392 ;src/main.c:182: case ST_aterrizando: { asignarFrame(anim_caer);     break; }
   4F0C                     393 00106$:
   4F0C 21 3F 4E      [10]  394 	ld	hl,#_anim_caer
   4F0F E5            [11]  395 	push	hl
   4F10 CD 75 4E      [17]  396 	call	_asignarFrame
   4F13 F1            [10]  397 	pop	af
                            398 ;src/main.c:183: }
                            399 ;src/main.c:184: girarFrame();
   4F14 C3 9B 4E      [10]  400 	jp  _girarFrame
                            401 ;src/main.c:187: void dibujarProta() {
                            402 ;	---------------------------------
                            403 ; Function dibujarProta
                            404 ; ---------------------------------
   4F17                     405 _dibujarProta::
                            406 ;src/main.c:188: u8* pvmem = cpct_getScreenPtr(CPCT_VMEM_START, prota.x, prota.y);
   4F17 21 DC 4D      [10]  407 	ld	hl, #_prota + 1
   4F1A 56            [ 7]  408 	ld	d,(hl)
   4F1B 21 DB 4D      [10]  409 	ld	hl, #_prota + 0
   4F1E 46            [ 7]  410 	ld	b,(hl)
   4F1F D5            [11]  411 	push	de
   4F20 33            [ 6]  412 	inc	sp
   4F21 C5            [11]  413 	push	bc
   4F22 33            [ 6]  414 	inc	sp
   4F23 21 00 C0      [10]  415 	ld	hl,#0xC000
   4F26 E5            [11]  416 	push	hl
   4F27 CD 52 4D      [17]  417 	call	_cpct_getScreenPtr
   4F2A EB            [ 4]  418 	ex	de,hl
                            419 ;src/main.c:189: cpct_drawSpriteMaskedAlignedTable(prota.frame->sprite, pvmem, G_HERO_00_W, G_HERO_00_H, g_tablatrans);
   4F2B 2A E1 4D      [16]  420 	ld	hl, (#_prota + 6)
   4F2E 23            [ 6]  421 	inc	hl
   4F2F 4E            [ 7]  422 	ld	c,(hl)
   4F30 23            [ 6]  423 	inc	hl
   4F31 46            [ 7]  424 	ld	b,(hl)
   4F32 21 00 01      [10]  425 	ld	hl,#_g_tablatrans
   4F35 E5            [11]  426 	push	hl
   4F36 21 08 1B      [10]  427 	ld	hl,#0x1B08
   4F39 E5            [11]  428 	push	hl
   4F3A D5            [11]  429 	push	de
   4F3B C5            [11]  430 	push	bc
   4F3C CD 72 4D      [17]  431 	call	_cpct_drawSpriteMaskedAlignedTable
   4F3F C9            [10]  432 	ret
                            433 ;src/main.c:192: void borrarProta() {
                            434 ;	---------------------------------
                            435 ; Function borrarProta
                            436 ; ---------------------------------
   4F40                     437 _borrarProta::
   4F40 DD E5         [15]  438 	push	ix
   4F42 DD 21 00 00   [14]  439 	ld	ix,#0
   4F46 DD 39         [15]  440 	add	ix,sp
   4F48 F5            [11]  441 	push	af
   4F49 3B            [ 6]  442 	dec	sp
                            443 ;src/main.c:193: u8 w = 4 + (prota.px & 1);
   4F4A 21 DD 4D      [10]  444 	ld	hl, #_prota + 2
   4F4D 4E            [ 7]  445 	ld	c,(hl)
   4F4E 79            [ 4]  446 	ld	a,c
   4F4F E6 01         [ 7]  447 	and	a, #0x01
   4F51 47            [ 4]  448 	ld	b,a
   4F52 04            [ 4]  449 	inc	b
   4F53 04            [ 4]  450 	inc	b
   4F54 04            [ 4]  451 	inc	b
   4F55 04            [ 4]  452 	inc	b
                            453 ;src/main.c:194: u8 h = 7 + (prota.py & 3 ? 1 : 0);
   4F56 21 DE 4D      [10]  454 	ld	hl, #_prota + 3
   4F59 5E            [ 7]  455 	ld	e,(hl)
   4F5A 7B            [ 4]  456 	ld	a,e
   4F5B E6 03         [ 7]  457 	and	a, #0x03
   4F5D 28 04         [12]  458 	jr	Z,00103$
   4F5F 3E 01         [ 7]  459 	ld	a,#0x01
   4F61 18 02         [12]  460 	jr	00104$
   4F63                     461 00103$:
   4F63 3E 00         [ 7]  462 	ld	a,#0x00
   4F65                     463 00104$:
   4F65 C6 07         [ 7]  464 	add	a, #0x07
   4F67 DD 77 FD      [19]  465 	ld	-3 (ix),a
                            466 ;src/main.c:195: cpct_etm_drawTileBox2x4(prota.px / 2, (prota.py-ORIGEN_MAPA_Y) / 4, w, h, 40, ORIGEN_MAPA, mapa);
   4F6A FD 2A D8 4D   [20]  467 	ld	iy,(_mapa)
   4F6E 16 00         [ 7]  468 	ld	d,#0x00
   4F70 7B            [ 4]  469 	ld	a,e
   4F71 C6 BC         [ 7]  470 	add	a,#0xBC
   4F73 DD 77 FE      [19]  471 	ld	-2 (ix),a
   4F76 7A            [ 4]  472 	ld	a,d
   4F77 CE FF         [ 7]  473 	adc	a,#0xFF
   4F79 DD 77 FF      [19]  474 	ld	-1 (ix),a
   4F7C DD 6E FE      [19]  475 	ld	l,-2 (ix)
   4F7F DD 66 FF      [19]  476 	ld	h,-1 (ix)
   4F82 DD CB FF 7E   [20]  477 	bit	7, -1 (ix)
   4F86 28 04         [12]  478 	jr	Z,00105$
   4F88 21 BF FF      [10]  479 	ld	hl,#0xFFBF
   4F8B 19            [11]  480 	add	hl,de
   4F8C                     481 00105$:
   4F8C CB 2C         [ 8]  482 	sra	h
   4F8E CB 1D         [ 8]  483 	rr	l
   4F90 CB 2C         [ 8]  484 	sra	h
   4F92 CB 1D         [ 8]  485 	rr	l
   4F94 55            [ 4]  486 	ld	d,l
   4F95 CB 39         [ 8]  487 	srl	c
   4F97 FD E5         [15]  488 	push	iy
   4F99 21 80 E2      [10]  489 	ld	hl,#0xE280
   4F9C E5            [11]  490 	push	hl
   4F9D 3E 28         [ 7]  491 	ld	a,#0x28
   4F9F F5            [11]  492 	push	af
   4FA0 33            [ 6]  493 	inc	sp
   4FA1 DD 7E FD      [19]  494 	ld	a,-3 (ix)
   4FA4 F5            [11]  495 	push	af
   4FA5 33            [ 6]  496 	inc	sp
   4FA6 C5            [11]  497 	push	bc
   4FA7 33            [ 6]  498 	inc	sp
   4FA8 D5            [11]  499 	push	de
   4FA9 33            [ 6]  500 	inc	sp
   4FAA 79            [ 4]  501 	ld	a,c
   4FAB F5            [11]  502 	push	af
   4FAC 33            [ 6]  503 	inc	sp
   4FAD CD 44 43      [17]  504 	call	_cpct_etm_drawTileBox2x4
   4FB0 DD F9         [10]  505 	ld	sp, ix
   4FB2 DD E1         [14]  506 	pop	ix
   4FB4 C9            [10]  507 	ret
                            508 ;src/main.c:198: u8* obtenerTilePtr(u8 x, u8 y) {
                            509 ;	---------------------------------
                            510 ; Function obtenerTilePtr
                            511 ; ---------------------------------
   4FB5                     512 _obtenerTilePtr::
   4FB5 DD E5         [15]  513 	push	ix
   4FB7 DD 21 00 00   [14]  514 	ld	ix,#0
   4FBB DD 39         [15]  515 	add	ix,sp
                            516 ;src/main.c:199: return mapa + (y-ORIGEN_MAPA_Y)/4*g_map1_W + x/2;
   4FBD DD 4E 05      [19]  517 	ld	c,5 (ix)
   4FC0 06 00         [ 7]  518 	ld	b,#0x00
   4FC2 79            [ 4]  519 	ld	a,c
   4FC3 C6 BC         [ 7]  520 	add	a,#0xBC
   4FC5 5F            [ 4]  521 	ld	e,a
   4FC6 78            [ 4]  522 	ld	a,b
   4FC7 CE FF         [ 7]  523 	adc	a,#0xFF
   4FC9 57            [ 4]  524 	ld	d,a
   4FCA 6B            [ 4]  525 	ld	l, e
   4FCB 62            [ 4]  526 	ld	h, d
   4FCC CB 7A         [ 8]  527 	bit	7, d
   4FCE 28 04         [12]  528 	jr	Z,00103$
   4FD0 21 BF FF      [10]  529 	ld	hl,#0xFFBF
   4FD3 09            [11]  530 	add	hl,bc
   4FD4                     531 00103$:
   4FD4 CB 2C         [ 8]  532 	sra	h
   4FD6 CB 1D         [ 8]  533 	rr	l
   4FD8 CB 2C         [ 8]  534 	sra	h
   4FDA CB 1D         [ 8]  535 	rr	l
   4FDC 4D            [ 4]  536 	ld	c, l
   4FDD 44            [ 4]  537 	ld	b, h
   4FDE 29            [11]  538 	add	hl, hl
   4FDF 29            [11]  539 	add	hl, hl
   4FE0 09            [11]  540 	add	hl, bc
   4FE1 29            [11]  541 	add	hl, hl
   4FE2 29            [11]  542 	add	hl, hl
   4FE3 29            [11]  543 	add	hl, hl
   4FE4 4D            [ 4]  544 	ld	c,l
   4FE5 44            [ 4]  545 	ld	b,h
   4FE6 2A D8 4D      [16]  546 	ld	hl,(_mapa)
   4FE9 09            [11]  547 	add	hl,bc
   4FEA DD 4E 04      [19]  548 	ld	c,4 (ix)
   4FED CB 39         [ 8]  549 	srl	c
   4FEF 59            [ 4]  550 	ld	e,c
   4FF0 16 00         [ 7]  551 	ld	d,#0x00
   4FF2 19            [11]  552 	add	hl,de
   4FF3 DD E1         [14]  553 	pop	ix
   4FF5 C9            [10]  554 	ret
                            555 ;src/main.c:202: void ajustarAlSuelo() {
                            556 ;	---------------------------------
                            557 ; Function ajustarAlSuelo
                            558 ; ---------------------------------
   4FF6                     559 _ajustarAlSuelo::
                            560 ;src/main.c:203: prota.y = (prota.y & 0b11111100) + 1;
   4FF6 01 DC 4D      [10]  561 	ld	bc,#_prota+1
   4FF9 0A            [ 7]  562 	ld	a,(bc)
   4FFA E6 FC         [ 7]  563 	and	a, #0xFC
   4FFC 3C            [ 4]  564 	inc	a
   4FFD 02            [ 7]  565 	ld	(bc),a
   4FFE C9            [10]  566 	ret
                            567 ;src/main.c:206: u8 sobreSuelo() {
                            568 ;	---------------------------------
                            569 ; Function sobreSuelo
                            570 ; ---------------------------------
   4FFF                     571 _sobreSuelo::
                            572 ;src/main.c:207: u8* tileSuelo = obtenerTilePtr(prota.x+2, prota.y + ALTOPROTA+1);
   4FFF 3A DC 4D      [13]  573 	ld	a, (#_prota + 1)
   5002 C6 1C         [ 7]  574 	add	a, #0x1C
   5004 57            [ 4]  575 	ld	d,a
   5005 21 DB 4D      [10]  576 	ld	hl, #_prota + 0
   5008 46            [ 7]  577 	ld	b,(hl)
   5009 04            [ 4]  578 	inc	b
   500A 04            [ 4]  579 	inc	b
   500B D5            [11]  580 	push	de
   500C 33            [ 6]  581 	inc	sp
   500D C5            [11]  582 	push	bc
   500E 33            [ 6]  583 	inc	sp
   500F CD B5 4F      [17]  584 	call	_obtenerTilePtr
   5012 F1            [10]  585 	pop	af
                            586 ;src/main.c:208: if (*tileSuelo < 4 || *(tileSuelo+G_HERO_00_W/2-3) < 4)
   5013 7E            [ 7]  587 	ld	a, (hl)
   5014 D6 04         [ 7]  588 	sub	a, #0x04
   5016 38 06         [12]  589 	jr	C,00101$
   5018 23            [ 6]  590 	inc	hl
   5019 7E            [ 7]  591 	ld	a, (hl)
   501A D6 04         [ 7]  592 	sub	a, #0x04
   501C 30 03         [12]  593 	jr	NC,00102$
   501E                     594 00101$:
                            595 ;src/main.c:209: return 1;
   501E 2E 01         [ 7]  596 	ld	l,#0x01
   5020 C9            [10]  597 	ret
   5021                     598 00102$:
                            599 ;src/main.c:211: return 0;
   5021 2E 00         [ 7]  600 	ld	l,#0x00
   5023 C9            [10]  601 	ret
                            602 ;src/main.c:214: void avanzarMapa() {
                            603 ;	---------------------------------
                            604 ; Function avanzarMapa
                            605 ; ---------------------------------
   5024                     606 _avanzarMapa::
                            607 ;src/main.c:215: if (num_mapa < NUM_MAPAS-1) {
   5024 3A DA 4D      [13]  608 	ld	a,(#_num_mapa + 0)
   5027 D6 02         [ 7]  609 	sub	a, #0x02
   5029 D0            [11]  610 	ret	NC
                            611 ;src/main.c:216: mapa = mapas[++num_mapa];
   502A 01 F7 4D      [10]  612 	ld	bc,#_mapas+0
   502D 21 DA 4D      [10]  613 	ld	hl, #_num_mapa+0
   5030 34            [11]  614 	inc	(hl)
   5031 FD 21 DA 4D   [14]  615 	ld	iy,#_num_mapa
   5035 FD 6E 00      [19]  616 	ld	l,0 (iy)
   5038 26 00         [ 7]  617 	ld	h,#0x00
   503A 29            [11]  618 	add	hl, hl
   503B 09            [11]  619 	add	hl,bc
   503C 7E            [ 7]  620 	ld	a,(hl)
   503D FD 21 D8 4D   [14]  621 	ld	iy,#_mapa
   5041 FD 77 00      [19]  622 	ld	0 (iy),a
   5044 23            [ 6]  623 	inc	hl
   5045 7E            [ 7]  624 	ld	a,(hl)
   5046 32 D9 4D      [13]  625 	ld	(#_mapa + 1),a
                            626 ;src/main.c:217: prota.x = prota.px = 0;
   5049 21 DD 4D      [10]  627 	ld	hl,#(_prota + 0x0002)
   504C 36 00         [10]  628 	ld	(hl),#0x00
   504E 21 DB 4D      [10]  629 	ld	hl,#_prota
   5051 36 00         [10]  630 	ld	(hl),#0x00
                            631 ;src/main.c:218: prota.mover = SI;
   5053 21 DF 4D      [10]  632 	ld	hl,#(_prota + 0x0004)
   5056 36 01         [10]  633 	ld	(hl),#0x01
                            634 ;src/main.c:219: dibujarMapa();
   5058 C3 5F 4E      [10]  635 	jp  _dibujarMapa
                            636 ;src/main.c:223: void retrocederMapa() {
                            637 ;	---------------------------------
                            638 ; Function retrocederMapa
                            639 ; ---------------------------------
   505B                     640 _retrocederMapa::
                            641 ;src/main.c:224: if (num_mapa > 0) {
   505B 3A DA 4D      [13]  642 	ld	a,(#_num_mapa + 0)
   505E B7            [ 4]  643 	or	a, a
   505F C8            [11]  644 	ret	Z
                            645 ;src/main.c:225: mapa = mapas[--num_mapa];
   5060 01 F7 4D      [10]  646 	ld	bc,#_mapas+0
   5063 21 DA 4D      [10]  647 	ld	hl, #_num_mapa+0
   5066 35            [11]  648 	dec	(hl)
   5067 FD 21 DA 4D   [14]  649 	ld	iy,#_num_mapa
   506B FD 6E 00      [19]  650 	ld	l,0 (iy)
   506E 26 00         [ 7]  651 	ld	h,#0x00
   5070 29            [11]  652 	add	hl, hl
   5071 09            [11]  653 	add	hl,bc
   5072 7E            [ 7]  654 	ld	a,(hl)
   5073 FD 21 D8 4D   [14]  655 	ld	iy,#_mapa
   5077 FD 77 00      [19]  656 	ld	0 (iy),a
   507A 23            [ 6]  657 	inc	hl
   507B 7E            [ 7]  658 	ld	a,(hl)
   507C 32 D9 4D      [13]  659 	ld	(#_mapa + 1),a
                            660 ;src/main.c:226: prota.x = prota.px = ANCHO - G_HERO_00_W;
   507F 21 DD 4D      [10]  661 	ld	hl,#(_prota + 0x0002)
   5082 36 48         [10]  662 	ld	(hl),#0x48
   5084 21 DB 4D      [10]  663 	ld	hl,#_prota
   5087 36 48         [10]  664 	ld	(hl),#0x48
                            665 ;src/main.c:227: prota.mover = SI;
   5089 21 DF 4D      [10]  666 	ld	hl,#(_prota + 0x0004)
   508C 36 01         [10]  667 	ld	(hl),#0x01
                            668 ;src/main.c:228: dibujarMapa();
   508E C3 5F 4E      [10]  669 	jp  _dibujarMapa
                            670 ;src/main.c:232: void moverDerecha() { 
                            671 ;	---------------------------------
                            672 ; Function moverDerecha
                            673 ; ---------------------------------
   5091                     674 _moverDerecha::
                            675 ;src/main.c:233: if (prota.x + G_HERO_00_W < ANCHO) {
   5091 21 DB 4D      [10]  676 	ld	hl, #_prota + 0
   5094 4E            [ 7]  677 	ld	c,(hl)
   5095 59            [ 4]  678 	ld	e,c
   5096 16 00         [ 7]  679 	ld	d,#0x00
   5098 21 08 00      [10]  680 	ld	hl,#0x0008
   509B 19            [11]  681 	add	hl,de
   509C 11 50 80      [10]  682 	ld	de, #0x8050
   509F 29            [11]  683 	add	hl, hl
   50A0 3F            [ 4]  684 	ccf
   50A1 CB 1C         [ 8]  685 	rr	h
   50A3 CB 1D         [ 8]  686 	rr	l
   50A5 ED 52         [15]  687 	sbc	hl, de
   50A7 D2 24 50      [10]  688 	jp	NC,_avanzarMapa
                            689 ;src/main.c:234: prota.x++;
   50AA 0C            [ 4]  690 	inc	c
   50AB 21 DB 4D      [10]  691 	ld	hl,#_prota
   50AE 71            [ 7]  692 	ld	(hl),c
                            693 ;src/main.c:235: prota.mira  = M_derecha;
   50AF 21 E4 4D      [10]  694 	ld	hl,#(_prota + 0x0009)
   50B2 36 00         [10]  695 	ld	(hl),#0x00
   50B4 C9            [10]  696 	ret
                            697 ;src/main.c:237: avanzarMapa();
   50B5 C3 24 50      [10]  698 	jp  _avanzarMapa
                            699 ;src/main.c:241: void moverIzquierda() {
                            700 ;	---------------------------------
                            701 ; Function moverIzquierda
                            702 ; ---------------------------------
   50B8                     703 _moverIzquierda::
                            704 ;src/main.c:242: if (prota.x > 0) {
   50B8 01 DB 4D      [10]  705 	ld	bc,#_prota+0
   50BB 0A            [ 7]  706 	ld	a,(bc)
   50BC B7            [ 4]  707 	or	a, a
   50BD CA 5B 50      [10]  708 	jp	Z,_retrocederMapa
                            709 ;src/main.c:243: prota.x--;
   50C0 C6 FF         [ 7]  710 	add	a,#0xFF
   50C2 02            [ 7]  711 	ld	(bc),a
                            712 ;src/main.c:244: prota.mira  = M_izquierda;
   50C3 21 E4 4D      [10]  713 	ld	hl,#(_prota + 0x0009)
   50C6 36 01         [10]  714 	ld	(hl),#0x01
   50C8 C9            [10]  715 	ret
                            716 ;src/main.c:246: retrocederMapa();
   50C9 C3 5B 50      [10]  717 	jp  _retrocederMapa
                            718 ;src/main.c:250: void redibujarProta() {
                            719 ;	---------------------------------
                            720 ; Function redibujarProta
                            721 ; ---------------------------------
   50CC                     722 _redibujarProta::
                            723 ;src/main.c:251: borrarProta();
   50CC CD 40 4F      [17]  724 	call	_borrarProta
                            725 ;src/main.c:252: prota.px = prota.x;
   50CF 01 DD 4D      [10]  726 	ld	bc,#_prota + 2
   50D2 3A DB 4D      [13]  727 	ld	a, (#_prota + 0)
   50D5 02            [ 7]  728 	ld	(bc),a
                            729 ;src/main.c:253: prota.py = prota.y;
   50D6 01 DE 4D      [10]  730 	ld	bc,#_prota + 3
   50D9 3A DC 4D      [13]  731 	ld	a, (#_prota + 1)
   50DC 02            [ 7]  732 	ld	(bc),a
                            733 ;src/main.c:254: dibujarProta();
   50DD C3 17 4F      [10]  734 	jp  _dibujarProta
                            735 ;src/main.c:257: u8 compruebaTeclas(const cpct_keyID* k, u8 numk) {
                            736 ;	---------------------------------
                            737 ; Function compruebaTeclas
                            738 ; ---------------------------------
   50E0                     739 _compruebaTeclas::
   50E0 DD E5         [15]  740 	push	ix
   50E2 DD 21 00 00   [14]  741 	ld	ix,#0
   50E6 DD 39         [15]  742 	add	ix,sp
                            743 ;src/main.c:260: if (cpct_isAnyKeyPressed()) {
   50E8 CD 02 44      [17]  744 	call	_cpct_isAnyKeyPressed
   50EB 7D            [ 4]  745 	ld	a,l
   50EC B7            [ 4]  746 	or	a, a
   50ED 28 29         [12]  747 	jr	Z,00105$
                            748 ;src/main.c:261: for(i=1; i <= numk; i++, k++) {
   50EF 01 01 01      [10]  749 	ld	bc,#0x0101
   50F2 DD 5E 04      [19]  750 	ld	e,4 (ix)
   50F5 DD 56 05      [19]  751 	ld	d,5 (ix)
   50F8                     752 00107$:
   50F8 DD 7E 06      [19]  753 	ld	a,6 (ix)
   50FB 90            [ 4]  754 	sub	a, b
   50FC 38 1A         [12]  755 	jr	C,00105$
                            756 ;src/main.c:262: if (cpct_isKeyPressed(*k))
   50FE 6B            [ 4]  757 	ld	l, e
   50FF 62            [ 4]  758 	ld	h, d
   5100 7E            [ 7]  759 	ld	a, (hl)
   5101 23            [ 6]  760 	inc	hl
   5102 66            [ 7]  761 	ld	h,(hl)
   5103 6F            [ 4]  762 	ld	l,a
   5104 C5            [11]  763 	push	bc
   5105 D5            [11]  764 	push	de
   5106 CD 87 42      [17]  765 	call	_cpct_isKeyPressed
   5109 D1            [10]  766 	pop	de
   510A C1            [10]  767 	pop	bc
   510B 7D            [ 4]  768 	ld	a,l
   510C B7            [ 4]  769 	or	a, a
   510D 28 03         [12]  770 	jr	Z,00108$
                            771 ;src/main.c:263: return i;
   510F 69            [ 4]  772 	ld	l,c
   5110 18 08         [12]  773 	jr	00109$
   5112                     774 00108$:
                            775 ;src/main.c:261: for(i=1; i <= numk; i++, k++) {
   5112 04            [ 4]  776 	inc	b
   5113 48            [ 4]  777 	ld	c,b
   5114 13            [ 6]  778 	inc	de
   5115 13            [ 6]  779 	inc	de
   5116 18 E0         [12]  780 	jr	00107$
   5118                     781 00105$:
                            782 ;src/main.c:266: return 0;
   5118 2E 00         [ 7]  783 	ld	l,#0x00
   511A                     784 00109$:
   511A DD E1         [14]  785 	pop	ix
   511C C9            [10]  786 	ret
                            787 ;src/main.c:271: void aterrizando_entrar() {
                            788 ;	---------------------------------
                            789 ; Function aterrizando_entrar
                            790 ; ---------------------------------
   511D                     791 _aterrizando_entrar::
                            792 ;src/main.c:272: prota.nframe = 0;
   511D 21 E3 4D      [10]  793 	ld	hl,#(_prota + 0x0008)
   5120 36 00         [10]  794 	ld	(hl),#0x00
                            795 ;src/main.c:273: prota.estado = ST_aterrizando;
   5122 21 E0 4D      [10]  796 	ld	hl,#(_prota + 0x0005)
   5125 36 05         [10]  797 	ld	(hl),#0x05
                            798 ;src/main.c:274: prota.mover  = SI;
   5127 21 DF 4D      [10]  799 	ld	hl,#(_prota + 0x0004)
   512A 36 01         [10]  800 	ld	(hl),#0x01
   512C C9            [10]  801 	ret
                            802 ;src/main.c:277: void aterrizando() {
                            803 ;	---------------------------------
                            804 ; Function aterrizando
                            805 ; ---------------------------------
   512D                     806 _aterrizando::
                            807 ;src/main.c:278: prota.mover = SI;
   512D 21 DF 4D      [10]  808 	ld	hl,#(_prota + 0x0004)
   5130 36 01         [10]  809 	ld	(hl),#0x01
                            810 ;src/main.c:279: if(++prota.nframe == CAER_FRAMES*ANIM_PAUSA)
   5132 01 E3 4D      [10]  811 	ld	bc,#_prota + 8
   5135 0A            [ 7]  812 	ld	a,(bc)
   5136 3C            [ 4]  813 	inc	a
   5137 02            [ 7]  814 	ld	(bc),a
   5138 D6 08         [ 7]  815 	sub	a, #0x08
   513A C0            [11]  816 	ret	NZ
                            817 ;src/main.c:280: quieto_entrar();      
   513B C3 BA 51      [10]  818 	jp  _quieto_entrar
                            819 ;src/main.c:283: void cayendo_entrar() {
                            820 ;	---------------------------------
                            821 ; Function cayendo_entrar
                            822 ; ---------------------------------
   513E                     823 _cayendo_entrar::
                            824 ;src/main.c:284: prota.estado = ST_cayendo;
   513E 21 E0 4D      [10]  825 	ld	hl,#(_prota + 0x0005)
   5141 36 04         [10]  826 	ld	(hl),#0x04
                            827 ;src/main.c:285: prota.mover  = SI;
   5143 21 DF 4D      [10]  828 	ld	hl,#(_prota + 0x0004)
   5146 36 01         [10]  829 	ld	(hl),#0x01
                            830 ;src/main.c:286: prota.salto  = PASOS_SALTO - 3;
   5148 21 E5 4D      [10]  831 	ld	hl,#(_prota + 0x000a)
   514B 36 11         [10]  832 	ld	(hl),#0x11
   514D C9            [10]  833 	ret
                            834 ;src/main.c:289: void descender() {
                            835 ;	---------------------------------
                            836 ; Function descender
                            837 ; ---------------------------------
   514E                     838 _descender::
                            839 ;src/main.c:290: prota.y += cpct_get2Bits(g_tablaSalto, prota.salto);
   514E 21 DC 4D      [10]  840 	ld	hl, #(_prota + 0x0001) + 0
   5151 4E            [ 7]  841 	ld	c,(hl)
   5152 21 E5 4D      [10]  842 	ld	hl, #(_prota + 0x000a) + 0
   5155 5E            [ 7]  843 	ld	e,(hl)
   5156 16 00         [ 7]  844 	ld	d,#0x00
   5158 C5            [11]  845 	push	bc
   5159 D5            [11]  846 	push	de
   515A 21 43 4E      [10]  847 	ld	hl,#_g_tablaSalto
   515D E5            [11]  848 	push	hl
   515E CD 0F 44      [17]  849 	call	_cpct_get2Bits
   5161 C1            [10]  850 	pop	bc
   5162 79            [ 4]  851 	ld	a,c
   5163 85            [ 4]  852 	add	a, l
   5164 32 DC 4D      [13]  853 	ld	(#(_prota + 0x0001)),a
                            854 ;src/main.c:291: if (prota.salto > 1)
   5167 21 E5 4D      [10]  855 	ld	hl, #(_prota + 0x000a) + 0
   516A 4E            [ 7]  856 	ld	c,(hl)
   516B 3E 01         [ 7]  857 	ld	a,#0x01
   516D 91            [ 4]  858 	sub	a, c
   516E D0            [11]  859 	ret	NC
                            860 ;src/main.c:292: prota.salto--;
   516F 0D            [ 4]  861 	dec	c
   5170 21 E5 4D      [10]  862 	ld	hl,#(_prota + 0x000a)
   5173 71            [ 7]  863 	ld	(hl),c
   5174 C9            [10]  864 	ret
                            865 ;src/main.c:295: void cayendo() {
                            866 ;	---------------------------------
                            867 ; Function cayendo
                            868 ; ---------------------------------
   5175                     869 _cayendo::
                            870 ;src/main.c:297: u8 k = compruebaTeclas(keys, 2);
   5175 3E 02         [ 7]  871 	ld	a,#0x02
   5177 F5            [11]  872 	push	af
   5178 33            [ 6]  873 	inc	sp
   5179 21 B6 51      [10]  874 	ld	hl,#_cayendo_keys_1_118
   517C E5            [11]  875 	push	hl
   517D CD E0 50      [17]  876 	call	_compruebaTeclas
   5180 F1            [10]  877 	pop	af
   5181 33            [ 6]  878 	inc	sp
   5182 5D            [ 4]  879 	ld	e,l
                            880 ;src/main.c:298: switch(k) {
   5183 3E 02         [ 7]  881 	ld	a,#0x02
   5185 93            [ 4]  882 	sub	a, e
   5186 38 18         [12]  883 	jr	C,00104$
   5188 16 00         [ 7]  884 	ld	d,#0x00
   518A 21 90 51      [10]  885 	ld	hl,#00117$
   518D 19            [11]  886 	add	hl,de
   518E 19            [11]  887 	add	hl,de
                            888 ;src/main.c:299: case 0: break; // Nada que hacer
                            889 ;src/main.c:300: case 1: moverDerecha();   break;
   518F E9            [ 4]  890 	jp	(hl)
   5190                     891 00117$:
   5190 18 0E         [12]  892 	jr	00104$
   5192 18 04         [12]  893 	jr	00102$
   5194 18 07         [12]  894 	jr	00103$
   5196 18 08         [12]  895 	jr	00104$
   5198                     896 00102$:
   5198 CD 91 50      [17]  897 	call	_moverDerecha
   519B 18 03         [12]  898 	jr	00104$
                            899 ;src/main.c:301: case 2: moverIzquierda(); break;
   519D                     900 00103$:
   519D CD B8 50      [17]  901 	call	_moverIzquierda
                            902 ;src/main.c:302: }
   51A0                     903 00104$:
                            904 ;src/main.c:303: descender();
   51A0 CD 4E 51      [17]  905 	call	_descender
                            906 ;src/main.c:304: if (sobreSuelo()) {
   51A3 CD FF 4F      [17]  907 	call	_sobreSuelo
   51A6 7D            [ 4]  908 	ld	a,l
   51A7 B7            [ 4]  909 	or	a, a
   51A8 28 06         [12]  910 	jr	Z,00106$
                            911 ;src/main.c:305: ajustarAlSuelo();
   51AA CD F6 4F      [17]  912 	call	_ajustarAlSuelo
                            913 ;src/main.c:306: aterrizando_entrar();
   51AD CD 1D 51      [17]  914 	call	_aterrizando_entrar
   51B0                     915 00106$:
                            916 ;src/main.c:308: prota.mover=SI;
   51B0 21 DF 4D      [10]  917 	ld	hl,#(_prota + 0x0004)
   51B3 36 01         [10]  918 	ld	(hl),#0x01
   51B5 C9            [10]  919 	ret
   51B6                     920 _cayendo_keys_1_118:
   51B6 00 02               921 	.dw #0x0200
   51B8 01 01               922 	.dw #0x0101
                            923 ;src/main.c:311: void quieto_entrar() {
                            924 ;	---------------------------------
                            925 ; Function quieto_entrar
                            926 ; ---------------------------------
   51BA                     927 _quieto_entrar::
                            928 ;src/main.c:312: prota.estado = ST_quieto;
   51BA 21 E0 4D      [10]  929 	ld	hl,#(_prota + 0x0005)
   51BD 36 00         [10]  930 	ld	(hl),#0x00
                            931 ;src/main.c:313: prota.mover  = SI;
   51BF 21 DF 4D      [10]  932 	ld	hl,#(_prota + 0x0004)
   51C2 36 01         [10]  933 	ld	(hl),#0x01
   51C4 C9            [10]  934 	ret
                            935 ;src/main.c:319: void quieto() {
                            936 ;	---------------------------------
                            937 ; Function quieto
                            938 ; ---------------------------------
   51C5                     939 _quieto::
                            940 ;src/main.c:321: u8 k = compruebaTeclas(keys, 3);
   51C5 3E 03         [ 7]  941 	ld	a,#0x03
   51C7 F5            [11]  942 	push	af
   51C8 33            [ 6]  943 	inc	sp
   51C9 21 FD 51      [10]  944 	ld	hl,#_quieto_keys_1_123
   51CC E5            [11]  945 	push	hl
   51CD CD E0 50      [17]  946 	call	_compruebaTeclas
   51D0 F1            [10]  947 	pop	af
   51D1 33            [ 6]  948 	inc	sp
   51D2 5D            [ 4]  949 	ld	e,l
                            950 ;src/main.c:322: switch(k) {
   51D3 3E 03         [ 7]  951 	ld	a,#0x03
   51D5 93            [ 4]  952 	sub	a, e
   51D6 D8            [11]  953 	ret	C
   51D7 16 00         [ 7]  954 	ld	d,#0x00
   51D9 21 DF 51      [10]  955 	ld	hl,#00112$
   51DC 19            [11]  956 	add	hl,de
   51DD 19            [11]  957 	add	hl,de
                            958 ;src/main.c:323: case 0: break; // Nada que hacer
                            959 ;src/main.c:324: case 1: prepSalto_entrar(); break;
   51DE E9            [ 4]  960 	jp	(hl)
   51DF                     961 00112$:
   51DF 18 1B         [12]  962 	jr	00106$
   51E1 18 06         [12]  963 	jr	00102$
   51E3 18 07         [12]  964 	jr	00103$
   51E5 18 0D         [12]  965 	jr	00104$
   51E7 18 13         [12]  966 	jr	00106$
   51E9                     967 00102$:
   51E9 C3 86 52      [10]  968 	jp  _prepSalto_entrar
                            969 ;src/main.c:325: case 2: andando_entrar(M_derecha);   break;
   51EC                     970 00103$:
   51EC AF            [ 4]  971 	xor	a, a
   51ED F5            [11]  972 	push	af
   51EE 33            [ 6]  973 	inc	sp
   51EF CD C8 52      [17]  974 	call	_andando_entrar
   51F2 33            [ 6]  975 	inc	sp
   51F3 C9            [10]  976 	ret
                            977 ;src/main.c:326: case 3: andando_entrar(M_izquierda); break;
   51F4                     978 00104$:
   51F4 3E 01         [ 7]  979 	ld	a,#0x01
   51F6 F5            [11]  980 	push	af
   51F7 33            [ 6]  981 	inc	sp
   51F8 CD C8 52      [17]  982 	call	_andando_entrar
   51FB 33            [ 6]  983 	inc	sp
                            984 ;src/main.c:327: }
   51FC                     985 00106$:
   51FC C9            [10]  986 	ret
   51FD                     987 _quieto_keys_1_123:
   51FD 00 01               988 	.dw #0x0100
   51FF 00 02               989 	.dw #0x0200
   5201 01 01               990 	.dw #0x0101
                            991 ;src/main.c:330: void ascender() {
                            992 ;	---------------------------------
                            993 ; Function ascender
                            994 ; ---------------------------------
   5203                     995 _ascender::
                            996 ;src/main.c:331: prota.y -= cpct_get2Bits(g_tablaSalto, prota.salto);
   5203 21 DC 4D      [10]  997 	ld	hl, #(_prota + 0x0001) + 0
   5206 4E            [ 7]  998 	ld	c,(hl)
   5207 21 E5 4D      [10]  999 	ld	hl, #(_prota + 0x000a) + 0
   520A 5E            [ 7] 1000 	ld	e,(hl)
   520B 16 00         [ 7] 1001 	ld	d,#0x00
   520D C5            [11] 1002 	push	bc
   520E D5            [11] 1003 	push	de
   520F 21 43 4E      [10] 1004 	ld	hl,#_g_tablaSalto
   5212 E5            [11] 1005 	push	hl
   5213 CD 0F 44      [17] 1006 	call	_cpct_get2Bits
   5216 C1            [10] 1007 	pop	bc
   5217 79            [ 4] 1008 	ld	a,c
   5218 95            [ 4] 1009 	sub	a, l
   5219 4F            [ 4] 1010 	ld	c,a
   521A 21 DC 4D      [10] 1011 	ld	hl,#(_prota + 0x0001)
   521D 71            [ 7] 1012 	ld	(hl),c
                           1013 ;src/main.c:332: if (prota.y < ORIGEN_MAPA_Y)
   521E 79            [ 4] 1014 	ld	a,c
   521F D6 44         [ 7] 1015 	sub	a, #0x44
   5221 30 02         [12] 1016 	jr	NC,00102$
                           1017 ;src/main.c:333: prota.y = ORIGEN_MAPA_Y;
   5223 36 44         [10] 1018 	ld	(hl),#0x44
   5225                    1019 00102$:
                           1020 ;src/main.c:334: if (++prota.salto == PASOS_SALTO)
   5225 3A E5 4D      [13] 1021 	ld	a, (#(_prota + 0x000a) + 0)
   5228 3C            [ 4] 1022 	inc	a
   5229 32 E5 4D      [13] 1023 	ld	(#(_prota + 0x000a)),a
   522C D6 14         [ 7] 1024 	sub	a, #0x14
   522E C0            [11] 1025 	ret	NZ
                           1026 ;src/main.c:335: cayendo_entrar();
   522F CD 3E 51      [17] 1027 	call	_cayendo_entrar
   5232 C9            [10] 1028 	ret
                           1029 ;src/main.c:338: void saltando_entrar() {
                           1030 ;	---------------------------------
                           1031 ; Function saltando_entrar
                           1032 ; ---------------------------------
   5233                    1033 _saltando_entrar::
                           1034 ;src/main.c:339: prota.estado = ST_saltando;
   5233 21 E0 4D      [10] 1035 	ld	hl,#(_prota + 0x0005)
   5236 36 03         [10] 1036 	ld	(hl),#0x03
                           1037 ;src/main.c:340: prota.mover  = SI;
   5238 21 DF 4D      [10] 1038 	ld	hl,#(_prota + 0x0004)
   523B 36 01         [10] 1039 	ld	(hl),#0x01
                           1040 ;src/main.c:341: prota.salto  = 0;
   523D 21 E5 4D      [10] 1041 	ld	hl,#(_prota + 0x000a)
   5240 36 00         [10] 1042 	ld	(hl),#0x00
   5242 C9            [10] 1043 	ret
                           1044 ;src/main.c:344: void saltando() {
                           1045 ;	---------------------------------
                           1046 ; Function saltando
                           1047 ; ---------------------------------
   5243                    1048 _saltando::
                           1049 ;src/main.c:345: if (!cpct_isKeyPressed(Key_CursorUp)) {
   5243 21 00 01      [10] 1050 	ld	hl,#0x0100
   5246 CD 87 42      [17] 1051 	call	_cpct_isKeyPressed
   5249 7D            [ 4] 1052 	ld	a,l
   524A B7            [ 4] 1053 	or	a, a
                           1054 ;src/main.c:346: cayendo_entrar();
   524B CA 3E 51      [10] 1055 	jp	Z,_cayendo_entrar
                           1056 ;src/main.c:349: u8 k = compruebaTeclas(keys, 2);
   524E 3E 02         [ 7] 1057 	ld	a,#0x02
   5250 F5            [11] 1058 	push	af
   5251 33            [ 6] 1059 	inc	sp
   5252 21 82 52      [10] 1060 	ld	hl,#_saltando_keys_2_129
   5255 E5            [11] 1061 	push	hl
   5256 CD E0 50      [17] 1062 	call	_compruebaTeclas
   5259 F1            [10] 1063 	pop	af
   525A 33            [ 6] 1064 	inc	sp
   525B 5D            [ 4] 1065 	ld	e,l
                           1066 ;src/main.c:350: switch(k) {
   525C 3E 02         [ 7] 1067 	ld	a,#0x02
   525E 93            [ 4] 1068 	sub	a, e
   525F 38 18         [12] 1069 	jr	C,00104$
   5261 16 00         [ 7] 1070 	ld	d,#0x00
   5263 21 69 52      [10] 1071 	ld	hl,#00118$
   5266 19            [11] 1072 	add	hl,de
   5267 19            [11] 1073 	add	hl,de
                           1074 ;src/main.c:351: case 0: break;
                           1075 ;src/main.c:352: case 1: moverDerecha();   break;
   5268 E9            [ 4] 1076 	jp	(hl)
   5269                    1077 00118$:
   5269 18 0E         [12] 1078 	jr	00104$
   526B 18 04         [12] 1079 	jr	00102$
   526D 18 07         [12] 1080 	jr	00103$
   526F 18 08         [12] 1081 	jr	00104$
   5271                    1082 00102$:
   5271 CD 91 50      [17] 1083 	call	_moverDerecha
   5274 18 03         [12] 1084 	jr	00104$
                           1085 ;src/main.c:353: case 2: moverIzquierda(); break;
   5276                    1086 00103$:
   5276 CD B8 50      [17] 1087 	call	_moverIzquierda
                           1088 ;src/main.c:354: }
   5279                    1089 00104$:
                           1090 ;src/main.c:355: ascender();
   5279 CD 03 52      [17] 1091 	call	_ascender
                           1092 ;src/main.c:356: prota.mover = SI;
   527C 21 DF 4D      [10] 1093 	ld	hl,#(_prota + 0x0004)
   527F 36 01         [10] 1094 	ld	(hl),#0x01
   5281 C9            [10] 1095 	ret
   5282                    1096 _saltando_keys_2_129:
   5282 00 02              1097 	.dw #0x0200
   5284 01 01              1098 	.dw #0x0101
                           1099 ;src/main.c:361: void prepSalto_entrar() {
                           1100 ;	---------------------------------
                           1101 ; Function prepSalto_entrar
                           1102 ; ---------------------------------
   5286                    1103 _prepSalto_entrar::
                           1104 ;src/main.c:362: prota.nframe = 0;
   5286 21 E3 4D      [10] 1105 	ld	hl,#(_prota + 0x0008)
   5289 36 00         [10] 1106 	ld	(hl),#0x00
                           1107 ;src/main.c:363: prota.estado = ST_prepSalto;
   528B 21 E0 4D      [10] 1108 	ld	hl,#(_prota + 0x0005)
   528E 36 02         [10] 1109 	ld	(hl),#0x02
                           1110 ;src/main.c:364: prota.mover  = SI;
   5290 21 DF 4D      [10] 1111 	ld	hl,#(_prota + 0x0004)
   5293 36 01         [10] 1112 	ld	(hl),#0x01
   5295 C9            [10] 1113 	ret
                           1114 ;src/main.c:367: void prepSalto_animar() {
                           1115 ;	---------------------------------
                           1116 ; Function prepSalto_animar
                           1117 ; ---------------------------------
   5296                    1118 _prepSalto_animar::
                           1119 ;src/main.c:368: if (++prota.nframe == SALTAR_FRAMES*ANIM_PAUSA)
   5296 01 E3 4D      [10] 1120 	ld	bc,#_prota+8
   5299 0A            [ 7] 1121 	ld	a,(bc)
   529A 3C            [ 4] 1122 	inc	a
   529B 02            [ 7] 1123 	ld	(bc),a
   529C D6 10         [ 7] 1124 	sub	a, #0x10
   529E C0            [11] 1125 	ret	NZ
                           1126 ;src/main.c:369: saltando_entrar();
   529F C3 33 52      [10] 1127 	jp  _saltando_entrar
                           1128 ;src/main.c:372: void prepSalto() {
                           1129 ;	---------------------------------
                           1130 ; Function prepSalto
                           1131 ; ---------------------------------
   52A2                    1132 _prepSalto::
                           1133 ;src/main.c:374: u8 k = compruebaTeclas(keys, 1);
   52A2 3E 01         [ 7] 1134 	ld	a,#0x01
   52A4 F5            [11] 1135 	push	af
   52A5 33            [ 6] 1136 	inc	sp
   52A6 21 C6 52      [10] 1137 	ld	hl,#_prepSalto_keys_1_133
   52A9 E5            [11] 1138 	push	hl
   52AA CD E0 50      [17] 1139 	call	_compruebaTeclas
   52AD F1            [10] 1140 	pop	af
   52AE 33            [ 6] 1141 	inc	sp
                           1142 ;src/main.c:375: switch(k) {
   52AF 7D            [ 4] 1143 	ld	a,l
   52B0 B7            [ 4] 1144 	or	a, a
   52B1 28 05         [12] 1145 	jr	Z,00101$
   52B3 2D            [ 4] 1146 	dec	l
   52B4 28 07         [12] 1147 	jr	Z,00102$
   52B6 18 08         [12] 1148 	jr	00103$
                           1149 ;src/main.c:376: case 0: quieto_entrar(); break; 
   52B8                    1150 00101$:
   52B8 CD BA 51      [17] 1151 	call	_quieto_entrar
   52BB 18 03         [12] 1152 	jr	00103$
                           1153 ;src/main.c:377: case 1: prepSalto_animar(); break;
   52BD                    1154 00102$:
   52BD CD 96 52      [17] 1155 	call	_prepSalto_animar
                           1156 ;src/main.c:378: }
   52C0                    1157 00103$:
                           1158 ;src/main.c:379: prota.mover = SI;
   52C0 21 DF 4D      [10] 1159 	ld	hl,#(_prota + 0x0004)
   52C3 36 01         [10] 1160 	ld	(hl),#0x01
   52C5 C9            [10] 1161 	ret
   52C6                    1162 _prepSalto_keys_1_133:
   52C6 00 01              1163 	.dw #0x0100
                           1164 ;src/main.c:382: void andando_entrar(u8 mirar) {
                           1165 ;	---------------------------------
                           1166 ; Function andando_entrar
                           1167 ; ---------------------------------
   52C8                    1168 _andando_entrar::
                           1169 ;src/main.c:383: prota.nframe = 0;
   52C8 21 E3 4D      [10] 1170 	ld	hl,#(_prota + 0x0008)
   52CB 36 00         [10] 1171 	ld	(hl),#0x00
                           1172 ;src/main.c:384: prota.estado = ST_andando;
   52CD 21 E0 4D      [10] 1173 	ld	hl,#(_prota + 0x0005)
   52D0 36 01         [10] 1174 	ld	(hl),#0x01
                           1175 ;src/main.c:385: prota.mira   = mirar;
   52D2 21 E4 4D      [10] 1176 	ld	hl,#(_prota + 0x0009)
   52D5 FD 21 02 00   [14] 1177 	ld	iy,#2
   52D9 FD 39         [15] 1178 	add	iy,sp
   52DB FD 7E 00      [19] 1179 	ld	a,0 (iy)
   52DE 77            [ 7] 1180 	ld	(hl),a
                           1181 ;src/main.c:386: prota.mover  = SI;
   52DF 21 DF 4D      [10] 1182 	ld	hl,#(_prota + 0x0004)
   52E2 36 01         [10] 1183 	ld	(hl),#0x01
   52E4 C9            [10] 1184 	ret
                           1185 ;src/main.c:389: void andando_animar(u8 mirar) {
                           1186 ;	---------------------------------
                           1187 ; Function andando_animar
                           1188 ; ---------------------------------
   52E5                    1189 _andando_animar::
                           1190 ;src/main.c:390: prota.mira  = mirar;
   52E5 21 E4 4D      [10] 1191 	ld	hl,#(_prota + 0x0009)
   52E8 FD 21 02 00   [14] 1192 	ld	iy,#2
   52EC FD 39         [15] 1193 	add	iy,sp
   52EE FD 7E 00      [19] 1194 	ld	a,0 (iy)
   52F1 77            [ 7] 1195 	ld	(hl),a
                           1196 ;src/main.c:391: if(++prota.nframe == ANDAR_FRAMES*ANIM_PAUSA)
   52F2 01 E3 4D      [10] 1197 	ld	bc,#_prota + 8
   52F5 0A            [ 7] 1198 	ld	a,(bc)
   52F6 3C            [ 4] 1199 	inc	a
   52F7 02            [ 7] 1200 	ld	(bc),a
   52F8 D6 14         [ 7] 1201 	sub	a, #0x14
   52FA C0            [11] 1202 	ret	NZ
                           1203 ;src/main.c:392: prota.nframe = 0;
   52FB AF            [ 4] 1204 	xor	a, a
   52FC 02            [ 7] 1205 	ld	(bc),a
   52FD C9            [10] 1206 	ret
                           1207 ;src/main.c:395: void andando() {
                           1208 ;	---------------------------------
                           1209 ; Function andando
                           1210 ; ---------------------------------
   52FE                    1211 _andando::
                           1212 ;src/main.c:397: u8 k = compruebaTeclas(keys, 3);
   52FE 3E 03         [ 7] 1213 	ld	a,#0x03
   5300 F5            [11] 1214 	push	af
   5301 33            [ 6] 1215 	inc	sp
   5302 21 50 53      [10] 1216 	ld	hl,#_andando_keys_1_139
   5305 E5            [11] 1217 	push	hl
   5306 CD E0 50      [17] 1218 	call	_compruebaTeclas
   5309 F1            [10] 1219 	pop	af
   530A 33            [ 6] 1220 	inc	sp
   530B 5D            [ 4] 1221 	ld	e,l
                           1222 ;src/main.c:398: switch(k) {
   530C 3E 03         [ 7] 1223 	ld	a,#0x03
   530E 93            [ 4] 1224 	sub	a, e
   530F 38 31         [12] 1225 	jr	C,00105$
   5311 16 00         [ 7] 1226 	ld	d,#0x00
   5313 21 19 53      [10] 1227 	ld	hl,#00118$
   5316 19            [11] 1228 	add	hl,de
   5317 19            [11] 1229 	add	hl,de
                           1230 ;src/main.c:399: case 0: quieto_entrar();    break;
   5318 E9            [ 4] 1231 	jp	(hl)
   5319                    1232 00118$:
   5319 18 06         [12] 1233 	jr	00101$
   531B 18 09         [12] 1234 	jr	00102$
   531D 18 0C         [12] 1235 	jr	00103$
   531F 18 16         [12] 1236 	jr	00104$
   5321                    1237 00101$:
   5321 CD BA 51      [17] 1238 	call	_quieto_entrar
   5324 18 1C         [12] 1239 	jr	00105$
                           1240 ;src/main.c:400: case 1: prepSalto_entrar(); break;
   5326                    1241 00102$:
   5326 CD 86 52      [17] 1242 	call	_prepSalto_entrar
   5329 18 17         [12] 1243 	jr	00105$
                           1244 ;src/main.c:401: case 2: moverDerecha();   andando_animar(M_derecha);   break;
   532B                    1245 00103$:
   532B CD 91 50      [17] 1246 	call	_moverDerecha
   532E AF            [ 4] 1247 	xor	a, a
   532F F5            [11] 1248 	push	af
   5330 33            [ 6] 1249 	inc	sp
   5331 CD E5 52      [17] 1250 	call	_andando_animar
   5334 33            [ 6] 1251 	inc	sp
   5335 18 0B         [12] 1252 	jr	00105$
                           1253 ;src/main.c:402: case 3: moverIzquierda(); andando_animar(M_izquierda); break;
   5337                    1254 00104$:
   5337 CD B8 50      [17] 1255 	call	_moverIzquierda
   533A 3E 01         [ 7] 1256 	ld	a,#0x01
   533C F5            [11] 1257 	push	af
   533D 33            [ 6] 1258 	inc	sp
   533E CD E5 52      [17] 1259 	call	_andando_animar
   5341 33            [ 6] 1260 	inc	sp
                           1261 ;src/main.c:403: }
   5342                    1262 00105$:
                           1263 ;src/main.c:404: prota.mover = SI;
   5342 21 DF 4D      [10] 1264 	ld	hl,#(_prota + 0x0004)
   5345 36 01         [10] 1265 	ld	(hl),#0x01
                           1266 ;src/main.c:405: if (!sobreSuelo())
   5347 CD FF 4F      [17] 1267 	call	_sobreSuelo
   534A 7D            [ 4] 1268 	ld	a,l
   534B B7            [ 4] 1269 	or	a, a
   534C C0            [11] 1270 	ret	NZ
                           1271 ;src/main.c:406: cayendo_entrar();
   534D C3 3E 51      [10] 1272 	jp  _cayendo_entrar
   5350                    1273 _andando_keys_1_139:
   5350 00 01              1274 	.dw #0x0100
   5352 00 02              1275 	.dw #0x0200
   5354 01 01              1276 	.dw #0x0101
                           1277 ;src/main.c:409: void ejecutarEstado() {
                           1278 ;	---------------------------------
                           1279 ; Function ejecutarEstado
                           1280 ; ---------------------------------
   5356                    1281 _ejecutarEstado::
                           1282 ;src/main.c:410: switch(prota.estado) {
   5356 21 E0 4D      [10] 1283 	ld	hl, #(_prota + 0x0005) + 0
   5359 5E            [ 7] 1284 	ld	e,(hl)
   535A 3E 05         [ 7] 1285 	ld	a,#0x05
   535C 93            [ 4] 1286 	sub	a, e
   535D D8            [11] 1287 	ret	C
   535E 16 00         [ 7] 1288 	ld	d,#0x00
   5360 21 66 53      [10] 1289 	ld	hl,#00114$
   5363 19            [11] 1290 	add	hl,de
   5364 19            [11] 1291 	add	hl,de
                           1292 ;src/main.c:411: case ST_quieto:      quieto();      break;
   5365 E9            [ 4] 1293 	jp	(hl)
   5366                    1294 00114$:
   5366 18 0A         [12] 1295 	jr	00101$
   5368 18 0B         [12] 1296 	jr	00102$
   536A 18 0C         [12] 1297 	jr	00103$
   536C 18 0D         [12] 1298 	jr	00104$
   536E 18 0E         [12] 1299 	jr	00105$
   5370 18 0F         [12] 1300 	jr	00106$
   5372                    1301 00101$:
   5372 C3 C5 51      [10] 1302 	jp  _quieto
                           1303 ;src/main.c:412: case ST_andando:     andando();     break;
   5375                    1304 00102$:
   5375 C3 FE 52      [10] 1305 	jp  _andando
                           1306 ;src/main.c:413: case ST_prepSalto:   prepSalto();   break;
   5378                    1307 00103$:
   5378 C3 A2 52      [10] 1308 	jp  _prepSalto
                           1309 ;src/main.c:414: case ST_saltando:    saltando();    break;
   537B                    1310 00104$:
   537B C3 43 52      [10] 1311 	jp  _saltando
                           1312 ;src/main.c:415: case ST_cayendo:     cayendo();     break;
   537E                    1313 00105$:
   537E C3 75 51      [10] 1314 	jp  _cayendo
                           1315 ;src/main.c:416: case ST_aterrizando: aterrizando(); break;
   5381                    1316 00106$:
                           1317 ;src/main.c:417: }
   5381 C3 2D 51      [10] 1318 	jp  _aterrizando
                           1319 ;src/main.c:420: void inicializar() {
                           1320 ;	---------------------------------
                           1321 ; Function inicializar
                           1322 ; ---------------------------------
   5384                    1323 _inicializar::
                           1324 ;src/main.c:421: cpct_disableFirmware();
   5384 CD 20 4D      [17] 1325 	call	_cpct_disableFirmware
                           1326 ;src/main.c:422: cpct_setVideoMode(0);
   5387 2E 00         [ 7] 1327 	ld	l,#0x00
   5389 CD E9 44      [17] 1328 	call	_cpct_setVideoMode
                           1329 ;src/main.c:423: cpct_setPalette(g_palette, 16);
   538C 21 10 00      [10] 1330 	ld	hl,#0x0010
   538F E5            [11] 1331 	push	hl
   5390 21 98 41      [10] 1332 	ld	hl,#_g_palette
   5393 E5            [11] 1333 	push	hl
   5394 CD 70 42      [17] 1334 	call	_cpct_setPalette
                           1335 ;src/main.c:424: cpct_setBorder(HW_BLACK);
   5397 21 10 14      [10] 1336 	ld	hl,#0x1410
   539A E5            [11] 1337 	push	hl
   539B CD 93 42      [17] 1338 	call	_cpct_setPALColour
                           1339 ;src/main.c:425: cpct_etm_setTileset2x4(g_tileset);
   539E 21 A8 41      [10] 1340 	ld	hl,#_g_tileset
   53A1 CD D3 43      [17] 1341 	call	_cpct_etm_setTileset2x4
                           1342 ;src/main.c:426: cpct_drawSprite(g_retropolis_0, cpctm_screenPtr(CPCT_VMEM_START,  0, 0), G_RETROPOLIS_0_W, G_RETROPOLIS_0_H);
   53A4 21 28 42      [10] 1343 	ld	hl,#0x4228
   53A7 E5            [11] 1344 	push	hl
   53A8 21 00 C0      [10] 1345 	ld	hl,#0xC000
   53AB E5            [11] 1346 	push	hl
   53AC 21 78 1F      [10] 1347 	ld	hl,#_g_retropolis_0
   53AF E5            [11] 1348 	push	hl
   53B0 CD 9F 42      [17] 1349 	call	_cpct_drawSprite
                           1350 ;src/main.c:427: cpct_drawSprite(g_retropolis_1, cpctm_screenPtr(CPCT_VMEM_START, 40, 0), G_RETROPOLIS_0_W, G_RETROPOLIS_0_H);
   53B3 21 28 42      [10] 1351 	ld	hl,#0x4228
   53B6 E5            [11] 1352 	push	hl
   53B7 26 C0         [ 7] 1353 	ld	h, #0xC0
   53B9 E5            [11] 1354 	push	hl
   53BA 21 C8 29      [10] 1355 	ld	hl,#_g_retropolis_1
   53BD E5            [11] 1356 	push	hl
   53BE CD 9F 42      [17] 1357 	call	_cpct_drawSprite
                           1358 ;src/main.c:428: mapa = g_map1;
   53C1 21 50 1A      [10] 1359 	ld	hl,#_g_map1+0
   53C4 22 D8 4D      [16] 1360 	ld	(_mapa),hl
                           1361 ;src/main.c:429: num_mapa = 0;
   53C7 21 DA 4D      [10] 1362 	ld	hl,#_num_mapa + 0
   53CA 36 00         [10] 1363 	ld	(hl), #0x00
                           1364 ;src/main.c:430: prota.x = prota.px = 0;
   53CC 21 DD 4D      [10] 1365 	ld	hl,#(_prota + 0x0002)
   53CF 36 00         [10] 1366 	ld	(hl),#0x00
   53D1 21 DB 4D      [10] 1367 	ld	hl,#_prota
   53D4 36 00         [10] 1368 	ld	(hl),#0x00
                           1369 ;src/main.c:431: prota.y = prota.py = 100;
   53D6 21 DE 4D      [10] 1370 	ld	hl,#(_prota + 0x0003)
   53D9 36 64         [10] 1371 	ld	(hl),#0x64
   53DB 21 DC 4D      [10] 1372 	ld	hl,#(_prota + 0x0001)
   53DE 36 64         [10] 1373 	ld	(hl),#0x64
                           1374 ;src/main.c:432: prota.estado = ST_quieto;
   53E0 21 E0 4D      [10] 1375 	ld	hl,#(_prota + 0x0005)
   53E3 36 00         [10] 1376 	ld	(hl),#0x00
                           1377 ;src/main.c:433: prota.mira   = M_derecha;
   53E5 21 E4 4D      [10] 1378 	ld	hl,#(_prota + 0x0009)
   53E8 36 00         [10] 1379 	ld	(hl),#0x00
                           1380 ;src/main.c:434: prota.nframe = 0;
   53EA 21 E3 4D      [10] 1381 	ld	hl,#(_prota + 0x0008)
   53ED 36 00         [10] 1382 	ld	(hl),#0x00
                           1383 ;src/main.c:435: prota.mover  = NO;
   53EF 21 DF 4D      [10] 1384 	ld	hl,#(_prota + 0x0004)
   53F2 36 00         [10] 1385 	ld	(hl),#0x00
                           1386 ;src/main.c:436: prota.frame  = &g_frames[0];
   53F4 21 FD 4D      [10] 1387 	ld	hl,#_g_frames
   53F7 22 E1 4D      [16] 1388 	ld	((_prota + 0x0006)), hl
                           1389 ;src/main.c:437: dibujarMapa();
   53FA CD 5F 4E      [17] 1390 	call	_dibujarMapa
                           1391 ;src/main.c:438: dibujarProta();
   53FD CD 17 4F      [17] 1392 	call	_dibujarProta
                           1393 ;src/main.c:439: cpct_akp_musicInit(G_song);
   5400 21 00 02      [10] 1394 	ld	hl,#_G_song
   5403 E5            [11] 1395 	push	hl
   5404 CD FC 4B      [17] 1396 	call	_cpct_akp_musicInit
   5407 F1            [10] 1397 	pop	af
                           1398 ;src/main.c:440: cpct_setInterruptHandler(interrupcion);
   5408 21 49 4E      [10] 1399 	ld	hl,#_interrupcion
   540B CD AD 4D      [17] 1400 	call	_cpct_setInterruptHandler
   540E C9            [10] 1401 	ret
                           1402 ;src/main.c:443: void main(void) {
                           1403 ;	---------------------------------
                           1404 ; Function main
                           1405 ; ---------------------------------
   540F                    1406 _main::
                           1407 ;src/main.c:444: inicializar();
   540F CD 84 53      [17] 1408 	call	_inicializar
                           1409 ;src/main.c:447: while (1) {
   5412                    1410 00104$:
                           1411 ;src/main.c:448: ejecutarEstado();
   5412 CD 56 53      [17] 1412 	call	_ejecutarEstado
                           1413 ;src/main.c:449: if (prota.mover) {
   5415 3A DF 4D      [13] 1414 	ld	a, (#(_prota + 0x0004) + 0)
   5418 B7            [ 4] 1415 	or	a, a
   5419 28 F7         [12] 1416 	jr	Z,00104$
                           1417 ;src/main.c:450: seleccionarSpriteProta();
   541B CD BD 4E      [17] 1418 	call	_seleccionarSpriteProta
                           1419 ;src/main.c:451: cpct_waitVSYNC();
   541E CD E1 44      [17] 1420 	call	_cpct_waitVSYNC
                           1421 ;src/main.c:452: redibujarProta();
   5421 CD CC 50      [17] 1422 	call	_redibujarProta
                           1423 ;src/main.c:453: prota.mover = NO;
   5424 21 DF 4D      [10] 1424 	ld	hl,#(_prota + 0x0004)
   5427 36 00         [10] 1425 	ld	(hl),#0x00
   5429 18 E7         [12] 1426 	jr	00104$
                           1427 	.area _CODE
                           1428 	.area _INITIALIZER
                           1429 	.area _CABS (ABS)
