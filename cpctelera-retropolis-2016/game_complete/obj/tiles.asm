;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module tiles
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _g_tiles_19
	.globl _g_tiles_18
	.globl _g_tiles_17
	.globl _g_tiles_16
	.globl _g_tiles_15
	.globl _g_tiles_14
	.globl _g_tiles_13
	.globl _g_tiles_12
	.globl _g_tiles_11
	.globl _g_tiles_10
	.globl _g_tiles_09
	.globl _g_tiles_08
	.globl _g_tiles_07
	.globl _g_tiles_06
	.globl _g_tiles_05
	.globl _g_tiles_04
	.globl _g_tiles_03
	.globl _g_tiles_02
	.globl _g_tiles_01
	.globl _g_tiles_00
	.globl _g_tileset
	.globl _g_palette
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	.area _CODE
_g_palette:
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x55	; 85	'U'
	.db #0x5C	; 92
	.db #0x4C	; 76	'L'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x5E	; 94
	.db #0x40	; 64
	.db #0x4E	; 78	'N'
	.db #0x47	; 71	'G'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x4A	; 74	'J'
	.db #0x43	; 67	'C'
	.db #0x4B	; 75	'K'
_g_tileset:
	.dw _g_tiles_00
	.dw _g_tiles_01
	.dw _g_tiles_02
	.dw _g_tiles_03
	.dw _g_tiles_04
	.dw _g_tiles_05
	.dw _g_tiles_06
	.dw _g_tiles_07
	.dw _g_tiles_08
	.dw _g_tiles_09
	.dw _g_tiles_10
	.dw _g_tiles_11
	.dw _g_tiles_12
	.dw _g_tiles_13
	.dw _g_tiles_14
	.dw _g_tiles_15
	.dw _g_tiles_16
	.dw _g_tiles_17
	.dw _g_tiles_18
	.dw _g_tiles_19
_g_tiles_00:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_g_tiles_01:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_g_tiles_02:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_g_tiles_03:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_g_tiles_04:
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x3C	; 60
_g_tiles_05:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xCC	; 204
	.db #0xF0	; 240
	.db #0xCC	; 204
	.db #0xD8	; 216
_g_tiles_06:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x52	; 82	'R'
	.db #0xE4	; 228
_g_tiles_07:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xD8	; 216
	.db #0xF0	; 240
	.db #0xCC	; 204
	.db #0xF0	; 240
	.db #0x56	; 86	'V'
	.db #0xE4	; 228
_g_tiles_08:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xE4	; 228
	.db #0xF8	; 248
	.db #0xCC	; 204
	.db #0x03	; 3
	.db #0xCC	; 204
_g_tiles_09:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_g_tiles_10:
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xFC	; 252
	.db #0xCC	; 204
	.db #0xFC	; 252
	.db #0xCC	; 204
	.db #0xFC	; 252
_g_tiles_11:
	.db #0xCC	; 204
	.db #0x89	; 137
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xA9	; 169
	.db #0xCC	; 204
	.db #0xFC	; 252
	.db #0x46	; 70	'F'
_g_tiles_12:
	.db #0xFC	; 252
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x56	; 86	'V'
	.db #0xCC	; 204
	.db #0xFC	; 252
_g_tiles_13:
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x46	; 70	'F'
	.db #0xCC	; 204
	.db #0xEC	; 236
	.db #0xCC	; 204
_g_tiles_14:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_g_tiles_15:
	.db #0xCC	; 204
	.db #0x56	; 86	'V'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
_g_tiles_16:
	.db #0xFC	; 252
	.db #0xEC	; 236
	.db #0x56	; 86	'V'
	.db #0x46	; 70	'F'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
_g_tiles_17:
	.db #0x89	; 137
	.db #0xFC	; 252
	.db #0xCC	; 204
	.db #0x56	; 86	'V'
	.db #0xCC	; 204
	.db #0x89	; 137
	.db #0xCC	; 204
	.db #0xCC	; 204
_g_tiles_18:
	.db #0xA9	; 169
	.db #0xCC	; 204
	.db #0xFC	; 252
	.db #0xCC	; 204
	.db #0xFC	; 252
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
_g_tiles_19:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
