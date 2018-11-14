.include "disparo.h.s"
.include "colision.h.s"
.include "objects.h.s"
.include "main.h.s"
.include "entity.h.s"
.include "cargar_level.h.s"



k_max_num_obj = 3    ;;numero maximo de objetos que puedo tener
k_obj_size = llave_size      ;;tamaño del objetos
obj_vector:
DefineObjects llave,    0x20,   0x80,   0x05,   0x10,   _llave_sp,   1, 1    
DefineObjects puerta,   0x1A,   0x00,   0x08,   0x10,   _puerta_sp,  2, 0
DefineObjects bala,     0x40,   0x6C,   0x05,   0x0C,   _bala_sp,    3, 0



obj_draw:
 ld    de, #0xC000         ;; Comienzo de memoria de video
  ld    c, obj_x(ix)          ;; Entidad X
  ld    b, obj_y(ix)          ;; Entidad Y
  call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

  ;;;HL -> Memoria de video

  ex    de, hl         ;; Cambio lo de HL a DE
  ld    l, obj_sp_l(ix)
  ld    h, obj_sp_h(ix)
  ;;;ld    hl, #_hero_sp_0  
  ld    c,  obj_h(ix)     ;; Alto
  ld    b,  obj_w(ix)     ;; Ancho


   call cpct_drawSpriteBlended_asm

ret

obj_drawY:
 ld    de, #0xC000         ;; Comienzo de memoria de video
  ld    c, obj_x(iy)          ;; Entidad X
  ld    b, obj_y(iy)          ;; Entidad Y
  call  cpct_getScreenPtr_asm  ;; Posicionar en pantalla

  ;;;HL -> Memoria de video

  ex    de, hl         ;; Cambio lo de HL a DE
  ld    l, obj_sp_l(iy)
  ld    h, obj_sp_h(iy)
  ;;;ld    hl, #_hero_sp_0  
  ld    c,  obj_h(iy)     ;; Alto
  ld    b,  obj_w(iy)     ;; Ancho


   call cpct_drawSpriteBlended_asm

ret

;clear_obj:

;  ld    a, obj_col(ix)      ;; Cargo el color en AF
;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;Cambiado con variable automodificable
;  ld    (obj_aux), a
;  ;;ex    af,   af'         ;; Intercambio AF por su registro alternativo 
;  ld    obj_col(ix), #0     ;; El color lo cambio por fondo
;  call  obj_draw          ;; Le digo que dibuje fondo para que borrar
;  ;;ex    af,   af'
;  obj_aux = . + 1
;  ld    a, #0   
;
;  ld    obj_col(ix), a      ;; Reestablezco el color de hero 

;  ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUPONEMOS QUE EL OBJETO ENTRA EN IY
;;                                               Hay que compararlo con IX (hero)



coge_objeto:

   ld    a,    obj_open(ix)               ;; ESTA ABIERTO EL OBJETO?
   cp    #0
   jp    z,    no_coge_objeto

   ld    iy,   #hero_data

   call  colision_check_ex                  ;; Compruebo si colisiona

   ld    a,    (colision)
   cp    #1
   jp    nz,   no_coge_objeto             ;; Si no hay colision No coge obj

      ld    a,    obj_tipo(ix)            ;; Voy viendo que tipo de objeto quiero
      cp    #1
      jp    nz,   no_es_llave             ;; 1 = LLAVE, 2 = PUERTA, 3 = BALA 

         call  comportamiento_llave
         ret
      no_es_llave:

      ld    a,    obj_tipo(ix)
      cp    #2
      jp    nz,   no_es_puerta

         call  comportamiento_puerta
         ret
      no_es_puerta:

      ld    a,    obj_tipo(ix)
      cp    #3
      jp    nz,   no_es_bala

         call  comportamiento_bala
         ret
      no_es_bala:

   no_coge_objeto:

   ret

comportamiento_llave:


ld    a,    #0             ;; SE APAGA LA LLAVE
ld    obj_open(ix),     a
call  obj_draw
ld    iy,   #puerta
ld    a,    #1             ;; Se ABRE la puerta
ld    obj_open(iy),     a

ld    iy,   #puerta        ;; TEMPORAL CUANDO TENGA EL ARRAY FUERA
call  obj_drawY


ld    iy,   #hero_data     ;; reestablezco IY heroe


ret

comportamiento_puerta:
ld    a,    #0             ;; APAGO PUERTA
ld    obj_open(ix),     a
ld    a,    (level)
add   #1
ld    (level),    a
ld    a,    #1
ld    (end_level),   a


ret

comportamiento_bala:
ld    a,    #0             ;; APAGO BALA
ld    obj_open(ix),     a  ;;  
call  obj_draw
ld    a,    (munition)
   call draw_numbers
ld    a,    #9             ;; recargo num balas
ld    (munition), a
ld    a,    (munition)
   call draw_numbers

ret

main_obj:

   ld    a, #k_max_num_obj     ;; NUMERO DE OBJETIVOS
   ld    ix, #obj_vector       ;; VECTOR DE OBJETIVOS

bucle_obj:

   ld    (obj_aux), a


   call  coge_objeto
   ld    a,    obj_open(ix)
   cp    #0
   jp    z,    no_dibuja

   no_dibuja:


   obj_aux = . + 1
   ld    a, #0                     ;; VUELVO A CAMBIAR AF por AF'
   ld    bc, #k_obj_size           ;; AUMENTO POSICION ARRAY
   add   ix, bc                     ;; LA CARGO EN IY

   dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   jp    nz, bucle_obj                    ;; SI NO ES CERO BUCLE
ret

draw_obj:

   ld    a, #k_max_num_obj     ;; NUMERO DE OBJETIVOS
   ld    ix, #obj_vector       ;; VECTOR DE OBJETIVOS

bucle_obj2:

   ld    (obj_aux2), a


   ld    a,    obj_open(ix)
   cp    #0
   jp    z,    no_dibuja2

   call  obj_draw

   no_dibuja2:


   obj_aux2 = . + 1
   ld    a, #0                     ;; VUELVO A CAMBIAR AF por AF'
   ld    bc, #k_obj_size           ;; AUMENTO POSICION ARRAY
   add   ix, bc                     ;; LA CARGO EN IY

   dec   a                          ;; DECREMENTO LA CANTIDAD DEL ARRAY
   jp    nz, bucle_obj2                    ;; SI NO ES CERO BUCLE
ret

