;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "entity.h.s"
.include "main.h.s"
.include "platform.h.s"
.include "colision.h.s"
.include "enemy.h.s"
.include "disparo.h.s"
.include "titulo.h.s"
.include "cargar_level.h.s"
.include "load_level.h.s"
.include "keyboard/keyboard.s"


.globl _robot_pal    ;;uso estos colores tonos morados


;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA
.area _CODE



;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call  cpct_disableFirmware_asm

   ld 	c, #0                    ;; Change video mode
   call	cpct_setVideoMode_asm    ;;
   
   ld    hl, #_robot_pal      ;; palette
   ld    de, #16                  ;; 16 colors
   call  cpct_setPalette_asm      ;; set it

   ld    hl, #0x1410              ;; black border color
   call  cpct_setPALColour_asm    ;; change border color


     

  ;; ld    a, #30
   ;;call  plat_checkAll_draw

   ;;call  update_draw_life


;draw_title_animation:


   
reempezar:
   ld    a,    #0
   ld    (level), a
   call  cargar_nivel
   ld    ix,   #hero_data
   ld    a,    #0x03
   ld    e_life(ix),    a
segundaC:
   call  cargar_nivel3
p_no_pulsada:

   call cpct_scanKeyboard_asm
   call cargar_titulo
    ld    hl, #Key_C 
   call  cpct_isKeyPressed_asm
   jr    z, c_no_pulsada
   mamama:
   call  cargar_nivel2
   call cpct_scanKeyboard_asm
   ld    hl, #Key_C 
   call  cpct_isKeyPressed_asm
   jp    z, segundaC
   jp    mamama



   c_no_pulsada:
   ld    hl, #Key_P 
   call  cpct_isKeyPressed_asm
   jr    z, p_no_pulsada

   ld    a,    #1
   ld    (level), a

   
   recargar:
   ld    a,    #0
   ld    (end_level),   a
   call  cargar_nivel
   ld    a,    (munition)
   call  draw_numbers
   call  draw_obj
   ld    ix,   #hero_data
   call  ent_background
   call  update_draw_life
   
   ;; Loop forever
loop:
   ;;;;;;; SOLO PINTAR Y LIMPIAR SI ES NECESARIO (PLAT(OK), ENEM(OK), HERO)

   
   ld    a,    (end_level)
   cp    #1

   jp    z, recargar                ;; SI END LEVEL = 1 carga siguiente level



   call main_obj

   ld ix, #hero_data


   ld    a,    e_life(ix)
   cp    #0
   jp    nz, no_GameOver
   

   call cargar_GameOver
   
   ;ld    a,    #0
   ;ld    (level), a
   ld    a,    #0xFFFFF
   fin:
   
   dec   a
   jp    nz,   fin
   jp    reempezar
   no_GameOver:
   

   

   ld ix, #hero_data                      ;//////// HEROE
   
   call ent_background
   call plat_checkAll_border
   call ent_update
   call ent_isJumping_or_canFall
   call ent_background

   ld a, (hero_shot)                      ;///////// SHOT
   cp #-1
   jp z, no_draw_shot
      ld ix, #shot_data
      call  s_background
      call shotControl

   no_draw_shot:


   call enemy_interaction                 ;////////// ENEMY


   call cpct_waitVSYNC_asm

   jr    loop
