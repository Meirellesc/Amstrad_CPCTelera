ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .macro DefineEnemy _name, _x, _y, _vx, _vy, _w, _h, _sprite, _life, _slow, _slowReference, _canMove, _tipo
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _vx, _vy     ;;VX, VY
                              5    .db   _w, _h       ;;W, H
                              6    .dw   _sprite      ;;Puntero al sprite
                              7    .db   _life        ;;Enemy life
                              8    .db   _slow        ;;enemy slow
                              9    .db   _slowReference        ;;enemy slow
                             10    .db 	 _canMove
                             11    .db   _tipo
                             12    _name'_size = . - _name
                             13 .endm
                             14 
                     0000    15 en_x = 0
                     0001    16 en_y = 1
                     0002    17 en_vx = 2
                     0003    18 en_vy = 3
                     0004    19 en_w = 4
                     0005    20 en_h = 5
                     0006    21 en_sp_l = 6
                     0007    22 en_sp_h = 7
                     0008    23 en_life = 8
                     0009    24 en_slow = 9
                     000A    25 en_slowReference = 10
                     000B    26 en_canMove = 11
                     000C    27 en_tipo = 12
                             28 
                             29 
                             30 .globl enemy_interaction
                             31 .globl enemy_vector 
                             32 .globl k_enemy_size 
                             33 
                             34 .globl enemy_data0
                             35 .globl enemy_data1
                             36 .globl enemy_data2
                             37 .globl enemy_data3
                             38 .globl enemy_data4
                             39 .globl init_enemy
                             40 
                             41 .globl pos_y_en
