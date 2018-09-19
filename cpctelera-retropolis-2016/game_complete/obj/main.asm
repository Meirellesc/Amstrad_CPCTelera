;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _inicializar
	.globl _ejecutarEstado
	.globl _andando
	.globl _andando_animar
	.globl _prepSalto
	.globl _prepSalto_animar
	.globl _saltando
	.globl _saltando_entrar
	.globl _ascender
	.globl _quieto
	.globl _cayendo
	.globl _descender
	.globl _cayendo_entrar
	.globl _aterrizando
	.globl _aterrizando_entrar
	.globl _compruebaTeclas
	.globl _redibujarProta
	.globl _moverIzquierda
	.globl _moverDerecha
	.globl _retrocederMapa
	.globl _avanzarMapa
	.globl _sobreSuelo
	.globl _ajustarAlSuelo
	.globl _obtenerTilePtr
	.globl _borrarProta
	.globl _dibujarProta
	.globl _seleccionarSpriteProta
	.globl _girarFrame
	.globl _asignarFrame
	.globl _dibujarMapa
	.globl _interrupcion
	.globl _playmusic
	.globl _cpct_etm_setTileset2x4
	.globl _cpct_etm_drawTileBox2x4
	.globl _cpct_akp_musicInit
	.globl _cpct_getScreenPtr
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_waitVSYNC
	.globl _cpct_setVideoMode
	.globl _cpct_hflipSpriteM0
	.globl _cpct_drawSpriteMaskedAlignedTable
	.globl _cpct_drawSprite
	.globl _cpct_get2Bits
	.globl _cpct_isAnyKeyPressed
	.globl _cpct_isKeyPressed
	.globl _cpct_scanKeyboard_if
	.globl _cpct_setInterruptHandler
	.globl _cpct_disableFirmware
	.globl _prota
	.globl _num_mapa
	.globl _mapa
	.globl _EEstados
	.globl _EEventos
	.globl _EMirar
	.globl _g_tablaSalto
	.globl _anim_caer
	.globl _anim_saltar
	.globl _anim_andar
	.globl _g_frames
	.globl _mapas
	.globl _G_song
	.globl _quieto_entrar
	.globl _prepSalto_entrar
	.globl _andando_entrar
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_EMirar::
	.ds 1
_EEventos::
	.ds 1
_EEstados::
	.ds 1
_mapa::
	.ds 2
_num_mapa::
	.ds 1
_prota::
	.ds 11
_interrupcion_kk_1_78:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:125: cpctm_createTransparentMaskTable(g_tablatrans, 0x100, M0, 0);
;	---------------------------------
; Function dummy_cpct_transparentMaskTable0M0_container
; ---------------------------------
_dummy_cpct_transparentMaskTable0M0_container::
	.area _g_tablatrans_ (ABS) 
	.org 0x100 
	 _g_tablatrans::
	.db 0xFF, 0xAA, 0x55, 0x00, 0xAA, 0xAA, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 
	.area _CSEG (REL, CON) 
