.macro DefinePlatform _name, _x, _y, _vx, _vy, _w, _h
_name:
   .db   _x, _y       ;;X, Y
   .db	 _vx, _vy		  ;;W, H
   .db	 _w, _h		  ;;W, H

.endm



p_x = 0
p_y = 1
p_vx = 2
p_vy = 3
p_w = 4
p_h = 5



.globl platform_datas 
.globl platform_data 
.globl platform_data2 
.globl platform_data3
.globl platform_data4
.globl platform_data5
.globl platform_data6
.globl platform_data7
.globl platform_data8
.globl platform_data9
.globl platform_data10
.globl platform_data11

.globl plat_checkAll
.globl ent_fall
.globl plat_checkAll_border
.globl k_plat_size
.globl check_platform_enemy