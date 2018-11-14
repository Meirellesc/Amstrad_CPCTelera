.include "cpctelera.h.s"
.include "enemy.h.s"
.include "main.h.s"
.include "entity.h.s"
.include "colision.h.s"
.include "disparo.h.s"
.include "platform.h.s"
.include "load_level.h.s"
.include "cargar_level.h.s"
.include "objects.h.s"


;k_max_num_enemy = (n_enem)    ;;numero maximo de enemigos que puedo tener
k_enemy_size = enemy_data0_size      ;;tamaño del enemigo

enemy_vector:
DefineEnemy enemy_data0, 0x00, 0x00, 0xFF, 0x00, 0x06, 0x10, _robot_sp_0, 0x00, 0x06, 0x06, -1, -1
DefineEnemy enemy_data1, 0x00, 0x00, 0xFF, 0x00, 0x06, 0x10, _robot_sp_0, 0x00, 0x06, 0x06, -1, 0
DefineEnemy enemy_data2, 0x00, 0x00, 0xFF, 0x00, 0x06, 0x10, _robot_sp_0, 0x00, 0x06, 0x06, -1, 0
DefineEnemy enemy_data3, 0x00, 0x00, 0xFF, 0x00, 0x06, 0x10, _robot_sp_0, 0x00, 0x06, 0x06, -1, 0
DefineEnemy enemy_data4, 0x00, 0x00, 0xFF, 0x00, 0x06, 0x10, _robot_sp_0, 0x00, 0x06, 0x06, -1, 0

init_enemy:     .db #1            ;; pinta por primera vez todas
pos_y_en:               .db #100
pos_x:               .db #100

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    MOVER ENTIDAD
;; Destruye 
;; Entrada IX -> puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_move:
   
   ;;call  check_platform_enemy
   ld    a,    en_vx(iy)    
   cp    #0x01
   jp    z,    go_moveright

   ld    a,    en_vx(iy)    
   cp    #0xFF
   jp    z,    go_moveleft

   go_moveleft:
      ld    hl, #_robot_sp_1    
      ld    en_sp_l(iy), l
      ld    en_sp_h(iy), h    

      ld    a,    en_x(iy)    
      cp    #0x00
      jp    z,    no_moveX
      jp    nz,   move

   go_moveright:
      ld    hl, #_robot_sp_0      
      ld    en_sp_l(iy), l
      ld    en_sp_h(iy), h 

      ld    a,    en_x(iy) 
      add   en_w(iy)   
      cp    #0x50
      jp    z,    no_moveX

   move:
      ld    a,    en_x(iy)    ;; Cargo la posicion X en A
      add   en_vx(iy)       ;; Le sumo la VX
      ld    en_x(iy),   a     ;; Actualizo la posicion

      call  check_platform_enemy
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ld    a,    11(iy)
      cp    #1             ;; Si llega al final no actualiza
      jp    z,    end_move
      ld    a,    en_x(iy)
      sub   en_vx(iy)
      ld    en_x(iy),   a
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      end_move:
      ret


   no_moveX:

   ld    a,  en_y(iy)
   add   en_vy(iy)
   ld    en_y(iy), a

   ret


enemy_interaction:

   ld    a, (n_enem)                      ;; NUMERO DE Enemigos
   cp    #0
   ret    z
   ld    a, (n_enem)                      ;; NUMERO DE Enemigos
   ld    iy, #enemy_vector          ;; VECTOR DE Enemigos

bucle:

   ex    af, af'                    ;; INTERCAMBIO AF por AF'

;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////

   ld    a, (init_enemy)
   cp    #1                         ;; INICIALIZA EL ENEMIGO

   jp    z, inicializacion_enemy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SI EL ENEMIGO YA ESTA MUERTO
                                    ;; AL SIGUIENTE
   ld    a,    en_life(iy)
   cp    #0
   jp    z,    next_enemy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SI EL ENEMIGO CHOCA CON EL HERO

   call enemy_touch_hero

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPROBAMOS SI TENEMOS DISPARO

   ld    a,    (hero_shot)
   cp    #-1

   jp    z,    not_colision

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPROBACION SI LE DAMOS A UN ENEMIGO
   ld    ix,    #shot_data
   call  colision_check
   ld    a,    (colision)
   cp    #1
   jp    nz,   not_colision         ;; Si no hay colision

   call  quita_vida_enemigo

   ld    a, #-1                     ;; para de disparar
   ld    (hero_shot), a
   ld    a,    (munition)
   call draw_numbers

   call  hero_dispara

   ;; INTENTAMOS CAMBIO DE COLOR EN CASO DE COLISION (3 DISPAROS)


   ld    a,    en_life(iy)
   cp    #0
   jp    p,   aun_no_muere

   aun_no_muere:
      call  s_background

   not_colision:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PINTA Y LIMPIA CADA ENEMIGO
   ld    a, en_life(iy)
   cp    #0

   jp    z, enemy_die               ;; NO TIENE VIDA, DEJO DE PINTAR

      call  enemy_see_hero
      cp #10
      jp nz, no_move_no_draw

      inicializacion_enemy:           ;; inicializa los enemigos
         call  enemy_draw

      no_move_no_draw:

   ld    a, en_life(iy)
   cp    #0
   jp    nz,   next_enemy           ;; EVITO EL ULTIMO LIMPIAR

   enemy_die:
      call  enemy_draw             ;; lo limpia por ultima vez
      ;call  s_background
   next_enemy:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FIN DE COMPORTAMIENTO ENEMIGO
   

      ex    af, af'                    ;; VUELVO A CAMBIAR AF por AF'
      ld    bc, #k_enemy_size           ;; AUMENTO POSICION ARRAY
      add   iy, bc                     ;; LA CARGO EN IY

      dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
      jr    nz, bucle                    ;; SI NO ES CERO BUCLE

      ld    a,    #-1
      ld    (init_enemy), a
   ret  

