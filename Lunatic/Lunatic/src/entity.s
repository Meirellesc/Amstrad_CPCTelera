.include "cpctelera.h.s"
.include "entity.h.s"
.include "main.h.s"
.include "platform.h.s"
.include "disparo.h.s"
.include "colision.h.s"
.include "funciones_mat.h.s"
.include "cargar_level.h.s"
.include "objects.h.s"


.globl _fondo1_sp
.globl _life_sp

DefineEntity hero_data, 0x01, 0x88, 0x00, 0x00, 0x06, 0x10, _hero_sp_00, ent_moveKeyboard, 0x03   
DefineEntity life, 0x04, 0x06, 0x00, 0x00, 0x04, 0x08, _life_sp, ent_moveKeyboard, 0x03   

separation_life:  .db 0x07             ;;separacion para escribir
life_hero:        .db #0x00
hero_jump:        .db #-1              ;;variable salto
hero_fall:        .db #-1              ;;variable hero is falling
sprite_tmp:       .dw _hero_sp_00       ;;variable del sprite incio hero
sprite_fondo:     .dw _fondo1_sp      ;;variable q pinta negro el fondo
change_sprite_L:     .db #30
change_sprite_R:     .db #30
direccion_mira:      .db #1
pos_y:            .db #100
pos_x:               .db #100


;;Jump Table 
;;up 8 and down 8
;;80hex = 128dec, ends jump
jumpTable:
   .db   #-4, #-4
   .db   #-4, #-4
   .db   #-4, #-4
   .db   #-4, #-4
   .db   #-4, #-4
   .db   #-2, #00, #00, #00
   .db   #0x80



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    ACTUALIZA ENTIDAD
;; Destruye 
;; Entrada IX -> puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_update:
   
   ld     h,  e_upd_h(ix)
   ld     l, e_upd_l(ix)
   jp    (hl)
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    START JUMP
;;Destruye: AF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
startJump:
   ld    a, (hero_jump)    ;; Acceder a hero_jump
   cp    #-1               ;; check if jump is active
   ret   nz                ;;
   
   ld    a, #0
   ld    (hero_jump), a

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    CONTROL JUMP MOVEMENTS
;;Destruye: AF, HL, BC
;;ENTRADA: IX 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
jumpControl:
   ;; check if we are jumping right now
   ld    a, (hero_jump)          ;; A = hero_jump status
   cp    #-1                     ;; A == -1? (-1 es que no salta)
   ret   z                       ;; 

   ;; get jump value
   ld    hl, #jumpTable          ;; HL points to start of jump
   ld    c, a                    ;;
   ld    b, #0                   ;; BC = A(offset)
   add   hl, bc                  ;; HL += BC

   ;; check end of jumping
   ld    a, (hl)                 ;; A = jump movement
   cp    #0x80                   ;; jump value == 0x80? end of jump
   jr    z, end_of_jump          ;; If 0x80, end of jump

   ;; do jump movement
   ld    b, a                    ;; B = jump movement
   ld    a, e_y(ix)              ;; A = e_y
   add   b                       ;; A += B (add jump)
   ld    e_y(ix), a              ;; update e_y value
   ld    a,    e_y(ix)
   cp    #24
   jp    nz,   no_para_salto

   ld    a, e_y(ix)              ;; A = e_y
   sub   b                       ;; A += B (add jump)
   ld    e_y(ix), a  

   ld    a, #-1         ;; A = hero_jump
   ld    (hero_jump), a 
   call    plat_checkAll
  
   ret
   no_para_salto:

   

   ;; increment hero_jump index
   ld    a, (hero_jump)          ;; A = hero_jump
   inc   a                       ;;
   ld    (hero_jump), a          ;; hero_jump++

   ;call ent_check
   ret

   ;;put -1 in the jump index when jump ended
end_of_jump:
      call  plat_checkAll            ;; Patch by dont repeat jump
      ld    a, #-1               ;;
      ld    (hero_jump), a       ;; hero_jump=-1
      ld    a,    (direccion_mira)
      cp    #1
      ld    hl, #_hero_sp_00    ;;sprite hero jump
      jp    z,    cae_sprite
      ld    hl, #_hero_sp_06    ;;sprite hero jump
      cae_sprite:
      call  poner_sprite_hero
      ld    e_sp_l(ix), l
      ld    e_sp_h(ix), h
      ld    (sprite_tmp), hl

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    MOVER ENTIDAD TECLADO
;; Destruye: HL
;; Entrada IX -> puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_moveKeyboard:

   
  call cpct_scanKeyboard_asm

   ld    hl, #Key_W 
   call  cpct_isKeyPressed_asm
   jr    z, w_no_pulsada

      call  sprite_salto
      ld    e_sp_l(ix), l
      ld    e_sp_h(ix), h
      ld    (sprite_tmp), hl

      ld a, (hero_fall)          ;; HERO IS FALLING NO JUMP
      cp #-1
      jp nz, w_no_pulsada

         call startJump
