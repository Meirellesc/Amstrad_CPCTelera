ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
