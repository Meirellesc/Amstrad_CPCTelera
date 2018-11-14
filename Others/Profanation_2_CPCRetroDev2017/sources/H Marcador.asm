; Rutinas para el marcador

;;
;;escribe un tile en el marcador
;;
;;ENTRADA
;;A' Tile
;;BC  Tile Coords (Y,X)
;;E  Juego de Tiles
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
write_tile_marcador_YX
	PUSH	DE
	LD	HL,DIRECCION_MARCADOR
	LD	A,B
	CP	0
	JR	Z,solo_x_wtmyx
	LD	DE,#100
posy_wtmyx
	ADD	HL,DE
	DJNZ	posy_wtmyx
	LD	B,A
solo_x_wtmyx
	LD	D,0
	LD	E,C
	ADD	HL,DE
	ADD	HL,DE
	EX	DE,HL

	POP	BC
	LD	A,C
	AND	%01111111
	LD	H,A
	; Get the tile address ($4000 + tile_number << 4)
	EX   	AF,AF'								; A TILE
	DEC  	A			;resto 1 para empezar desde el tile 0
	SLA  	A          
	RL   	H      
	RLA             
	RL   	H          
	RLA             
	RL   	H          
	RLA             
	RL   	H  
	LD   	L,A                  ; HL Tile address
	EX   	DE,HL                ; HL screen address
				     ; DE TILE address

	LD	BC,#40
	; 1º Scanline
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	3,H
	
	; 2º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	ADD	HL,BC

	; 4º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	RES	3,H

	; 3º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	ADD	HL,BC
	ADD	HL,BC

	; 7º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SBC	HL,BC

	; 5º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 6º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	ADD	HL,BC

	; 8º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD   	(HL),A

	RET

;;
;;Pinta en el marcador el STile E en BC (Y,X)
;;
;;ENTRADA
;;E:STile
;;BC:Coordenadas (Y,X)
;;SALIDA
;;Nada
;;destruye A,A',DE
;;
Pinta_Supertile_Marcador_HL
	PUSH	HL
	JR	Pinta_Supertile1_Marcador
Pinta_Supertile_Marcador
	PUSH	HL
	LD	HL,MAPA_STILES
	AND     A
	LD	D,0
	RL	E
	ADD	HL,DE
	LD	A,E
	LD	(CHECK_PINTA_TILE),A
	LD	E,(HL)
	INC     HL
	LD      D,(HL)
	EX      HL,DE		;en HL tengo la direccion del STile
Pinta_Supertile1_Marcador
	LD	A,(HL)
	AND	%10000000
	RLA
	RLA
	ADD	A,5
	LD	E,A		;juego de Tiles
	;ancho
	LD      A,(HL)
	AND	%01110000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	EX	AF,AF'
	;alto
	LD      A,(HL)
	AND	%00001111
	LD      D,A
	INC     HL
	EX	AF,AF'
	;;A:ancho
	;;D:alto
alto_psm
	PUSH	AF
	PUSH	BC
ancho_psm
	PUSH    AF	
	LD	A,(HL)		;tile
	EX	AF,AF'
	PUSH	HL
	PUSH	BC
	PUSH	DE
	CALL	write_tile_marcador_YX
	POP	DE
	POP	BC
	POP	HL
	INC	C
	INC	HL
	POP	AF
	DEC	A
	JR      NZ,ancho_psm

	POP	BC
	INC	B
	POP	AF
	DEC	D
	JR	NZ,alto_psm

	POP	HL
	RET

imprime_vidas
	LD   	A,(SPRITE0_VIDAS)
	CP   	#FF
	RET  	Z
	CP   	11
	CALL 	NC,0 
  
	ADD  	A,CORRECTOR_NUMEROS
	EX   	AF,AF'
	LD	BC,#0105
	LD	E,JUEGO_TILES_2
	
	JP	write_tile_marcador_YX

Vuelca_Marcador
	LD	A,13		;Y del marcador en pantalla
	LD	HL,#4000
Otra_Linea_VM
	PUSH	AF

	PUSH	HL
	LD	C,A
	LD      B,0
	LD      HL,TABLA_SCANLINES
	AND     A
	RL      C
	ADD     HL,BC
	LD      A,(HL)
	INC     HL
	LD      D,(HL)
	LD      E,A     ;DE screen address
	POP	HL
	PUSH	HL
	LD	BC,#40
	LDIR
	POP	HL

	BIT     3,H
	JR	NZ,resetea_VM
	SET	3,H
	JR	sigue_VM
resetea_VM
	RES	3,H
	LD	BC,#40
	ADD	HL,BC
sigue_VM

	POP	AF
	INC	A
	CP	64+13
	JR	NZ,Otra_Linea_VM
	
	LD	A,#00
otro_an_VM
	LD	B,#10
	LD	C,A
	PUSH	BC
	LD	A,TILE_FONDO
	EX	AF,AF'
	LD	E,JUEGO_TILES_1
	CALL	write_tile_screen_YX
	POP	BC
	PUSH	BC
	LD	B,#18
	LD	A,TILE_FONDO
	EX	AF,AF'
	LD	E,JUEGO_TILES_1
	CALL	write_tile_screen_YX
	POP	BC
	LD	A,C
	ADD	A,8
	CP	00
	JR	NZ,otro_an_VM

	LD	A,#30
otro_an1_VM
	LD	B,#20
	LD	C,A
	PUSH	BC
	LD	A,TILE_FONDO
	EX	AF,AF'
	LD	E,JUEGO_TILES_1
	CALL	write_tile_screen_YX
	POP	BC
	PUSH	BC
	LD	B,#28
	LD	A,TILE_FONDO
	EX	AF,AF'
	LD	E,JUEGO_TILES_1
	CALL	write_tile_screen_YX
	POP	BC
	LD	A,C
	ADD	A,8
	CP	#D0
	JR	NZ,otro_an1_VM

	LD	HL,dstile_33
	LD	BC,#20C0
	CALL	Pinta_Supertile_HL
	LD	HL,dstile_23
	LD	BC,#28B8
	CALL	Pinta_Supertile_HL

	RET
