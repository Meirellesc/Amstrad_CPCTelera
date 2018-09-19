#include "hero.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
// Tile g_hero_00: 16x27 pixels, 8x27 bytes.
const u8 g_hero_00[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x39, 0x1e, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x30, 0x25, 0x4e, 0x00,
	0x00, 0x00, 0x51, 0xb2, 0x30, 0x30, 0xcc, 0x88,
	0x00, 0x00, 0xf3, 0xe9, 0x30, 0x30, 0x64, 0x88,
	0x00, 0x51, 0xf6, 0xc3, 0xc6, 0x30, 0x64, 0x82,
	0x00, 0xf3, 0xe9, 0xc3, 0x98, 0x30, 0x64, 0x82,
	0x00, 0xf6, 0xe9, 0x82, 0x98, 0x30, 0x64, 0x82,
	0x51, 0xf6, 0xe9, 0x82, 0x98, 0x30, 0xcc, 0xc3,
	0x51, 0xfc, 0xa8, 0xc3, 0x92, 0x30, 0xcc, 0xc3,
	0xf3, 0xfc, 0x00, 0x41, 0x92, 0x64, 0xcc, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x10, 0x20, 0xcc, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0x30, 0x00, 0xcc, 0x00,
	0xa2, 0x00, 0x00, 0x00, 0x30, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x00, 0x00, 0xfc, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x20, 0x00, 0xcc, 0x88
};

// Tile g_hero_01: 16x27 pixels, 8x27 bytes.
const u8 g_hero_01[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x1b, 0x28,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0xb2, 0x25, 0x1a, 0x00,
	0x00, 0x00, 0x51, 0xe9, 0x92, 0x30, 0x30, 0x88,
	0x00, 0x00, 0xf6, 0xe9, 0xc3, 0x30, 0x30, 0x88,
	0x00, 0x51, 0xfc, 0xe9, 0x92, 0x30, 0x30, 0x82,
	0x00, 0xf6, 0xfc, 0xe9, 0x92, 0x30, 0x30, 0x82,
	0x00, 0xf6, 0xfc, 0x41, 0x92, 0x30, 0x30, 0x82,
	0x51, 0xfc, 0xa8, 0x41, 0xc3, 0x30, 0x30, 0xc3,
	0x51, 0xfc, 0xa8, 0x00, 0xc3, 0x92, 0x30, 0xc3,
	0xf6, 0xfc, 0x00, 0x00, 0x41, 0x92, 0x30, 0x00,
	0xf6, 0xfc, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0x44, 0x30, 0x20, 0x00,
	0x54, 0x00, 0x00, 0x00, 0x44, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xcc, 0x10, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x44, 0x88, 0x00, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x44, 0x88, 0x00, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x44, 0xcc, 0x00, 0x30, 0x20
};

// Tile g_hero_02: 16x27 pixels, 8x27 bytes.
const u8 g_hero_02[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x30, 0x20,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x1a,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x93,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x36,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x87, 0x0f, 0x0f,
	0x00, 0x00, 0x00, 0x00, 0x30, 0xc3, 0xc3, 0x0f,
	0x00, 0x00, 0x00, 0x00, 0x30, 0xc3, 0x43, 0x87,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x61, 0x83, 0x07,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0xf3, 0x30, 0x25, 0x20,
	0x00, 0x00, 0x00, 0x51, 0xb8, 0x92, 0x30, 0x64,
	0x00, 0x00, 0x00, 0xf6, 0xb8, 0xc3, 0x30, 0x64,
	0x00, 0x00, 0x51, 0xfc, 0xb8, 0xc3, 0x30, 0x61,
	0x00, 0x00, 0xf6, 0xfc, 0x10, 0xc3, 0x30, 0x61,
	0x00, 0x00, 0xf6, 0xa8, 0x10, 0xc3, 0x30, 0x61,
	0x00, 0x51, 0xfc, 0x00, 0x10, 0xc3, 0x30, 0x61,
	0x00, 0x51, 0xfc, 0x00, 0x10, 0xc3, 0x92, 0x61,
	0x00, 0xf6, 0xa8, 0x00, 0x10, 0x61, 0x92, 0x20,
	0x00, 0xf6, 0xa8, 0x00, 0x10, 0x30, 0x30, 0x88,
	0x51, 0xfc, 0x00, 0x00, 0x00, 0x30, 0x64, 0x88,
	0x51, 0xa8, 0x00, 0x00, 0x00, 0x98, 0x64, 0x88,
	0x00, 0xa8, 0x00, 0x00, 0xcc, 0x98, 0x64, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xcc, 0x98, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x88, 0x10, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x20, 0x00
};

