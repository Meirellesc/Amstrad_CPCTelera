.macro DefineObjects _name, _x, _y, _w, _h, _sprite, _tipo, _open
_name:
   .db   _x, _y       ;;X, Y
   .db   _w, _h       ;;W, H
   .dw   _sprite      ;;Puntero al sprite
   .db   _tipo        ;;Enemy life
   .db 	 _open
   _name'_size = . - _name
.endm

obj_x 		= 0
obj_y 		= 1
obj_w 		= 2
obj_h 		= 3
obj_sp_l 	= 4
obj_sp_h 	= 5
obj_tipo 	= 6
obj_open 	= 7

.globl 	main_obj
.globl 	draw_obj
.globl 	bala
.globl 	puerta
.globl 	llave