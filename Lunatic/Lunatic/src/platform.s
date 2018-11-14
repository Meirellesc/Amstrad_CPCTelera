.include "cpctelera.h.s"
.include "entity.h.s"
.include "main.h.s"
.include "platform.h.s"
.include "colision.h.s"
.include "load_level.h.s"
.include "objects.h.s"


;k_max_num_plat =     ;;numero maximo de plataformas que puedo tener
k_plat_size = 6      ;;tamaño de la plataforma

platform_vector:
DefinePlatform platform_datas,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data,    0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data2,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data3,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data4,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data5,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data6,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data7,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data8,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data9,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data10,   0x00,0x00,0x00,0x00,0x00,0x00
DefinePlatform platform_data11,   0x00,0x00,0x00,0x00,0x00,0x00

init_plat:      .db #1            ;; pinta por primera vez todas




ent_check:

   ld ix,   #hero_data


   ;; if (platform_x + platform_w - hero_x <= 0)

   ld a, p_x(iy)
   add p_w(iy)
   sub e_x(ix)

   jr z, no_collision   ;== 0 no collision
   jp m, no_collision   ;<= 0 no collision

   ;;if (hero_x + hero_w - platform_x <= 0)
   ld a, e_x(ix)
   add e_w(ix)
   sub p_x(iy)

   jr z, no_collision   ;== 0 no collision
   jp m, no_collision   ;<= 0 no collision

   

   ld    a, e_y(ix)             ;; A -> hero_y
   add   e_h(ix)               ;; A -> hero_y + hero_w
   sub   p_y(iy)               ;; A -> A - platform_y

   ;;ld    e_col(ix), #0xFF        ;; Cambio color a ROJO de heroe
   ld    a, #-1
   ld    (hero_fall), a

   jr nz, no_collision    ;;Solo hay colision si está justo encima de la plataforma

   ;;ld e_col(ix), #0xFF            ;; A -> platform_id
   ret

   no_collision:
      ;;ld    e_col(ix), #0x0C        ;; Cambiamos color AZUL
      
      ld    a, #1                   ;; Heroe cae
      ld    (hero_fall), a          ;; 

      ld a, #0                      ;; inicializamos la variable A=0


   ret



ent_fall:
   call plat_checkAll            ;; COMPRUEBO EN TODAS LAS PLATAFORMAS

   ld a, (hero_fall)
   cp #-1
   jp z,   dont_fall

   ld    a,    e_y(ix)
   add #2                          ;; SI CAE BAJO
   ld    e_y(ix),    a

   sub #0xB2               ;; If hero down, this restar in Y=0
   jp z, up_hero

   ret

   dont_fall:
  
   ret

   up_hero:

   call  update_draw_life
   ld    a,   e_life(ix)
   dec   a
   ld    e_life(ix),    a
   ld    a, #0
   call  update_draw_life
   ld    a,    (hero_x)
   ld    e_x(ix),    a
   ld    a,    (hero_y)
   ld    e_y(ix),    a

   call  draw_obj
   ld    ix,   #llave
   ld    a,    #1
   ld    obj_open(ix),  a    

   ld    ix,   #puerta
   ld    a,    #0
   ld    obj_open(ix),  a
 
   call  draw_obj
   
   ld    ix,   #hero_data 

   ret


plat_checkAll:

   ld    a, (n_plat)                      ;; NUMERO DE PLAYAFORMAS
   ld    iy, #platform_vector       ;; VECTOR DE PLATAFORMAS

buc:

   ex    af, af'                    ;; INTERCAMBIO AF por AF'
   
   call  ent_check
   ld    a, (hero_fall)             ;;
   cp    #-1                        ;; COMPRUEBO SI ESTA EN COLISION
   jp    z,   para_de_contar        ;; Si encuentra colision, fuera

   ex    af, af'                    ;; VUELVO A CAMBIAR AF por AF'
   ;;ld    p_col(iy),  #0xAF          ;; REESTABLEZCO COLOR PLAT
   ld    bc, #k_plat_size           ;; AUMENTO POSICION ARRAY
   add   iy, bc                     ;; LA CARGO EN IY

   dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   jr    nz, buc                    ;; SI NO ES CERO BUCLE
   ret

   para_de_contar:

   ex    af, af'                    ;; REESTABLEZCO EL INTERCAMBIO ANTERIOR
   ld    a, #0                      ;; A = 0
   ;;ld    p_col(iy),  #0x35          ;; CAMBIO COLOR DE PLATAFORMA QUE PISA

   ret   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;             Draw VECTOR Platforms
;;
;; INTPUT:     
;;             A ->  OBJECTS NUMBERS
;;             IY -> OBJECTS TYPE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CHECKEAR LOS LATERALES
plat_checkAll_border:

   ld    a,    (n_plat)                      ;; NUMERO DE PLATAFORMAS
   ld    iy, #platform_vector       ;; VECTOR DE PLATAFORMAS

bucle_border:

   ex    af, af'                    ;; INTERCAMBIO AF por AF'
   ld    ix,   #hero_data

   call  colision_check_border
   ld    a,    (colision_borde)
   cp    #-1
   jp    nz , out_border

   ex    af, af'                    ;; VUELVO A CAMBIAR AF por AF'
   ld    bc, #k_plat_size           ;; AUMENTO POSICION ARRAY
   add   iy, bc                     ;; LA CARGO EN IY

   dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   jr    nz, bucle_border           ;; SI NO ES CERO BUCLE
   out_border:
   ret     


check_platform_enemy:

   ld    a, (n_plat)   ;; NUMERO DE PLATAFORMAS
   ld    ix, #platform_vector       ;; VECTOR DE PLATAFORMAS

bucle_plat:

   ld    (en_plat_aux), a
   
   call  colision_enemy_platform
   ld    a,    11(iy)
   cp    #1
   jp    z,    goOUT

   en_plat_aux = . + 1
   ld    a, #0                     ;; VUELVO A CAMBIAR AF por AF'

   ld    bc, #k_plat_size          ;; AUMENTO POSICION ARRAY
   add   ix, bc                     ;; LA CARGO EN IY

   dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   jp    nz, bucle_plat                    ;; SI NO ES CERO BUCLE
   goOUT:
ret
