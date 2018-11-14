.macro DefineDisparo _name, _x, _y, _vx, _vy, _w, _h, _sprite
_name:
   .db   _x, _y       ;;X, Y
   .db	 _vx, _vy	  ;;vX, vY
   .db	 _w, _h		  ;;W, H
   .dw	 _sprite		  ;;Color

.endm


s_x = 0
s_y = 1
s_vx = 2
s_vy = 3
s_w = 4
s_h = 5
s_sp_l = 6
s_sp_h = 7

.globl shotControl
.globl startShot
.globl shot_data
.globl hero_shot

.globl shot_direction
.globl munition
.globl s_background