;src/main.c:131: void playmusic() {
;	---------------------------------
; Function playmusic
; ---------------------------------
_playmusic::
;src/main.c:146: __endasm;
	exx
	.db	#0x08
	push	af
	push	bc
	push	de
	push	hl
	call	_cpct_akp_musicPlay
	pop	hl
	pop	de
	pop	bc
	pop	af
	.db	#0x08
	exx
	ret
_G_song	=	0x0200
_mapas:
	.dw _g_map1
	.dw _g_map2
	.dw _g_map3
_g_frames:
	.db #0x00	; 0
	.dw _g_hero_00
	.db #0x00	; 0
	.dw _g_hero_01
	.db #0x00	; 0
	.dw _g_hero_02
	.db #0x00	; 0
	.dw _g_hero_03
	.db #0x00	; 0
	.dw _g_hero_04
	.db #0x00	; 0
	.dw _g_hero_05
	.db #0x00	; 0
	.dw _g_hero_06
	.db #0x00	; 0
	.dw _g_hero_07
	.db #0x00	; 0
	.dw _g_hero_08
	.db #0x00	; 0
	.dw _g_hero_09
	.db #0x00	; 0
	.dw _g_hero_10
	.db #0x00	; 0
	.dw _g_hero_11
	.db #0x00	; 0
	.dw _g_hero_12
	.db #0x00	; 0
	.dw _g_hero_13
	.db #0x00	; 0
	.dw _g_hero_14
	.db #0x00	; 0
	.dw _g_hero_15
_anim_andar:
	.dw (_g_frames + 3)
	.dw (_g_frames + 6)
	.dw (_g_frames + 9)
	.dw (_g_frames + 12)
	.dw (_g_frames + 15)
_anim_saltar:
	.dw (_g_frames + 24)
	.dw (_g_frames + 27)
	.dw (_g_frames + 30)
	.dw (_g_frames + 33)
_anim_caer:
	.dw (_g_frames + 42)
	.dw (_g_frames + 45)
_g_tablaSalto:
	.db #0xFF	; 255
	.db #0xFA	; 250
	.db #0xA9	; 169
	.db #0x55	; 85	'U'
	.db #0x40	; 64
	.db 0x00
;src/main.c:149: void interrupcion() {
;	---------------------------------
; Function interrupcion
; ---------------------------------
_interrupcion::
;src/main.c:152: if (++kk == 5) {
	ld	hl, #_interrupcion_kk_1_78+0
	inc	(hl)
	ld	a,(#_interrupcion_kk_1_78 + 0)
	sub	a, #0x05
	ret	NZ
;src/main.c:153: playmusic();
	call	_playmusic
;src/main.c:154: cpct_scanKeyboard_if();
	call	_cpct_scanKeyboard_if
;src/main.c:155: kk = 0;
	ld	hl,#_interrupcion_kk_1_78 + 0
	ld	(hl), #0x00
	ret
;src/main.c:159: void dibujarMapa() {
;	---------------------------------
; Function dibujarMapa
; ---------------------------------
_dibujarMapa::
;src/main.c:160: cpct_etm_drawTilemap2x4(g_map1_W, g_map1_H, ORIGEN_MAPA, mapa);
	ld	hl,(_mapa)
	push	hl
	ld	hl,#0xE280
	push	hl
	ld	hl,#0x2821
	push	hl
	ld	l, #0x00
	push	hl
	xor	a, a
	push	af
	inc	sp
	call	_cpct_etm_drawTileBox2x4
	ret
;src/main.c:163: void asignarFrame(TFrame **animacion) {
;	---------------------------------
; Function asignarFrame
; ---------------------------------
_asignarFrame::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/main.c:164: prota.frame = animacion[prota.nframe / ANIM_PAUSA];
	ld	hl, #_prota + 8
	ld	l,(hl)
	srl	l
	srl	l
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	l,4 (ix)
	ld	h,5 (ix)
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	((_prota + 0x0006)), bc
	pop	ix
	ret
;src/main.c:167: void girarFrame() {
;	---------------------------------
; Function girarFrame
; ---------------------------------
_girarFrame::
;src/main.c:168: TFrame* f = prota.frame;
	ld	bc, (#_prota + 6)
;src/main.c:169: if (f->mira != prota.mira) {
	ld	a,(bc)
	ld	e,a
	ld	hl, #(_prota + 0x0009) + 0
	ld	d,(hl)
	ld	a,e
	sub	a, d
	ret	Z
;src/main.c:170: cpct_hflipSpriteM0(G_HERO_00_W, G_HERO_00_H, f->sprite);
	ld	l, c
	ld	h, b
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	push	de
	ld	hl,#0x1B08
	push	hl
	call	_cpct_hflipSpriteM0
	pop	bc
;src/main.c:171: f->mira = prota.mira;
	ld	a, (#(_prota + 0x0009) + 0)
	ld	(bc),a
	ret
;src/main.c:175: void seleccionarSpriteProta() {
;	---------------------------------
; Function seleccionarSpriteProta
; ---------------------------------
_seleccionarSpriteProta::
;src/main.c:176: switch(prota.estado) {
	ld	hl, #_prota + 5
	ld	e,(hl)
	ld	a,#0x05
	sub	a, e
	jp	C,_girarFrame
;src/main.c:177: case ST_quieto:      { prota.frame = &g_frames[0];  break; }
;src/main.c:176: switch(prota.estado) {
	ld	d,#0x00
	ld	hl,#00114$
	add	hl,de
	add	hl,de
;src/main.c:177: case ST_quieto:      { prota.frame = &g_frames[0];  break; }
	jp	(hl)
00114$:
	jr	00101$
	jr	00102$
	jr	00103$
	jr	00104$
	jr	00105$
	jr	00106$
00101$:
	ld	hl,#_g_frames
	ld	((_prota + 0x0006)), hl
	jp	_girarFrame
;src/main.c:178: case ST_andando:     { asignarFrame(anim_andar);    break; }
00102$:
	ld	hl,#_anim_andar
	push	hl
	call	_asignarFrame
	pop	af
	jp	_girarFrame
;src/main.c:179: case ST_prepSalto:   { asignarFrame(anim_saltar);   break; }
00103$:
	ld	hl,#_anim_saltar
	push	hl
	call	_asignarFrame
	pop	af
	jp	_girarFrame
;src/main.c:180: case ST_saltando:    { prota.frame = &g_frames[12]; break; }
00104$:
	ld	hl,#(_g_frames + 0x0024)
	ld	((_prota + 0x0006)), hl
	jp	_girarFrame
;src/main.c:181: case ST_cayendo:     { prota.frame = &g_frames[13]; break; }
00105$:
	ld	hl,#(_g_frames + 0x0027)
	ld	((_prota + 0x0006)), hl
	jp	_girarFrame
;src/main.c:182: case ST_aterrizando: { asignarFrame(anim_caer);     break; }
00106$:
	ld	hl,#_anim_caer
	push	hl
	call	_asignarFrame
	pop	af
;src/main.c:183: }
;src/main.c:184: girarFrame();
	jp  _girarFrame
;src/main.c:187: void dibujarProta() {
;	---------------------------------
; Function dibujarProta
; ---------------------------------
_dibujarProta::
;src/main.c:188: u8* pvmem = cpct_getScreenPtr(CPCT_VMEM_START, prota.x, prota.y);
	ld	hl, #_prota + 1
	ld	d,(hl)
	ld	hl, #_prota + 0
	ld	b,(hl)
	push	de
	inc	sp
	push	bc
	inc	sp
	ld	hl,#0xC000
	push	hl
	call	_cpct_getScreenPtr
	ex	de,hl
;src/main.c:189: cpct_drawSpriteMaskedAlignedTable(prota.frame->sprite, pvmem, G_HERO_00_W, G_HERO_00_H, g_tablatrans);
	ld	hl, (#_prota + 6)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#_g_tablatrans
	push	hl
	ld	hl,#0x1B08
	push	hl
	push	de
	push	bc
	call	_cpct_drawSpriteMaskedAlignedTable
	ret
;src/main.c:192: void borrarProta() {
;	---------------------------------
; Function borrarProta
; ---------------------------------
_borrarProta::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/main.c:193: u8 w = 4 + (prota.px & 1);
	ld	hl, #_prota + 2
	ld	c,(hl)
	ld	a,c
	and	a, #0x01
	ld	b,a
	inc	b
	inc	b
	inc	b
	inc	b
;src/main.c:194: u8 h = 7 + (prota.py & 3 ? 1 : 0);
	ld	hl, #_prota + 3
	ld	e,(hl)
	ld	a,e
	and	a, #0x03
	jr	Z,00103$
	ld	a,#0x01
	jr	00104$
00103$:
	ld	a,#0x00
00104$:
	add	a, #0x07
	ld	-3 (ix),a
;src/main.c:195: cpct_etm_drawTileBox2x4(prota.px / 2, (prota.py-ORIGEN_MAPA_Y) / 4, w, h, 40, ORIGEN_MAPA, mapa);
	ld	iy,(_mapa)
	ld	d,#0x00
	ld	a,e
	add	a,#0xBC
	ld	-2 (ix),a
	ld	a,d
	adc	a,#0xFF
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	bit	7, -1 (ix)
	jr	Z,00105$
	ld	hl,#0xFFBF
	add	hl,de
00105$:
	sra	h
	rr	l
	sra	h
	rr	l
	ld	d,l
	srl	c
	push	iy
	ld	hl,#0xE280
	push	hl
	ld	a,#0x28
	push	af
	inc	sp
	ld	a,-3 (ix)
	push	af
	inc	sp
	push	bc
	inc	sp
	push	de
	inc	sp
	ld	a,c
	push	af
	inc	sp
	call	_cpct_etm_drawTileBox2x4
	ld	sp, ix
	pop	ix
	ret
;src/main.c:198: u8* obtenerTilePtr(u8 x, u8 y) {
;	---------------------------------
; Function obtenerTilePtr
; ---------------------------------
_obtenerTilePtr::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/main.c:199: return mapa + (y-ORIGEN_MAPA_Y)/4*g_map1_W + x/2;
	ld	c,5 (ix)
	ld	b,#0x00
	ld	a,c
	add	a,#0xBC
	ld	e,a
	ld	a,b
	adc	a,#0xFF
	ld	d,a
	ld	l, e
	ld	h, d
	bit	7, d
	jr	Z,00103$
	ld	hl,#0xFFBF
	add	hl,bc
00103$:
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
	ld	b, h
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c,l
	ld	b,h
	ld	hl,(_mapa)
	add	hl,bc
	ld	c,4 (ix)
	srl	c
	ld	e,c
	ld	d,#0x00
	add	hl,de
	pop	ix
	ret
;src/main.c:202: void ajustarAlSuelo() {
;	---------------------------------
; Function ajustarAlSuelo
; ---------------------------------
_ajustarAlSuelo::
;src/main.c:203: prota.y = (prota.y & 0b11111100) + 1;
	ld	bc,#_prota+1
	ld	a,(bc)
	and	a, #0xFC
	inc	a
	ld	(bc),a
	ret
;src/main.c:206: u8 sobreSuelo() {
;	---------------------------------
; Function sobreSuelo
; ---------------------------------
_sobreSuelo::
;src/main.c:207: u8* tileSuelo = obtenerTilePtr(prota.x+2, prota.y + ALTOPROTA+1);
	ld	a, (#_prota + 1)
	add	a, #0x1C
	ld	d,a
	ld	hl, #_prota + 0
	ld	b,(hl)
	inc	b
	inc	b
	push	de
	inc	sp
	push	bc
	inc	sp
	call	_obtenerTilePtr
	pop	af
;src/main.c:208: if (*tileSuelo < 4 || *(tileSuelo+G_HERO_00_W/2-3) < 4)
	ld	a, (hl)
	sub	a, #0x04
	jr	C,00101$
	inc	hl
	ld	a, (hl)
	sub	a, #0x04
	jr	NC,00102$
00101$:
;src/main.c:209: return 1;
	ld	l,#0x01
	ret
00102$:
;src/main.c:211: return 0;
	ld	l,#0x00
	ret
;src/main.c:214: void avanzarMapa() {
;	---------------------------------
; Function avanzarMapa
; ---------------------------------
_avanzarMapa::
;src/main.c:215: if (num_mapa < NUM_MAPAS-1) {
	ld	a,(#_num_mapa + 0)
	sub	a, #0x02
	ret	NC
;src/main.c:216: mapa = mapas[++num_mapa];
	ld	bc,#_mapas+0
	ld	hl, #_num_mapa+0
	inc	(hl)
	ld	iy,#_num_mapa
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	a,(hl)
	ld	iy,#_mapa
	ld	0 (iy),a
	inc	hl
	ld	a,(hl)
	ld	(#_mapa + 1),a
;src/main.c:217: prota.x = prota.px = 0;
	ld	hl,#(_prota + 0x0002)
	ld	(hl),#0x00
	ld	hl,#_prota
	ld	(hl),#0x00
;src/main.c:218: prota.mover = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
;src/main.c:219: dibujarMapa();
	jp  _dibujarMapa
;src/main.c:223: void retrocederMapa() {
;	---------------------------------
; Function retrocederMapa
; ---------------------------------
_retrocederMapa::
;src/main.c:224: if (num_mapa > 0) {
	ld	a,(#_num_mapa + 0)
	or	a, a
	ret	Z
;src/main.c:225: mapa = mapas[--num_mapa];
	ld	bc,#_mapas+0
	ld	hl, #_num_mapa+0
	dec	(hl)
	ld	iy,#_num_mapa
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	a,(hl)
	ld	iy,#_mapa
	ld	0 (iy),a
	inc	hl
	ld	a,(hl)
	ld	(#_mapa + 1),a
;src/main.c:226: prota.x = prota.px = ANCHO - G_HERO_00_W;
	ld	hl,#(_prota + 0x0002)
	ld	(hl),#0x48
	ld	hl,#_prota
	ld	(hl),#0x48
;src/main.c:227: prota.mover = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
;src/main.c:228: dibujarMapa();
	jp  _dibujarMapa
;src/main.c:232: void moverDerecha() { 
;	---------------------------------
; Function moverDerecha
; ---------------------------------
_moverDerecha::
;src/main.c:233: if (prota.x + G_HERO_00_W < ANCHO) {
	ld	hl, #_prota + 0
	ld	c,(hl)
	ld	e,c
	ld	d,#0x00
	ld	hl,#0x0008
	add	hl,de
	ld	de, #0x8050
	add	hl, hl
	ccf
	rr	h
	rr	l
	sbc	hl, de
	jp	NC,_avanzarMapa
;src/main.c:234: prota.x++;
	inc	c
	ld	hl,#_prota
	ld	(hl),c
;src/main.c:235: prota.mira  = M_derecha;
	ld	hl,#(_prota + 0x0009)
	ld	(hl),#0x00
	ret
;src/main.c:237: avanzarMapa();
	jp  _avanzarMapa
;src/main.c:241: void moverIzquierda() {
;	---------------------------------
; Function moverIzquierda
; ---------------------------------
_moverIzquierda::
;src/main.c:242: if (prota.x > 0) {
	ld	bc,#_prota+0
	ld	a,(bc)
	or	a, a
	jp	Z,_retrocederMapa
;src/main.c:243: prota.x--;
	add	a,#0xFF
	ld	(bc),a
;src/main.c:244: prota.mira  = M_izquierda;
	ld	hl,#(_prota + 0x0009)
	ld	(hl),#0x01
	ret
;src/main.c:246: retrocederMapa();
	jp  _retrocederMapa
;src/main.c:250: void redibujarProta() {
;	---------------------------------
; Function redibujarProta
; ---------------------------------
_redibujarProta::
;src/main.c:251: borrarProta();
	call	_borrarProta
;src/main.c:252: prota.px = prota.x;
	ld	bc,#_prota + 2
	ld	a, (#_prota + 0)
	ld	(bc),a
;src/main.c:253: prota.py = prota.y;
	ld	bc,#_prota + 3
	ld	a, (#_prota + 1)
	ld	(bc),a
;src/main.c:254: dibujarProta();
	jp  _dibujarProta
;src/main.c:257: u8 compruebaTeclas(const cpct_keyID* k, u8 numk) {
;	---------------------------------
; Function compruebaTeclas
; ---------------------------------
_compruebaTeclas::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/main.c:260: if (cpct_isAnyKeyPressed()) {
	call	_cpct_isAnyKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00105$
;src/main.c:261: for(i=1; i <= numk; i++, k++) {
	ld	bc,#0x0101
	ld	e,4 (ix)
	ld	d,5 (ix)
00107$:
	ld	a,6 (ix)
	sub	a, b
	jr	C,00105$
;src/main.c:262: if (cpct_isKeyPressed(*k))
	ld	l, e
	ld	h, d
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	bc
	push	de
	call	_cpct_isKeyPressed
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00108$
;src/main.c:263: return i;
	ld	l,c
	jr	00109$
00108$:
;src/main.c:261: for(i=1; i <= numk; i++, k++) {
	inc	b
	ld	c,b
	inc	de
	inc	de
	jr	00107$
00105$:
;src/main.c:266: return 0;
	ld	l,#0x00
00109$:
	pop	ix
	ret
;src/main.c:271: void aterrizando_entrar() {
;	---------------------------------
; Function aterrizando_entrar
; ---------------------------------
_aterrizando_entrar::
;src/main.c:272: prota.nframe = 0;
	ld	hl,#(_prota + 0x0008)
	ld	(hl),#0x00
;src/main.c:273: prota.estado = ST_aterrizando;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x05
;src/main.c:274: prota.mover  = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
;src/main.c:277: void aterrizando() {
;	---------------------------------
; Function aterrizando
; ---------------------------------
_aterrizando::
;src/main.c:278: prota.mover = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
;src/main.c:279: if(++prota.nframe == CAER_FRAMES*ANIM_PAUSA)
	ld	bc,#_prota + 8
	ld	a,(bc)
	inc	a
	ld	(bc),a
	sub	a, #0x08
	ret	NZ
;src/main.c:280: quieto_entrar();      
	jp  _quieto_entrar
;src/main.c:283: void cayendo_entrar() {
;	---------------------------------
; Function cayendo_entrar
; ---------------------------------
_cayendo_entrar::
;src/main.c:284: prota.estado = ST_cayendo;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x04
;src/main.c:285: prota.mover  = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
;src/main.c:286: prota.salto  = PASOS_SALTO - 3;
	ld	hl,#(_prota + 0x000a)
	ld	(hl),#0x11
	ret
;src/main.c:289: void descender() {
;	---------------------------------
; Function descender
; ---------------------------------
_descender::
;src/main.c:290: prota.y += cpct_get2Bits(g_tablaSalto, prota.salto);
	ld	hl, #(_prota + 0x0001) + 0
	ld	c,(hl)
	ld	hl, #(_prota + 0x000a) + 0
	ld	e,(hl)
	ld	d,#0x00
	push	bc
	push	de
	ld	hl,#_g_tablaSalto
	push	hl
	call	_cpct_get2Bits
	pop	bc
	ld	a,c
	add	a, l
	ld	(#(_prota + 0x0001)),a
;src/main.c:291: if (prota.salto > 1)
	ld	hl, #(_prota + 0x000a) + 0
	ld	c,(hl)
	ld	a,#0x01
	sub	a, c
	ret	NC
;src/main.c:292: prota.salto--;
	dec	c
	ld	hl,#(_prota + 0x000a)
	ld	(hl),c
	ret
;src/main.c:295: void cayendo() {
;	---------------------------------
; Function cayendo
; ---------------------------------
_cayendo::
;src/main.c:297: u8 k = compruebaTeclas(keys, 2);
	ld	a,#0x02
	push	af
	inc	sp
	ld	hl,#_cayendo_keys_1_118
	push	hl
	call	_compruebaTeclas
	pop	af
	inc	sp
	ld	e,l
;src/main.c:298: switch(k) {
	ld	a,#0x02
	sub	a, e
	jr	C,00104$
	ld	d,#0x00
	ld	hl,#00117$
	add	hl,de
	add	hl,de
;src/main.c:299: case 0: break; // Nada que hacer
;src/main.c:300: case 1: moverDerecha();   break;
	jp	(hl)
00117$:
	jr	00104$
	jr	00102$
	jr	00103$
	jr	00104$
00102$:
	call	_moverDerecha
	jr	00104$
;src/main.c:301: case 2: moverIzquierda(); break;
00103$:
	call	_moverIzquierda
;src/main.c:302: }
00104$:
;src/main.c:303: descender();
	call	_descender
;src/main.c:304: if (sobreSuelo()) {
	call	_sobreSuelo
	ld	a,l
	or	a, a
	jr	Z,00106$
;src/main.c:305: ajustarAlSuelo();
	call	_ajustarAlSuelo
;src/main.c:306: aterrizando_entrar();
	call	_aterrizando_entrar
00106$:
;src/main.c:308: prota.mover=SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
_cayendo_keys_1_118:
	.dw #0x0200
	.dw #0x0101
;src/main.c:311: void quieto_entrar() {
;	---------------------------------
; Function quieto_entrar
; ---------------------------------
_quieto_entrar::
;src/main.c:312: prota.estado = ST_quieto;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x00
;src/main.c:313: prota.mover  = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
;src/main.c:319: void quieto() {
;	---------------------------------
; Function quieto
; ---------------------------------
_quieto::
;src/main.c:321: u8 k = compruebaTeclas(keys, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#_quieto_keys_1_123
	push	hl
	call	_compruebaTeclas
	pop	af
	inc	sp
	ld	e,l
;src/main.c:322: switch(k) {
	ld	a,#0x03
	sub	a, e
	ret	C
	ld	d,#0x00
	ld	hl,#00112$
	add	hl,de
	add	hl,de
;src/main.c:323: case 0: break; // Nada que hacer
;src/main.c:324: case 1: prepSalto_entrar(); break;
	jp	(hl)
00112$:
	jr	00106$
	jr	00102$
	jr	00103$
	jr	00104$
	jr	00106$
00102$:
	jp  _prepSalto_entrar
;src/main.c:325: case 2: andando_entrar(M_derecha);   break;
00103$:
	xor	a, a
	push	af
	inc	sp
	call	_andando_entrar
	inc	sp
	ret
;src/main.c:326: case 3: andando_entrar(M_izquierda); break;
00104$:
	ld	a,#0x01
	push	af
	inc	sp
	call	_andando_entrar
	inc	sp
;src/main.c:327: }
00106$:
	ret
_quieto_keys_1_123:
	.dw #0x0100
	.dw #0x0200
	.dw #0x0101
;src/main.c:330: void ascender() {
;	---------------------------------
; Function ascender
; ---------------------------------
_ascender::
;src/main.c:331: prota.y -= cpct_get2Bits(g_tablaSalto, prota.salto);
	ld	hl, #(_prota + 0x0001) + 0
	ld	c,(hl)
	ld	hl, #(_prota + 0x000a) + 0
	ld	e,(hl)
	ld	d,#0x00
	push	bc
	push	de
	ld	hl,#_g_tablaSalto
	push	hl
	call	_cpct_get2Bits
	pop	bc
	ld	a,c
	sub	a, l
	ld	c,a
	ld	hl,#(_prota + 0x0001)
	ld	(hl),c
;src/main.c:332: if (prota.y < ORIGEN_MAPA_Y)
	ld	a,c
	sub	a, #0x44
	jr	NC,00102$
;src/main.c:333: prota.y = ORIGEN_MAPA_Y;
	ld	(hl),#0x44
00102$:
;src/main.c:334: if (++prota.salto == PASOS_SALTO)
	ld	a, (#(_prota + 0x000a) + 0)
	inc	a
	ld	(#(_prota + 0x000a)),a
	sub	a, #0x14
	ret	NZ
;src/main.c:335: cayendo_entrar();
	call	_cayendo_entrar
	ret
;src/main.c:338: void saltando_entrar() {
;	---------------------------------
; Function saltando_entrar
; ---------------------------------
_saltando_entrar::
;src/main.c:339: prota.estado = ST_saltando;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x03
;src/main.c:340: prota.mover  = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
;src/main.c:341: prota.salto  = 0;
	ld	hl,#(_prota + 0x000a)
	ld	(hl),#0x00
	ret
;src/main.c:344: void saltando() {
;	---------------------------------
; Function saltando
; ---------------------------------
_saltando::
;src/main.c:345: if (!cpct_isKeyPressed(Key_CursorUp)) {
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
;src/main.c:346: cayendo_entrar();
	jp	Z,_cayendo_entrar
;src/main.c:349: u8 k = compruebaTeclas(keys, 2);
	ld	a,#0x02
	push	af
	inc	sp
	ld	hl,#_saltando_keys_2_129
	push	hl
	call	_compruebaTeclas
	pop	af
	inc	sp
	ld	e,l
;src/main.c:350: switch(k) {
	ld	a,#0x02
	sub	a, e
	jr	C,00104$
	ld	d,#0x00
	ld	hl,#00118$
	add	hl,de
	add	hl,de
;src/main.c:351: case 0: break;
;src/main.c:352: case 1: moverDerecha();   break;
	jp	(hl)
00118$:
	jr	00104$
	jr	00102$
	jr	00103$
	jr	00104$
00102$:
	call	_moverDerecha
	jr	00104$
;src/main.c:353: case 2: moverIzquierda(); break;
00103$:
	call	_moverIzquierda
;src/main.c:354: }
00104$:
;src/main.c:355: ascender();
	call	_ascender
;src/main.c:356: prota.mover = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
_saltando_keys_2_129:
	.dw #0x0200
	.dw #0x0101
;src/main.c:361: void prepSalto_entrar() {
;	---------------------------------
; Function prepSalto_entrar
; ---------------------------------
_prepSalto_entrar::
;src/main.c:362: prota.nframe = 0;
	ld	hl,#(_prota + 0x0008)
	ld	(hl),#0x00
;src/main.c:363: prota.estado = ST_prepSalto;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x02
;src/main.c:364: prota.mover  = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
;src/main.c:367: void prepSalto_animar() {
;	---------------------------------
; Function prepSalto_animar
; ---------------------------------
_prepSalto_animar::
;src/main.c:368: if (++prota.nframe == SALTAR_FRAMES*ANIM_PAUSA)
	ld	bc,#_prota+8
	ld	a,(bc)
	inc	a
	ld	(bc),a
	sub	a, #0x10
	ret	NZ
;src/main.c:369: saltando_entrar();
	jp  _saltando_entrar
;src/main.c:372: void prepSalto() {
;	---------------------------------
; Function prepSalto
; ---------------------------------
_prepSalto::
;src/main.c:374: u8 k = compruebaTeclas(keys, 1);
	ld	a,#0x01
	push	af
	inc	sp
	ld	hl,#_prepSalto_keys_1_133
	push	hl
	call	_compruebaTeclas
	pop	af
	inc	sp
;src/main.c:375: switch(k) {
	ld	a,l
	or	a, a
	jr	Z,00101$
	dec	l
	jr	Z,00102$
	jr	00103$
;src/main.c:376: case 0: quieto_entrar(); break; 
00101$:
	call	_quieto_entrar
	jr	00103$
;src/main.c:377: case 1: prepSalto_animar(); break;
00102$:
	call	_prepSalto_animar
;src/main.c:378: }
00103$:
;src/main.c:379: prota.mover = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
_prepSalto_keys_1_133:
	.dw #0x0100
;src/main.c:382: void andando_entrar(u8 mirar) {
;	---------------------------------
; Function andando_entrar
; ---------------------------------
_andando_entrar::
;src/main.c:383: prota.nframe = 0;
	ld	hl,#(_prota + 0x0008)
	ld	(hl),#0x00
;src/main.c:384: prota.estado = ST_andando;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x01
;src/main.c:385: prota.mira   = mirar;
	ld	hl,#(_prota + 0x0009)
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	ld	(hl),a
;src/main.c:386: prota.mover  = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
	ret
;src/main.c:389: void andando_animar(u8 mirar) {
;	---------------------------------
; Function andando_animar
; ---------------------------------
_andando_animar::
;src/main.c:390: prota.mira  = mirar;
	ld	hl,#(_prota + 0x0009)
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	ld	(hl),a
;src/main.c:391: if(++prota.nframe == ANDAR_FRAMES*ANIM_PAUSA)
	ld	bc,#_prota + 8
	ld	a,(bc)
	inc	a
	ld	(bc),a
	sub	a, #0x14
	ret	NZ
;src/main.c:392: prota.nframe = 0;
	xor	a, a
	ld	(bc),a
	ret
;src/main.c:395: void andando() {
;	---------------------------------
; Function andando
; ---------------------------------
_andando::
;src/main.c:397: u8 k = compruebaTeclas(keys, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#_andando_keys_1_139
	push	hl
	call	_compruebaTeclas
	pop	af
	inc	sp
	ld	e,l
;src/main.c:398: switch(k) {
	ld	a,#0x03
	sub	a, e
	jr	C,00105$
	ld	d,#0x00
	ld	hl,#00118$
	add	hl,de
	add	hl,de
;src/main.c:399: case 0: quieto_entrar();    break;
	jp	(hl)
00118$:
	jr	00101$
	jr	00102$
	jr	00103$
	jr	00104$
00101$:
	call	_quieto_entrar
	jr	00105$
;src/main.c:400: case 1: prepSalto_entrar(); break;
00102$:
	call	_prepSalto_entrar
	jr	00105$
;src/main.c:401: case 2: moverDerecha();   andando_animar(M_derecha);   break;
00103$:
	call	_moverDerecha
	xor	a, a
	push	af
	inc	sp
	call	_andando_animar
	inc	sp
	jr	00105$
;src/main.c:402: case 3: moverIzquierda(); andando_animar(M_izquierda); break;
00104$:
	call	_moverIzquierda
	ld	a,#0x01
	push	af
	inc	sp
	call	_andando_animar
	inc	sp
;src/main.c:403: }
00105$:
;src/main.c:404: prota.mover = SI;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x01
;src/main.c:405: if (!sobreSuelo())
	call	_sobreSuelo
	ld	a,l
	or	a, a
	ret	NZ
;src/main.c:406: cayendo_entrar();
	jp  _cayendo_entrar
_andando_keys_1_139:
	.dw #0x0100
	.dw #0x0200
	.dw #0x0101
;src/main.c:409: void ejecutarEstado() {
;	---------------------------------
; Function ejecutarEstado
; ---------------------------------
_ejecutarEstado::
;src/main.c:410: switch(prota.estado) {
	ld	hl, #(_prota + 0x0005) + 0
	ld	e,(hl)
	ld	a,#0x05
	sub	a, e
	ret	C
	ld	d,#0x00
	ld	hl,#00114$
	add	hl,de
	add	hl,de
;src/main.c:411: case ST_quieto:      quieto();      break;
	jp	(hl)
00114$:
	jr	00101$
	jr	00102$
	jr	00103$
	jr	00104$
	jr	00105$
	jr	00106$
00101$:
	jp  _quieto
;src/main.c:412: case ST_andando:     andando();     break;
00102$:
	jp  _andando
;src/main.c:413: case ST_prepSalto:   prepSalto();   break;
00103$:
	jp  _prepSalto
;src/main.c:414: case ST_saltando:    saltando();    break;
00104$:
	jp  _saltando
;src/main.c:415: case ST_cayendo:     cayendo();     break;
00105$:
	jp  _cayendo
;src/main.c:416: case ST_aterrizando: aterrizando(); break;
00106$:
;src/main.c:417: }
	jp  _aterrizando
;src/main.c:420: void inicializar() {
;	---------------------------------
; Function inicializar
; ---------------------------------
_inicializar::
;src/main.c:421: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:422: cpct_setVideoMode(0);
	ld	l,#0x00
	call	_cpct_setVideoMode
;src/main.c:423: cpct_setPalette(g_palette, 16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
;src/main.c:424: cpct_setBorder(HW_BLACK);
	ld	hl,#0x1410
	push	hl
	call	_cpct_setPALColour
;src/main.c:425: cpct_etm_setTileset2x4(g_tileset);
	ld	hl,#_g_tileset
	call	_cpct_etm_setTileset2x4
;src/main.c:426: cpct_drawSprite(g_retropolis_0, cpctm_screenPtr(CPCT_VMEM_START,  0, 0), G_RETROPOLIS_0_W, G_RETROPOLIS_0_H);
	ld	hl,#0x4228
	push	hl
	ld	hl,#0xC000
	push	hl
	ld	hl,#_g_retropolis_0
	push	hl
	call	_cpct_drawSprite
;src/main.c:427: cpct_drawSprite(g_retropolis_1, cpctm_screenPtr(CPCT_VMEM_START, 40, 0), G_RETROPOLIS_0_W, G_RETROPOLIS_0_H);
	ld	hl,#0x4228
	push	hl
	ld	h, #0xC0
	push	hl
	ld	hl,#_g_retropolis_1
	push	hl
	call	_cpct_drawSprite
;src/main.c:428: mapa = g_map1;
	ld	hl,#_g_map1+0
	ld	(_mapa),hl
;src/main.c:429: num_mapa = 0;
	ld	hl,#_num_mapa + 0
	ld	(hl), #0x00
;src/main.c:430: prota.x = prota.px = 0;
	ld	hl,#(_prota + 0x0002)
	ld	(hl),#0x00
	ld	hl,#_prota
	ld	(hl),#0x00
;src/main.c:431: prota.y = prota.py = 100;
	ld	hl,#(_prota + 0x0003)
	ld	(hl),#0x64
	ld	hl,#(_prota + 0x0001)
	ld	(hl),#0x64
;src/main.c:432: prota.estado = ST_quieto;
	ld	hl,#(_prota + 0x0005)
	ld	(hl),#0x00
;src/main.c:433: prota.mira   = M_derecha;
	ld	hl,#(_prota + 0x0009)
	ld	(hl),#0x00
;src/main.c:434: prota.nframe = 0;
	ld	hl,#(_prota + 0x0008)
	ld	(hl),#0x00
;src/main.c:435: prota.mover  = NO;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x00
;src/main.c:436: prota.frame  = &g_frames[0];
	ld	hl,#_g_frames
	ld	((_prota + 0x0006)), hl
;src/main.c:437: dibujarMapa();
	call	_dibujarMapa
;src/main.c:438: dibujarProta();
	call	_dibujarProta
;src/main.c:439: cpct_akp_musicInit(G_song);
	ld	hl,#_G_song
	push	hl
	call	_cpct_akp_musicInit
	pop	af
;src/main.c:440: cpct_setInterruptHandler(interrupcion);
	ld	hl,#_interrupcion
	call	_cpct_setInterruptHandler
	ret
;src/main.c:443: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:444: inicializar();
	call	_inicializar
;src/main.c:447: while (1) {
00104$:
;src/main.c:448: ejecutarEstado();
	call	_ejecutarEstado
;src/main.c:449: if (prota.mover) {
	ld	a, (#(_prota + 0x0004) + 0)
	or	a, a
	jr	Z,00104$
;src/main.c:450: seleccionarSpriteProta();
	call	_seleccionarSpriteProta
;src/main.c:451: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:452: redibujarProta();
	call	_redibujarProta
;src/main.c:453: prota.mover = NO;
	ld	hl,#(_prota + 0x0004)
	ld	(hl),#0x00
	jr	00104$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
