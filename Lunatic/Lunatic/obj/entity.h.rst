ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