// Tile g_hero_03: 16x27 pixels, 8x27 bytes.
const u8 g_hero_03[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x2f, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x3b, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x4b, 0xc3, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x4b, 0x43, 0x82,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x4b, 0x83, 0x02,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x25, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x51, 0xb2, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0xb8, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x51, 0xf6, 0x30, 0xc3, 0x30, 0x00,
	0x00, 0x00, 0xf3, 0xfc, 0x30, 0xc3, 0x30, 0x00,
	0x00, 0x51, 0xf6, 0xa8, 0x30, 0xc3, 0x30, 0x00,
	0x00, 0x51, 0xf6, 0x00, 0x30, 0xc3, 0x30, 0x00,
	0x00, 0xf3, 0xa8, 0x00, 0x30, 0xc3, 0xc3, 0x00,
	0x00, 0xf3, 0xa8, 0x00, 0x30, 0x61, 0xc3, 0x00,
	0x51, 0xf6, 0x00, 0x00, 0x30, 0x30, 0x30, 0x00,
	0x51, 0xf6, 0x00, 0x00, 0x30, 0x30, 0x64, 0x00,
	0xf3, 0xa8, 0x00, 0x00, 0x10, 0x30, 0xcc, 0x88,
	0xf3, 0x00, 0x00, 0x00, 0x10, 0x30, 0xcc, 0x88,
	0x51, 0x00, 0x00, 0x00, 0x10, 0x64, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x44, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x44, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x00, 0x00, 0x00
};

// Tile g_hero_04: 16x27 pixels, 8x27 bytes.
const u8 g_hero_04[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x1b, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x1b, 0x2d, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x83, 0xc3, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0xc3, 0x03, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x0f, 0x0a, 0x00,
	0x00, 0x00, 0x00, 0x51, 0xf3, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0xb2, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x61, 0x92, 0x20, 0x00,
	0x00, 0x00, 0x51, 0xb2, 0x61, 0xc3, 0x20, 0x00,
	0x00, 0x00, 0x51, 0xb2, 0x30, 0xc3, 0x20, 0xc3,
	0x00, 0x00, 0xf3, 0x10, 0x30, 0x61, 0xc3, 0xc3,
	0x00, 0x00, 0xf3, 0x10, 0x30, 0x30, 0xc3, 0x00,
	0x00, 0x51, 0xa2, 0x10, 0x30, 0x30, 0x20, 0x00,
	0x00, 0x51, 0xa2, 0x10, 0x30, 0x30, 0x20, 0x00,
	0x00, 0xf3, 0x00, 0x00, 0x30, 0x30, 0x88, 0x00,
	0x00, 0xf3, 0x00, 0x00, 0x30, 0x64, 0x00, 0x00,
	0x51, 0xa2, 0x00, 0x10, 0x30, 0xcc, 0x00, 0x00,
	0x51, 0xa2, 0x30, 0x30, 0x20, 0xcc, 0x00, 0x00,
	0x51, 0x00, 0x30, 0x30, 0x00, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x20, 0x00, 0x00, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0xcc, 0x88, 0x00
};

// Tile g_hero_05: 16x27 pixels, 8x27 bytes.
const u8 g_hero_05[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x27, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x36, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x4b, 0x87, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x4b, 0x43, 0x82,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x4b, 0x83, 0x02,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x25, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x51, 0xb2, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0xb2, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x30, 0xc3, 0x30, 0x00,
	0x00, 0x00, 0x51, 0xf6, 0x30, 0xc3, 0x30, 0x00,
	0x00, 0x00, 0xf3, 0xa8, 0x30, 0x61, 0x92, 0x00,
	0x00, 0x00, 0xf3, 0xa8, 0x30, 0x61, 0x92, 0x00,
	0x00, 0x51, 0xf6, 0x00, 0x30, 0x30, 0xc3, 0x82,
	0x00, 0x51, 0xa2, 0x00, 0x30, 0x30, 0x61, 0x82,
	0x00, 0xf3, 0xa8, 0x00, 0x30, 0x30, 0x30, 0x00,
	0x00, 0xf3, 0xa8, 0x00, 0x10, 0x30, 0x30, 0x20,
	0x51, 0xf6, 0x00, 0x00, 0x00, 0x30, 0x30, 0x20,
	0x51, 0xf6, 0x00, 0x00, 0x30, 0x30, 0x30, 0x00,
	0x51, 0xa8, 0x00, 0x00, 0x30, 0x30, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x64, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x44, 0x88, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xcc, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xcc, 0x00, 0x00, 0x00
};