w_no_pulsada:
   
   ld    hl, #Key_A 
   call  cpct_isKeyPressed_asm

   jr    z, a_no_pulsada
      call  sprite_hero_L
      ld    (sprite_tmp), hl

      ld a, #0
      ld (shot_direction), a
      ld a, e_x(ix)
      cp #0
      jr z, a_no_pulsada
      ld    a,    (colision_borde)
      cp    #2
      jp    z,    a_no_pulsada
      ld    a,    (colision_borde)
      cp    #3
      jp    z,    a_no_pulsada
         ld    e_vx(ix),   #-1
      jp    l_no_pulsada
a_no_pulsada:


   ld    hl, #Key_D 
   call  cpct_isKeyPressed_asm
   jr    z, d_no_pulsada
      call sprite_hero_R
      ld    (sprite_tmp), hl

      ld a, #1
      ld (shot_direction), a
      ld a, e_x(ix)
      cp #80-8
      jr z, d_no_pulsada
      ld    a,    (colision_borde)
      cp    #1
      jp    z,    d_no_pulsada
      ld    a,    (colision_borde)
      cp    #3
      jp    z,    d_no_pulsada
         ld    e_vx(ix),   #1 
      jp    l_no_pulsada
d_no_pulsada:


   ld    hl, #Key_M 
   call  cpct_isKeyPressed_asm
   jr    z, l_no_pulsada

      call startShot

l_no_pulsada:

   call  ent_move
   ld    e_vx(ix),   #0
   ld    e_vy(ix),   #0

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    MOVER ENTIDAD
;; Destruye 
;; Entrada IX -> puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_move:

   ld    a,  e_x(ix)    ;; Cargo la posicion X en A
   add   e_vx(ix)       ;; Le sumo la VX
   ld    e_x(ix), a     ;; Actualizo la posicion

   ld    a,  e_y(ix)
   add   e_vy(ix)
   ld    e_y(ix), a

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    DIBUJAR ENTIDAD
;; Destruye DE,AF,BC,HL
;; Entrada IX -> puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_draw:



;(2B DE) memory Destination video memory pointer
;(1B C ) height Sprite Height in bytes (>0)
;(1B B ) width  Sprite Width in bytes (>0) (Beware, not in pixels!)
;(2B HL) sprite Source Sprite Pointer (array with pixel data)

  
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ld    de, #0xC000         ;; Comienzo de memoria de video
  ld    c, e_x(ix)          ;; Entidad X
  ld    b, e_y(ix)          ;; Entidad Y
  call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

  ;;;HL -> Memoria de video

  ex    de, hl         ;; Cambio lo de HL a DE
  ld    l, e_sp_l(ix)
  ld    h, e_sp_h(ix)
  ;;;ld    hl, #_hero_sp_0  
  ld    b, e_h(ix)     ;; Alto
  ld    c, e_w(ix)     ;; Ancho
 
  call cpct_drawSprite_asm

   
   ret 


ent_background:

ld    de, #0xC000         ;; Comienzo de memoria de video
  ld    c, e_x(ix)          ;; Entidad X
  ld    b, e_y(ix)          ;; Entidad Y
  call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

  ;;;HL -> Memoria de video

  ex    de, hl         ;; Cambio lo de HL a DE
  ld    l, e_sp_l(ix)
  ld    h, e_sp_h(ix)
  ;;;ld    hl, #_hero_sp_0  
  ld    c,  e_h(ix)     ;; Alto
  ld    b,  e_w(ix)     ;; Ancho


   call cpct_drawSpriteBlended_asm

  
   ret
 




ent_isJumping_or_canFall:

   ld    a,    (hero_fall)
   cp    #-1
   jp    nz,   no_jump  ;; if is falling, hero cant jump


   ld    a,    (hero_jump)
   cp    #-1
   jp    z,    no_jump     ;;Check is jumping or is falling

   call jumpControl        ;; Need clean A?

   ret 

   no_jump:


      call ent_fall        ;; Need clean A?
      ld    a,    #0


ret

