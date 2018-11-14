.include "cpctelera.h.s"
.include "entity.h.s"
.include "main.h.s"
.include "platform.h.s"
.include "disparo.h.s"
.include "numbers.h.s"


ShotTableRight:
   .db   #1, #1, #1
   .db   #1, #1, #1
   .db   #1, #1, #1
   .db   #1, #1, #1
   .db   #1, #1, #1, #00, #00
   .db   #00
   .db   #0x80

ShotTableLeft:
   .db   #-1, #-1, #-1
   .db   #-1, #-1, #-1
   .db   #-1, #-1, #-1
   .db   #-1, #-1, #-1
   .db   #-1, #-1, #-1, #00, #00
   .db   #00
   .db   #0x80

DefineDisparo	shot_data, 0x00,0x00, 0x00, 0x00, 0x04, 0x06, _disparo_sp_0

hero_shot:	.db #-1
shot_direction:            .db	#1			;; Direction: -X = 0 or X = 1
final_direction:          .db #1
munition:	           .db #9
pos_bala_x:             .db#100
pos_bala_y:             .db#100



startShot:
   
   ld    a ,   (munition)
   cp #0
   jp    z, no_munition   
   ld    a, (hero_shot)    ;; Acceder a hero_jump
   cp    #-1               ;; check if shot is active
   ret   nz                ;;
   ld    ix,   #shot_data

   ld    a, #0
   ld    (hero_shot), a
   ld	iy,	#hero_data
   ld	ix, #shot_data

   

   ld	a,	(shot_direction)
   ld	(final_direction), a
   cp #0
   jp 	z, shot_left
	   ld	a,	e_y(iy)
	   add	e_w(iy)
	   ld	s_y(ix), a

	   ld 	a,	e_x(iy)
	   add	e_w(iy)
	   ld	s_x(ix), a
      
      ; SI SALTA NO LIMPIO
      ld    a, (hero_jump)
      cp    #-1
	   jp   z,    limpio_el_primer_tiro

      ld    ix,   #hero_data
      call  ent_background
      ld    ix,   #shot_data
      ret

   shot_left:

   	   ld	a,	e_y(iy)
	   add	e_w(iy)
	   ld	s_y(ix), a

	   ld 	a,	e_x(iy)
	   sub	s_w(iy)
	   ld	s_x(ix), a
      ld    a, (hero_jump)
      cp    #-1

      jp   z,    limpio_el_primer_tiro
      ld    ix,   #hero_data
      call  ent_background
      ld    ix,   #shot_data
      ret
      limpio_el_primer_tiro:
      call s_background
   no_munition:
   ret

shotControl:
   
   ;; check if we are jumping right now
   ld    a, (hero_shot)          ;; A = hero_shot status
   cp    #-1                     ;; A == -1? (-1 es que no salta)
   ret   z                       ;; 

   ;; get shot value

   ld    hl,   #_disparo_sp_0
   ld    s_sp_l(ix),    l
   ld    s_sp_h(ix),    h  
   ld    hl, #ShotTableLeft         ;; HL points to start of shot
   ld 	 a, (final_direction)
   cp 	 #0
   jp 	 z,	continue_shot
      ld    hl,   #_disparo_sp_1
      ld    s_sp_l(ix),    l
      ld    s_sp_h(ix),    h     
		ld    hl, #ShotTableRight         ;; HL points to start of shot 
         	

continue_shot: 
   ld    a, (hero_shot)          ;; A = hero_shot status
   ld    c, a                    ;;
   ld    b, #0                   ;; BC = A(offset)
   add   hl, bc                  ;; HL += BC


   ;; check end of jumping
   ld    a, (hl)                 ;; A = shot movement
   cp    #0x80                   ;; shot value == 0x80? end of shot
   jr    z, end_shot          	 ;; If 0x80, end of shot

   ;; do shot movement
   ld    b, a                    ;; B = shot movement
   ld    a, s_x(ix)              ;; A = e_x
   add   b                       ;; A += B (add shot)

   ld    s_x(ix), a              ;; update e_x value

   ld    a,    s_x(ix)
   cp    #0x4C
   jp    z, se_sale
   jp    m, se_sale

   ld    a,    s_x(ix)
   sub   b
   ld    s_x(ix), a 
   jp    end_shot
   
   se_sale:
   ld    a,    s_x(ix)
   cp    #0x00
   jp    p, sigue_disparo
   
   ld    a,    s_x(ix)
   sub   b
   ld    s_x(ix), a 
   jp    end_shot
   sigue_disparo:
   ;; increment hero_shot index
   ld    a, (hero_shot)          ;; A = hero_shot
   inc   a                       ;;
   ld    (hero_shot), a          ;; hero_shot++

   call s_background

   ret

   ;;put -1 in the shot index when shot ended
end_shot:

	ld    a, #-1               ;;
   ld    (hero_shot), a       ;; hero_shot=-1
   ;call s_background
   ld    a,    (munition)
   call draw_numbers
   ld    a, (munition)
   sub   #1
   ld    (munition), a
   ld    a,    (munition)
   call draw_numbers

	ret


s_background:
ld    de, #0xC000         ;; Comienzo de memoria de video
  ld    c, s_x(ix)          ;; Entidad X
  ld    b, s_y(ix)          ;; Entidad Y
  call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

  ;;;HL -> Memoria de video

  ex    de, hl         ;; Cambio lo de HL a DE
  ld    l, s_sp_l(ix)
  ld    h, s_sp_h(ix)
  ;;;ld    hl, #_hero_sp_0  
  ld    c,  s_h(ix)     ;; Alto
  ld    b,  s_w(ix)     ;; Ancho


   call cpct_drawSpriteBlended_asm
ret

  


s_draw:
   ld    de, #0xC000         ;; Comienzo de memoria de video
   ld    c, e_x(ix)          ;; Entidad X
   ld    b, e_y(ix)          ;; Entidad Y
   call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

   ;;HL -> Memoria de video

   ex    de, hl         ;; Cambio lo de HL a DE
   ld    l, e_sp_l(ix)
   ld    h, e_sp_h(ix)
   ;;ld    hl, #_hero_sp_0  
   ld    b, e_h(ix)     ;; Alto
   ld    c, e_w(ix)     ;; Ancho
 
   call cpct_drawSprite_asm

   ret 