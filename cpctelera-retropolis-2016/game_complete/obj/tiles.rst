                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module tiles
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_tiles_19
                             12 	.globl _g_tiles_18
                             13 	.globl _g_tiles_17
                             14 	.globl _g_tiles_16
                             15 	.globl _g_tiles_15
                             16 	.globl _g_tiles_14
                             17 	.globl _g_tiles_13
                             18 	.globl _g_tiles_12
                             19 	.globl _g_tiles_11
                             20 	.globl _g_tiles_10
                             21 	.globl _g_tiles_09
                             22 	.globl _g_tiles_08
                             23 	.globl _g_tiles_07
                             24 	.globl _g_tiles_06
                             25 	.globl _g_tiles_05
                             26 	.globl _g_tiles_04
                             27 	.globl _g_tiles_03
                             28 	.globl _g_tiles_02
                             29 	.globl _g_tiles_01
                             30 	.globl _g_tiles_00
                             31 	.globl _g_tileset
                             32 	.globl _g_palette
                             33 ;--------------------------------------------------------
                             34 ; special function registers
                             35 ;--------------------------------------------------------
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DATA
                             40 ;--------------------------------------------------------
                             41 ; ram data
                             42 ;--------------------------------------------------------
                             43 	.area _INITIALIZED
                             44 ;--------------------------------------------------------
                             45 ; absolute external ram data
                             46 ;--------------------------------------------------------
                             47 	.area _DABS (ABS)
                             48 ;--------------------------------------------------------
                             49 ; global & static initialisations
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _GSINIT
                             53 	.area _GSFINAL
                             54 	.area _GSINIT
                             55 ;--------------------------------------------------------
                             56 ; Home
                             57 ;--------------------------------------------------------
                             58 	.area _HOME
                             59 	.area _HOME
                             60 ;--------------------------------------------------------
                             61 ; code
                             62 ;--------------------------------------------------------
                             63 	.area _CODE
                             64 	.area _CODE
   4198                      65 _g_palette:
   4198 54                   66 	.db #0x54	; 84	'T'
   4199 44                   67 	.db #0x44	; 68	'D'
   419A 55                   68 	.db #0x55	; 85	'U'
   419B 5C                   69 	.db #0x5C	; 92
   419C 4C                   70 	.db #0x4C	; 76	'L'
   419D 56                   71 	.db #0x56	; 86	'V'
   419E 57                   72 	.db #0x57	; 87	'W'
   419F 5E                   73 	.db #0x5E	; 94
   41A0 40                   74 	.db #0x40	; 64
   41A1 4E                   75 	.db #0x4E	; 78	'N'
   41A2 47                   76 	.db #0x47	; 71	'G'
   41A3 52                   77 	.db #0x52	; 82	'R'
   41A4 53                   78 	.db #0x53	; 83	'S'
   41A5 4A                   79 	.db #0x4A	; 74	'J'
   41A6 43                   80 	.db #0x43	; 67	'C'
   41A7 4B                   81 	.db #0x4B	; 75	'K'
   41A8                      82 _g_tileset:
   41A8 D0 41                83 	.dw _g_tiles_00
   41AA D8 41                84 	.dw _g_tiles_01
   41AC E0 41                85 	.dw _g_tiles_02
   41AE E8 41                86 	.dw _g_tiles_03
   41B0 F0 41                87 	.dw _g_tiles_04
   41B2 F8 41                88 	.dw _g_tiles_05
   41B4 00 42                89 	.dw _g_tiles_06
   41B6 08 42                90 	.dw _g_tiles_07
   41B8 10 42                91 	.dw _g_tiles_08
   41BA 18 42                92 	.dw _g_tiles_09
   41BC 20 42                93 	.dw _g_tiles_10
   41BE 28 42                94 	.dw _g_tiles_11
   41C0 30 42                95 	.dw _g_tiles_12
   41C2 38 42                96 	.dw _g_tiles_13
   41C4 40 42                97 	.dw _g_tiles_14
   41C6 48 42                98 	.dw _g_tiles_15
   41C8 50 42                99 	.dw _g_tiles_16
   41CA 58 42               100 	.dw _g_tiles_17
   41CC 60 42               101 	.dw _g_tiles_18
   41CE 68 42               102 	.dw _g_tiles_19
   41D0                     103 _g_tiles_00:
   41D0 F0                  104 	.db #0xF0	; 240
   41D1 F0                  105 	.db #0xF0	; 240
   41D2 F0                  106 	.db #0xF0	; 240
   41D3 F0                  107 	.db #0xF0	; 240
   41D4 F0                  108 	.db #0xF0	; 240
   41D5 F0                  109 	.db #0xF0	; 240
   41D6 F0                  110 	.db #0xF0	; 240
   41D7 F0                  111 	.db #0xF0	; 240
   41D8                     112 _g_tiles_01:
   41D8 F0                  113 	.db #0xF0	; 240
   41D9 F0                  114 	.db #0xF0	; 240
   41DA F0                  115 	.db #0xF0	; 240
   41DB F0                  116 	.db #0xF0	; 240
   41DC F0                  117 	.db #0xF0	; 240
   41DD F0                  118 	.db #0xF0	; 240
   41DE F0                  119 	.db #0xF0	; 240
   41DF F0                  120 	.db #0xF0	; 240
   41E0                     121 _g_tiles_02:
   41E0 F0                  122 	.db #0xF0	; 240
   41E1 F0                  123 	.db #0xF0	; 240
   41E2 F0                  124 	.db #0xF0	; 240
   41E3 F0                  125 	.db #0xF0	; 240
   41E4 F0                  126 	.db #0xF0	; 240
   41E5 F0                  127 	.db #0xF0	; 240
   41E6 F0                  128 	.db #0xF0	; 240
   41E7 F0                  129 	.db #0xF0	; 240
   41E8                     130 _g_tiles_03:
   41E8 F0                  131 	.db #0xF0	; 240
   41E9 F0                  132 	.db #0xF0	; 240
   41EA F0                  133 	.db #0xF0	; 240
   41EB F0                  134 	.db #0xF0	; 240
   41EC F0                  135 	.db #0xF0	; 240
   41ED F0                  136 	.db #0xF0	; 240
   41EE F0                  137 	.db #0xF0	; 240
   41EF F0                  138 	.db #0xF0	; 240
   41F0                     139 _g_tiles_04:
   41F0 3C                  140 	.db #0x3C	; 60
   41F1 3C                  141 	.db #0x3C	; 60
   41F2 3C                  142 	.db #0x3C	; 60
   41F3 3C                  143 	.db #0x3C	; 60
   41F4 3C                  144 	.db #0x3C	; 60
   41F5 3C                  145 	.db #0x3C	; 60
   41F6 3C                  146 	.db #0x3C	; 60
   41F7 3C                  147 	.db #0x3C	; 60
   41F8                     148 _g_tiles_05:
   41F8 F0                  149 	.db #0xF0	; 240
   41F9 F0                  150 	.db #0xF0	; 240
   41FA F0                  151 	.db #0xF0	; 240
   41FB F0                  152 	.db #0xF0	; 240
   41FC CC                  153 	.db #0xCC	; 204
   41FD F0                  154 	.db #0xF0	; 240
   41FE CC                  155 	.db #0xCC	; 204
   41FF D8                  156 	.db #0xD8	; 216
   4200                     157 _g_tiles_06:
   4200 F0                  158 	.db #0xF0	; 240
   4201 F0                  159 	.db #0xF0	; 240
   4202 F0                  160 	.db #0xF0	; 240
   4203 F0                  161 	.db #0xF0	; 240
   4204 F0                  162 	.db #0xF0	; 240
   4205 F0                  163 	.db #0xF0	; 240
   4206 52                  164 	.db #0x52	; 82	'R'
   4207 E4                  165 	.db #0xE4	; 228
   4208                     166 _g_tiles_07:
   4208 F0                  167 	.db #0xF0	; 240
   4209 F0                  168 	.db #0xF0	; 240
   420A D8                  169 	.db #0xD8	; 216
   420B F0                  170 	.db #0xF0	; 240
   420C CC                  171 	.db #0xCC	; 204
   420D F0                  172 	.db #0xF0	; 240
   420E 56                  173 	.db #0x56	; 86	'V'
   420F E4                  174 	.db #0xE4	; 228
   4210                     175 _g_tiles_08:
   4210 F0                  176 	.db #0xF0	; 240
   4211 F0                  177 	.db #0xF0	; 240
   4212 F0                  178 	.db #0xF0	; 240
   4213 E4                  179 	.db #0xE4	; 228
   4214 F8                  180 	.db #0xF8	; 248
   4215 CC                  181 	.db #0xCC	; 204
   4216 03                  182 	.db #0x03	; 3
   4217 CC                  183 	.db #0xCC	; 204
   4218                     184 _g_tiles_09:
   4218 0C                  185 	.db #0x0C	; 12
   4219 0C                  186 	.db #0x0C	; 12
   421A 0C                  187 	.db #0x0C	; 12
   421B 0C                  188 	.db #0x0C	; 12
   421C 0C                  189 	.db #0x0C	; 12
   421D 0C                  190 	.db #0x0C	; 12
   421E 0C                  191 	.db #0x0C	; 12
   421F 0C                  192 	.db #0x0C	; 12
   4220                     193 _g_tiles_10:
   4220 CC                  194 	.db #0xCC	; 204
   4221 CC                  195 	.db #0xCC	; 204
   4222 CC                  196 	.db #0xCC	; 204
   4223 FC                  197 	.db #0xFC	; 252
   4224 CC                  198 	.db #0xCC	; 204
   4225 FC                  199 	.db #0xFC	; 252
   4226 CC                  200 	.db #0xCC	; 204
   4227 FC                  201 	.db #0xFC	; 252
   4228                     202 _g_tiles_11:
   4228 CC                  203 	.db #0xCC	; 204
   4229 89                  204 	.db #0x89	; 137
   422A CC                  205 	.db #0xCC	; 204
   422B CC                  206 	.db #0xCC	; 204
   422C A9                  207 	.db #0xA9	; 169
   422D CC                  208 	.db #0xCC	; 204
   422E FC                  209 	.db #0xFC	; 252
   422F 46                  210 	.db #0x46	; 70	'F'
   4230                     211 _g_tiles_12:
   4230 FC                  212 	.db #0xFC	; 252
   4231 CC                  213 	.db #0xCC	; 204
   4232 CC                  214 	.db #0xCC	; 204
   4233 CC                  215 	.db #0xCC	; 204
   4234 CC                  216 	.db #0xCC	; 204
   4235 56                  217 	.db #0x56	; 86	'V'
   4236 CC                  218 	.db #0xCC	; 204
   4237 FC                  219 	.db #0xFC	; 252
   4238                     220 _g_tiles_13:
   4238 CC                  221 	.db #0xCC	; 204
   4239 CC                  222 	.db #0xCC	; 204
   423A CC                  223 	.db #0xCC	; 204
   423B CC                  224 	.db #0xCC	; 204
   423C 46                  225 	.db #0x46	; 70	'F'
   423D CC                  226 	.db #0xCC	; 204
   423E EC                  227 	.db #0xEC	; 236
   423F CC                  228 	.db #0xCC	; 204
   4240                     229 _g_tiles_14:
   4240 C0                  230 	.db #0xC0	; 192
   4241 C0                  231 	.db #0xC0	; 192
   4242 C0                  232 	.db #0xC0	; 192
   4243 C0                  233 	.db #0xC0	; 192
   4244 C0                  234 	.db #0xC0	; 192
   4245 C0                  235 	.db #0xC0	; 192
   4246 C0                  236 	.db #0xC0	; 192
   4247 C0                  237 	.db #0xC0	; 192
   4248                     238 _g_tiles_15:
   4248 CC                  239 	.db #0xCC	; 204
   4249 56                  240 	.db #0x56	; 86	'V'
   424A CC                  241 	.db #0xCC	; 204
   424B CC                  242 	.db #0xCC	; 204
   424C CC                  243 	.db #0xCC	; 204
   424D CC                  244 	.db #0xCC	; 204
   424E CC                  245 	.db #0xCC	; 204
   424F CC                  246 	.db #0xCC	; 204
   4250                     247 _g_tiles_16:
   4250 FC                  248 	.db #0xFC	; 252
   4251 EC                  249 	.db #0xEC	; 236
   4252 56                  250 	.db #0x56	; 86	'V'
   4253 46                  251 	.db #0x46	; 70	'F'
   4254 CC                  252 	.db #0xCC	; 204
   4255 CC                  253 	.db #0xCC	; 204
   4256 CC                  254 	.db #0xCC	; 204
   4257 CC                  255 	.db #0xCC	; 204
   4258                     256 _g_tiles_17:
   4258 89                  257 	.db #0x89	; 137
   4259 FC                  258 	.db #0xFC	; 252
   425A CC                  259 	.db #0xCC	; 204
   425B 56                  260 	.db #0x56	; 86	'V'
   425C CC                  261 	.db #0xCC	; 204
   425D 89                  262 	.db #0x89	; 137
   425E CC                  263 	.db #0xCC	; 204
   425F CC                  264 	.db #0xCC	; 204
   4260                     265 _g_tiles_18:
   4260 A9                  266 	.db #0xA9	; 169
   4261 CC                  267 	.db #0xCC	; 204
   4262 FC                  268 	.db #0xFC	; 252
   4263 CC                  269 	.db #0xCC	; 204
   4264 FC                  270 	.db #0xFC	; 252
   4265 CC                  271 	.db #0xCC	; 204
   4266 CC                  272 	.db #0xCC	; 204
   4267 CC                  273 	.db #0xCC	; 204
   4268                     274 _g_tiles_19:
   4268 00                  275 	.db #0x00	; 0
   4269 00                  276 	.db #0x00	; 0
   426A 00                  277 	.db #0x00	; 0
   426B 00                  278 	.db #0x00	; 0
   426C 00                  279 	.db #0x00	; 0
   426D 00                  280 	.db #0x00	; 0
   426E 00                  281 	.db #0x00	; 0
   426F 00                  282 	.db #0x00	; 0
                            283 	.area _INITIALIZER
                            284 	.area _CABS (ABS)
