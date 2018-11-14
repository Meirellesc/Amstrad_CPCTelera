ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .macro DefineObjects _name, _x, _y, _w, _h, _sprite, _tipo, _open
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _w, _h       ;;W, H
                              5    .dw   _sprite      ;;Puntero al sprite
                              6    .db   _tipo        ;;Enemy life
                              7    .db 	 _open
                              8    _name'_size = . - _name
                              9 .endm
                             10 
                     0000    11 obj_x 		= 0
                     0001    12 obj_y 		= 1
                     0002    13 obj_w 		= 2
                     0003    14 obj_h 		= 3
                     0004    15 obj_sp_l 	= 4
                     0005    16 obj_sp_h 	= 5
                     0006    17 obj_tipo 	= 6
                     0007    18 obj_open 	= 7
                             19 
                             20 .globl 	main_obj
                             21 .globl 	draw_obj
                             22 .globl 	bala
                             23 .globl 	puerta
                             24 .globl 	llave
