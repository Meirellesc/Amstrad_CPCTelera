//-----------------------------LICENSE NOTICE------------------------------------
//  This file is part of CPCtelera: An Amstrad CPC Game Engine
//  Copyright (C) 2015 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------

#include <cpctelera.h>
#include "tiles.h"
#include "map1.h"
#include "map2.h"
#include "map3.h"
#include "hero.h"
#include "retropolis.h"

__at(0x200) const unsigned char G_song[2342];

#define SI 1
#define NO 0

#define ANCHO  80
#define ALTO  160

#define ANCHOPROTA   (16/2)
#define ALTOPROTA    27

#define ORIGEN_MAPA_Y   68
#define ORIGEN_MAPA     cpctm_screenPtr(CPCT_VMEM_START, 0, ORIGEN_MAPA_Y)

typedef struct {
   u8  mira;
   u8* sprite;
} TFrame;

typedef struct {
   u8 x, y;
   u8 px, py;
   u8 mover;
   u8 estado;
   TFrame* frame;
   u8 nframe;
   u8 mira;
   u8 salto;
} TProta;

// Mirando hacia
enum {
      M_derecha   = 0
   ,  M_izquierda
} EMirar;

// Eventos del personaje
enum {
      EV_detenerse = 0
   ,  EV_moverse
   ,  EV_saltar
   ,  EV_numEventos
} EEventos;

// Estados del personaje
enum {
      ST_quieto  = 0
   ,  ST_andando
   ,  ST_prepSalto
   ,  ST_saltando
   ,  ST_cayendo
   ,  ST_aterrizando
   ,  ST_numEstados
} EEstados;

// Mapas
#define NUM_MAPAS 3
u8* const mapas[NUM_MAPAS] = { g_map1, g_map2, g_map3 };

// Estado de Sprites
#define HERO_FRAMES  16
const TFrame g_frames[HERO_FRAMES] = {
      { M_derecha, g_hero_00 }   ,  { M_derecha, g_hero_01 }
   ,  { M_derecha, g_hero_02 }   ,  { M_derecha, g_hero_03 }
   ,  { M_derecha, g_hero_04 }   ,  { M_derecha, g_hero_05 }
   ,  { M_derecha, g_hero_06 }   ,  { M_derecha, g_hero_07 }
   ,  { M_derecha, g_hero_08 }   ,  { M_derecha, g_hero_09 }
   ,  { M_derecha, g_hero_10 }   ,  { M_derecha, g_hero_11 }
   ,  { M_derecha, g_hero_12 }   ,  { M_derecha, g_hero_13 }
   ,  { M_derecha, g_hero_14 }   ,  { M_derecha, g_hero_15 }
};

// Animaciones
#define ANIM_PAUSA      4
#define ANDAR_FRAMES    5
#define SALTAR_FRAMES   4
#define CAER_FRAMES     2
TFrame* const anim_andar[ANDAR_FRAMES] = { 
   &g_frames[1], &g_frames[2], &g_frames[3], &g_frames[4], &g_frames[5]
};
TFrame* const anim_saltar[SALTAR_FRAMES] = { 
   &g_frames[8], &g_frames[9], &g_frames[10], &g_frames[11]
};
TFrame* const anim_caer[CAER_FRAMES] = { 
   &g_frames[14], &g_frames[15]
};

// Control de salto
#define PASOS_SALTO  20
const CPCT_2BITARRAY(g_tablaSalto, PASOS_SALTO) = {
     CPCT_ENCODE2BITS(3, 3, 3, 3) 
   , CPCT_ENCODE2BITS(3, 3, 2, 2)
   , CPCT_ENCODE2BITS(2, 2, 2, 1)
   , CPCT_ENCODE2BITS(1, 1, 1, 1)
   , CPCT_ENCODE2BITS(1, 0, 0, 0)
};

// Máscara de transparencia
cpctm_createTransparentMaskTable(g_tablatrans, 0x100, M0, 0);

u8* mapa;
u8  num_mapa;
TProta prota;

void playmusic() {
   __asm 
      exx
      .db #0x08
      push af
      push bc
      push de
      push hl
      call _cpct_akp_musicPlay
      pop hl
      pop de
      pop bc
      pop af
      .db #0x08
      exx
   __endasm;
}

void interrupcion() {
   static u8 kk;

   if (++kk == 5) {
      playmusic();
      cpct_scanKeyboard_if();
      kk = 0;
   }
}

void dibujarMapa() {
   cpct_etm_drawTilemap2x4(g_map1_W, g_map1_H, ORIGEN_MAPA, mapa);
}

