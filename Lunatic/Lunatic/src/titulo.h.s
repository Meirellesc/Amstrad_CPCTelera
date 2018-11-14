.macro DefineTitle _name, _x, _y, _vx, _vy, _w, _h, _sprite
_name:
   .db   _x, _y       ;;X, Y
   .db   _vx, _vy     ;;VX, VY
   .db   _w, _h       ;;W, H
   .dw   _sprite      ;;Puntero al sprite
   _name'_size = . - _name
.endm

t_x      = 0
t_y      = 1
t_vx     = 2
t_vy     = 3
t_w      = 4
t_h      = 5
t_sp_l   = 6
t_sp_h	 = 7

.globl cargar_titulo
.globl cargar_GameOver