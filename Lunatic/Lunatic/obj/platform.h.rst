ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