void asignarFrame(TFrame **animacion) {
   prota.frame = animacion[prota.nframe / ANIM_PAUSA];
}

void girarFrame() {
   TFrame* f = prota.frame;
   if (f->mira != prota.mira) {
      cpct_hflipSpriteM0(G_HERO_00_W, G_HERO_00_H, f->sprite);
      f->mira = prota.mira;
   }
}

void seleccionarSpriteProta() {
   switch(prota.estado) {
      case ST_quieto:      { prota.frame = &g_frames[0];  break; }
      case ST_andando:     { asignarFrame(anim_andar);    break; }
      case ST_prepSalto:   { asignarFrame(anim_saltar);   break; }
      case ST_saltando:    { prota.frame = &g_frames[12]; break; }
      case ST_cayendo:     { prota.frame = &g_frames[13]; break; }
      case ST_aterrizando: { asignarFrame(anim_caer);     break; }
   }
   girarFrame();
}

void dibujarProta() {
   u8* pvmem = cpct_getScreenPtr(CPCT_VMEM_START, prota.x, prota.y);
   cpct_drawSpriteMaskedAlignedTable(prota.frame->sprite, pvmem, G_HERO_00_W, G_HERO_00_H, g_tablatrans);
}

void borrarProta() {
   u8 w = 4 + (prota.px & 1);
   u8 h = 7 + (prota.py & 3 ? 1 : 0);
   cpct_etm_drawTileBox2x4(prota.px / 2, (prota.py-ORIGEN_MAPA_Y) / 4, w, h, 40, ORIGEN_MAPA, mapa);
}

u8* obtenerTilePtr(u8 x, u8 y) {
   return mapa + (y-ORIGEN_MAPA_Y)/4*g_map1_W + x/2;
}

void ajustarAlSuelo() {
   prota.y = (prota.y & 0b11111100) + 1;
}

u8 sobreSuelo() {
   u8* tileSuelo = obtenerTilePtr(prota.x+2, prota.y + ALTOPROTA+1);
   if (*tileSuelo < 4 || *(tileSuelo+G_HERO_00_W/2-3) < 4)
      return 1;

   return 0;
}

void avanzarMapa() {
   if (num_mapa < NUM_MAPAS-1) {
      mapa = mapas[++num_mapa];
      prota.x = prota.px = 0;
      prota.mover = SI;
      dibujarMapa();
   }
}

void retrocederMapa() {
   if (num_mapa > 0) {
      mapa = mapas[--num_mapa];
      prota.x = prota.px = ANCHO - G_HERO_00_W;
      prota.mover = SI;
      dibujarMapa();
   }
}

void moverDerecha() { 
   if (prota.x + G_HERO_00_W < ANCHO) {
      prota.x++;
      prota.mira  = M_derecha;
   } else {
      avanzarMapa();
   }
}

void moverIzquierda() {
   if (prota.x > 0) {
      prota.x--;
      prota.mira  = M_izquierda;
   } else {
      retrocederMapa();
   }
}

void redibujarProta() {
   borrarProta();
   prota.px = prota.x;
   prota.py = prota.y;
   dibujarProta();
}

u8 compruebaTeclas(const cpct_keyID* k, u8 numk) {
   u8 i;
//   cpct_scanKeyboard_if();
   if (cpct_isAnyKeyPressed()) {
      for(i=1; i <= numk; i++, k++) {
         if (cpct_isKeyPressed(*k))
            return i;
      }
   }
   return 0;
}

void quieto_entrar();

void aterrizando_entrar() {
   prota.nframe = 0;
   prota.estado = ST_aterrizando;
   prota.mover  = SI;
}

void aterrizando() {
   prota.mover = SI;
   if(++prota.nframe == CAER_FRAMES*ANIM_PAUSA)
      quieto_entrar();      
}

void cayendo_entrar() {
   prota.estado = ST_cayendo;
   prota.mover  = SI;
   prota.salto  = PASOS_SALTO - 3;
}

void descender() {
   prota.y += cpct_get2Bits(g_tablaSalto, prota.salto);
   if (prota.salto > 1)
      prota.salto--;
}

void cayendo() {
   static const cpct_keyID keys[2] = {Key_CursorRight, Key_CursorLeft};
   u8 k = compruebaTeclas(keys, 2);
   switch(k) {
      case 0: break; // Nada que hacer
      case 1: moverDerecha();   break;
      case 2: moverIzquierda(); break;
   }
   descender();
   if (sobreSuelo()) {
      ajustarAlSuelo();
      aterrizando_entrar();
   }
   prota.mover=SI;
}

void quieto_entrar() {
   prota.estado = ST_quieto;
   prota.mover  = SI;
}