// Tile g_hero_06: 16x27 pixels, 8x27 bytes.
const u8 g_hero_06[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x1a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x1b, 0x0f, 0x93,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x1b, 0x2d, 0x36,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x87, 0x0f, 0x0f,
	0x00, 0x00, 0x00, 0x10, 0x25, 0xc3, 0xc3, 0x0f,
	0x00, 0x00, 0x00, 0x00, 0x25, 0x83, 0xc3, 0x87,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x4b, 0x03, 0x0f,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0xf3, 0xb2, 0x0f, 0x88,
	0x00, 0x00, 0x00, 0xf3, 0xf3, 0x30, 0x64, 0x88,
	0x00, 0x00, 0x51, 0xf3, 0xfc, 0xc3, 0x30, 0x88,
	0x00, 0x00, 0xf3, 0xfc, 0xfc, 0xc3, 0xc3, 0x82,
	0x00, 0x51, 0xf6, 0xfc, 0xa8, 0xc9, 0xc3, 0x82,
	0x00, 0x51, 0xfc, 0xfc, 0x00, 0x30, 0x30, 0x88,
	0x00, 0xf3, 0xfc, 0xa8, 0x00, 0x64, 0x30, 0x88,
	0x00, 0xf6, 0xfc, 0x00, 0x00, 0x30, 0x64, 0x88,
	0x51, 0xf6, 0xa8, 0x00, 0x00, 0x30, 0x64, 0x88,
	0x51, 0xfc, 0x00, 0x00, 0x00, 0x30, 0xcc, 0x00,
	0x51, 0xa8, 0x00, 0x00, 0x10, 0x20, 0xcc, 0x00,
	0x51, 0x00, 0x00, 0x00, 0x10, 0x20, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x51, 0xa2, 0x00, 0xfc, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0xcc, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x00, 0xcc, 0x88
};

// Tile g_hero_07: 16x27 pixels, 8x27 bytes.
const u8 g_hero_07[8 * 27] = {
	0x00, 0x00, 0x00, 0x30, 0x30, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x25, 0x0f, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x30, 0x0f, 0x0f, 0x1a, 0x00, 0x00,
	0x00, 0x10, 0x25, 0x1b, 0x0f, 0x93, 0x00, 0x00,
	0x00, 0x10, 0x25, 0x1b, 0x2d, 0x36, 0x00, 0x00,
	0x00, 0x10, 0x25, 0x87, 0x0f, 0x0f, 0x00, 0x00,
	0x00, 0x10, 0x25, 0xc3, 0xc3, 0x0f, 0x00, 0x00,
	0x00, 0x00, 0x25, 0x83, 0xc3, 0x87, 0x00, 0x00,
	0x00, 0x00, 0x30, 0x4b, 0x03, 0x0f, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x25, 0x0f, 0x0a, 0x00, 0x00,
	0x00, 0x00, 0xf3, 0xb2, 0x0f, 0x88, 0x00, 0x00,
	0x00, 0xf3, 0xf3, 0x30, 0x64, 0xcc, 0x41, 0x82,
	0x51, 0xf3, 0xfc, 0x30, 0xc3, 0xc3, 0xc3, 0xc3,
	0x51, 0xfc, 0xfc, 0x30, 0xc3, 0xc3, 0xc3, 0xc3,
	0xf3, 0xfc, 0xa8, 0x30, 0x30, 0x20, 0x41, 0x82,
	0xf3, 0xfc, 0x00, 0x30, 0x30, 0x20, 0x00, 0x00,
	0xf6, 0xa8, 0x00, 0x30, 0x30, 0x20, 0x00, 0x00,
	0xf6, 0x00, 0x00, 0x30, 0x30, 0x88, 0x00, 0x00,
	0xa2, 0x00, 0x10, 0x30, 0x64, 0x88, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x30, 0xcc, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x30, 0x20, 0xcc, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x30, 0x00, 0xcc, 0x00, 0x00, 0x00,
	0x00, 0x10, 0x30, 0x44, 0x88, 0x00, 0x00, 0x00,
	0x00, 0xb2, 0x20, 0x44, 0x88, 0x00, 0x00, 0x00,
	0x10, 0x71, 0x00, 0x54, 0xa8, 0x00, 0x00, 0x00,
	0x10, 0x30, 0x00, 0x44, 0x88, 0x00, 0x00, 0x00,
	0x00, 0x10, 0x20, 0x44, 0xcc, 0x00, 0x00, 0x00
};

