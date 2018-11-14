.macro DefineEnemy _name, _x, _y, _vx, _vy, _w, _h, _sprite, _life, _slow, _slowReference, _canMove, _tipo
_name:
   .db   _x, _y       ;;X, Y
   .db   _vx, _vy     ;;VX, VY
   .db   _w, _h       ;;W, H
   .dw   _sprite      ;;Puntero al sprite
   .db   _life        ;;Enemy life
   .db   _slow        ;;enemy slow
   .db   _slowReference        ;;enemy slow
   .db 	 _canMove
   .db   _tipo
   _name'_size = . - _name
.endm

en_x = 0
en_y = 1
en_vx = 2
en_vy = 3
en_w = 4
en_h = 5
en_sp_l = 6
en_sp_h = 7
en_life = 8
en_slow = 9
en_slowReference = 10
en_canMove = 11
en_tipo = 12


.globl enemy_interaction
.globl enemy_vector 
.globl k_enemy_size 

.globl enemy_data0
.globl enemy_data1
.globl enemy_data2
.globl enemy_data3
.globl enemy_data4
.globl init_enemy

.globl pos_y_en