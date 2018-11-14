ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .macro DefineTitle _name, _x, _y, _vx, _vy, _w, _h, _sprite
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _vx, _vy     ;;VX, VY
                              5    .db   _w, _h       ;;W, H
                              6    .dw   _sprite      ;;Puntero al sprite
                              7    _name'_size = . - _name
                              8 .endm
                              9 
                     0000    10 t_x      = 0
                     0001    11 t_y      = 1
                     0002    12 t_vx     = 2
                     0003    13 t_vy     = 3
                     0004    14 t_w      = 4
                     0005    15 t_h      = 5
                     0006    16 t_sp_l   = 6
                     0007    17 t_sp_h	 = 7
                             18 
                             19 .globl cargar_titulo
                             20 .globl cargar_GameOver