// Tile g_hero_08: 16x27 pixels, 8x27 bytes.
const u8 g_hero_08[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x1e, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x30, 0x25, 0x1a, 0x00,
	0x00, 0x00, 0x51, 0xb2, 0x30, 0x30, 0x30, 0x20,
	0x00, 0x00, 0xf3, 0xad, 0x30, 0x30, 0x30, 0x61,
	0x00, 0x51, 0xf6, 0x0f, 0x4e, 0x30, 0x30, 0x41,
	0x00, 0xf3, 0xad, 0x0f, 0x98, 0x30, 0x64, 0x41,
	0x51, 0xf6, 0xad, 0x5e, 0x98, 0x30, 0x64, 0x41,
	0x51, 0xfc, 0xad, 0x5e, 0x98, 0xcc, 0xcc, 0xc3,
	0xf3, 0xfc, 0xa8, 0x0f, 0x4e, 0x30, 0x64, 0x82,
	0xf6, 0xfc, 0x00, 0x05, 0x1a, 0x30, 0x20, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x10, 0x30, 0x88, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0xb2, 0x64, 0x88, 0x00,
	0xf6, 0x00, 0x00, 0x10, 0x71, 0x74, 0xa8, 0x00,
	0xf6, 0x00, 0x00, 0x10, 0x20, 0x44, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x44, 0x88, 0x00
};

// Tile g_hero_09: 16x27 pixels, 8x27 bytes.
const u8 g_hero_09[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x1e, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0xb2, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x51, 0xb2, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0xf3, 0xe9, 0x30, 0x0f, 0x0f, 0x20,
	0x00, 0x51, 0xf6, 0xc3, 0x92, 0x25, 0x1a, 0x41,
	0x00, 0xf3, 0xfc, 0xc3, 0x30, 0x30, 0x30, 0x41,
	0x51, 0xf6, 0xe9, 0x92, 0x30, 0x30, 0x30, 0x41,
	0x51, 0xf6, 0xe9, 0x92, 0x30, 0x30, 0x30, 0xc3,
	0xf3, 0xfc, 0xa8, 0xc3, 0x92, 0x30, 0x30, 0x82,
	0xf3, 0xfc, 0x00, 0x41, 0x92, 0x30, 0x20, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0xb2, 0x30, 0x20, 0x00,
	0xf6, 0x00, 0x00, 0x10, 0x71, 0x74, 0xa8, 0x00,
	0xa2, 0x00, 0x00, 0x10, 0x20, 0x10, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x20, 0x10, 0x20, 0x00
};

// Tile g_hero_10: 16x27 pixels, 8x27 bytes.
const u8 g_hero_10[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x1e, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x30, 0x25, 0x1a, 0x00,
	0x00, 0x00, 0x51, 0xb2, 0x30, 0x30, 0x30, 0x20,
	0x00, 0x00, 0xf3, 0xad, 0x1a, 0x30, 0x30, 0x20,
	0x00, 0x51, 0xf6, 0x0f, 0x4e, 0x30, 0x30, 0x82,
	0x00, 0xf3, 0xfc, 0x0f, 0x98, 0x30, 0x64, 0xc3,
	0x51, 0xf6, 0xfc, 0xad, 0x0f, 0x30, 0x64, 0xc3,
	0x51, 0xfc, 0xfc, 0x00, 0x0f, 0xcc, 0xcc, 0x00,
	0xf3, 0xfc, 0xa8, 0x00, 0x30, 0x30, 0x64, 0x00,
	0xf6, 0xfc, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x10, 0x30, 0x88, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0xb2, 0x64, 0x88, 0x00,
	0xf6, 0x00, 0x00, 0x10, 0x71, 0x74, 0xa8, 0x00,
	0xa2, 0x00, 0x00, 0x10, 0x20, 0x44, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x20, 0x44, 0x88, 0x00
};