enemy_draw:
  ld    de, #0xC000         ;; Comienzo de memoria de video
  ld    c, en_x(iy)          ;; Entidad X
  ld    b, en_y(iy)          ;; Entidad Y
  call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

  ;;;HL -> Memoria de video

  ex    de, hl         ;; Cambio lo de HL a DE
  ld    l, en_sp_l(iy)
  ld    h, en_sp_h(iy)
  ;;;ld    hl, #_hero_sp_0  
  ld    c,  en_h(iy)     ;; Alto
  ld    b,  en_w(iy)     ;; Ancho


   call cpct_drawSpriteBlended_asm

   ret 




enemy_see_hero:

   ;; SI EL HEROE ESTÁ EN LA MISMA Y QUE EL HEROE PERO RELATIVAMENTE CERCA

   ;; Restamos uno al slow
   ld    a,    en_slow(iy)
   sub   #1
   ld    en_slow(iy),   a

   jp    nz, no_mira

   ld    a,    en_slowReference(iy)
   ld    en_slow(iy),   a

   ;;if Enemy_y + Enemy_h - hero_y > 0   (1)

   ld    a,    1(iy)
   add   5(iy)
   sub   1(ix)   
  
   jp    p,    comprueba_hero_y

   ;;if hero_y + hero_h - enemy_y > 0   (1)

   ld    a,    1(ix)
   add   5(ix)
   sub   1(iy)


   jp    p,    comprueba_enemy_y
   ret

   comprueba_hero_y:
      ;; if hero_y + hero_w - (enemy_y + enemy_w) (1)

      ld    a,    1(ix)
      add   5(ix)
      sub   1(iy)   
      sub   5(iy)   

   jp    p,    lo_veo
   ret

   comprueba_enemy_y:

   ;; if enemy_y + enemy_w - (hero_y + hero_w) (1)

      ld    a,    1(iy)
      add   5(iy)
      sub   1(ix)   
      sub   5(ix)   

   jp    p,    lo_veo
   ret

   lo_veo:
   ;; ver la direccion en la que va a ir el enemigo -X = 0xFF
   ;;                                                X = 0x01

      ld    a,    0(ix)
      sub   0(iy)


      ld    a,    #0xFF  
      jp m , go_left

      ld    a,    #0x01

      go_left:
      ld    2(iy),   a   
      call  enemy_draw
      ;ld    a,    10(iy)
      ;cp #-1
      ;jp    z,    no_draw
      call  enemy_move
      no_draw:
      ld a, #10
   no_mira: 

   ret

enemy_touch_hero:

   ld    ix,    #hero_data
   call  colision_check

   ld    a,    (colision)
   cp    #1
   jp    nz, al_final        ;; Si no hay colision

   call  ent_background          ;; EN VERDAD LIMPIO EL HERO
   ld    a,    (hero_y)
   ld    e_y(ix),   a
     ld    a,    (hero_x)
   ld    e_x(ix),   a
   call  ent_background
   call  update_draw_life
   ld    a,    e_life(ix)
   dec   a
   ld    e_life(ix), a
   call  update_draw_life

   call  draw_obj
   ld    ix,   #llave
   ld    a,    #1
   ld    obj_open(ix),  a    

   ld    ix,   #puerta
   ld    a,    #0
   ld    obj_open(ix),  a
 
   call  draw_obj
   ;call  carga_todo



  al_final:

   ld    a,    #-1
   ld    (colision), a

   ret

enemy_platform_check:

   ld    a, (n_enem)    ;; NUMERO DE PLATAFORMAS
   ld    ix, #enemy_vector       ;; VECTOR DE PLATAFORMAS

bucle_enem:

   ld    (en_plat_aux), a
   
   call  check_platform_enemy


   en_plat_aux = . + 1
   ld    a, #0                     ;; VUELVO A CAMBIAR AF por AF'
   ld    bc, #k_enemy_size           ;; AUMENTO POSICION ARRAY
   add   iy, bc                     ;; LA CARGO EN IY

   dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   jr    nz, bucle_enem                    ;; SI NO ES CERO BUCLE
ret

quita_vida_enemigo:

   ld    a,    en_life(iy)
   sub   #1
   ld    en_life(iy),   a
ret