update_draw_life:
   
   ;call update_clear_life


   ld    ix,   #hero_data

   ld    a,    e_life(ix)
   ld    (life_hero),   a

   ld    ix,   #life

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PINTAMOS VIDAS
   draw_life:
   
   call  ent_background               ;; PINTO

   ld    a,    e_x(ix)
   add   #0x04
   ld    e_x(ix),    a           ;; Aumento espacio pintado

   ld    a,    (life_hero)
   dec   a                    ;; Decremento vida
   ld    (life_hero),   a
                              ;;;
   jp    m,    end_draw       ;;; SI ES MENOR, EL HEROE HA MUERTO
                              ;;;
   jp    nz,    draw_life
  

  end_draw: 
   ld    a,    #0x04
   ld    e_x(ix),    a 


   ld    ix,   #hero_data
   ;;call clear_shot
ret


update_clear_life:
   
   ld    ix,   #hero_data

   ld    a,    e_life(ix)
   add   #0x01
   ld    (life_hero),   a

   ld    ix,   #life

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PINTAMOS VIDAS
   clear_life:
   
   call ent_background               ;; PINTO

   ld    a,    e_x(ix)
   add   #0x04
   ld    e_x(ix),    a           ;; Aumento espacio pintado

   ld    a,    (life_hero)
   dec   a                    ;; Decremento vida
   ld    (life_hero),   a
   jp    nz,    clear_life


   ld    a,    #0x04
   ld    e_x(ix),    a 


   ld    ix,   #hero_data
   ;;
ret

hero_dispara:
   ld    a, (munition)
   dec   a
   ld    (munition), a
      ld    a,    (munition)
   call draw_numbers
ret

sprite_hero_R:
   ld    a,    #1
   ld    (direccion_mira), a

   ld    a,    #30
   ld    (change_sprite_L),   a

   ld    a,    (change_sprite_R)
   cp    #1
   jp    z, empiezo_again

   ld    a,    (change_sprite_R)
   dec   a
   ld    (change_sprite_R),   a
   cp    #5
   jp    m,    hero_5

   ld    a,    (change_sprite_R)
   cp    #10
   jp    m,    hero_4

   ld    a,    (change_sprite_R)
   cp    #15
   jp    m,    hero_3

   ld    a,    (change_sprite_R)
   cp    #20
   jp    m,    hero_2

   ld    a,    (change_sprite_R)
   cp    #25
   jp    m,    hero_1

   hero_1:
   ld    hl,   #_hero_sp_00
   call  poner_sprite_hero
   ret
   hero_2:
   ld    hl,   #_hero_sp_01
   call  poner_sprite_hero
   ret
   hero_3:
   ld    hl,   #_hero_sp_02
   call  poner_sprite_hero
   ret
   hero_4:
   ld    hl,   #_hero_sp_03
   call  poner_sprite_hero
   ret
   hero_5:
   ld    hl,   #_hero_sp_04
   call  poner_sprite_hero
   ret
   empiezo_again:
   ld    a,    #30
   ld    (change_sprite_R),   a
   ld    hl,   #_hero_sp_04
   call  poner_sprite_hero
ret

sprite_hero_L:
   ld    a,    #-1
   ld    (direccion_mira), a
   ld    a,    #30
   ld    (change_sprite_R),   a

   ld    a,    (change_sprite_L)
   cp    #1
   jp    z, empiezo_again_L

   ld    a,    (change_sprite_L)
   dec   a
   ld    (change_sprite_L),   a
   cp    #5
   jp    m,    hero_5_L

   ld    a,    (change_sprite_L)
   cp    #10
   jp    m,    hero_4_L

   ld    a,    (change_sprite_L)
   cp    #15
   jp    m,    hero_3_L

   ld    a,    (change_sprite_L)
   cp    #20
   jp    m,    hero_2_L

   ld    a,    (change_sprite_L)
   cp    #25
   jp    m,    hero_1_L

   hero_1_L:
   ld    hl,   #_hero_sp_06
   call  poner_sprite_hero
   ret
   hero_2_L:
   ld    hl,   #_hero_sp_07
   call  poner_sprite_hero
   ret
   hero_3_L:
   ld    hl,   #_hero_sp_08
   call  poner_sprite_hero
   ret
   hero_4_L:
   ld    hl,   #_hero_sp_09
   call  poner_sprite_hero
   ret
   hero_5_L:
   ld    hl,   #_hero_sp_10
   call  poner_sprite_hero
   ret
   empiezo_again_L:
   ld    a,    #30
   ld    (change_sprite_L),   a
   ld    hl,   #_hero_sp_10
   call  poner_sprite_hero
ret


poner_sprite_hero:

   ld    e_sp_l(ix),    l
   ld    e_sp_h(ix),    h

ret

sprite_salto:

   ld    a,    (direccion_mira)
   cp #-1
   ld    hl,   #_hero_sp_11
   jp    z, mira_izq
   ld    hl,   #_hero_sp_05
   mira_izq:

   call  poner_sprite_hero
ret