// Tile g_hero_11: 16x27 pixels, 8x27 bytes.
const u8 g_hero_11[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x1e, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x51, 0x30, 0x25, 0x4e, 0x00,
	0x00, 0x00, 0x00, 0xb2, 0x30, 0x30, 0xcc, 0x88,
	0x00, 0x00, 0x51, 0xad, 0x1a, 0x30, 0x64, 0x88,
	0x00, 0x00, 0xf3, 0x0f, 0x0f, 0x1a, 0x64, 0x82,
	0x00, 0x51, 0xa7, 0x0f, 0x0f, 0x30, 0x64, 0x82,
	0x00, 0xf3, 0xfc, 0xfc, 0x98, 0x30, 0x64, 0x82,
	0x00, 0xf6, 0xfc, 0xa8, 0x98, 0x30, 0xcc, 0xc3,
	0x51, 0xf6, 0xfc, 0x00, 0x10, 0x30, 0xcc, 0xc3,
	0x51, 0xfc, 0xa8, 0x00, 0x10, 0x64, 0xcc, 0x00,
	0xf3, 0xfc, 0x00, 0x00, 0x10, 0x64, 0xcc, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x30, 0x44, 0xcc, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0x30, 0x44, 0x88, 0x00,
	0xa2, 0x00, 0x00, 0x10, 0x20, 0xcc, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0xfc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x00, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x00, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x20, 0xcc, 0x00, 0x00
};

// Tile g_hero_12: 16x27 pixels, 8x27 bytes.
const u8 g_hero_12[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x1a,
	0x00, 0x00, 0x00, 0x41, 0x25, 0x1b, 0x0f, 0x93,
	0x00, 0x00, 0x00, 0x41, 0x87, 0x1b, 0x2d, 0x39,
	0x00, 0x00, 0x00, 0x41, 0x87, 0x87, 0x0f, 0x0f,
	0x00, 0x00, 0x00, 0x41, 0x87, 0xc3, 0xc3, 0x0f,
	0x00, 0x00, 0x00, 0x41, 0x87, 0x83, 0xc3, 0x87,
	0x00, 0x00, 0x00, 0x00, 0xc3, 0x4b, 0x03, 0x0f,
	0x00, 0x00, 0x00, 0x00, 0xc3, 0x8d, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x00, 0xc3, 0x98, 0x0f, 0x88,
	0x00, 0x00, 0x00, 0x51, 0xc3, 0x98, 0x64, 0xcc,
	0x00, 0x00, 0x00, 0xf6, 0xc3, 0xc6, 0x30, 0xcc,
	0x00, 0x00, 0x51, 0xf6, 0xe9, 0xc6, 0x30, 0xc9,
	0x00, 0x00, 0xf3, 0xfc, 0xec, 0x98, 0x30, 0xc9,
	0x00, 0x51, 0xf6, 0xfc, 0xec, 0x30, 0x30, 0xc9,
	0x00, 0x51, 0xfc, 0xfc, 0x44, 0x30, 0x64, 0xc9,
	0x00, 0xf3, 0xfc, 0xa8, 0x00, 0x30, 0x64, 0xc9,
	0x00, 0xf6, 0xfc, 0x00, 0x00, 0x30, 0xcc, 0x88,
	0x51, 0xf6, 0xa8, 0x00, 0x10, 0x30, 0xcc, 0x88,
	0x51, 0xfc, 0x00, 0x00, 0x10, 0x20, 0xcc, 0x88,
	0x51, 0xa8, 0x00, 0x00, 0x30, 0x20, 0xcc, 0x00,
	0x51, 0x00, 0x00, 0x00, 0x30, 0x54, 0xec, 0x00,
	0x00, 0x00, 0x00, 0x51, 0xf3, 0x44, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x44, 0x88, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x20, 0x44, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00
};

