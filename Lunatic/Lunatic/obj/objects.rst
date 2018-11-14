ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "disparo.h.s"
                              1 .macro DefineDisparo _name, _x, _y, _vx, _vy, _w, _h, _sprite
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db	 _vx, _vy	  ;;vX, vY
                              5    .db	 _w, _h		  ;;W, H
                              6    .dw	 _sprite		  ;;Color
                              7 
                              8 .endm
                              9 
                             10 
                     0000    11 s_x = 0
                     0001    12 s_y = 1
                     0002    13 s_vx = 2
                     0003    14 s_vy = 3
                     0004    15 s_w = 4
                     0005    16 s_h = 5
                     0006    17 s_sp_l = 6
                     0007    18 s_sp_h = 7
                             19 
                             20 .globl shotControl
                             21 .globl startShot
                             22 .globl shot_data
                             23 .globl hero_shot
                             24 
                             25 .globl shot_direction
                             26 .globl munition
                             27 .globl s_background
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "colision.h.s"
                              1 
                              2 .globl colision
                              3 .globl colision_borde
                              4 
                              5 .globl colision_check
                              6 .globl colision_check_border
                              7 .globl colision_enemy_platform
                              8 .globl colision_check_ex
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 .include "objects.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              4 .include "main.h.s"
                              1 ;; 
                              2 ;; Declare all function entry points as global symbols for the compiler.
                              3 ;; (The linker will know what to do with them)
                              4 ;; WARNING: Every global symbol declared will be linked, so DO NOT declare 
                              5 ;; symbols for functions you do not use.
                              6 ;;
                              7 .globl cpct_disableFirmware_asm
                              8 .globl cpct_drawSolidBox_asm
                              9 .globl cpct_getScreenPtr_asm
                             10 .globl cpct_waitVSYNC_asm
                             11 .globl cpct_scanKeyboard_asm
                             12 .globl cpct_isKeyPressed_asm
                             13 .globl cpct_setVideoMode_asm
                             14 .globl cpct_drawSprite_asm
                             15 .globl cpct_setPalette_asm
                             16 .globl cpct_setPALColour_asm
                             17 .globl cpct_drawSpriteMasked_asm 
                             18 .globl cpct_drawStringM0_asm
                             19 .globl cpct_setDrawCharM0_asm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              5 .include "entity.h.s"
                              1 .macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _sprite, _upd, _life 
                              2 _name:
                              3    .db   _x, _y       ;;X, Y
                              4    .db   _vx, _vy     ;;VX, VY
                              5    .db   _w, _h       ;;W, H
                              6    .dw   _sprite      ;;Puntero al sprite
                              7    .dw   _upd         ;;Update 
                              8    .db   _life        ;;Life
                              9    _name'_size = . - _name
                             10 .endm
                             11 
                             12 ;;.macro DefineEntityDefault _name, _suf
                             13 ;;   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, 
                             14 ;;.endm
                             15 
                             16 ;;.macro DefineNEntities _name, _n
                             17 ;;   _c = 0
                             18 ;;   .rept _n
                             19 ;;      DefineEntityDefault _name, \_c
                             20 ;;      _c = _c + 1
                             21 ;;   .endm
                             22 ;;.endm
                             23 
                     0000    24 e_x      = 0
                     0001    25 e_y      = 1
                     0002    26 e_vx     = 2
                     0003    27 e_vy     = 3
                     0004    28 e_w      = 4
                     0005    29 e_h      = 5
                     0006    30 e_sp_l   = 6
                     0007    31 e_sp_h	 = 7
                     0008    32 e_upd_l  = 8
                     0009    33 e_upd_h  = 9
                     000A    34 e_life   = 10
                             35 
                             36 
                             37 .globl ent_update
                             38 .globl ent_draw
                             39 .globl update_draw_life
                             40 
                             41 
                             42 .globl hero_data
                             43 .globl jumpControl
                             44 .globl ent_isJumping_or_canFall
                             45 .globl hero_fall
                             46 .globl hero_dispara
                             47 .globl hero_jump
                             48 
                             49 
                             50 .globl	ent_background
                             51 .globl 	pos_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              6 .include "cargar_level.h.s"
                              1 
                              2 .globl cargar_nivel
                              3 .globl level
                              4 .globl end_level
                              5 .globl carga_fondos
                              6 .globl carga_todo
                              7 .globl cargar_nivel2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              7 
                              8 
                              9 
                     0003    10 k_max_num_obj = 3    ;;numero maximo de objetos que puedo tener
                     0008    11 k_obj_size = llave_size      ;;tamaño del objetos
   83C6                      12 obj_vector:
   83C6                      13 DefineObjects llave,    0x20,   0x80,   0x05,   0x10,   _llave_sp,   1, 1    
   0000                       1 llave:
   83C6 20 80                 2    .db   0x20, 0x80       ;;X, Y
   83C8 05 10                 3    .db   0x05, 0x10       ;;W, H
   83CA F0 41                 4    .dw   _llave_sp      ;;Puntero al sprite
   83CC 01                    5    .db   1        ;;Enemy life
   83CD 01                    6    .db 	 1
                     0008     7    llave_size = . - llave
   83CE                      14 DefineObjects puerta,   0x1A,   0x00,   0x08,   0x10,   _puerta_sp,  2, 0
   0008                       1 puerta:
   83CE 1A 00                 2    .db   0x1A, 0x00       ;;X, Y
   83D0 08 10                 3    .db   0x08, 0x10       ;;W, H
   83D2 60 41                 4    .dw   _puerta_sp      ;;Puntero al sprite
   83D4 02                    5    .db   2        ;;Enemy life
   83D5 00                    6    .db 	 0
                     0008     7    puerta_size = . - puerta
   83D6                      15 DefineObjects bala,     0x40,   0x6C,   0x05,   0x0C,   _bala_sp,    3, 0
   0010                       1 bala:
   83D6 40 6C                 2    .db   0x40, 0x6C       ;;X, Y
   83D8 05 0C                 3    .db   0x05, 0x0C       ;;W, H
   83DA 14 41                 4    .dw   _bala_sp      ;;Puntero al sprite
   83DC 03                    5    .db   3        ;;Enemy life
   83DD 00                    6    .db 	 0
                     0008     7    bala_size = . - bala
                             16 
                             17 
                             18 
   83DE                      19 obj_draw:
   83DE 11 00 C0      [10]   20  ld    de, #0xC000         ;; Comienzo de memoria de video
   83E1 DD 4E 00      [19]   21   ld    c, obj_x(ix)          ;; Entidad X
   83E4 DD 46 01      [19]   22   ld    b, obj_y(ix)          ;; Entidad Y
   83E7 CD 38 8A      [17]   23   call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla
                             24 
                             25   ;;;HL -> Memoria de video
                             26 
   83EA EB            [ 4]   27   ex    de, hl         ;; Cambio lo de HL a DE
   83EB DD 6E 04      [19]   28   ld    l, obj_sp_l(ix)
   83EE DD 66 05      [19]   29   ld    h, obj_sp_h(ix)
                             30   ;;;ld    hl, #_hero_sp_0  
   83F1 DD 4E 03      [19]   31   ld    c,  obj_h(ix)     ;; Alto
   83F4 DD 46 02      [19]   32   ld    b,  obj_w(ix)     ;; Ancho
                             33 
                             34 
   83F7 CD ED 89      [17]   35    call cpct_drawSpriteBlended_asm
                             36 
   83FA C9            [10]   37 ret
                             38 
   83FB                      39 obj_drawY:
   83FB 11 00 C0      [10]   40  ld    de, #0xC000         ;; Comienzo de memoria de video
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   83FE FD 4E 00      [19]   41   ld    c, obj_x(iy)          ;; Entidad X
   8401 FD 46 01      [19]   42   ld    b, obj_y(iy)          ;; Entidad Y
   8404 CD 38 8A      [17]   43   call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla
                             44 
                             45   ;;;HL -> Memoria de video
                             46 
   8407 EB            [ 4]   47   ex    de, hl         ;; Cambio lo de HL a DE
   8408 FD 6E 04      [19]   48   ld    l, obj_sp_l(iy)
   840B FD 66 05      [19]   49   ld    h, obj_sp_h(iy)
                             50   ;;;ld    hl, #_hero_sp_0  
   840E FD 4E 03      [19]   51   ld    c,  obj_h(iy)     ;; Alto
   8411 FD 46 02      [19]   52   ld    b,  obj_w(iy)     ;; Ancho
                             53 
                             54 
   8414 CD ED 89      [17]   55    call cpct_drawSpriteBlended_asm
                             56 
   8417 C9            [10]   57 ret
                             58 
                             59 ;clear_obj:
                             60 
                             61 ;  ld    a, obj_col(ix)      ;; Cargo el color en AF
                             62 ;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;Cambiado con variable automodificable
                             63 ;  ld    (obj_aux), a
                             64 ;  ;;ex    af,   af'         ;; Intercambio AF por su registro alternativo 
                             65 ;  ld    obj_col(ix), #0     ;; El color lo cambio por fondo
                             66 ;  call  obj_draw          ;; Le digo que dibuje fondo para que borrar
                             67 ;  ;;ex    af,   af'
                             68 ;  obj_aux = . + 1
                             69 ;  ld    a, #0   
                             70 ;
                             71 ;  ld    obj_col(ix), a      ;; Reestablezco el color de hero 
                             72 
                             73 ;  ret
                             74 
                             75 
                             76 
                             77 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUPONEMOS QUE EL OBJETO ENTRA EN IY
                             78 ;;                                               Hay que compararlo con IX (hero)
                             79 
                             80 
                             81 
   8418                      82 coge_objeto:
                             83 
   8418 DD 7E 07      [19]   84    ld    a,    obj_open(ix)               ;; ESTA ABIERTO EL OBJETO?
   841B FE 00         [ 7]   85    cp    #0
   841D CA 53 84      [10]   86    jp    z,    no_coge_objeto
                             87 
   8420 FD 21 61 79   [14]   88    ld    iy,   #hero_data
                             89 
   8424 CD D3 74      [17]   90    call  colision_check_ex                  ;; Compruebo si colisiona
                             91 
   8427 3A 95 74      [13]   92    ld    a,    (colision)
   842A FE 01         [ 7]   93    cp    #1
   842C C2 53 84      [10]   94    jp    nz,   no_coge_objeto             ;; Si no hay colision No coge obj
                             95 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   842F DD 7E 06      [19]   96       ld    a,    obj_tipo(ix)            ;; Voy viendo que tipo de objeto quiero
   8432 FE 01         [ 7]   97       cp    #1
   8434 C2 3B 84      [10]   98       jp    nz,   no_es_llave             ;; 1 = LLAVE, 2 = PUERTA, 3 = BALA 
                             99 
   8437 CD 54 84      [17]  100          call  comportamiento_llave
   843A C9            [10]  101          ret
   843B                     102       no_es_llave:
                            103 
   843B DD 7E 06      [19]  104       ld    a,    obj_tipo(ix)
   843E FE 02         [ 7]  105       cp    #2
   8440 C2 47 84      [10]  106       jp    nz,   no_es_puerta
                            107 
   8443 CD 71 84      [17]  108          call  comportamiento_puerta
   8446 C9            [10]  109          ret
   8447                     110       no_es_puerta:
                            111 
   8447 DD 7E 06      [19]  112       ld    a,    obj_tipo(ix)
   844A FE 03         [ 7]  113       cp    #3
   844C C2 53 84      [10]  114       jp    nz,   no_es_bala
                            115 
   844F CD 84 84      [17]  116          call  comportamiento_bala
   8452 C9            [10]  117          ret
   8453                     118       no_es_bala:
                            119 
   8453                     120    no_coge_objeto:
                            121 
   8453 C9            [10]  122    ret
                            123 
   8454                     124 comportamiento_llave:
                            125 
                            126 
   8454 3E 00         [ 7]  127 ld    a,    #0             ;; SE APAGA LA LLAVE
   8456 DD 77 07      [19]  128 ld    obj_open(ix),     a
   8459 CD DE 83      [17]  129 call  obj_draw
   845C FD 21 CE 83   [14]  130 ld    iy,   #puerta
   8460 3E 01         [ 7]  131 ld    a,    #1             ;; Se ABRE la puerta
   8462 FD 77 07      [19]  132 ld    obj_open(iy),     a
                            133 
   8465 FD 21 CE 83   [14]  134 ld    iy,   #puerta        ;; TEMPORAL CUANDO TENGA EL ARRAY FUERA
   8469 CD FB 83      [17]  135 call  obj_drawY
                            136 
                            137 
   846C FD 21 61 79   [14]  138 ld    iy,   #hero_data     ;; reestablezco IY heroe
                            139 
                            140 
   8470 C9            [10]  141 ret
                            142 
   8471                     143 comportamiento_puerta:
   8471 3E 00         [ 7]  144 ld    a,    #0             ;; APAGO PUERTA
   8473 DD 77 07      [19]  145 ld    obj_open(ix),     a
   8476 3A 68 73      [13]  146 ld    a,    (level)
   8479 C6 01         [ 7]  147 add   #1
   847B 32 68 73      [13]  148 ld    (level),    a
   847E 3E 01         [ 7]  149 ld    a,    #1
   8480 32 69 73      [13]  150 ld    (end_level),   a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            151 
                            152 
   8483 C9            [10]  153 ret
                            154 
   8484                     155 comportamiento_bala:
   8484 3E 00         [ 7]  156 ld    a,    #0             ;; APAGO BALA
   8486 DD 77 07      [19]  157 ld    obj_open(ix),     a  ;;  
   8489 CD DE 83      [17]  158 call  obj_draw
   848C 3A 12 76      [13]  159 ld    a,    (munition)
   848F CD A8 83      [17]  160    call draw_numbers
   8492 3E 09         [ 7]  161 ld    a,    #9             ;; recargo num balas
   8494 32 12 76      [13]  162 ld    (munition), a
   8497 3A 12 76      [13]  163 ld    a,    (munition)
   849A CD A8 83      [17]  164    call draw_numbers
                            165 
   849D C9            [10]  166 ret
                            167 
   849E                     168 main_obj:
                            169 
   849E 3E 03         [ 7]  170    ld    a, #k_max_num_obj     ;; NUMERO DE OBJETIVOS
   84A0 DD 21 C6 83   [14]  171    ld    ix, #obj_vector       ;; VECTOR DE OBJETIVOS
                            172 
   84A4                     173 bucle_obj:
                            174 
   84A4 32 B3 84      [13]  175    ld    (obj_aux), a
                            176 
                            177 
   84A7 CD 18 84      [17]  178    call  coge_objeto
   84AA DD 7E 07      [19]  179    ld    a,    obj_open(ix)
   84AD FE 00         [ 7]  180    cp    #0
   84AF CA B2 84      [10]  181    jp    z,    no_dibuja
                            182 
   84B2                     183    no_dibuja:
                            184 
                            185 
                     00ED   186    obj_aux = . + 1
   84B2 3E 00         [ 7]  187    ld    a, #0                     ;; VUELVO A CAMBIAR AF por AF'
   84B4 01 08 00      [10]  188    ld    bc, #k_obj_size           ;; AUMENTO POSICION ARRAY
   84B7 DD 09         [15]  189    add   ix, bc                     ;; LA CARGO EN IY
                            190 
   84B9 3D            [ 4]  191    dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   84BA C2 A4 84      [10]  192    jp    nz, bucle_obj                    ;; SI NO ES CERO BUCLE
   84BD C9            [10]  193 ret
                            194 
   84BE                     195 draw_obj:
                            196 
   84BE 3E 03         [ 7]  197    ld    a, #k_max_num_obj     ;; NUMERO DE OBJETIVOS
   84C0 DD 21 C6 83   [14]  198    ld    ix, #obj_vector       ;; VECTOR DE OBJETIVOS
                            199 
   84C4                     200 bucle_obj2:
                            201 
   84C4 32 D3 84      [13]  202    ld    (obj_aux2), a
                            203 
                            204 
   84C7 DD 7E 07      [19]  205    ld    a,    obj_open(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   84CA FE 00         [ 7]  206    cp    #0
   84CC CA D2 84      [10]  207    jp    z,    no_dibuja2
                            208 
   84CF CD DE 83      [17]  209    call  obj_draw
                            210 
   84D2                     211    no_dibuja2:
                            212 
                            213 
                     010D   214    obj_aux2 = . + 1
   84D2 3E 00         [ 7]  215    ld    a, #0                     ;; VUELVO A CAMBIAR AF por AF'
   84D4 01 08 00      [10]  216    ld    bc, #k_obj_size           ;; AUMENTO POSICION ARRAY
   84D7 DD 09         [15]  217    add   ix, bc                     ;; LA CARGO EN IY
                            218 
   84D9 3D            [ 4]  219    dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   84DA C2 C4 84      [10]  220    jp    nz, bucle_obj2                    ;; SI NO ES CERO BUCLE
   84DD C9            [10]  221 ret
                            222 
