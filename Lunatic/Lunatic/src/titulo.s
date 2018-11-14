.include "cpctelera.h.s"
.include "titulo.h.s"
.include "main.h.s"


.globl _title_sp
.globl _fondotitulo_sp

DefineTitle titulito, 0x07, 0x10, 0x00, 0x00, 0x3C, 0x32, _title_sp

sprite_fondo:     .dw  _fondotitulo_sp      ;;variable q pinta negro el fondo

title_draw:

	ld    de, #0xC000         ;; Comienzo de memoria de video
   	ld    c, t_x(ix)          ;; Entidad X
   	ld    b, t_y(ix)          ;; Entidad Y
  	call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

   ;;HL -> Memoria de video

   	ex    de, hl         ;; Cambio lo de HL a DE
   	ld    l, t_sp_l(ix)
   	ld    h, t_sp_h(ix) 
   	ld    b, t_h(ix)     ;; Alto
   	ld    c, t_w(ix)     ;; Ancho
 
   	call cpct_drawSprite_asm
   
   ret

title_clear:
	ld   hl, #_fondotitulo_sp       ;; El color lo cambio por fondo
   	ld    t_sp_l(ix), l
   	ld    t_sp_h(ix), h
   	call  title_draw           ;; Le digo que dibuje fondo para que borrar 
   
    ld   hl, #_title_sp 
    ld    t_sp_l(ix), l
    ld    t_sp_h(ix), h
  
    ret

title_animation:
	ld 	a, t_y(ix)
	add t_y(ix)
	ld 	t_y(ix), a

	ret

cargar_GameOver:
    ld  ix, #titulito
    ld   hl, #_GameOver_sp
    ld    t_sp_l(ix), l
    ld    t_sp_h(ix), h

    ld  a, #0x1A      ;; HAY QUE CENTRARLO
    ld  t_x(ix),  a
    ld  a, #0x30
    ld  t_y(ix),  a
    ld  a, #0x1E
    ld  t_w(ix),  a
    ld  a, #0x18
    ld  t_h(ix),  a

    call  title_draw


    ld    a, #0xAAA
    go_here:
    dec   a
    halt
    jp    nz, go_here
ret

cargar_titulo:
    ld  ix,   #titulito
    ld  hl,   #_title_sp
    ld    t_sp_l(ix), l
    ld    t_sp_h(ix), h
    ld  a, #0x07      
    ld  t_x(ix),  a
    ld  a, #0x00
    ld  t_y(ix),  a
    ld  a, #0x3C
    ld  t_w(ix),  a
    ld  a, #0x32
    ld  t_h(ix),  a
    call  title_draw

    ld  hl,   #_eleccion_sp
    ld    t_sp_l(ix), l
    ld    t_sp_h(ix), h
    ld  a, #0x0A      ;; HAY QUE CENTRARLO
    ld  t_x(ix),  a
    ld  a, #0x80
    ld  t_y(ix),  a
    ld  a, #0x32
    ld  t_w(ix),  a
    ld  a, #0x2C
    ld  t_h(ix),  a
    call  title_draw
ret