// Tile g_hero_13: 16x27 pixels, 8x27 bytes.
const u8 g_hero_13[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20, 0x00,
	0x00, 0x00, 0x10, 0x0f, 0x27, 0x4b, 0x22, 0x00,
	0x00, 0x00, 0x10, 0x0f, 0x36, 0x1b, 0x28, 0x00,
	0x00, 0x00, 0x10, 0x4b, 0x0f, 0x0f, 0x0a, 0x00,
	0x51, 0xf3, 0xb2, 0x4b, 0xc3, 0x87, 0x0a, 0x00,
	0xf3, 0xf3, 0xb2, 0x4b, 0x43, 0xc3, 0x0a, 0x00,
	0xf3, 0xe3, 0xd3, 0x25, 0x83, 0x07, 0x0a, 0xc3,
	0xf9, 0xe3, 0xd3, 0xe6, 0x0f, 0x0f, 0x00, 0xc3,
	0x54, 0xf9, 0xc3, 0xe6, 0x25, 0x4e, 0x41, 0x82,
	0x00, 0x54, 0xc3, 0xc6, 0x30, 0xcc, 0xc9, 0x82,
	0x00, 0x00, 0xe9, 0xc3, 0x98, 0x64, 0xc3, 0x00,
	0x00, 0x00, 0x00, 0xc3, 0x98, 0x64, 0xc3, 0x00,
	0x00, 0x00, 0x00, 0x44, 0x30, 0x64, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x64, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x64, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x64, 0xcc, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x00, 0xcc, 0x88, 0x00,
	0x00, 0x00, 0x10, 0x30, 0x00, 0xcc, 0xa8, 0x00,
	0x00, 0x00, 0x10, 0x20, 0x00, 0x54, 0x88, 0x00,
	0x00, 0x00, 0xf3, 0x00, 0x00, 0x44, 0x88, 0x00,
	0x00, 0x00, 0x30, 0x00, 0x00, 0x44, 0xcc, 0x00,
	0x00, 0x10, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile g_hero_14: 16x27 pixels, 8x27 bytes.
const u8 g_hero_14[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x0f, 0x20,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x27, 0x4b, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x36, 0x1e, 0x22,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0x0f, 0x0f, 0x0a,
	0x00, 0x00, 0x00, 0x30, 0x4b, 0xc3, 0x87, 0x0a,
	0x00, 0x00, 0x00, 0xb2, 0x4b, 0x43, 0xc3, 0x0a,
	0x00, 0x00, 0x51, 0xb2, 0x25, 0x83, 0x07, 0x0a,
	0x00, 0x00, 0xf3, 0xe9, 0x30, 0x0f, 0x0f, 0x20,
	0x00, 0x51, 0xf6, 0xc3, 0x92, 0x25, 0x1a, 0x41,
	0x00, 0xf3, 0xfc, 0xc3, 0x30, 0x30, 0x30, 0x41,
	0x51, 0xf6, 0xe9, 0x92, 0x30, 0x30, 0x30, 0x41,
	0x51, 0xf6, 0xe9, 0x92, 0x30, 0x30, 0x30, 0xc3,
	0xf3, 0xfc, 0xa8, 0xc3, 0x92, 0x30, 0x30, 0x82,
	0xf3, 0xfc, 0x00, 0x41, 0x92, 0x30, 0x20, 0x00,
	0xf6, 0xa8, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00,
	0xf6, 0x00, 0x00, 0x00, 0xb2, 0x30, 0x20, 0x00,
	0xf6, 0x00, 0x00, 0x10, 0x71, 0x74, 0xa8, 0x00,
	0xa2, 0x00, 0x00, 0x10, 0x20, 0x10, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x20, 0x10, 0x20, 0x00
};

// Tile g_hero_15: 16x27 pixels, 8x27 bytes.
const u8 g_hero_15[8 * 27] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x25, 0x0f, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x0f, 0x0f, 0x1a, 0x00,
	0x00, 0x00, 0x00, 0x25, 0x1b, 0x0f, 0x93, 0x00,
	0x00, 0x00, 0x00, 0x25, 0x1b, 0x2d, 0x36, 0x00,
	0x00, 0x00, 0x00, 0x25, 0x87, 0x0f, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x25, 0xc3, 0xc3, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x25, 0x83, 0xc3, 0x87, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x4b, 0x03, 0x0f, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x8d, 0x0f, 0x0a, 0x00,
	0x00, 0x00, 0x00, 0x51, 0xb2, 0x0f, 0x88, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0x98, 0x64, 0xcc, 0x00,
	0x00, 0x00, 0x51, 0xe9, 0xc6, 0x30, 0x61, 0x82,
	0x00, 0x00, 0xf6, 0xe9, 0xc6, 0x30, 0x61, 0x82,
	0x00, 0x51, 0xf6, 0xc3, 0x98, 0x30, 0x20, 0xc3,
	0x00, 0x51, 0xfc, 0xc3, 0x30, 0x30, 0x20, 0xc3,
	0x00, 0xf6, 0xfc, 0xc3, 0x30, 0x30, 0x20, 0x41,
	0x51, 0xfc, 0xfc, 0xc3, 0x30, 0x30, 0xcc, 0x41,
	0xf6, 0xfc, 0xe9, 0x92, 0x30, 0xcc, 0xcc, 0x00,
	0xf6, 0xfc, 0x61, 0x92, 0x30, 0x44, 0x88, 0x00,
	0xf6, 0xb8, 0x30, 0x74, 0x00, 0x44, 0x88, 0x00,
	0xf6, 0xb8, 0xfc, 0xa8, 0x00, 0x44, 0xcc, 0x00
};

