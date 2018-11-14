                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Mac OS X x86_64)
                              4 ;--------------------------------------------------------
                              5 	.module tiles
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_tiles_17
                             12 	.globl _g_tiles_16
                             13 	.globl _g_tiles_15
                             14 	.globl _g_tiles_14
                             15 	.globl _g_tiles_13
                             16 	.globl _g_tiles_12
                             17 	.globl _g_tiles_11
                             18 	.globl _g_tiles_10
                             19 	.globl _g_tiles_09
                             20 	.globl _g_tiles_08
                             21 	.globl _g_tiles_07
                             22 	.globl _g_tiles_06
                             23 	.globl _g_tiles_05
                             24 	.globl _g_tiles_04
                             25 	.globl _g_tiles_03
                             26 	.globl _g_tiles_02
                             27 	.globl _g_tiles_01
                             28 	.globl _g_tiles_00
                             29 	.globl _g_tileset
                             30 ;--------------------------------------------------------
                             31 ; special function registers
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DATA
                             37 ;--------------------------------------------------------
                             38 ; ram data
                             39 ;--------------------------------------------------------
                             40 	.area _INITIALIZED
                             41 ;--------------------------------------------------------
                             42 ; absolute external ram data
                             43 ;--------------------------------------------------------
                             44 	.area _DABS (ABS)
                             45 ;--------------------------------------------------------
                             46 ; global & static initialisations
                             47 ;--------------------------------------------------------
                             48 	.area _HOME
                             49 	.area _GSINIT
                             50 	.area _GSFINAL
                             51 	.area _GSINIT
                             52 ;--------------------------------------------------------
                             53 ; Home
                             54 ;--------------------------------------------------------
                             55 	.area _HOME
                             56 	.area _HOME
                             57 ;--------------------------------------------------------
                             58 ; code
                             59 ;--------------------------------------------------------
                             60 	.area _CODE
                             61 	.area _CODE
   3EC0                      62 _g_tileset:
   3EC0 E4 3E                63 	.dw _g_tiles_00
   3EC2 EC 3E                64 	.dw _g_tiles_01
   3EC4 F4 3E                65 	.dw _g_tiles_02
   3EC6 FC 3E                66 	.dw _g_tiles_03
   3EC8 04 3F                67 	.dw _g_tiles_04
   3ECA 0C 3F                68 	.dw _g_tiles_05
   3ECC 14 3F                69 	.dw _g_tiles_06
   3ECE 1C 3F                70 	.dw _g_tiles_07
   3ED0 24 3F                71 	.dw _g_tiles_08
   3ED2 2C 3F                72 	.dw _g_tiles_09
   3ED4 34 3F                73 	.dw _g_tiles_10
   3ED6 3C 3F                74 	.dw _g_tiles_11
   3ED8 44 3F                75 	.dw _g_tiles_12
   3EDA 4C 3F                76 	.dw _g_tiles_13
   3EDC 54 3F                77 	.dw _g_tiles_14
   3EDE 5C 3F                78 	.dw _g_tiles_15
   3EE0 64 3F                79 	.dw _g_tiles_16
   3EE2 6C 3F                80 	.dw _g_tiles_17
   3EE4                      81 _g_tiles_00:
   3EE4 FF                   82 	.db #0xff	; 255
   3EE5 FF                   83 	.db #0xff	; 255
   3EE6 FF                   84 	.db #0xff	; 255
   3EE7 FF                   85 	.db #0xff	; 255
   3EE8 FF                   86 	.db #0xff	; 255
   3EE9 FF                   87 	.db #0xff	; 255
   3EEA FF                   88 	.db #0xff	; 255
   3EEB FF                   89 	.db #0xff	; 255
   3EEC                      90 _g_tiles_01:
   3EEC 33                   91 	.db #0x33	; 51	'3'
   3EED 33                   92 	.db #0x33	; 51	'3'
   3EEE 27                   93 	.db #0x27	; 39
   3EEF 0F                   94 	.db #0x0f	; 15
   3EF0 27                   95 	.db #0x27	; 39
   3EF1 0F                   96 	.db #0x0f	; 15
   3EF2 27                   97 	.db #0x27	; 39
   3EF3 0F                   98 	.db #0x0f	; 15
   3EF4                      99 _g_tiles_02:
   3EF4 33                  100 	.db #0x33	; 51	'3'
   3EF5 33                  101 	.db #0x33	; 51	'3'
   3EF6 0F                  102 	.db #0x0f	; 15
   3EF7 1B                  103 	.db #0x1b	; 27
   3EF8 0F                  104 	.db #0x0f	; 15
   3EF9 1B                  105 	.db #0x1b	; 27
   3EFA 0F                  106 	.db #0x0f	; 15
   3EFB 1B                  107 	.db #0x1b	; 27
   3EFC                     108 _g_tiles_03:
   3EFC 0F                  109 	.db #0x0f	; 15
   3EFD 1B                  110 	.db #0x1b	; 27
   3EFE 0F                  111 	.db #0x0f	; 15
   3EFF 1B                  112 	.db #0x1b	; 27
   3F00 0F                  113 	.db #0x0f	; 15
   3F01 1B                  114 	.db #0x1b	; 27
   3F02 33                  115 	.db #0x33	; 51	'3'
   3F03 33                  116 	.db #0x33	; 51	'3'
   3F04                     117 _g_tiles_04:
   3F04 27                  118 	.db #0x27	; 39
   3F05 0F                  119 	.db #0x0f	; 15
   3F06 27                  120 	.db #0x27	; 39
   3F07 0F                  121 	.db #0x0f	; 15
   3F08 27                  122 	.db #0x27	; 39
   3F09 0F                  123 	.db #0x0f	; 15
   3F0A 33                  124 	.db #0x33	; 51	'3'
   3F0B 33                  125 	.db #0x33	; 51	'3'
   3F0C                     126 _g_tiles_05:
   3F0C 0F                  127 	.db #0x0f	; 15
   3F0D 0F                  128 	.db #0x0f	; 15
   3F0E 0F                  129 	.db #0x0f	; 15
   3F0F 0F                  130 	.db #0x0f	; 15
   3F10 0F                  131 	.db #0x0f	; 15
   3F11 0F                  132 	.db #0x0f	; 15
   3F12 0F                  133 	.db #0x0f	; 15
   3F13 0F                  134 	.db #0x0f	; 15
   3F14                     135 _g_tiles_06:
   3F14 00                  136 	.db #0x00	; 0
   3F15 00                  137 	.db #0x00	; 0
   3F16 00                  138 	.db #0x00	; 0
   3F17 00                  139 	.db #0x00	; 0
   3F18 00                  140 	.db #0x00	; 0
   3F19 00                  141 	.db #0x00	; 0
   3F1A 00                  142 	.db #0x00	; 0
   3F1B 00                  143 	.db #0x00	; 0
   3F1C                     144 _g_tiles_07:
   3F1C 3C                  145 	.db #0x3c	; 60
   3F1D 3C                  146 	.db #0x3c	; 60
   3F1E 3C                  147 	.db #0x3c	; 60
   3F1F 3C                  148 	.db #0x3c	; 60
   3F20 3C                  149 	.db #0x3c	; 60
   3F21 3C                  150 	.db #0x3c	; 60
   3F22 3C                  151 	.db #0x3c	; 60
   3F23 3C                  152 	.db #0x3c	; 60
   3F24                     153 _g_tiles_08:
   3F24 0F                  154 	.db #0x0f	; 15
   3F25 0F                  155 	.db #0x0f	; 15
   3F26 0F                  156 	.db #0x0f	; 15
   3F27 0F                  157 	.db #0x0f	; 15
   3F28 0F                  158 	.db #0x0f	; 15
   3F29 0F                  159 	.db #0x0f	; 15
   3F2A 33                  160 	.db #0x33	; 51	'3'
   3F2B 33                  161 	.db #0x33	; 51	'3'
   3F2C                     162 _g_tiles_09:
   3F2C 33                  163 	.db #0x33	; 51	'3'
   3F2D 33                  164 	.db #0x33	; 51	'3'
   3F2E 0F                  165 	.db #0x0f	; 15
   3F2F 0F                  166 	.db #0x0f	; 15
   3F30 0F                  167 	.db #0x0f	; 15
   3F31 0F                  168 	.db #0x0f	; 15
   3F32 0F                  169 	.db #0x0f	; 15
   3F33 0F                  170 	.db #0x0f	; 15
   3F34                     171 _g_tiles_10:
   3F34 27                  172 	.db #0x27	; 39
   3F35 0F                  173 	.db #0x0f	; 15
   3F36 27                  174 	.db #0x27	; 39
   3F37 0F                  175 	.db #0x0f	; 15
   3F38 27                  176 	.db #0x27	; 39
   3F39 0F                  177 	.db #0x0f	; 15
   3F3A 27                  178 	.db #0x27	; 39
   3F3B 0F                  179 	.db #0x0f	; 15
   3F3C                     180 _g_tiles_11:
   3F3C 3F                  181 	.db #0x3f	; 63
   3F3D 3F                  182 	.db #0x3f	; 63
   3F3E 3F                  183 	.db #0x3f	; 63
   3F3F 3F                  184 	.db #0x3f	; 63
   3F40 3F                  185 	.db #0x3f	; 63
   3F41 3F                  186 	.db #0x3f	; 63
   3F42 3F                  187 	.db #0x3f	; 63
   3F43 3F                  188 	.db #0x3f	; 63
   3F44                     189 _g_tiles_12:
   3F44 30                  190 	.db #0x30	; 48	'0'
   3F45 30                  191 	.db #0x30	; 48	'0'
   3F46 30                  192 	.db #0x30	; 48	'0'
   3F47 30                  193 	.db #0x30	; 48	'0'
   3F48 30                  194 	.db #0x30	; 48	'0'
   3F49 30                  195 	.db #0x30	; 48	'0'
   3F4A 30                  196 	.db #0x30	; 48	'0'
   3F4B 30                  197 	.db #0x30	; 48	'0'
   3F4C                     198 _g_tiles_13:
   3F4C 30                  199 	.db #0x30	; 48	'0'
   3F4D 30                  200 	.db #0x30	; 48	'0'
   3F4E 30                  201 	.db #0x30	; 48	'0'
   3F4F 30                  202 	.db #0x30	; 48	'0'
   3F50 30                  203 	.db #0x30	; 48	'0'
   3F51 30                  204 	.db #0x30	; 48	'0'
   3F52 30                  205 	.db #0x30	; 48	'0'
   3F53 30                  206 	.db #0x30	; 48	'0'
   3F54                     207 _g_tiles_14:
   3F54 FC                  208 	.db #0xfc	; 252
   3F55 FC                  209 	.db #0xfc	; 252
   3F56 FC                  210 	.db #0xfc	; 252
   3F57 FC                  211 	.db #0xfc	; 252
   3F58 FC                  212 	.db #0xfc	; 252
   3F59 FC                  213 	.db #0xfc	; 252
   3F5A FC                  214 	.db #0xfc	; 252
   3F5B FC                  215 	.db #0xfc	; 252
   3F5C                     216 _g_tiles_15:
   3F5C 0F                  217 	.db #0x0f	; 15
   3F5D 0F                  218 	.db #0x0f	; 15
   3F5E 0F                  219 	.db #0x0f	; 15
   3F5F 0F                  220 	.db #0x0f	; 15
   3F60 0F                  221 	.db #0x0f	; 15
   3F61 0F                  222 	.db #0x0f	; 15
   3F62 0F                  223 	.db #0x0f	; 15
   3F63 0F                  224 	.db #0x0f	; 15
   3F64                     225 _g_tiles_16:
   3F64 0F                  226 	.db #0x0f	; 15
   3F65 1B                  227 	.db #0x1b	; 27
   3F66 0F                  228 	.db #0x0f	; 15
   3F67 1B                  229 	.db #0x1b	; 27
   3F68 0F                  230 	.db #0x0f	; 15
   3F69 1B                  231 	.db #0x1b	; 27
   3F6A 0F                  232 	.db #0x0f	; 15
   3F6B 1B                  233 	.db #0x1b	; 27
   3F6C                     234 _g_tiles_17:
   3F6C 33                  235 	.db #0x33	; 51	'3'
   3F6D 33                  236 	.db #0x33	; 51	'3'
   3F6E 33                  237 	.db #0x33	; 51	'3'
   3F6F 33                  238 	.db #0x33	; 51	'3'
   3F70 33                  239 	.db #0x33	; 51	'3'
   3F71 33                  240 	.db #0x33	; 51	'3'
   3F72 33                  241 	.db #0x33	; 51	'3'
   3F73 33                  242 	.db #0x33	; 51	'3'
                            243 	.area _INITIALIZER
                            244 	.area _CABS (ABS)