void andando_entrar(u8 mirar);
void prepSalto_entrar();

void quieto() {
   static const cpct_keyID keys[3] = {Key_CursorUp, Key_CursorRight, Key_CursorLeft};
   u8 k = compruebaTeclas(keys, 3);
   switch(k) {
      case 0: break; // Nada que hacer
      case 1: prepSalto_entrar(); break;
      case 2: andando_entrar(M_derecha);   break;
      case 3: andando_entrar(M_izquierda); break;
   }
}

void ascender() {
   prota.y -= cpct_get2Bits(g_tablaSalto, prota.salto);
   if (prota.y < ORIGEN_MAPA_Y)
      prota.y = ORIGEN_MAPA_Y;
   if (++prota.salto == PASOS_SALTO)
      cayendo_entrar();
}

void saltando_entrar() {
   prota.estado = ST_saltando;
   prota.mover  = SI;
   prota.salto  = 0;
}

void saltando() {
   if (!cpct_isKeyPressed(Key_CursorUp)) {
      cayendo_entrar();
   } else {
      static const cpct_keyID keys[2] = {Key_CursorRight, Key_CursorLeft};
      u8 k = compruebaTeclas(keys, 2);
      switch(k) {
         case 0: break;
         case 1: moverDerecha();   break;
         case 2: moverIzquierda(); break;
      }
      ascender();
      prota.mover = SI;
   }
}


void prepSalto_entrar() {
   prota.nframe = 0;
   prota.estado = ST_prepSalto;
   prota.mover  = SI;
}

void prepSalto_animar() {
   if (++prota.nframe == SALTAR_FRAMES*ANIM_PAUSA)
      saltando_entrar();
}

void prepSalto() {
   static const cpct_keyID keys[1] = {Key_CursorUp};
   u8 k = compruebaTeclas(keys, 1);
   switch(k) {
      case 0: quieto_entrar(); break; 
      case 1: prepSalto_animar(); break;
   }
   prota.mover = SI;
}

void andando_entrar(u8 mirar) {
   prota.nframe = 0;
   prota.estado = ST_andando;
   prota.mira   = mirar;
   prota.mover  = SI;
}

void andando_animar(u8 mirar) {
   prota.mira  = mirar;
   if(++prota.nframe == ANDAR_FRAMES*ANIM_PAUSA)
      prota.nframe = 0;
}

void andando() {
   static const cpct_keyID keys[3] = {Key_CursorUp, Key_CursorRight, Key_CursorLeft};
   u8 k = compruebaTeclas(keys, 3);
   switch(k) {
      case 0: quieto_entrar();    break;
      case 1: prepSalto_entrar(); break;
      case 2: moverDerecha();   andando_animar(M_derecha);   break;
      case 3: moverIzquierda(); andando_animar(M_izquierda); break;
   }
   prota.mover = SI;
   if (!sobreSuelo())
      cayendo_entrar();
}

void ejecutarEstado() {
   switch(prota.estado) {
      case ST_quieto:      quieto();      break;
      case ST_andando:     andando();     break;
      case ST_prepSalto:   prepSalto();   break;
      case ST_saltando:    saltando();    break;
      case ST_cayendo:     cayendo();     break;
      case ST_aterrizando: aterrizando(); break;
   }
}

void inicializar() {
   cpct_disableFirmware();
   cpct_setVideoMode(0);
   cpct_setPalette(g_palette, 16);
   cpct_setBorder(HW_BLACK);
   cpct_etm_setTileset2x4(g_tileset);
   cpct_drawSprite(g_retropolis_0, cpctm_screenPtr(CPCT_VMEM_START,  0, 0), G_RETROPOLIS_0_W, G_RETROPOLIS_0_H);
   cpct_drawSprite(g_retropolis_1, cpctm_screenPtr(CPCT_VMEM_START, 40, 0), G_RETROPOLIS_0_W, G_RETROPOLIS_0_H);
   mapa = g_map1;
   num_mapa = 0;
   prota.x = prota.px = 0;
   prota.y = prota.py = 100;
   prota.estado = ST_quieto;
   prota.mira   = M_derecha;
   prota.nframe = 0;
   prota.mover  = NO;
   prota.frame  = &g_frames[0];
   dibujarMapa();
   dibujarProta();
   cpct_akp_musicInit(G_song);
   cpct_setInterruptHandler(interrupcion);
}

void main(void) {
   inicializar();

   // Loop forever
   while (1) {
      ejecutarEstado();
      if (prota.mover) {
         seleccionarSpriteProta();
         cpct_waitVSYNC();
         redibujarProta();
         prota.mover = NO;
      }
   }
}
