;1 - LOAD"-DISC.BAS
;2 ASM
;3 CALL &A000

ORG &1B0
	XOR A
	CALL &BC0E	;MODE 0

	CALL MASQUER

	LD HL,&5FD0
	LD DE,&C000
	LD BC,&2D30
	LDIR		;Transfert image vers ecran

	CALL &5F70	;Decomp overscan
	CALL &7F00	;Anim overscan

	CALL MASQUER
	CALL &ECDF	;Decomp design
	CALL &BB6C	;cls
	LD BC,&BC06
	OUT (C),C
	LD BC,&BD00+25
	OUT (C),C	;OUT R6=25
	CALL &9000	;Anim rouleau
	RET
MASQUER
	LD BC,&BC06
	OUT (C),C
	LD BC,&BD00
	OUT (C),C	;OUT R6=0
	RET


ORG &A000
CHARGEMENT_FICHIER_OVERSCAN
	LD B,&0C
	LD HL,fichier_overscan
	LD DE,&C000
	CALL &BC77 ;lecture entete
	LD HL,&01F0
	CALL &BC83 ;lecture fichier
	CALL &BC7A ;ferme le fichier
	;fin &7EC0

CHARGEMENT_FICHIER_DESIGN
	LD B,&0C
	LD HL,fichier_design
	LD DE,&C000
	CALL &BC77 ;lecture entete
	LD HL,&5FD0
	CALL &BC83 ;lecture fichier
	CALL &BC7A ;ferme le fichier


;SAUVER LE FICHIER BASIC/BINAIRE
;&0170 Basic
;&01B0 ASM pour decomp+deplacement+anim
;&01F0 legacy.ovr lg=&5DD1 fin=&5FC1
;&5FD0 legacy.pic lg=&2D30 fin=&8D01
;lg=&8B91
	LD B,12
	LD HL,NOM_FICHIER
	LD DE,&C000
	CALL &BC8C

	LD HL,&170	;debut du fichier
	LD DE,&8BA0	;longueur du fichier (avec une marge de securite)
	LD BC,&FADA	;adresse execution du fichier
	LD A,0		;type BASIC
	CALL &BC98
	CALL &BC8F
	CALL &BC89
	CALL &BC92
	RET

NOM_FICHIER
DEFB "DISC    .BAS"

fichier_overscan
DEFM "LEGACY  .OVR"

fichier_design
DEFM "LEGACY  .PIC"

