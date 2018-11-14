.include "cpctelera.h.s"
.include "colision.h.s"
.include "main.h.s"
.include "entity.h.s"
.include "platform.h.s"
.include "cargar_level.h.s"

level:         .db #0
end_level:     .db #0
 
cargar_nivel:

ld hl, #_g_tileset      ;; Get the tiles
call cpct_etm_setTileset2x4_asm

call carga_todo
    ;; Set Parameters on the stack
push hl              ;; Push ptilemap to the stack
ld   hl, #0xC000 ;; HL = Pointer to video memory location where tilemap is drawn
push hl              ;; Push pvideomem to the stack
;; Set Paramters on registers
ld    a, #40           ;; A = map_width
ld    b, #0x00          ;; B = x tile-coordinate
ld    c, #0x00          ;; C = y tile-coordinate
ld    d, #0x32          ;; H = height in tiles of the tile-box
ld    e, #0x28          ;; L =  width in tiles of the tile-box
call  cpct_etm_drawTileBox2x4_asm ;; Call the function

ret

cargar_nivel2:

ld hl, #_g_tileset      ;; Get the tiles
call cpct_etm_setTileset2x4_asm

ld  hl, #_controls
    ;; Set Parameters on the stack
push hl              ;; Push ptilemap to the stack
ld   hl, #0xC000 ;; HL = Pointer to video memory location where tilemap is drawn
push hl              ;; Push pvideomem to the stack
;; Set Paramters on registers
ld    a, #40           ;; A = map_width
ld    b, #0x00          ;; B = x tile-coordinate
ld    c, #0x00          ;; C = y tile-coordinate
ld    d, #0x32          ;; H = height in tiles of the tile-box
ld    e, #0x28          ;; L =  width in tiles of the tile-box
call  cpct_etm_drawTileBox2x4_asm ;; Call the function

ret
cargar_nivel3:

ld hl, #_g_tileset      ;; Get the tiles
call cpct_etm_setTileset2x4_asm

ld  hl, #_fin
    ;; Set Parameters on the stack
push hl              ;; Push ptilemap to the stack
ld   hl, #0xC000 ;; HL = Pointer to video memory location where tilemap is drawn
push hl              ;; Push pvideomem to the stack
;; Set Paramters on registers
ld    a, #40           ;; A = map_width
ld    b, #0x00          ;; B = x tile-coordinate
ld    c, #0x00          ;; C = y tile-coordinate
ld    d, #0x32          ;; H = height in tiles of the tile-box
ld    e, #0x28          ;; L =  width in tiles of the tile-box
call  cpct_etm_drawTileBox2x4_asm ;; Call the function

ret

carga_todo:
	ld 	a,	(level)
	cp 	#0
	jp 	z, 	elFin
	ld 	a, 	(level)
	cp 	#1
	jp 	z, carga_level_0
	ld 	a, 	(level)
	cp 	#2
	jp 	z, carga_level_1
	ld 	a, 	(level)
	cp 	#3
	jp 	z, carga_level_2
	ld 	a, 	(level)
	cp 	#4
	jp 	z, carga_level_3
	ld 	a, 	(level)
	cp 	#5
	jp 	z, carga_level_4
	ld 	a, 	(level)
	cp 	#6
	jp 	z, carga_level_5
	ld 	a, 	(level)
	cp 	#7
	jp 	z, carga_level_6
	
	elFin:
	ld   hl, #_fin   ;; HL = pointer to the tilemap
	ret
	carga_level_0:
	call 	load_level0
	ld   hl, #_level0   ;; HL = pointer to the tilemap
	ret
	carga_level_1:
	call 	load_level1
	ld   hl, #_level1   ;; HL = pointer to the tilemap
	ret
	carga_level_2:
	ld   hl, #_level2   ;; HL = pointer to the tilemap
	call 	load_level2
	ret
	carga_level_3:
	ld   hl, #_level1   ;; HL = pointer to the tilemap
	call 	load_level3
	ret
	carga_level_4:
	ld   hl, #_level8   ;; HL = pointer to the tilemap
	call 	load_level8
	ret
	carga_level_5:
	ld   hl, #_level9   ;; HL = pointer to the tilemap
	call 	load_level9
	ret
	carga_level_6:
	ld   hl, #_level10   ;; HL = pointer to the tilemap
	call 	load_level10
	ret
	
ret

carga_fondos:
	ld 	a,	(level)
	cp 	#0
	jp 	z, 	elFines
	ld 	a, 	(level)
	cp 	#1
	jp 	z, cargalevel_0
	ld 	a, 	(level)
	cp 	#2
	jp 	z, cargalevel_1
	ld 	a, 	(level)
	cp 	#3
	jp 	z, cargalevel_2
	ld 	a, 	(level)
	cp 	#4
	jp 	z, cargalevel_3
	ld 	a, 	(level)
	cp 	#5
	jp 	z, cargalevel_4
	ld 	a, 	(level)
	cp 	#6
	jp 	z, cargalevel_5
	ld 	a, 	(level)
	cp 	#7
	jp 	z, cargalevel_6
	

	elFines:
	ld   hl, #_fin   ;; HL = pointer to the tilemap
	ret
	cargalevel_0:
	ld   hl, #_level0   ;; HL = pointer to the tilemap
	ret
	cargalevel_1:
	ld   hl, #_level1   ;; HL = pointer to the tilemap

	ret
	cargalevel_2:
	ld   hl, #_level2   ;; HL = pointer to the tilemap

	ret
	cargalevel_3:
	ld   hl, #_level1   ;; HL = pointer to the tilemap

	ret
	cargalevel_4:
	ld   hl, #_level8   ;; HL = pointer to the tilemap

	ret
	cargalevel_5:
	ld   hl, #_level9   ;; HL = pointer to the tilemap

	ret
	cargalevel_6:
	ld   hl, #_level10   ;; HL = pointer to the tilemap

	ret

	
ret

