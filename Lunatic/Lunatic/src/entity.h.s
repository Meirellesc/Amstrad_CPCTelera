.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _sprite, _upd, _life 
_name:
   .db   _x, _y       ;;X, Y
   .db   _vx, _vy     ;;VX, VY
   .db   _w, _h       ;;W, H
   .dw   _sprite      ;;Puntero al sprite
   .dw   _upd         ;;Update 
   .db   _life        ;;Life
   _name'_size = . - _name
.endm

;;.macro DefineEntityDefault _name, _suf
;;   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, 
;;.endm

;;.macro DefineNEntities _name, _n
;;   _c = 0
;;   .rept _n
;;      DefineEntityDefault _name, \_c
;;      _c = _c + 1
;;   .endm
;;.endm

e_x      = 0
e_y      = 1
e_vx     = 2
e_vy     = 3
e_w      = 4
e_h      = 5
e_sp_l   = 6
e_sp_h	 = 7
e_upd_l  = 8
e_upd_h  = 9
e_life   = 10


.globl ent_update
.globl ent_draw
.globl update_draw_life


.globl hero_data
.globl jumpControl
.globl ent_isJumping_or_canFall
.globl hero_fall
.globl hero_dispara
.globl hero_jump


.globl	ent_background
.globl 	pos_y