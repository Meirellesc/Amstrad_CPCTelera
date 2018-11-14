largueur_tableau	EQU 16
hauteur_tableau		EQU 10
ecran_tableau		EQU &E002

;&4F80 DATA END lg &50 (8bits * 80 octets = 640 tiles 8x8)
gfx_bouton_off		EQU &4FD0
gfx_bouton_on		EQU &5130
gfx_bouton_largeur	EQU 11
gfx_bouton_hauteur	EQU 32
gfx_adresse_ecran	EQU &E685

niveau_dans_temporaire 	EQU &5290 ;lg &B0
gfx_fonte		EQU &5340 ;lg &5B0
gfx_des_tiles		EQU &5900 ;lg &2500
gfx_des_icones		EQU &7680 ;(gfx_des_tiles + (118 * 64)) soit &1D80
;fin &7E00

ZIC_RAYXAMBER		EQU &7E10 ;lg &1E7
load_niveau_courant 	EQU &8000

LVL_STARTX	EQU &80A0 ;DB 0 ;depart X
LVL_STARTY	EQU &80A1 ;DB 5 ;depart Y
LVL_SENSX	EQU &80A2 ;DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
LVL_SENSY	EQU &80A3 ;DB 0 ;sens Y (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
LVL_OPTION1 	EQU &80A4 ;option 1 - fleche haut
LVL_OPTION2 	EQU &80A5 ;option 2 - fleche diagonale haut/droite
LVL_OPTION3 	EQU &80A6 ;option 3 - fleche droite
LVL_OPTION4 	EQU &80A7 ;option 4 - fleche diagonale bas/droite
LVL_OPTION5 	EQU &80A8 ;option 5 - fleche bas
LVL_OPTION6 	EQU &80A9 ;option 6 - fleche diagonale bas/gauche
LVL_OPTION7 	EQU &80AA ;option 7 - fleche gauche
LVL_OPTION8	EQU &80AB ;option 8 - fleche haut/gauche
LVL_OPTION9 	EQU &80AC ;option 9 - Teleporteur (maximum 1)
LVL_OPTION10	EQU &80AD ;option 10 - Tir 1 direction
LVL_OPTION11	EQU &80AE ;option 11 - Tir 4 directions
LVL_OPTION12	EQU &80AF ;option 12 - Bouclier

AFF_OPTIONX	EQU &EF36
AFF_ICONE1	EQU &E695

TABLEX_TOTAL_ELEMENTS	EQU	64
TABLEY_TOTAL_ELEMENTS	EQU	64

ORG &8100
WRITE "LEGACY.RSX"
NOLIST

; ****************************
; *** RSX - INITIALISATION ***
; ****************************
.RSX_Init :
	LD	HL,RSX_Init
	LD	(HL),&C9		; Ecrire un RET pour empêcher une nouvelle initialisation
	LD	BC,RSX_Commandes	; BC pointe sur la table des Commandes RSX
	LD	HL,RSX_Tampon		; HL pointe sur 4 octets libres.
	JP	&BCD1

.RSX_Tampon :
	DEFS	4			; Tampon de quatre octets.

.RSX_Commandes :
	DEFW	RSX_Mots_Clefs		; Adresse des mots clefs
	JP	TRANSFERT_DANS_TAMPON
	JP	LEVEL_FLIP
	JP	CHOIX_FLIP
	JP	LEVEL_LOAD_ET_AFFICHAGE
	JP	TILES_16x16_opaque
	JP	AFFICHAGE_ELEMENT_TRANSPARENT
	JP	DECOR_16x16_SAUVEGARDE
	JP	DECOR_16x16_RESTAURATION
	JP	TILE8
	JP	AFF_12_OPTIONS
	JP	PLAYER_ARKOS
	JP	PLAYER_ARKOS_OFF
	JP	MENU
	JP	CONTROLES
	JP	CREDITS
	JP	INFOS
	JP	BOUTON_OFF
	JP	BOUTON_ON
	JP	SUB_MENU

.RSX_Mots_Clefs
	DEFB	"TMPLV","L"+&80		;TMPLVL,level (1 a 20)
	DEFB	"LVLFLI","P"+&80	;LVLFLIP,1a4
	DEFB	"AFFFLI","P"+&80	;LVLFLIP,1a5
	DEFB	"LVLAF","F"+&80		;LVLAFF
	DEFB	"T1","6"+&80		;TILE,adresse_ecran,adresse_tiles(tile*64)
	DEFB	"SP","R"+&80		;SPRITE,element,adresse_ecran
	DEFB	"SA","V"+&80		;DECORSAVE,slot(1a3),adresse_ecran
	DEFB	"AF","F"+&80		;DECORAFF,slot(1a3),adresse_ecran
	DEFB	"T","8"+&80		;tile8,caractere,adresse_ecran
	DEFB	"ICONE","S"+&80		;ICONES (affichage des 12 icones + valeurs)
	DEFB	"ZICO","N"+&80		;ZICON
	DEFB	"ZICOF","F"+&80		;ZICOFF
	DEFB	"MEN","U"+&80		;MENU
	DEFB	"CONTROLE","S"+&80	;CONTROLES
	DEFB	"CREDIT","S"+&80	;CREDITS
	DEFB	"INFO","S"+&80		;INFOS
	DEFB	"BTNOF","F"+&80		;BTNOFF
	DEFB	"BTNO","N"+&80		;BTNON
	DEFM	"SU","B"+&80		;SUB
	DEFB	0			;Fin de la table.

;------------------------------------------------------------------------------
; BOUTON MOTOR OFF + MOTOR ON
;------------------------------------------------------------------------------
.BOUTON_OFF
	LD HL,gfx_adresse_ecran
	LD DE,gfx_bouton_off
	LD B,gfx_bouton_hauteur
	CALL LOOP2
	RET
.BOUTON_ON
	LD HL,gfx_adresse_ecran
	LD DE,gfx_bouton_on
	LD B,gfx_bouton_hauteur
	CALL LOOP2
	RET

LOOP2	PUSH BC
	PUSH HL
	LD B,gfx_bouton_largeur

LOOP1	LD A,(DE)
	LD (HL),A
	INC DE
	INC HL
	DJNZ LOOP1
	POP HL
	CALL &BC26
	POP BC
	DJNZ LOOP2
	RET

;------------------------------------------------------------------------------
; INFOS
;------------------------------------------------------------------------------
.INFOS
	CALL vider_ecran_jeu
	LD HL,INFOS0:LD DE,&F052+3+18:CALL directmini

	LD HL,INFOS1:LD DE,&F0F2+3+2:CALL directmini
	LD HL,INFOS2:LD DE,&F142+3+2:CALL directmini
	LD HL,INFOS3:LD DE,&F192+3+2:CALL directmini
	LD HL,INFOS4:LD DE,&F1E2+3+2:CALL directmini
	LD HL,INFOS5:LD DE,&F232+3+4:CALL directmini

	LD HL,INFOS6:LD DE,&F2D2+3:CALL directmini
	LD HL,INFOS7:LD DE,&F322+3:CALL directmini
	LD HL,INFOS8:LD DE,&F372+3:CALL directmini
	LD HL,INFOS9:LD DE,&F3C2+3:CALL directmini
	LD HL,INFOS10:LD DE,&F412+3:CALL directmini
	LD HL,INFOS11:LD DE,&F462+3:CALL directmini

	LD HL,INFOS12:LD DE,&F502+3:CALL directmini
	LD HL,INFOS13:LD DE,&F552+3:CALL directmini
	LD HL,INFOS14:LD DE,&F5A2+3:CALL directmini

	RET
INFOS0	 DEFB "instructions" : DB 0
;-------------"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
INFOS1	 DEFB "YOUR MISSION IS TO FIND A" : DB 0
INFOS2	 DEFB "SAFE WAY FOR YOUR SHIP TO" : DB 0
INFOS3	 DEFB "CAPTURE THE FLAG WITHOUT" : DB 0
INFOS4	 DEFB "YOUR SHIP BEING DESTROYED." : DB 0
INFOS5	 DEFB "SAVE THE PLANET phantis" : DB 0

INFOS6	 DEFB "HERE ARE AVAILABLE FUNCTIONS:" : DB 0
INFOS7	 DEFB "- ARROWS MODIFY THE DIRECTION" : DB 0
INFOS8	 DEFB "- TELEPORT  = GO TO OTHER ONE" : DB 0
INFOS9	 DEFB "- SHOOT x1  = 1 FRONT SHOT" : DB 0
INFOS10	 DEFB "- SHOOTS x4 = 4 WAY SHOT" : DB 0
INFOS11	 DEFB "- SHIELD = PROTECTS YOUR SHIP" : DB 0

INFOS12	 DEFB "BLACK ARROWS CANNOT BE MOVED." : DB 0
INFOS13	 DEFB "CANNONS FIRE DEADLY RAY." : DB 0
INFOS14	 DEFB "DESTROY CANNONS AND MINES." : DB 0



;------------------------------------------------------------------------------
; CREDITS
;------------------------------------------------------------------------------
.CREDITS
	CALL vider_ecran_jeu

	LD HL,CREDIT0:LD DE,&F052+11+16:CALL directmini
	LD HL,CREDIT1:LD DE,&F142+11+12:CALL directmini
	LD HL,CREDIT2:LD DE,&F1E2+11+12:CALL directmini
	LD HL,CREDIT3:LD DE,&F282+11+14:CALL directmini
	LD HL,CREDIT4:LD DE,&F322+11+10:CALL directmini
	LD HL,CREDIT5:LD DE,&F3C2+11+10:CALL directmini
	LD HL,CREDIT6:LD DE,&F462+11+6:CALL directmini
	LD HL,CREDIT7:LD DE,&F4B2+11+4:CALL directmini
	LD HL,CREDIT8:LD DE,&F502+11+2:CALL directmini
	LD HL,CREDIT9:LD DE,&F552+11:CALL directmini
	RET

CREDIT0	 DEFB "credits" : DB 0
;-------------"xxxxxxxxxxxxxxxxxxxxxxxxxx"
CREDIT1	 DEFB "IDEA : fano" : DB 0

CREDIT2	 DEFB "CODE : kukulcan" : DB 0

CREDIT3	 DEFB "GFX : ced" : DB 0

CREDIT4	 DEFB "MUSIC : rayxamber" : DB 0

CREDIT5  DEFB "COVER : ixien" : DB 0

CREDIT6  DEFB "TESTERS : ixien, lone" : DB 0
CREDIT7  DEFB "fredouille, cpcmaniaco" : DB 0
CREDIT8  DEFB "christophe petit, tanuki" : DB 0
CREDIT9  DEFB "maxit, galamoth, zisquier" : DB 0



;------------------------------------------------------------------------------
; CONTROLES
;------------------------------------------------------------------------------
.CONTROLES
	CALL vider_ecran_jeu

	LD HL,TOUCHE0:LD DE,&F002+3+20:CALL directmini
	LD HL,TOUCHE1:LD DE,&F0A2+3+4:CALL directmini
	LD HL,TOUCHE2:LD DE,&F0F2+3+4:CALL directmini
	LD HL,TOUCHE3:LD DE,&F192+3+4:CALL directmini
	LD HL,TOUCHE4:LD DE,&F1E2+3+4:CALL directmini
	LD HL,TOUCHE5:LD DE,&F282+3:CALL directmini
	LD HL,TOUCHE6:LD DE,&F2D2+3:CALL directmini
	LD HL,TOUCHE7:LD DE,&F372+3:CALL directmini
	LD HL,TOUCHE8:LD DE,&F3C2+3:CALL directmini
	LD HL,TOUCHE9:LD DE,&F462+3:CALL directmini
	LD HL,TOUCHE10:LD DE,&F502+3:CALL directmini
	LD HL,TOUCHE11:LD DE,&F5A2+3:CALL directmini
	RET
TOUCHE0	 DEFB "controls" : DB 0
;-------------"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
TOUCHE1	 DEFB "cursor keys OR joystick TO" : DB 0
TOUCHE2  DEFB "MOVE TARGET ON THE MAP." : DB 0

TOUCHE3	 DEFB "space OR joystick fire^ TO" : DB 0
TOUCHE4  DEFB "DROP/CATCH OPTION." : DB 0

TOUCHE5	 DEFB "TO CHOOSE AN OPTION : x OR c" : DB 0
TOUCHE6  DEFB "OR fire`+left OR fire`+right" : DB 0
	                                   
TOUCHE7	 DEFB "PRESS return OR fire`+up TO" : DB 0
TOUCHE8  DEFB "START THE ENGINE OF THE SHIP." : DB 0
	                                   
TOUCHE9	 DEFB "i OR fire`+down INGAME MENU" : DB 0
	                                   
TOUCHE10 DEFB "r=RESTART LEVEL  a=ABORT GAME" : DB 0
	                                   
TOUCHE11 DEFB "m=TURN MUSIC ON/OFF" : DB 0


;------------------------------------------------------------------------------
; CHOIX FLIP - Menu principal
;------------------------------------------------------------------------------
.CHOIX_FLIP
	LD A,(IX+00)	;1 a 5 (1=normal;2=FLIPX;3=FLIPY;4=FLIPXY;5=RANDOM)
	LD HL,chflip1-9
.calculadrchflip
	LD DE,9		;taille texte + le 0
	ADD HL,DE
	DEC A
	CP 0
	JP NZ,calculadrchflip

	LD DE,&DAF3:CALL directmini
	RET

chflip1 
	DEFB "NORMAL  " : DB 0
	DEFB "FLIP X  " : DB 0
	DEFB "FLIP Y  " : DB 0
	DEFB "FLIP X+Y" : DB 0
	DEFB "RANDOM  " : DB 0



;------------------------------------------------------------------------------
; SOUS MENU pour gestion 100% JOYSTICK
;------------------------------------------------------------------------------
.SUB_MENU
	LD HL,SUB1:LD DE,&D1A6:CALL directmini
	LD HL,SUB2:LD DE,&D246:CALL directmini
	LD HL,SUB3:LD DE,&D2E6:CALL directmini
	LD HL,SUB4:LD DE,&D386:CALL directmini
	LD HL,SUB5:LD DE,&D426:CALL directmini
	LD HL,SUB6:LD DE,&D4C6:CALL directmini
	RET
SUB1	DEFB "CONTINUE" : DB 0
SUB2	DEFB "RESTART  LEVEL" : DB 0
SUB3	DEFB "PREVIOUS LEVEL" : DB 0
SUB4	DEFB "NEXT LEVEL" : DB 0
SUB5	DEFB "MUSIC ON/OFF" : DB 0
SUB6	DEFB "ABORT GAME" : DB 0

;------------------------------------------------------------------------------
; MENU PRINCIPAL
;------------------------------------------------------------------------------
.MENU
	CALL vider_ecran_jeu

	LD HL,MENU0:LD DE,&F051+16:CALL directmini
	LD HL,MENU1:LD DE,&D9A5-4:CALL directmini
	LD HL,MENU2:LD DE,&DA45-4:CALL directmini
	LD HL,MENU3:LD DE,&DAE5-4:CALL directmini
	LD HL,MENU4:LD DE,&DB85-4:CALL directmini
	LD HL,MENU5:LD DE,&DC25-4:CALL directmini
	LD HL,MENU6:LD DE,&DCC5-4:CALL directmini
	LD HL,MENU7:LD DE,&F5A2+8:CALL directmini
	RET

MENU0	DEFB "@ Phantis Legacy @" : DB 0
MENU1	DEFB "start" : DB 0
MENU2	DEFB "mission  01" : DB 0
MENU3	DEFB "display  " : DB 0
MENU4	DEFB "instructions"	: DB 0
MENU5	DEFB "controls" : DB 0
MENU6	DEFB "credits" : DB 0
MENU7	DEFB "2017 #$ WWW.CPC-POWER.COM" : DB 0


.directmini
	LD A,(HL)
	CP 0
	RET Z

	PUSH HL
	PUSH DE
	CALL aff_TILES8_0
	POP DE
	INC DE:INC DE ;+2 pixels
	POP HL
	INC HL ;position caractere suivant
	JR directmini

;------------------------------------------------------------------------------
; VIDER ECRAN DE JEU
;------------------------------------------------------------------------------
.vider_ecran_jeu
	LD HL,load_niveau_courant
	PUSH HL
	POP IX

	LD DE,load_niveau_courant+1
	LD BC,&B0-1
	LD (HL),59	;'case noire
	LDIR

	CALL access_pour_menu
	RET

;------------------------------------------------------------------------------
; TILE8 OPAQUE
;------------------------------------------------------------------------------
.TILE8
	;lecture valeur caractere
	LD A,(IX+2)

	;lecture valeur adresse_ecran
	LD D,(IX+1)
	LD E,(IX+0)

.aff_TILES8_0
	LD C,32
	SUB C		;A = A-32

	PUSH DE 	;sauver DE
	LD L,A		;L = A
	LD H,0		;H = 0
	ADD HL,HL 	;*2
	ADD HL,HL 	;*4
	ADD HL,HL 	;*8
	ADD HL,HL 	;*16
	LD DE,gfx_fonte
	ADD HL,DE	;HL contient l'adresse du tiles
	POP DE		;recuperer l'adresse d'affichage a l'ecran

	LD A,8 		;Hauteur_du_tile
.aff_TILES8_1
	LDI
	LDI		;8 pixels = 2 octets
	EX DE,HL
	LD BC,&07FE 	;&800 - 2 octets (largeur ecran - largeur tiles)
	ADD HL,BC
	JR NC,aff_TILES8_2
	LD BC,&C050	;R1=40 alors &C050 (normal) - R1=32 alors &C040 (reduit)
	ADD HL,BC
.aff_TILES8_2
	EX DE,HL
	DEC A
	JR NZ,aff_TILES8_1
	RET

;------------------------------------------------------------------------------
; SAUVER LE DECOR DE FOND - 3 slots (1 a 3)
;------------------------------------------------------------------------------
.tampon_tile_sauvegarde :
	DEFS	64	;TILE = 16px*16px = 4*16 = 64 octets
	DEFS	64	;TILE = 16px*16px = 4*16 = 64 octets
	DEFS	64	;TILE = 16px*16px = 4*16 = 64 octets

.DECOR_16x16_SAUVEGARDE
	;lecture slot
	LD A,(IX+02)

	;lecture adresse_ecran
	LD E,(IX+00)
	LD D,(IX+01)
	PUSH DE

	LD HL,tampon_tile_sauvegarde-64
.calculadrslotsave
	LD DE,64	;taille du slot
	ADD HL,DE
	DEC A
	CP 0
	JP NZ,calculadrslotsave

	POP DE

	LD A,16	;hauteur
	EX DE,HL	

.sauver_fond1
	LDI ; 16 pixels = 4 octets
	LDI
	LDI
	LDI
	LD BC,&7FC
	ADD HL,BC
	JR NC,sauver_fond2
	LD BC,&C050
	ADD HL,BC
	
.sauver_fond2
	DEC A
	JR NZ,sauver_fond1
	RET

;------------------------------------------------------------------------------
; RESTAURER LE DECOR DE FOND
;------------------------------------------------------------------------------
.DECOR_16x16_RESTAURATION
	;lecture slot
	LD A,(IX+02)

	;lecture adresse_ecran
	LD E,(IX+00)
	LD D,(IX+01)
	PUSH DE

	LD HL,tampon_tile_sauvegarde-64
.calculadrslotrestauration
	LD DE,64	;taille du slot
	ADD HL,DE
	DEC A
	CP 0
	JP NZ,calculadrslotrestauration

	POP DE
	
	LD A,16	;hauteur
	
.restore_fond1
	LDI ; 16 pixels = 4 octets
	LDI
	LDI
	LDI
	EX DE,HL
	LD BC,&7FC
	ADD HL,BC
	JR NC,restore_fond2
	LD BC,&C050
	ADD HL,BC
	
.restore_fond2
	EX DE,HL
	DEC A
	JR NZ,restore_fond1
	RET


;------------------------------------------------------------------------------
; ELEMENTS (VAISSEAU, EXPLOSION, ECLAIR, CIBLE) - SPRITE TRANSPARENT (130 a 145)
; Entrees ;
; A = element
; DE = adresse ecran
;------------------------------------------------------------------------------
AFFICHAGE_ELEMENT_TRANSPARENT
	;lecture valeur adresse_ecran
	LD E,(IX+00)
	LD D,(IX+01)
	PUSH DE
	;element transparent
	LD A,(IX+02)	;0 a 14

	LD L,A		;L = A
	LD H,0		;H = 0
	ADD HL,HL 	;*2
	ADD HL,HL 	;*4
	ADD HL,HL 	;*8
	ADD HL,HL 	;*16
	ADD HL,HL 	;*32
	ADD HL,HL 	;*64

	LD DE,gfx_des_tiles+&20C0	;gfx_des_tiles+(131*64)
	ADD HL,DE	;HL contient l'adresse du tiles

	LD B,16
	LD C,4
	POP DE
	CALL TRAN_SPR_PR
RET


;------------------------------------------------------------------------------
; TRANSFERT NIVEAU DANS ZONE TAMPON
; Entrees ;
; A = numero du niveau
;------------------------------------------------------------------------------
TRANSFERT_DANS_TAMPON
	LD A,(IX+00)		;1 a 20 (numero du niveau)

	;calcul adresse
	LD HL,LEVELS-&B0

.calculadrniveau
	LD DE,&B0		;taille du niveau
	ADD HL,DE
	DEC A
	CP 0
	JP NZ,calculadrniveau

	;PUSH HL		;Sauver HL dans la Pile

	;transfert des donnees dans la zone temporaire pour appliquer ou non le FLIPX/FLIPY
	LD DE,niveau_dans_temporaire
	LD BC,&B0		;longueur d'un niveau
	LDIR			;transfert des donnees
	RET

;------------------------------------------------------------------------------
; GESTION DU FLIPX ou FLIPY DU NIVEAU
;------------------------------------------------------------------------------
.LEVEL_FLIP
	LD A,(IX+00)	;1 a 4 (1=none;2=FLIPX;3=FLIPY;4=FLIPX+FLIPY)
	CP 1:CALL Z,SUB_FLIPNONE
	CP 2:CALL Z,SUB_FLIPX
	CP 3:CALL Z,SUB_FLIPY
	CP 4:CALL Z,SUB_FLIPXY
	RET

.SUB_FLIPNONE
	LD HL,niveau_dans_temporaire
	LD DE,load_niveau_courant
	LD BC,&B0
	LDIR
	XOR A
	RET

.SUB_FLIPX
	CALL LVL_FLIP_X
	XOR A
	RET
.SUB_FLIPY
	CALL LVL_FLIP_Y
	XOR A
	RET
.SUB_FLIPXY
	CALL LVL_FLIP_X
	;recopier le niveau dans temporaire pour pouvoir ensuite appliquer le deuxieme FLIP
	LD HL,load_niveau_courant
	LD DE,niveau_dans_temporaire
	LD BC,&B0
	LDIR
	CALL LVL_FLIP_Y
	XOR A
	RET

;------------------------------------------------------------------------------
; AFFICHAGE NIVEAU
;------------------------------------------------------------------------------
.LEVEL_LOAD_ET_AFFICHAGE
	CALL LEVEL_AFF
	CALL AFF_12_OPTIONS
	RET

.LEVEL_AFF
;	LD A,(IX+00)	;1 a 20 (numero du niveau)
;
;	;calcul adresse
;	LD HL,LEVELS-&B0
;
;.calculadrniveau
;	LD DE,&B0	;taille du niveau
;	ADD HL,DE
;	DEC A
;	CP 0
;	JP NZ,calculadrniveau
;
;	PUSH HL		;Sauver HL dans la Pile
;
;	;transfert des donnees dans la zone du niveau courant
;	LD DE,load_niveau_courant
;	LD BC,&B0   ;longueur d'un niveau
;	LDIR        ;transfert des donnees
;
;	POP IX		;Restaurer la Pile dans IX

	LD IX,load_niveau_courant
.access_pour_menu
	LD DE,ecran_tableau
	LD A,hauteur_tableau

.aff_tableau3
	PUSH AF
	PUSH DE		; on sauvegarde l'adresse video de la premiere ligne de sprites a afficher
	LD A,largueur_tableau

.aff_tableau2
	PUSH AF

	LD A,(IX+&00)
	INC IX

	LD L,A
	LD H,0
	ADD HL,HL	; x2
	ADD HL,HL	; x4
	ADD HL,HL	; x8
	ADD HL,HL	; x16
	ADD HL,HL	; x32
	ADD HL,HL	; x64 (16x16 = 4 octets x 16)

	LD BC,gfx_des_tiles
	ADD HL,BC

	PUSH DE
	CALL TILES_1
	POP DE

.aff_tableau1
	INC DE		;Case suivante 16 pixels = 4 octets
	INC DE
	INC DE
	INC DE

	POP AF
	DEC A
	JR NZ,aff_tableau2

	POP HL
	LD BC,&00A0
	ADD HL,BC
	EX DE,HL	;Ligne suivante
	POP AF
	DEC A
	JR NZ,aff_tableau3

	RET


;------------------------------------------------------------------------------
; AFFICHAGE ICONES + VALEUR
;------------------------------------------------------------------------------
AFF_1_OPTIONS
	LD C,48
	ADD C
	CALL aff_TILES8_0
	RET
icone_13		;icone vide
	LD HL,gfx_des_icones+768
	RET

AFF_12_OPTIONS
	LD DE,AFF_OPTIONX
	LD A,(LVL_OPTION1)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION1)
	LD HL,gfx_des_icones
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1
	CALL TILES_1

	LD DE,AFF_OPTIONX+5
	LD A,(LVL_OPTION2)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION2)
	LD HL,gfx_des_icones+64
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+5
	CALL TILES_1

	LD DE,AFF_OPTIONX+10
	LD A,(LVL_OPTION3)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION3)
	LD HL,gfx_des_icones+128
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+10
	CALL TILES_1

	LD DE,AFF_OPTIONX+15
	LD A,(LVL_OPTION4)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION4)
	LD HL,gfx_des_icones+192
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+15
	CALL TILES_1

	LD DE,AFF_OPTIONX+20
	LD A,(LVL_OPTION5)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION5)
	LD HL,gfx_des_icones+256
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+20
	CALL TILES_1

	LD DE,AFF_OPTIONX+25
	LD A,(LVL_OPTION6)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION6)
	LD HL,gfx_des_icones+320
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+25
	CALL TILES_1

	LD DE,AFF_OPTIONX+30
	LD A,(LVL_OPTION7)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION7)
	LD HL,gfx_des_icones+384
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+30
	CALL TILES_1

	LD DE,AFF_OPTIONX+35
	LD A,(LVL_OPTION8)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION8)
	LD HL,gfx_des_icones+448
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+35
	CALL TILES_1

	LD DE,AFF_OPTIONX+40
	LD A,(LVL_OPTION9)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION9)
	LD HL,gfx_des_icones+512
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+40
	CALL TILES_1

	LD DE,AFF_OPTIONX+45
	LD A,(LVL_OPTION10)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION10)
	LD HL,gfx_des_icones+576
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+45
	CALL TILES_1

	LD DE,AFF_OPTIONX+50
	LD A,(LVL_OPTION11)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION11)
	LD HL,gfx_des_icones+640
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+50
	CALL TILES_1

	LD DE,AFF_OPTIONX+55
	LD A,(LVL_OPTION12)
	CALL AFF_1_OPTIONS
	LD A,(LVL_OPTION12)
	LD HL,gfx_des_icones+704
	CP 0
	CALL Z,icone_13
	LD DE,AFF_ICONE1+55
	CALL TILES_1
RET


;------------------------------------------------------------------------------
; TILES 16x16 opaque
; Entrees ;
; A = element
; DE = adresse ecran
;------------------------------------------------------------------------------
.TILES_16x16_opaque
	;lecture valeur adresse_ecran
	LD E,(IX+00)
	LD D,(IX+01)
	PUSH DE
	;element opaque
	LD A,(IX+02)	;0 a 117

	LD L,A		;L = A
	LD H,0		;H = 0
	ADD HL,HL 	;*2
	ADD HL,HL 	;*4
	ADD HL,HL 	;*8
	ADD HL,HL 	;*16
	ADD HL,HL 	;*32
	ADD HL,HL 	;*64

	LD DE,gfx_des_tiles
	ADD HL,DE	;HL contient l'adresse du tiles

	POP DE		;DE adresse ecran

;.TILES_16x16_opaque
;	;lecture valeur adresse_tiles
;	LD L,(IX+00)
;	LD H,(IX+01)
;	;lecture valeur adresse_ecran
;	LD E,(IX+02)
;	LD D,(IX+03)
.TILES_1
	LD A,16
.TILES_2
	LDI		;16 pixels = 4 octets
	LDI
	LDI
	LDI
	EX DE,HL
	LD BC,&07FC
	ADD HL,BC
	JR NC,TILES_3
	LD BC,&C050
	ADD HL,BC
.TILES_3
	EX DE,HL
	DEC A
	JR NZ,TILES_2
	RET

;------------------------------------------------------------------------------
; Sprite transparent en mode 0
; Entrees ;
; - B = nombre de lignes
; - C = largeur du sprite en octets
; - HL = adresse du sprite
; - DE = adresse ecran.
;------------------------------------------------------------------------------
TRAN_SPR_PR	PUSH BC
		PUSH DE

TRAN_SPR_P0	LD A,(HL)		; A = octet courant
		LD B,A
		OR A			; Octet transparent?
		JR Z,TRAN_SPR_P1	; Oui => prochain octet (couleurs inchangees)

		AND %10101010		; Couleur gauche transparente?
		JR NZ,TRAN_SPR_P3	; Non => TRAN_SPR_P3

		LD A,(DE)		; Oui => octet = couleur droite du sprite + couleur gauche du fond d'ecran
		AND %10101010
		OR B
		LD (DE),A		; Octet paint

TRAN_SPR_P1	INC HL
		INC DE
		DEC C
		JR NZ,TRAN_SPR_P0

		POP DE			; DE = ligne ecran suivante (+&0800 or +&C800)
		EX HL,DE
		LD BC,&800
		ADD HL,BC
		JR NC,TRAN_SPR_P2
		LD BC,&C050
		ADD HL,BC
TRAN_SPR_P2	EX HL,DE
		POP BC
		DJNZ TRAN_SPR_PR
		RET

TRAN_SPR_P3	LD A,B
		AND %01010101		; Is sprite right color black?
		JR NZ,TRAN_SPR_P5	; No => TRAN_SPR_P5

		LD A,(DE)		; Oui => octet = couleur gauche du sprite + couleur droite du fond d'ecran
		AND %01010101
		OR B
		LD (DE),A		; Octet paint
		INC HL
		INC DE
		DEC C
		JR NZ,TRAN_SPR_P0

		POP DE			; DE = ligne ecran suivante (+&0800 or +&C800)
		EX HL,DE
		LD BC,&800
		ADD HL,BC
		JR NC,TRAN_SPR_P4
		LD BC,&C050
		ADD HL,BC
TRAN_SPR_P4	EX HL,DE
		POP BC
		DJNZ TRAN_SPR_PR
		RET

TRAN_SPR_P5	LD A,(DE)
		LD A,B
		LD (DE),A		; Octet = octet entier du sprite
		JR TRAN_SPR_P1

;-----------------------------------------------------------------------------------
; Entree   HL = TABLE
;           B = nb elements dans la table (par lot de 2 octets - cherche,remplace)
; Sortie    A = nouvelle valeur si trouve
;-----------------------------------------------------------------------------------
ConvValue
	CP(HL)				;comparer contenu de HL avec A
	JR Z,ConvValueFind	;si identique saut a ConvValueFind
	INC HL
	INC HL				;HL+2 pour lire la prochaine valeur dans la table de conversion
	DEC B				;compteurB-1
	JR NZ,ConvValue			;tant que b<>0 on boucle
	RET
ConvValueFind
	INC HL				;HL+1 (se positionner sur l'adresse suivante)
	LD A,(HL)			;A=la nouvelle valeur de substitution
	RET

;-----------------------------------------------------------------------------------
; LEVEL FLIP Y
;-----------------------------------------------------------------------------------
LVL_FLIP_Y
	;ligne 0 en 9
	LD IX,&5290
	LD IY,&8090
	LD C,16
	CALL FLIPY
	;ligne 1 en 8
	LD IX,&52A0
	LD IY,&8080
	LD C,16
	CALL FLIPY
	;ligne 2 en 7
	LD IX,&52B0
	LD IY,&8070
	LD C,16
	CALL FLIPY
	;ligne 3 en 6
	LD IX,&52C0
	LD IY,&8060
	LD C,16
	CALL FLIPY
	;ligne 4 en 5
	LD IX,&52D0
	LD IY,&8050
	LD C,16
	CALL FLIPY
	;ligne 5 en 4
	LD IX,&52E0
	LD IY,&8040
	LD C,16
	CALL FLIPY
	;ligne 6 en 3
	LD IX,&52F0
	LD IY,&8030
	LD C,16
	CALL FLIPY
	;ligne 7 en 2
	LD IX,&5300
	LD IY,&8020
	LD C,16
	CALL FLIPY
	;ligne 8 en 1
	LD IX,&5310
	LD IY,&8010
	LD C,16
	CALL FLIPY
	;ligne 9 en 0
	LD IX,&5320
	LD IY,&8000
	LD C,16
	CALL FLIPY
	;posx - idem
	LD A,(&5330)
	LD(&80A0),A
	;posy
	LD A,(&5331)
		LD HL,TABLEYPOSY
		LD B,10
		CALL ConvValue
	LD(&80A1),A
	;sensx - idem
	LD A,(&5332)
	LD(&80A2),A
	;sensy
	LD A,(&5333)
		LD HL,TABLEYSENSY
		LD B,2
		CALL ConvValue
	LD(&80A3),A
	;haut devient bas
	LD A,(&5334)
	LD(&80A8),A
	;haut/droite devient bas/droite
	LD A,(&5335)
	LD(&80A7),A
	;droite - idem
	LD A,(&5336)
	LD(&80A6),A
	;bas/droite devient haut/droite
	LD A,(&5337)
	LD(&80A5),A
	;bas devient haut
	LD A,(&5338)
	LD(&80A4),A
	;bas/gauche devient haut/gauche
	LD A,(&5339)
	LD(&80AB),A
	;gauche - idem
	LD A,(&533A)
	LD(&80AA),A
	;haut/gauche devient bas/gauche
	LD A,(&533B)
	LD(&80A9),A
	;teleport
	LD A,(&533C)
	LD(&80AC),A
	;tir1
	LD A,(&533D)
	LD(&80AD),A
	;tir4
	LD A,(&533E)
	LD(&80AE),A
	;bouclier
	LD A,(&533F)
	LD(&80AF),A
	RET

FLIPY
	LD A,(IX)
		LD HL,TABLEY
		LD B,TABLEY_TOTAL_ELEMENTS
		CALL ConvValue
	LD (IY),A
	INC IX				;adr source+1
	INC IY				;adr destination+1
	DEC C				;compteurC-1
	JR NZ,FLIPY			;tant que c<>0 on boucle
	RET

;-----------------------------------------------------------------------------------
; LEVEL FLIP X
;-----------------------------------------------------------------------------------
LVL_FLIP_X
	;ligne 0
	LD IX,&5290
	LD IY,&800F
	LD C,16
	CALL FLIPX
	;ligne 1
	LD IX,&52A0
	LD IY,&801F
	LD C,16
	CALL FLIPX
	;ligne 2
	LD IX,&52B0
	LD IY,&802F
	LD C,16
	CALL FLIPX
	;ligne 3
	LD IX,&52C0
	LD IY,&803F
	LD C,16
	CALL FLIPX
	;ligne 4
	LD IX,&52D0
	LD IY,&804F
	LD C,16
	CALL FLIPX
	;ligne 5
	LD IX,&52E0
	LD IY,&805F
	LD C,16
	CALL FLIPX
	;ligne 6
	LD IX,&52F0
	LD IY,&806F
	LD C,16
	CALL FLIPX
	;ligne 7
	LD IX,&5300
	LD IY,&807F
	LD C,16
	CALL FLIPX
	;ligne 8
	LD IX,&5310
	LD IY,&808F
	LD C,16
	CALL FLIPX
	;ligne 9
	LD IX,&5320
	LD IY,&809F
	LD C,16
	CALL FLIPX
	;posx
	LD A,(&5330)
		LD HL,TABLEXPOSX
		LD B,16
		CALL ConvValue
	LD(&80A0),A
	;posy - idem
	LD A,(&5331)
	LD(&80A1),A
	;sensx
	LD A,(&5332)
		LD HL,TABLEXSENSX
		LD B,2
		CALL ConvValue
	LD(&80A2),A
	;sensy - idem
	LD A,(&5333)
	LD(&80A3),A
	;haut - idem
	LD A,(&5334)
	LD(&80A4),A
	;haut/droite devient haut/gauche
	LD A,(&5335)
	LD(&80AB),A
	;droite devient gauche
	LD A,(&5336)
	LD(&80AA),A
	;bas/droite devient bas/gauche
	LD A,(&5337)
	LD(&80A9),A
	;bas - idem
	LD A,(&5338)
	LD(&80A8),A
	;bas/gauche devient bas/droite
	LD A,(&5339)
	LD(&80A7),A
	;gauche devient droite
	LD A,(&533A)
	LD(&80A6),A
	;haut/gauche devient haut/droite
	LD A,(&533B)
	LD(&80A5),A
	;teleport
	LD A,(&533C)
	LD(&80AC),A
	;tir1
	LD A,(&533D)
	LD(&80AD),A
	;tir4
	LD A,(&533E)
	LD(&80AE),A
	;bouclier
	LD A,(&533F)
	LD(&80AF),A
	RET

FLIPX
	LD A,(IX)
		LD HL,TABLEX
		LD B,TABLEX_TOTAL_ELEMENTS
		CALL ConvValue
	LD (IY),A
	INC IX				;adr source+1
	DEC IY				;adr destination-1
	DEC C				;compteurC-1
	JR NZ,FLIPX			;tant que c<>0 on boucle
	RET


;-----------------------------------------------------------------------------------
; TABLEAU CONVERSION X - POSX - 16 correspondances (cherche,remplace)
;-----------------------------------------------------------------------------------
TABLEXPOSX
	DB 0,15,1,14,2,13,3,12,4,11,5,10,6,9,7,9,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15,0

;-----------------------------------------------------------------------------------
; TABLEAU CONVERSION X - SENSX - 2 correspondances (cherche,remplace)
;-----------------------------------------------------------------------------------
TABLEXSENSX
	DB 1,2,2,1 

;-----------------------------------------------------------------------------------
; TABLEAU CONVERSION X - 64 correspondances (cherche,remplace)
;-----------------------------------------------------------------------------------
TABLEX
	DB 0,2,2,0
	DB 20,22,22,20
	DB 40,42,42,40
	DB 3,5,5,3
	DB 23,25,25,23
	DB 43,45,45,43
	DB 6,8,8,6
	DB 26,28,28,26
	DB 46,48,48,46
	DB 9,11,11,9
	DB 29,31,31,29
	DB 49,51,51,49
	DB 12,14,14,12
	DB 32,34,34,32
	DB 52,54,54,52
	DB 15,17,17,15
	DB 35,37,37,35
	DB 55,57,57,55
	DB 60,62,62,60
	DB 63,65,65,63
	DB 66,68,68,66
	DB 69,71,71,69
	DB 72,74,74,72
	DB 75,77,77,75
	DB 78,80,80,78
	DB 81,83,83,81
	DB 84,86,86,84
	DB 90,91,91,90
	DB 94,95,95,94
	DB 98,99,99,98
	DB 106,107,107,106
	DB 112,114,114,112


;-----------------------------------------------------------------------------------
; TABLEAU CONVERSION Y - POSY - 10 correspondances (cherche,remplace)
;-----------------------------------------------------------------------------------
TABLEYPOSY
	DB 0,9,1,8,2,7,3,6,4,5,5,4,6,3,7,2,8,1,9,0

;-----------------------------------------------------------------------------------
; TABLEAU CONVERSION Y - SENSY - 2 correspondances (cherche,remplace)
;-----------------------------------------------------------------------------------
TABLEYSENSY
	DB 1,2,2,1

;-----------------------------------------------------------------------------------
; TABLEAU CONVERSION Y - 64 correspondances (cherche,remplace)
;-----------------------------------------------------------------------------------
TABLEY
	DB 0,40,40,0
	DB 1,41,41,1
	DB 2,42,42,2
	DB 3,43,43,3
	DB 4,44,44,4
	DB 5,45,45,5
	DB 6,46,46,6
	DB 7,47,47,7
	DB 8,48,48,8
	DB 9,49,49,9
	DB 10,50,50,10
	DB 11,51,51,11
	DB 12,52,52,12
	DB 13,53,53,13
	DB 14,54,54,14
	DB 15,55,55,15
	DB 16,56,56,16
	DB 17,57,57,17
	DB 60,78,78,60
	DB 61,79,79,61
	DB 62,80,80,62
	DB 63,81,81,63
	DB 64,82,82,64
	DB 65,83,83,65
	DB 66,84,84,66
	DB 67,85,85,67
	DB 68,86,86,68
	DB 92,93,93,92
	DB 96,97,97,96
	DB 100,101,101,100
	DB 108,109,109,108
	DB 111,113,113,111

;------------------------------------------------------------------------------
; NIVEAUX
; Calcul Longueur = 
;   16x10 = 160 cases
;   position depart = 2 octets
;   direction = 2 octets
;   options = 12 octets
;   total = 160 + 2 + 2 + 12 = 176 octets (&B0)
;------------------------------------------------------------------------------
LEVELS
;level 01
DB 116,116,117,0,2,116,116,116,116,116,116,116,116,116,116,117
DB 1,1,1,21,93,1,1,2,117,116,116,116,116,0,1,1
DB 18,19,21,21,21,21,21,21,1,2,116,116,117,20,21,21
DB 64,64,64,64,64,64,64,65,21,22,116,116,0,18,19,12
DB 70,70,70,70,70,73,70,74,21,22,116,0,21,12,13,39
DB 70,70,70,70,70,70,70,74,21,58,58,58,21,32,88,94
DB 70,70,105,108,105,99,82,83,102,22,116,40,21,32,30,38
DB 81,70,105,105,105,105,18,19,21,42,116,116,40,52,53,53
DB 21,81,82,82,83,21,21,27,42,117,116,116,116,20,21,18
DB 41,41,41,41,41,41,41,42,116,116,116,116,117,40,41,41
DB 0 ;depart X
DB 5 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 2 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 2 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 2 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 2 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 0 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 02
DB 39,36,36,39,30,34,21,27,21,18,28,117,116,69,70,70
DB 30,36,38,95,53,54,18,19,19,21,58,58,58,113,70,70
DB 38,36,53,54,21,41,58,41,41,41,42,116,116,69,70,70
DB 36,54,21,41,42,117,58,116,116,116,117,116,60,70,105,105
DB 54,21,22,116,116,116,58,116,60,61,61,61,70,70,70,106
DB 21,18,42,116,116,60,58,61,70,70,105,105,105,70,105,105
DB 21,22,116,116,117,69,70,70,70,70,105,107,70,6,105,21
DB 41,42,116,60,61,104,70,70,73,70,105,105,105,21,90,18
DB 117,116,116,69,70,70,70,70,70,70,70,106,105,18,19,27
DB 116,116,117,69,70,70,70,70,70,70,105,105,105,112,87,24
DB 4 ;depart X
DB 8 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 1 ;option 1 - fleche haut
DB 1 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 1 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 0 ;option 11 - Tir 4 directions
DB 1 ;option 12 - Bouclier

;level 03
DB 30,14,27,93,21,21,21,21,21,21,21,21,21,21,21,22
DB 39,34,21,21,21,27,21,21,21,18,19,21,21,21,21,22
DB 107,34,63,64,64,65,21,105,105,105,105,105,105,105,21,22
DB 53,54,72,113,70,74,21,105,21,63,64,65,21,105,21,42
DB 102,21,72,70,70,74,24,21,21,72,109,74,21,105,102,117
DB 64,64,76,70,104,74,21,105,21,72,70,74,21,105,21,2
DB 79,70,70,70,70,74,21,105,21,72,89,74,21,105,21,22
DB 117,69,70,70,76,74,21,105,21,72,70,74,21,105,21,22
DB 117,69,70,112,70,70,64,64,64,70,111,70,64,65,41,42
DB 117,69,70,100,70,70,70,76,70,70,70,70,70,71,117,117
DB 14 ;depart X
DB 0 ;depart Y
DB 0 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 1 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 1 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 04
DB 117,29,39,36,36,36,36,31,116,116,116,117,116,116,116,117
DB 116,29,36,36,107,88,36,31,117,116,60,61,62,116,116,116
DB 9,30,36,36,30,36,36,51,116,116,78,70,70,62,117,116
DB 29,36,36,115,36,36,58,58,58,58,58,58,70,70,62,116
DB 36,33,36,36,36,39,51,116,116,116,60,70,70,76,70,62
DB 36,36,38,36,36,51,116,116,117,60,70,73,70,70,98,80
DB 36,36,36,36,51,116,116,60,61,76,70,70,70,70,80,116
DB 29,39,36,51,116,117,60,70,70,70,70,70,76,80,116,117
DB 49,50,51,116,116,60,70,76,70,70,70,58,58,58,58,58
DB 116,116,117,116,116,69,70,70,70,70,70,80,116,117,116,116
DB 6 ;depart X
DB 8 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 1 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 1 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 05
DB 117,60,70,70,70,70,76,70,70,70,61,62,116,116,116,116
DB 117,69,70,70,15,16,16,17,101,70,70,80,116,116,116,116
DB 61,70,15,16,38,39,30,38,16,17,80,116,117,9,11,116
DB 76,70,35,36,36,36,36,36,36,37,116,9,10,36,36,11
DB 70,70,35,107,36,103,88,112,36,36,10,36,36,36,30,31
DB 78,70,35,36,39,36,36,36,30,36,30,33,96,30,36,51
DB 116,70,55,56,56,56,56,56,56,57,117,49,50,50,51,117
DB 61,70,76,70,70,70,70,70,100,70,62,116,116,116,116,116
DB 82,82,6,7,7,7,8,82,82,82,80,116,116,117,116,116
DB 18,19,27,92,27,19,24,18,19,22,117,116,116,116,116,116
DB 10 ;depart X
DB 4 ;depart Y
DB 2 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 2 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 06
DB 117,20,21,18,19,21,21,21,21,21,21,21,18,105,21,21
DB 116,40,41,21,21,107,21,27,21,109,105,105,105,105,21,27
DB 116,116,117,20,21,21,115,21,21,21,105,21,21,18,21,21
DB 10,10,11,40,27,21,112,21,21,21,27,87,24,106,21,21
DB 30,38,30,14,21,21,21,21,21,21,105,21,21,18,19,21
DB 36,39,36,34,21,107,21,21,21,108,105,105,105,105,21,21
DB 103,103,103,36,14,21,21,24,21,21,21,21,21,105,18,19
DB 103,36,30,36,38,13,14,21,21,21,21,27,21,105,105,105
DB 103,103,103,39,36,36,34,21,115,21,21,41,21,21,21,27
DB 39,36,36,36,30,36,36,102,102,102,42,117,40,42,40,41
DB 1 ;depart X
DB 7 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 1 ;option 4 - fleche diagonale bas/droite
DB 1 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 07
DB 117,116,0,2,116,116,116,117,116,116,20,21,21,72,76,89
DB 0,1,27,21,1,1,1,2,116,0,21,21,21,81,82,82
DB 20,21,21,27,21,102,21,58,58,58,21,18,19,21,21,21
DB 40,21,21,41,41,41,41,42,117,40,41,41,58,41,41,42
DB 116,58,42,117,116,116,116,116,116,116,116,116,58,116,117,116
DB 62,58,116,116,116,116,116,116,116,116,9,10,58,10,11,116
DB 76,58,61,61,62,116,116,116,117,116,29,39,36,39,31,116
DB 70,70,73,70,58,58,58,58,58,58,58,106,36,36,31,116
DB 70,70,70,70,71,116,117,116,116,116,49,50,30,36,31,116
DB 70,76,70,70,76,61,62,116,117,116,116,116,49,36,51,117
DB 1 ;depart X
DB 8 ;depart Y
DB 0 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 2 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 1 ;option 1 - fleche haut
DB 1 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 2 ;option 10 - Tir 1 direction
DB 0 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 08
DB 36,39,34,21,22,117,116,20,21,72,76,70,70,70,70,70
DB 39,36,34,21,22,116,117,20,21,72,70,70,70,70,70,76
DB 36,39,34,21,58,58,58,58,21,72,70,70,109,70,70,70
DB 30,103,34,21,22,117,116,20,21,72,76,70,70,105,105,70
DB 39,97,34,21,22,116,116,20,21,72,70,70,70,106,105,105
DB 36,88,34,21,22,117,117,20,21,72,70,76,70,105,105,70
DB 53,53,54,21,58,58,58,58,21,114,70,70,70,70,70,70
DB 21,21,21,41,42,116,117,20,21,72,70,105,108,105,70,70
DB 21,21,22,117,116,0,1,21,48,70,76,105,105,105,70,70
DB 21,92,22,116,116,20,21,48,70,70,70,70,105,70,76,70
DB 14 ;depart X
DB 6 ;depart Y
DB 2 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 2 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 1 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 1 ;option 12 - Bouclier

;level 09
DB 116,78,70,112,70,70,70,70,70,70,70,70,76,70,70,113
DB 2,117,78,70,70,70,70,76,70,70,70,105,70,6,7,7
DB 27,2,116,58,78,79,109,79,79,108,79,105,70,26,27,87
DB 14,21,1,58,2,117,116,116,117,116,116,69,105,105,18,19
DB 39,14,107,21,58,58,58,58,58,58,58,70,70,70,105,105
DB 30,34,21,21,22,116,117,116,116,116,69,70,76,70,70,70
DB 39,54,21,112,58,58,58,58,58,58,58,70,70,70,70,104
DB 54,18,19,21,22,116,116,116,116,117,69,104,70,111,73,70
DB 27,21,21,27,22,117,116,116,60,61,70,70,70,70,76,70
DB 21,27,21,21,22,116,116,117,78,104,70,70,70,104,70,70
DB 1 ;depart X
DB 9 ;depart Y
DB 0 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 2 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 1 ;option 1 - fleche haut
DB 1 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 1 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 2 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 10
DB 117,116,116,116,0,63,70,70,70,70,65,2,117,116,116,116
DB 116,116,117,0,63,73,70,70,70,76,70,65,2,116,117,116
DB 116,116,0,63,70,70,70,70,70,70,70,70,65,2,116,116
DB 117,0,63,76,70,70,70,76,70,70,70,70,106,65,2,117
DB 0,63,70,70,70,70,105,105,104,105,105,105,105,70,65,2
DB 40,81,70,112,70,70,70,104,70,104,70,89,105,70,70,65
DB 117,40,81,70,70,70,105,105,104,105,108,105,105,70,76,83
DB 116,116,40,70,79,79,79,79,70,105,105,105,109,70,83,42
DB 61,62,117,58,116,117,116,116,69,76,70,70,70,83,42,116
DB 70,76,61,70,61,61,58,58,70,70,70,70,83,42,116,117
DB 0 ;depart X
DB 9 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 1 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 1 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 2 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 11
DB 70,70,107,70,70,70,70,70,70,74,21,106,21,22,116,116
DB 76,70,70,70,105,105,105,105,105,74,21,21,21,22,117,116
DB 70,70,70,76,70,82,82,82,82,6,21,27,113,21,1,1
DB 70,70,70,70,83,41,41,41,42,40,102,21,21,21,21,18
DB 70,70,104,74,22,117,116,116,117,0,18,41,58,63,64,65
DB 70,70,82,83,22,116,116,0,1,24,63,62,58,78,73,70
DB 70,74,21,41,42,116,0,21,21,63,70,80,58,117,78,80
DB 70,74,22,117,116,0,21,27,63,70,71,117,58,117,117,116
DB 76,74,22,116,116,20,21,63,70,107,70,15,103,11,116,116
DB 82,83,22,116,117,20,21,81,70,70,70,35,88,31,116,117
DB 6 ;depart X
DB 0 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 1 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 3 ;option 10 - Tir 1 direction
DB 0 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 12
DB 117,117,20,21,21,27,21,21,21,22,117,116,69,70,70,89
DB 0,2,20,27,21,21,93,18,19,22,116,116,69,73,70,70
DB 40,42,20,112,21,27,21,21,58,58,58,58,58,58,76,70
DB 116,116,40,58,41,41,41,41,42,116,116,117,116,78,79,79
DB 117,116,116,58,116,116,116,117,116,116,116,116,116,116,117,116
DB 9,10,10,58,10,10,10,11,9,10,10,11,9,10,10,11
DB 36,36,30,111,38,36,30,36,36,36,114,36,36,36,39,36
DB 36,39,36,36,36,39,36,36,30,36,36,36,36,106,36,36
DB 36,36,36,33,36,36,36,38,36,36,36,39,36,30,36,36
DB 38,36,36,36,30,36,103,36,36,36,111,36,36,36,38,36
DB 1 ;depart X
DB 9 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 2 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 2 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 13
DB 70,55,38,39,97,38,57,70,70,70,26,27,21,27,18,19
DB 76,70,55,56,56,57,73,70,76,70,46,47,47,47,47,47
DB 70,70,70,70,70,70,70,70,70,70,70,76,70,70,70,70
DB 16,17,70,70,70,79,78,70,109,70,6,7,7,7,7,7
DB 39,37,70,70,71,117,116,78,79,80,40,41,42,40,41,41
DB 56,57,104,70,70,62,116,116,116,116,116,0,1,1,1,2
DB 79,76,70,79,70,58,58,58,58,58,58,58,102,18,19,87
DB 117,78,80,117,78,80,116,117,116,116,116,40,41,41,41,24
DB 116,116,9,10,11,116,116,116,116,116,116,9,10,11,116,40
DB 116,9,39,108,38,11,116,116,116,116,9,30,108,39,11,117
DB 14 ;depart X
DB 0 ;depart Y
DB 2 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 1 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 1 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 1 ;option 12 - Bouclier

;level 14
DB 117,116,60,70,70,70,70,70,70,62,116,117,116,116,116,117
DB 116,9,17,70,70,73,70,70,76,70,61,62,116,117,116,116
DB 60,35,97,17,70,70,82,70,70,6,8,70,61,61,62,117
DB 76,55,30,66,70,74,21,72,74,106,28,70,73,105,70,61
DB 70,70,112,70,76,74,102,27,21,18,28,70,70,105,76,70
DB 69,76,70,82,82,91,21,24,105,105,105,105,70,105,70,70
DB 78,104,74,107,21,27,21,72,114,113,70,70,70,105,70,76
DB 116,78,70,64,64,65,21,72,105,70,76,104,70,105,6,8
DB 117,116,78,70,76,74,18,72,105,70,70,70,70,105,46,48
DB 116,116,117,70,70,74,21,72,105,89,70,108,70,105,105,105
DB 6 ;depart X
DB 9 ;depart Y
DB 0 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 2 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 1 ;option 5 - fleche bas
DB 1 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 1 ;option 12 - Bouclier

;level 15
DB 39,36,36,37,70,76,70,70,70,70,70,110,113,116,116,116
DB 36,38,36,37,104,70,70,70,109,70,107,70,70,62,116,116
DB 36,36,39,36,16,17,70,70,70,70,70,70,70,76,62,116
DB 50,58,50,50,50,57,70,70,76,70,70,70,70,104,70,61
DB 117,58,116,117,116,78,79,79,79,70,70,105,76,105,105,105
DB 2,58,1,1,2,116,116,117,116,69,107,105,70,105,39,11
DB 21,112,58,58,58,58,58,58,58,58,76,70,70,105,38,31
DB 18,19,21,21,22,116,116,116,116,69,107,105,76,105,30,31
DB 27,21,92,18,19,2,117,116,116,78,105,105,70,105,38,51
DB 21,21,21,21,27,22,116,116,117,116,69,70,89,105,51,117
DB 5 ;depart X
DB 0 ;depart Y
DB 0 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 1 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 1 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 1 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 2 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 16
DB 21,2,117,116,0,1,2,117,0,1,1,2,117,116,116,117
DB 14,21,1,1,21,21,21,1,102,27,21,21,1,1,2,116
DB 38,14,21,18,12,13,13,13,13,14,21,12,13,14,21,2
DB 103,36,14,21,32,39,36,36,33,34,93,32,39,36,14,42
DB 36,107,34,21,32,30,36,39,36,34,27,32,106,36,34,117
DB 39,53,54,21,52,53,53,53,53,54,92,52,36,30,54,2
DB 54,63,65,27,21,18,19,21,21,21,21,21,52,54,41,42
DB 21,81,83,21,87,21,21,106,21,21,21,41,41,42,117,116
DB 21,63,64,65,21,21,41,41,41,41,42,117,116,116,116,116
DB 64,70,70,74,24,42,117,116,116,117,116,0,1,2,116,117
DB 5 ;depart X
DB 4 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 1 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 17
DB 18,19,91,44,45,36,30,50,50,36,38,39,36,30,23,90
DB 21,21,45,36,50,51,58,117,116,49,50,50,50,36,43,44
DB 27,25,36,31,117,116,58,116,116,116,116,116,117,49,50,50
DB 21,25,30,36,10,10,58,10,10,11,117,116,116,116,116,117
DB 24,45,36,36,36,36,36,30,36,38,10,10,11,117,116,116
DB 45,33,36,39,36,111,111,111,36,36,30,38,36,10,10,10
DB 105,105,105,105,39,36,36,36,36,39,36,105,105,105,105,105
DB 39,38,39,97,36,36,36,36,114,36,36,36,115,36,114,103
DB 38,88,103,39,36,36,36,36,114,36,30,36,36,36,114,103
DB 38,39,38,96,36,30,36,115,114,36,36,108,36,36,114,103
DB 6 ;depart X
DB 0 ;depart Y
DB 0 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 1 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 2 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 1 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 1 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 18
DB 60,62,0,1,1,1,2,117,0,1,1,1,1,1,2,117
DB 69,89,64,64,65,93,19,1,93,63,64,65,24,102,42,116
DB 78,82,76,99,70,64,64,64,64,104,76,83,18,42,116,60
DB 117,20,81,73,104,6,7,7,7,8,74,27,22,117,60,70
DB 116,20,92,72,76,26,27,102,93,28,74,90,22,60,70,76
DB 116,20,27,81,70,26,91,21,27,28,104,64,64,70,70,70
DB 60,65,102,91,72,46,47,47,47,48,70,82,70,73,82,70
DB 78,76,64,64,70,82,82,70,100,70,83,92,81,83,21,81
DB 116,78,82,82,83,92,27,81,82,83,18,19,42,40,21,27
DB 116,117,40,41,41,42,40,41,41,41,41,42,117,117,40,21
DB 15 ;depart X
DB 3 ;depart Y
DB 2 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 1 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 2 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 1 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 2 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 0 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 19
DB 116,116,116,116,116,40,105,109,105,42,116,116,116,116,116,116
DB 116,116,0,2,116,0,21,21,21,2,116,0,1,1,2,116
DB 1,1,21,21,1,21,21,21,21,27,1,21,21,21,21,2
DB 102,105,102,27,21,21,27,21,21,21,18,102,105,102,21,21
DB 115,107,21,21,18,19,63,64,65,24,21,21,106,105,21,24
DB 102,105,102,21,21,21,72,104,74,21,21,102,105,102,21,21
DB 41,42,20,21,21,27,81,82,83,21,41,41,41,21,21,42
DB 116,0,21,42,40,21,21,21,27,22,116,116,116,40,42,0
DB 0,21,42,116,116,20,105,108,105,22,116,116,0,1,1,21
DB 21,42,116,116,116,20,102,105,102,22,116,116,20,87,102,115
DB 0 ;depart X
DB 9 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 2 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 1 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 1 ;option 6 - fleche diagonale bas/gauche
DB 1 ;option 7 - fleche gauche
DB 1 ;option 8 - fleche haut/gauche
DB 0 ;option 9 - Teleporteur
DB 0 ;option 10 - Tir 1 direction
DB 2 ;option 11 - Tir 4 directions
DB 0 ;option 12 - Bouclier

;level 20
DB 21,102,21,21,18,21,21,32,39,103,30,36,31,116,116,116
DB 18,21,47,47,47,47,21,32,30,114,109,38,31,116,117,116
DB 40,28,101,76,101,70,26,32,39,114,53,53,54,2,116,116
DB 117,20,7,7,7,7,21,52,53,114,18,114,114,22,116,117
DB 116,107,21,18,21,21,19,21,18,19,90,114,87,22,116,116
DB 116,20,63,64,64,65,21,12,13,114,19,114,114,22,116,117
DB 117,40,81,82,82,83,21,32,30,114,13,13,13,42,116,116
DB 116,116,40,41,41,21,102,32,39,114,108,39,31,116,117,116
DB 116,117,116,116,117,20,27,32,30,114,36,39,30,10,10,10
DB 116,116,117,116,116,20,18,32,39,103,38,30,39,36,30,38
DB 5 ;depart X
DB 4 ;depart Y
DB 1 ;sens X (0=non, 1=droite, 2=gauche / le 2 a transformer en -1)
DB 0 ;sens Y (0=non, 1=bas, 2=haut / le 2 a transformer en -1)
DB 0 ;option 1 - fleche haut
DB 0 ;option 2 - fleche diagonale haut/droite
DB 0 ;option 3 - fleche droite
DB 0 ;option 4 - fleche diagonale bas/droite
DB 0 ;option 5 - fleche bas
DB 0 ;option 6 - fleche diagonale bas/gauche
DB 0 ;option 7 - fleche gauche
DB 0 ;option 8 - fleche haut/gauche
DB 2 ;option 9 - Teleporteur
DB 1 ;option 10 - Tir 1 direction
DB 0 ;option 11 - Tir 4 directions
DB 1 ;option 12 - Bouclier

;------------------------------------------------------------------------------
; Player Arkos tracker
;------------------------------------------------------------------------------
PLAYER_ARKOS
	list
;*** Start of Arkos Tracker Player
	nolist
; music selector
	JP start_music              ; front-end minable mais bon
PLAYER_ARKOS_OFF
	JP PLY_InterruptionOff      ; routine Arkos tracker 
	JP PLY_InterruptionContinue ; routine Arkos tracker
	JP PLY_SetFadeValue

	jp PLY_SFX_Init				;Call Player + 9 to initialise the sound effect music.
	jp PLY_BasicSoundEffectInterface_PlaySound ;Call Player + 12 to add sound effect in BASIC.
	jp PLY_SFX_Stop	


start_music
	LD A,E
	ADD A,A  ; x2
	LD C,A
	LD B,&0
	LD HL,musiques
	ADD HL,BC       ; on pointe sur la table contenant l'adresse de depart d'une musique

	LD E,(HL)
	INC HL
	LD D,(HL)
	JP PLY_InterruptionOn

musiques 
	defw ZIC_RAYXAMBER
	defw &0000 ;  rien
	defw &0000 ;  rien
	
	;end &5D03

;	Arkos Tracker Player V1.01 - CPC & MSX version.
;	21/09/09

;	Code By Targhan/Arkos.
;	PSG registers sendings based on Madram/Overlander's optimisation trick.
;	Restoring interruption status snippet by Grim/Arkos.

;	V1.01 additions
;	---------------
;	- Small (but not useless !) optimisations by Grim/Arkos at the PLY_Track1_WaitCounter / PLY_Track2_WaitCounter / PLY_Track3_WaitCounter labels.
;	- Optimisation of the R13 management by Grim/Arkos.



;	This player can adapt to the following machines =
;	Amstrad CPC and MSX.
;	Output codes are specific, as well as the frequency tables.

;	This player modifies all these registers = HL, DE, BC, AF, HL', DE', BC', AF', IX, IY.
;	The Stack is used in conventionnal manners (Call, Ret, Push, Pop) so integration with any of your code should be seamless.
;	The player does NOT modifies the Interruption state, unless you use the PLY_SystemFriendly flag, which will cut the
;	interruptions at the beginning, and will restore them ONLY IF NEEDED.


;	Basically, there are three kind of players.


;	ASM
;	---
;	Used in your Asm productions. You call the Player by yourself, you don't care if all the registers are modified.

;	Set PLY_SystemFriendly and PLY_UseFirmwareInterruptions to 0.

;	In Assembler =
;	ld de,MusicAddress
;	call Player / PLY_Init		to initialise the player with your song.
;	then
;	call Player + 3 / PLY_Play	whenever you want to play/continue the song.
;	call Player + 6 / PLY_Stop	to stop the song.


;	BASIC
;	-----
;	Used in Basic (on CPC), or under the helm of any OS. Interruptions will be cut by the player, but restored ONLY IF NECESSARY.
;	Also, some registers are saved (AF', BC', IX and IY), as they are used by the CPC Firmware.
;	If you need to add/remove more registers, take care to do it at PLY_Play, but also at PLY_Stop.
;	Registers are restored at PLY_PSGREG13_RecoverSystemRegisters.

;	Set PLY_SystemFriendly to 1 and PLY_UseFirmwareInterruptions to 0.

;	The Calls in Assembler are the same as above.

;	In Basic =
;	call Player, MusicAddress	to initialise the player with your song.
;	then
;	call Player + 3			whenever you want to play/continue the song.
;	call Player + 6			to stop the song.


;	INTERRUPTIONS
;	-------------
;	CPC Only ! Uses the Firmware Interruptions to put the Player on interruption. Very useful in Basic.

;	Set PLY_SystemFriendly and PLY_UseFirmwareInterruptions to 1.

;	In Assembler =
;	ld de,MusicAddress
;	call Player / PLY_InterruptionOn		to play the song from start.
;	call Player + 3 / PLY_InterruptionOff		to stop the song.
;	call Player + 6 / PLY_InterruptionContinue	to continue the song once it's been stopped.

;	In Basic=
;	call Player, MusicAddress	to play the song from start.
;	call Player + 3			to stop the song.
;	call Player + 6			to continue the song once it's been stopped.



;	FADES IN/OUT
;	------------
;	The player allows the volume to be modified. It provides the interface, but you'll have to set the volume by yourself.
;	Set PLY_UseFades to 1.
;	In Assembler =
;	ld e,Volume (0=full volume, 16 or more=no volume)
;	call PLY_SetFadeValue

;	In Basic =
;	call Player + 9 (or + 18, see just below), Volume (0=full volume, 16 or more=no volume)
;	WARNING ! You must call Player + 18 if PLY_UseBasicSoundEffectInterface is set to 1.



;	SOUND EFFECTS
;	-------------
;	The player manages Sound Effects. They must be defined in another song, generated as a "SFX Music" in the Arkos Tracker.
;	Set the PLY_UseSoundEffects to 1. If you want to use sound effects in Basic, set PLY_UseBasicSoundEffectInterface to 1.

;	In Assembler =
;	ld de,SFXMusicAddress
;	call PLY_SFX_Init		to initialise the SFX Song.

;	Then initialise and play the "music" song normally.

;	To play a sound effect =
;	A = No Channel (0,1,2)
;	L = SFX Number (>0)
;	H = Volume (0...F)
;	E = Note (0...143)
;	D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
;	BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
;	call PLY_SFX_Play
;	To stop a sound effect =
;	ld e,No Channel (0,1,2)
;	call PLY_SFX_Stop
;	To stop the sound effects on all the channels =
;	call PLY_SFX_StopAll

;	In Basic =
;	call Player + 9, SFXMusicAddress	to initialise the SFX Song.
;	To play a sound effect =
;	call Player + 12, No Channel, SFX Number, Volume, Note, Speed, Inverted Pitch. No parameter should be ommited !
;	To stop a sound effect =
;	call Player + 15, No Channel (0,1,2)


;	For more information, check the manual.

;	Any question, complaint, a need to reward ? Write to contact@julien-nevo.com


PLY_UseCPCMachine equ 1		;Indicates what frequency table and output code to use. 1 to use it.
PLY_UseMSXMachine equ 0


PLY_UseSoundEffects equ 1	;Set to 1 if you want to use Sound Effects in your player. Both CPU and memory consuming.

PLY_UseFades equ 1		;Set to 1 to allow fades in/out. A little CPU and memory consuming.
				;PLY_SetFadeValue becomes available.


PLY_SystemFriendly equ 1	;Set to 1 if you want to save the Registers used by AMSDOS (AF', BC', IX, IY)
				;(which allows you to call this player in BASIC)
				;As this option is system-friendly, it cuts the interruption, and restore them ONLY IF NECESSARY.

PLY_UseFirmwareInterruptions equ 1 
                                ;Set to 1 to use a Player under interruption. Only works on CPC, as it uses the CPC Firmware.
				;WARNING, PLY_SystemFriendly must be set to 1 if you use the Player under interruption !
				;SECOND WARNING, make sure the player is above #3fff, else it won't be played (system limitation).

PLY_UseBasicSoundEffectInterface equ 1	;Set to 1 if you want a little interface to be added if you are a BASIC programmer who wants
					;to use sound effects. Of course, you must also set PLY_UseSoundEffects to 1.







PLY_RetrigValue	equ #fe		;Value used to trigger the Retrig of Register 13. #FE corresponds to CP xx. Do not change it !






Player

	if PLY_UseFirmwareInterruptions

;******* Interruption Player ********

;You can remove these JPs if using the sub-routines directly.
	jp PLY_InterruptionOn			;Call Player = Start Music.
	jp PLY_InterruptionOff			;Call Player + 3 = Stop Music.
	jp PLY_InterruptionContinue		;Call Player + 6 = Continue (after stopping).

	if PLY_UseBasicSoundEffectInterface
	jp PLY_SFX_Init				;Call Player + 9 to initialise the sound effect music.
	jp PLY_BasicSoundEffectInterface_PlaySound ;Call Player + 12 to add sound effect in BASIC.
	jp PLY_SFX_Stop				;Call Player + 15 to stop a sound effect.
	endif

	if PLY_UseFades
	jp PLY_SetFadeValue			;Call Player + 9 or + 18 to set Fades values.
	endif



PLY_InterruptionOn call PLY_Init
	ld hl,PLY_Interruption_Convert
PLY_ReplayFrequency ld de,0
	ld a,d
	ld (PLY_Interruption_Cpt + 1),a
	add hl,de
	ld a,(hl)	;Chope nbinter wait
	ld (PLY_Interruption_Value + 1),a

PLY_InterruptionContinue
	ld hl,PLY_Interruption_ControlBloc
	ld bc,%10000001*256+0
	ld de,PLY_Interruption_Play
	jp #bce0
PLY_InterruptionOff ld hl,PLY_Interruption_ControlBloc
	call #bce6
	jp PLY_Stop

PLY_Interruption_ControlBloc defs 10,0	;Buffer used by the OS.

;Code run by the OS on each interruption.
PLY_Interruption_Play di

PLY_Interruption_Cpt ld a,0		;Run the player only if it has to, according to the music frequency.
PLY_Interruption_Value cp 5
	jr z,PLY_Interruption_NoWait
	inc a
	ld (PLY_Interruption_Cpt + 1),a
	ret

PLY_Interruption_NoWait xor a
	ld (PLY_Interruption_Cpt + 1),a
	jp PLY_Play

;Table to convert PLY_ReplayFrequency into a Frequency value for the AMSDOS.
PLY_Interruption_Convert defb 17, 11, 5, 2, 1, 0


	






	else




;***** Normal Player *****
;To be called when you want.

;You can remove these following JPs if using the sub-routines directly.
	jp PLY_Init						;Call Player = Initialise song (DE = Song address).
	jp PLY_Play						;Call Player + 3 = Play song.
	jp PLY_Stop						;Call Player + 6 = Stop song.
	endif

	if PLY_UseBasicSoundEffectInterface
	jp PLY_SFX_Init						;Call Player + 9 to initialise the sound effect music.
	jp PLY_BasicSoundEffectInterface_PlaySound		;Call Player + 12 to add sound effect in BASIC.
	jp PLY_SFX_Stop						;Call Player + 15 to stop a sound effect.
	endif

	if PLY_UseFades
	jp PLY_SetFadeValue					;Call Player + 9 or + 18 to set Fades values.
	endif



PLY_Digidrum db 0						;Read here to know if a Digidrum has been played (0=no).


PLY_Play

	if PLY_SystemFriendly
	call PLY_DisableInterruptions
	ex af,af'
	exx
	push af
	push bc
	push ix
	push iy
	endif



	xor a				
	ld (PLY_Digidrum),a		;Reset the Digidrum flag.


;Manage Speed. If Speed counter is over, we have to read the Pattern further.
PLY_SpeedCpt ld a,1
	dec a
	jp nz,PLY_SpeedEnd

	;Moving forward in the Pattern. Test if it is not over.
PLY_HeightCpt ld a,1
	dec a
	jr nz,PLY_HeightEnd

;Pattern Over. We have to read the Linker.




	;Get the Transpositions, if they have changed, or detect the Song Ending !
PLY_Linker_PT ld hl,0
	ld a,(hl)
	inc hl
	rra
	jr nc,PLY_SongNotOver
	;Song over ! We read the address of the Loop point.
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	ld a,(hl)			;We know the Song won't restart now, so we can skip the first bit.
	inc hl
	rra
PLY_SongNotOver
	rra
	jr nc,PLY_NoNewTransposition1
	ld de,PLY_Transposition1 + 1
	ldi
PLY_NoNewTransposition1
	rra
	jr nc,PLY_NoNewTransposition2
	ld de,PLY_Transposition2 + 1
	ldi
PLY_NoNewTransposition2
	rra
	jr nc,PLY_NoNewTransposition3
	ld de,PLY_Transposition3 + 1
	ldi
PLY_NoNewTransposition3

	;Get the Tracks addresses.
	ld de,PLY_Track1_PT + 1
	ldi
	ldi
	ld de,PLY_Track2_PT + 1
	ldi
	ldi
	ld de,PLY_Track3_PT + 1
	ldi
	ldi

	;Get the Special Track address, if it has changed.
	rra
	jr nc,PLY_NoNewHeight
	ld de,PLY_Height + 1
	ldi
PLY_NoNewHeight

	rra
	jr nc,PLY_NoNewSpecialTrack
PLY_NewSpecialTrack
	ld e,(hl)
	inc hl
	ld d,(hl)
	inc hl
	ld (PLY_SaveSpecialTrack + 1),de

PLY_NoNewSpecialTrack
	ld (PLY_Linker_PT + 1),hl
PLY_SaveSpecialTrack ld hl,0
	ld (PLY_SpecialTrack_PT + 1),hl

	;Reset the SpecialTrack/Tracks line counter.
	;We can't rely on the song data, because the Pattern Height is not related to the Tracks Height.
	ld a,1
	ld (PLY_SpecialTrack_WaitCounter + 1),a
	ld (PLY_Track1_WaitCounter + 1),a
	ld (PLY_Track2_WaitCounter + 1),a
	ld (PLY_Track3_WaitCounter + 1),a



PLY_Height ld a,1
PLY_HeightEnd
	ld (PLY_HeightCpt + 1),a






;Read the Special Track/Tracks.
;------------------------------


;Read the Special Track.
PLY_SpecialTrack_WaitCounter ld a,1
	dec a
	jr nz,PLY_SpecialTrack_Wait

PLY_SpecialTrack_PT ld hl,0
	ld a,(hl)
	inc hl
	srl a				;Data (1) or Wait (0) ?
	jr nc,PLY_SpecialTrack_NewWait	;If Wait, A contains the Wait value.
	;Data. Effect Type ?
	srl a				;Speed (0) or Digidrum (1) ?
	;First, we don't test the Effect Type, but only the Escape Code (=0)
	jr nz,PLY_SpecialTrack_NoEscapeCode
	ld a,(hl)
	inc hl
	
PLY_SpecialTrack_NoEscapeCode
	;Now, we test the Effect type, since the Carry didn't change.
	jr nc,PLY_SpecialTrack_Speed
	ld (PLY_Digidrum),a
	jr PLY_PT_SpecialTrack_EndData

PLY_SpecialTrack_Speed
	ld (PLY_Speed + 1),a
PLY_PT_SpecialTrack_EndData
	ld a,1
PLY_SpecialTrack_NewWait
	ld (PLY_SpecialTrack_PT + 1),hl
PLY_SpecialTrack_Wait
	ld (PLY_SpecialTrack_WaitCounter + 1),a















;Read the Track 1.
;-----------------

;Store the parameters, because the player below is called every frame, but the Read Track isn't.
PLY_Track1_WaitCounter ld a,1
	dec a
	jr nz,PLY_Track1_NewInstrument_SetWait

PLY_Track1_PT ld hl,0
	call PLY_ReadTrack
	ld (PLY_Track1_PT + 1),hl
	jr c,PLY_Track1_NewInstrument_SetWait


	;No Wait command. Can be a Note and/or Effects.
	ld a,d			;Make a copy of the flags+Volume in A, not to temper with the original.

	rra			;Volume ? If bit 4 was 1, then volume exists on b3-b0
	jr nc,PLY_Track1_SameVolume
	and %1111
	ld (PLY_Track1_Volume),a
PLY_Track1_SameVolume



	rl d				;New Pitch ?
	jr nc,PLY_Track1_NoNewPitch
	ld (PLY_Track1_PitchAdd + 1),ix
PLY_Track1_NoNewPitch

	rl d				;Note ? If no Note, we don't have to test if a new Instrument is here.
	jr nc,PLY_Track1_NoNoteGiven
	ld a,e
PLY_Transposition1 add a,0		;Transpose Note according to the Transposition in the Linker.
	ld (PLY_Track1_Note),a

	ld hl,0				;Reset the TrackPitch.
	ld (PLY_Track1_Pitch + 1),hl

	rl d				;New Instrument ?
	jr c,PLY_Track1_NewInstrument
PLY_Track1_SavePTInstrument ld hl,0	;Same Instrument. We recover its address to restart it.
	ld a,(PLY_Track1_InstrumentSpeed + 1)		;Reset the Instrument Speed Counter. Never seemed useful...
	ld (PLY_Track1_InstrumentSpeedCpt + 1),a
	jr PLY_Track1_InstrumentResetPT

PLY_Track1_NewInstrument		;New Instrument. We have to get its new address, and Speed.
	ld l,b				;H is already set to 0 before.
	add hl,hl
PLY_Track1_InstrumentsTablePT ld bc,0
	add hl,bc
	ld a,(hl)			;Get Instrument address.
	inc hl
	ld h,(hl)
	ld l,a
	ld a,(hl)			;Get Instrument speed.
	inc hl
	ld (PLY_Track1_InstrumentSpeed + 1),a
	ld (PLY_Track1_InstrumentSpeedCpt + 1),a
	ld a,(hl)
	or a				;Get IsRetrig?. Code it only if different to 0, else next Instruments are going to overwrite it.
	jr z,$+5
	ld (PLY_PSGReg13_Retrig + 1),a

	inc hl

	ld (PLY_Track1_SavePTInstrument + 1),hl		;When using the Instrument again, no need to give the Speed, it is skipped.

PLY_Track1_InstrumentResetPT
	ld (PLY_Track1_Instrument + 1),hl





PLY_Track1_NoNoteGiven

	ld a,1
PLY_Track1_NewInstrument_SetWait
	ld (PLY_Track1_WaitCounter + 1),a









;Read the Track 2.
;-----------------

;Store the parameters, because the player below is called every frame, but the Read Track isn't.
PLY_Track2_WaitCounter ld a,1
	dec a
	jr nz,PLY_Track2_NewInstrument_SetWait

PLY_Track2_PT ld hl,0
	call PLY_ReadTrack
	ld (PLY_Track2_PT + 1),hl
	jr c,PLY_Track2_NewInstrument_SetWait


	;No Wait command. Can be a Note and/or Effects.
	ld a,d			;Make a copy of the flags+Volume in A, not to temper with the original.

	rra			;Volume ? If bit 4 was 1, then volume exists on b3-b0
	jr nc,PLY_Track2_SameVolume
	and %1111
	ld (PLY_Track2_Volume),a
PLY_Track2_SameVolume



	rl d				;New Pitch ?
	jr nc,PLY_Track2_NoNewPitch
	ld (PLY_Track2_PitchAdd + 1),ix
PLY_Track2_NoNewPitch

	rl d				;Note ? If no Note, we don't have to test if a new Instrument is here.
	jr nc,PLY_Track2_NoNoteGiven
	ld a,e
PLY_Transposition2 add a,0		;Transpose Note according to the Transposition in the Linker.
	ld (PLY_Track2_Note),a

	ld hl,0				;Reset the TrackPitch.
	ld (PLY_Track2_Pitch + 1),hl

	rl d				;New Instrument ?
	jr c,PLY_Track2_NewInstrument
PLY_Track2_SavePTInstrument ld hl,0	;Same Instrument. We recover its address to restart it.
	ld a,(PLY_Track2_InstrumentSpeed + 1)		;Reset the Instrument Speed Counter. Never seemed useful...
	ld (PLY_Track2_InstrumentSpeedCpt + 1),a
	jr PLY_Track2_InstrumentResetPT

PLY_Track2_NewInstrument		;New Instrument. We have to get its new address, and Speed.
	ld l,b				;H is already set to 0 before.
	add hl,hl
PLY_Track2_InstrumentsTablePT ld bc,0
	add hl,bc
	ld a,(hl)			;Get Instrument address.
	inc hl
	ld h,(hl)
	ld l,a
	ld a,(hl)			;Get Instrument speed.
	inc hl
	ld (PLY_Track2_InstrumentSpeed + 1),a
	ld (PLY_Track2_InstrumentSpeedCpt + 1),a
	ld a,(hl)
	or a				;Get IsRetrig?. Code it only if different to 0, else next Instruments are going to overwrite it.
	jr z,$+5
	ld (PLY_PSGReg13_Retrig + 1),a
	inc hl


	ld (PLY_Track2_SavePTInstrument + 1),hl		;When using the Instrument again, no need to give the Speed, it is skipped.

PLY_Track2_InstrumentResetPT
	ld (PLY_Track2_Instrument + 1),hl





PLY_Track2_NoNoteGiven

	ld a,1
PLY_Track2_NewInstrument_SetWait
	ld (PLY_Track2_WaitCounter + 1),a







;Read the Track 3.
;-----------------

;Store the parameters, because the player below is called every frame, but the Read Track isn't.
PLY_Track3_WaitCounter ld a,1
	dec a
	jr nz,PLY_Track3_NewInstrument_SetWait

PLY_Track3_PT ld hl,0
	call PLY_ReadTrack
	ld (PLY_Track3_PT + 1),hl
	jr c,PLY_Track3_NewInstrument_SetWait


	;No Wait command. Can be a Note and/or Effects.
	ld a,d			;Make a copy of the flags+Volume in A, not to temper with the original.

	rra			;Volume ? If bit 4 was 1, then volume exists on b3-b0
	jr nc,PLY_Track3_SameVolume
	and %1111
	ld (PLY_Track3_Volume),a
PLY_Track3_SameVolume



	rl d				;New Pitch ?
	jr nc,PLY_Track3_NoNewPitch
	ld (PLY_Track3_PitchAdd + 1),ix
PLY_Track3_NoNewPitch

	rl d				;Note ? If no Note, we don't have to test if a new Instrument is here.
	jr nc,PLY_Track3_NoNoteGiven
	ld a,e
PLY_Transposition3 add a,0		;Transpose Note according to the Transposition in the Linker.
	ld (PLY_Track3_Note),a

	ld hl,0				;Reset the TrackPitch.
	ld (PLY_Track3_Pitch + 1),hl

	rl d				;New Instrument ?
	jr c,PLY_Track3_NewInstrument
PLY_Track3_SavePTInstrument ld hl,0	;Same Instrument. We recover its address to restart it.
	ld a,(PLY_Track3_InstrumentSpeed + 1)		;Reset the Instrument Speed Counter. Never seemed useful...
	ld (PLY_Track3_InstrumentSpeedCpt + 1),a
	jr PLY_Track3_InstrumentResetPT

PLY_Track3_NewInstrument		;New Instrument. We have to get its new address, and Speed.
	ld l,b				;H is already set to 0 before.
	add hl,hl
PLY_Track3_InstrumentsTablePT ld bc,0
	add hl,bc
	ld a,(hl)			;Get Instrument address.
	inc hl
	ld h,(hl)
	ld l,a
	ld a,(hl)			;Get Instrument speed.
	inc hl
	ld (PLY_Track3_InstrumentSpeed + 1),a
	ld (PLY_Track3_InstrumentSpeedCpt + 1),a
	ld a,(hl)
	or a				;Get IsRetrig?. Code it only if different to 0, else next Instruments are going to overwrite it.
	jr z,$+5
	ld (PLY_PSGReg13_Retrig + 1),a
	inc hl


	ld (PLY_Track3_SavePTInstrument + 1),hl		;When using the Instrument again, no need to give the Speed, it is skipped.

PLY_Track3_InstrumentResetPT
	ld (PLY_Track3_Instrument + 1),hl





PLY_Track3_NoNoteGiven

	ld a,1
PLY_Track3_NewInstrument_SetWait
	ld (PLY_Track3_WaitCounter + 1),a










PLY_Speed ld a,1
PLY_SpeedEnd
	ld (PLY_SpeedCpt + 1),a










;Play the Sound on Track 3
;-------------------------
;Plays the sound on each frame, but only save the forwarded Instrument pointer when Instrument Speed is reached.
;This is needed because TrackPitch is involved in the Software Frequency/Hardware Frequency calculation, and is calculated every frame.

	ld iy,PLY_PSGRegistersArray + 4
PLY_Track3_Pitch ld hl,0
PLY_Track3_PitchAdd ld de,0
	add hl,de
	ld (PLY_Track3_Pitch + 1),hl
	sra h				;Shift the Pitch to slow its speed.
	rr l
	sra h
	rr l
	ex de,hl
	exx

PLY_Track3_Volume equ $+2
PLY_Track3_Note equ $+1
	ld de,0				;D=Inverted Volume E=Note
PLY_Track3_Instrument ld hl,0
	call PLY_PlaySound

PLY_Track3_InstrumentSpeedCpt ld a,1
	dec a
	jr nz,PLY_Track3_PlayNoForward
	ld (PLY_Track3_Instrument + 1),hl
PLY_Track3_InstrumentSpeed ld a,6
PLY_Track3_PlayNoForward
	ld (PLY_Track3_InstrumentSpeedCpt + 1),a



;***************************************
;Play Sound Effects on Track 3 (only assembled used if PLY_UseSoundEffects is set to one)
;***************************************
	if PLY_UseSoundEffects


PLY_SFX_Track3_Pitch ld de,0
	exx
PLY_SFX_Track3_Volume equ $+2
PLY_SFX_Track3_Note equ $+1
	ld de,0				;D=Inverted Volume E=Note
PLY_SFX_Track3_Instrument ld hl,0	;If 0, no sound effect.
	ld a,l
	or h
	jr z,PLY_SFX_Track3_End
	ld a,1
	ld (PLY_PS_EndSound_SFX + 1),a
	call PLY_PlaySound
	xor a
	ld (PLY_PS_EndSound_SFX + 1),a
	ld a,l				;If the new address is 0, the instrument is over. Speed is set in the process, we don't care.
	or h
	jr z,PLY_SFX_Track3_Instrument_SetAddress

PLY_SFX_Track3_InstrumentSpeedCpt ld a,1
	dec a
	jr nz,PLY_SFX_Track3_PlayNoForward
PLY_SFX_Track3_Instrument_SetAddress
	ld (PLY_SFX_Track3_Instrument + 1),hl
PLY_SFX_Track3_InstrumentSpeed ld a,6
PLY_SFX_Track3_PlayNoForward
	ld (PLY_SFX_Track3_InstrumentSpeedCpt + 1),a

PLY_SFX_Track3_End

	endif
;******************************************




	ld a,ixl			;Save the Register 7 of the Track 3.
	ex af,af'
	



;Play the Sound on Track 2
;-------------------------
	ld iy,PLY_PSGRegistersArray + 2
PLY_Track2_Pitch ld hl,0
PLY_Track2_PitchAdd ld de,0
	add hl,de
	ld (PLY_Track2_Pitch + 1),hl
	sra h				;Shift the Pitch to slow its speed.
	rr l
	sra h
	rr l
	ex de,hl
	exx

PLY_Track2_Volume equ $+2
PLY_Track2_Note equ $+1
	ld de,0				;D=Inverted Volume E=Note
PLY_Track2_Instrument ld hl,0
	call PLY_PlaySound

PLY_Track2_InstrumentSpeedCpt ld a,1
	dec a
	jr nz,PLY_Track2_PlayNoForward
	ld (PLY_Track2_Instrument + 1),hl
PLY_Track2_InstrumentSpeed ld a,6
PLY_Track2_PlayNoForward
	ld (PLY_Track2_InstrumentSpeedCpt + 1),a



;***************************************
;Play Sound Effects on Track 2 (only assembled used if PLY_UseSoundEffects is set to one)
;***************************************
	if PLY_UseSoundEffects

PLY_SFX_Track2_Pitch ld de,0
	exx
PLY_SFX_Track2_Volume equ $+2
PLY_SFX_Track2_Note equ $+1
	ld de,0				;D=Inverted Volume E=Note
PLY_SFX_Track2_Instrument ld hl,0	;If 0, no sound effect.
	ld a,l
	or h
	jr z,PLY_SFX_Track2_End
	ld a,1
	ld (PLY_PS_EndSound_SFX + 1),a
	call PLY_PlaySound
	xor a
	ld (PLY_PS_EndSound_SFX + 1),a
	ld a,l				;If the new address is 0, the instrument is over. Speed is set in the process, we don't care.
	or h
	jr z,PLY_SFX_Track2_Instrument_SetAddress

PLY_SFX_Track2_InstrumentSpeedCpt ld a,1
	dec a
	jr nz,PLY_SFX_Track2_PlayNoForward
PLY_SFX_Track2_Instrument_SetAddress
	ld (PLY_SFX_Track2_Instrument + 1),hl
PLY_SFX_Track2_InstrumentSpeed ld a,6
PLY_SFX_Track2_PlayNoForward
	ld (PLY_SFX_Track2_InstrumentSpeedCpt + 1),a

PLY_SFX_Track2_End
	endif
;******************************************


	ex af,af'
	add a,a			;Mix Reg7 from Track2 with Track3, making room first.
	or ixl
	rla
	ex af,af'



;Play the Sound on Track 1
;-------------------------

	ld iy,PLY_PSGRegistersArray
PLY_Track1_Pitch ld hl,0
PLY_Track1_PitchAdd ld de,0
	add hl,de
	ld (PLY_Track1_Pitch + 1),hl
	sra h				;Shift the Pitch to slow its speed.
	rr l
	sra h
	rr l
	ex de,hl
	exx

PLY_Track1_Volume equ $+2
PLY_Track1_Note equ $+1
	ld de,0				;D=Inverted Volume E=Note
PLY_Track1_Instrument ld hl,0
	call PLY_PlaySound

PLY_Track1_InstrumentSpeedCpt ld a,1
	dec a
	jr nz,PLY_Track1_PlayNoForward
	ld (PLY_Track1_Instrument + 1),hl
PLY_Track1_InstrumentSpeed ld a,6
PLY_Track1_PlayNoForward
	ld (PLY_Track1_InstrumentSpeedCpt + 1),a




;***************************************
;Play Sound Effects on Track 1 (only assembled used if PLY_UseSoundEffects is set to one)
;***************************************
	if PLY_UseSoundEffects


PLY_SFX_Track1_Pitch ld de,0
	exx
PLY_SFX_Track1_Volume equ $+2
PLY_SFX_Track1_Note equ $+1
	ld de,0				;D=Inverted Volume E=Note
PLY_SFX_Track1_Instrument ld hl,0	;If 0, no sound effect.
	ld a,l
	or h
	jr z,PLY_SFX_Track1_End
	ld a,1
	ld (PLY_PS_EndSound_SFX + 1),a
	call PLY_PlaySound
	xor a
	ld (PLY_PS_EndSound_SFX + 1),a
	ld a,l				;If the new address is 0, the instrument is over. Speed is set in the process, we don't care.
	or h
	jr z,PLY_SFX_Track1_Instrument_SetAddress

PLY_SFX_Track1_InstrumentSpeedCpt ld a,1
	dec a
	jr nz,PLY_SFX_Track1_PlayNoForward
PLY_SFX_Track1_Instrument_SetAddress
	ld (PLY_SFX_Track1_Instrument + 1),hl
PLY_SFX_Track1_InstrumentSpeed ld a,6
PLY_SFX_Track1_PlayNoForward
	ld (PLY_SFX_Track1_InstrumentSpeedCpt + 1),a

PLY_SFX_Track1_End
	endif
;***********************************







	ex af,af'
	or ixl			;Mix Reg7 from Track3 with Track2+1.



;Send the registers to PSG. Various codes according to the machine used.
PLY_SendRegisters
;A=Register 7




	if PLY_UseMSXMachine

	ld b,a
	ld hl,PLY_PSGRegistersArray

;Register 0
	xor a
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 1
	ld a,1
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 2
	ld a,2
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 3
	ld a,3
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 4
	ld a,4
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 5
	ld a,5
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 6
	ld a,6
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 7
	ld a,7
	out (#a0),a
	ld a,b				;Use the stored Register 7.
	out (#a1),a

;Register 8
	ld a,8
	out (#a0),a
	ld a,(hl)

	if PLY_UseFades
PLY_Channel1_FadeValue sub 0		;Set a value from 0 (full volume) to 16 or more (volume to 0).
	jr nc,$+3
	xor a
	endif

	out (#a1),a
	inc hl
	inc hl				;Skip unused byte.

;Register 9
	ld a,9
	out (#a0),a
	ld a,(hl)

	if PLY_UseFades
PLY_Channel2_FadeValue sub 0		;Set a value from 0 (full volume) to 16 or more (volume to 0).
	jr nc,$+3
	xor a
	endif

	out (#a1),a
	inc hl
	inc hl				;Skip unused byte.
	
;Register 10
	ld a,10
	out (#a0),a
	ld a,(hl)

	if PLY_UseFades
PLY_Channel3_FadeValue sub 0		;Set a value from 0 (full volume) to 16 or more (volume to 0).
	jr nc,$+3
	xor a
	endif

	out (#a1),a
	inc hl

;Register 11
	ld a,11
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 12
	ld a,12
	out (#a0),a
	ld a,(hl)
	out (#a1),a
	inc hl

;Register 13
	if PLY_SystemFriendly
	call PLY_PSGReg13_Code
PLY_PSGREG13_RecoverSystemRegisters
	pop iy
	pop ix
	pop bc
	pop af
	exx
	ex af,af'
	;Restore Interrupt status
PLY_RestoreInterruption nop				;Will be automodified to an DI/EI.
	ret

	endif


PLY_PSGReg13_Code
	ld a,13
	out (#a0),a
	ld a,(hl)
PLY_PSGReg13_Retrig cp 255				;If IsRetrig?, force the R13 to be triggered.
	ret z

	out (#a1),a
	ld (PLY_PSGReg13_Retrig + 1),a
	ret



	endif
















	if PLY_UseCPCMachine

	ld de,#c080
	ld b,#f6
	out (c),d	;#f6c0
	exx
	ld hl,PLY_PSGRegistersArray
	ld e,#f6
	ld bc,#f401

;Register 0
	defb #ed,#71	;#f400+Register
	ld b,e
	defb #ed,#71	;#f600
	dec b
	outi		;#f400+value
	exx
	out (c),e	;#f680
	out (c),d	;#f6c0
	exx

;Register 1
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 2
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 3
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 4
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 5
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 6
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 7
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	dec b
	out (c),a			;Read A register instead of the list.
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 8
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	if PLY_UseFades
	dec b
	ld a,(hl)
PLY_Channel1_FadeValue sub 0		;Set a value from 0 (full volume) to 16 or more (volume to 0).
	jr nc,$+6
	defb #ed,#71
	jr $+4
	out (c),a
	inc hl

	else
	
	outi
	endif
	exx
	out (c),e
	out (c),d
	exx
	inc c
	inc hl				;Skip unused byte.

;Register 9
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	if PLY_UseFades			;If PLY_UseFades is set to 1, we manage the volume fade.
	dec b
	ld a,(hl)
PLY_Channel2_FadeValue sub 0		;Set a value from 0 (full volume) to 16 or more (volume to 0).
	jr nc,$+6
	defb #ed,#71
	jr $+4
	out (c),a
	inc hl

	else
	
	outi
	endif
	exx
	out (c),e
	out (c),d
	exx
	inc c
	inc hl				;Skip unused byte.

;Register 10
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	if PLY_UseFades
	dec b
	ld a,(hl)
PLY_Channel3_FadeValue sub 0		;Set a value from 0 (full volume) to 16 or more (volume to 0).
	jr nc,$+6
	defb #ed,#71
	jr $+4
	out (c),a
	inc hl

	else
	
	outi
	endif
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 11
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 12
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	exx
	inc c

;Register 13
	if PLY_SystemFriendly
	call PLY_PSGReg13_Code

PLY_PSGREG13_RecoverSystemRegisters
	pop iy
	pop ix
	pop bc
	pop af
	exx
	ex af,af'
	;Restore Interrupt status
PLY_RestoreInterruption nop				;Will be automodified to an DI/EI.
	ret

	endif


PLY_PSGReg13_Code
	ld a,(hl)
PLY_PSGReg13_Retrig cp 255				;If IsRetrig?, force the R13 to be triggered.
	ret z
	ld (PLY_PSGReg13_Retrig + 1),a
	out (c),c
	ld b,e
	defb #ed,#71
	dec b
	outi
	exx
	out (c),e
	out (c),d
	ret

	endif












;There are two holes in the list, because the Volume registers are set relatively to the Frequency of the same Channel (+7, always).
;Also, the Reg7 is passed as a register, so is not kept in the memory.
PLY_PSGRegistersArray
PLY_PSGReg0 db 0
PLY_PSGReg1 db 0
PLY_PSGReg2 db 0
PLY_PSGReg3 db 0
PLY_PSGReg4 db 0
PLY_PSGReg5 db 0
PLY_PSGReg6 db 0
PLY_PSGReg8 db 0		;+7
	    db 0
PLY_PSGReg9 db 0		;+9
	    db 0
PLY_PSGReg10 db 0		;+11
PLY_PSGReg11 db 0
PLY_PSGReg12 db 0
PLY_PSGReg13 db 0
PLY_PSGRegistersArray_End





























;Plays a sound stream.
;HL=Pointer on Instrument Data
;IY=Pointer on Register code (volume, frequency).
;E=Note
;D=Inverted Volume
;DE'=TrackPitch

;RET=
;HL=New Instrument pointer.
;IXL=Reg7 mask (x00x)

;Also used inside =
;B,C=read byte/second byte.
;IXH=Save original Note (only used for Independant mode).


PLY_PlaySound
	ld b,(hl)
	inc hl
	rr b
	jp c,PLY_PS_Hard

;**************
;Software Sound
;**************
	;Second Byte needed ?
	rr b
	jr c,PLY_PS_S_SecondByteNeeded

	;No second byte needed. We need to check if Volume is null or not.
	ld a,b
	and %1111
	jr nz,PLY_PS_S_SoundOn

	;Null Volume. It means no Sound. We stop the Sound, the Noise, and it's over.
	ld (iy + 7),a			;We have to make the volume to 0, because if a bass Hard was activated before, we have to stop it.
	ld ixl,%1001

	ret

PLY_PS_S_SoundOn
	;Volume is here, no Second Byte needed. It means we have a simple Software sound (Sound = On, Noise = Off)
	;We have to test Arpeggio and Pitch, however.
	ld ixl,%1000

	sub d						;Code Volume.
	jr nc,$+3
	xor a
	ld (iy + 7),a

	rr b						;Needed for the subroutine to get the good flags.
	call PLY_PS_CalculateFrequency
	ld (iy + 0),l					;Code Frequency.
	ld (iy + 1),h
	exx

	ret
	


PLY_PS_S_SecondByteNeeded
	ld ixl,%1000	;By defaut, No Noise, Sound.

	;Second Byte needed.
	ld c,(hl)
	inc hl

	;Noise ?
	ld a,c
	and %11111
	jr z,PLY_PS_S_SBN_NoNoise
	ld (PLY_PSGReg6),a
	ld ixl,%0000					;Open Noise Channel.
	PLY_PS_S_SBN_NoNoise

	;Here we have either Volume and/or Sound. So first we need to read the Volume.
	ld a,b
	and %1111
	sub d						;Code Volume.
	jr nc,$+3
	xor a
	ld (iy + 7),a

	;Sound ?
	bit 5,c
	jr nz,PLY_PS_S_SBN_Sound
	;No Sound. Stop here.
	inc ixl						;Set Sound bit to stop the Sound.
	ret

PLY_PS_S_SBN_Sound
	;Manual Frequency ?
	rr b						;Needed for the subroutine to get the good flags.
	bit 6,c
	call PLY_PS_CalculateFrequency_TestManualFrequency
	ld (iy + 0),l					;Code Frequency.
	ld (iy + 1),h
	exx

	ret




;**********
;Hard Sound
;**********
PLY_PS_Hard
	;We don't set the Volume to 16 now because we may have reached the end of the sound !

	rr b						;Test Retrig here, it is common to every Hard sounds.
	jr nc,PLY_PS_Hard_NoRetrig
	ld a,(PLY_Track1_InstrumentSpeedCpt + 1)	;Retrig only if it is the first step in this line of Instrument !
	ld c,a
	ld a,(PLY_Track1_InstrumentSpeed + 1)
	cp c
	jr nz,PLY_PS_Hard_NoRetrig
	ld a,PLY_RetrigValue
	ld (PLY_PSGReg13_Retrig + 1),a
PLY_PS_Hard_NoRetrig

	;Independant/Loop or Software/Hardware Dependent ?
	bit 1,b				;We don't shift the bits, so that we can use the same code (Frequency calculation) several times.
	jp nz,PLY_PS_Hard_LoopOrIndependent

	;Hardware Sound.
	ld (iy + 7),16					;Set Volume
	ld ixl,%1000					;Sound is always On here (only Independence mode can switch it off).

	;This code is common to both Software and Hardware Dependent.
	ld c,(hl)			;Get Second Byte.
	inc hl
	ld a,c				;Get the Hardware Envelope waveform.
	and %1111			;We don't care about the bit 7-4, but we have to clear them, else the waveform might be reset.
	ld (PLY_PSGReg13),a

	bit 0,b
	jr z,PLY_PS_HardwareDependent


;******************
;Software Dependent
;******************

	;Calculate the Software frequency
	bit 4-2,b		;Manual Frequency ? -2 Because the byte has been shifted previously.
	call PLY_PS_CalculateFrequency_TestManualFrequency
	ld (iy + 0),l		;Code Software Frequency.
	ld (iy + 1),h
	exx

	;Shift the Frequency.
	ld a,c
	rra
	rra			;Shift=Shift*4. The shift is inverted in memory (7 - Editor Shift).
	and %11100
	ld (PLY_PS_SD_Shift + 1),a
	ld a,b			;Used to get the HardwarePitch flag within the second registers set.
	exx

PLY_PS_SD_Shift jr $+2
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	jr nc,$+3
	inc hl

	;Hardware Pitch ?
	bit 7-2,a
	jr z,PLY_PS_SD_NoHardwarePitch
	exx						;Get Pitch and add it to the just calculated Hardware Frequency.
	ld a,(hl)
	inc hl
	exx
	add a,l						;Slow. Can be optimised ? Probably never used anyway.....
	ld l,a
	exx
	ld a,(hl)
	inc hl
	exx
	adc a,h
	ld h,a
PLY_PS_SD_NoHardwarePitch
	ld (PLY_PSGReg11),hl
	exx


	;This code is also used by Hardware Dependent.
PLY_PS_SD_Noise
	;Noise ?
	bit 7,c
	ret z
	ld a,(hl)
	inc hl
	ld (PLY_PSGReg6),a
	ld ixl,%0000
	ret




;******************
;Hardware Dependent
;******************
PLY_PS_HardwareDependent
	;Calculate the Hardware frequency
	bit 4-2,b			;Manual Hardware Frequency ? -2 Because the byte has been shifted previously.
	call PLY_PS_CalculateFrequency_TestManualFrequency
	ld (PLY_PSGReg11),hl		;Code Hardware Frequency.
	exx

	;Shift the Hardware Frequency.
	ld a,c
	rra
	rra			;Shift=Shift*4. The shift is inverted in memory (7 - Editor Shift).
	and %11100
	ld (PLY_PS_HD_Shift + 1),a
	ld a,b			;Used to get the Software flag within the second registers set.
	exx


PLY_PS_HD_Shift jr $+2
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h

	;Software Pitch ?
	bit 7-2,a
	jr z,PLY_PS_HD_NoSoftwarePitch
	exx						;Get Pitch and add it to the just calculated Software Frequency.
	ld a,(hl)
	inc hl
	exx
	add a,l
	ld l,a						;Slow. Can be optimised ? Probably never used anyway.....
	exx
	ld a,(hl)
	inc hl
	exx
	adc a,h
	ld h,a
PLY_PS_HD_NoSoftwarePitch
	ld (iy + 0),l					;Code Frequency.
	ld (iy + 1),h
	exx

	;Go to manage Noise, common to Software Dependent.
	jr PLY_PS_SD_Noise





PLY_PS_Hard_LoopOrIndependent
	bit 0,b					;We mustn't shift it to get the result in the Carry, as it would be mess the structure
	jr z,PLY_PS_Independent			;of the flags, making it uncompatible with the common code.

	;The sound has ended.
	;If Sound Effects activated, we mark the "end of sound" by returning a 0 as an address.
	if PLY_UseSoundEffects
PLY_PS_EndSound_SFX ld a,0			;Is the sound played is a SFX (1) or a normal sound (0) ?
	or a
	jr z,PLY_PS_EndSound_NotASFX
	ld hl,0
	ret
PLY_PS_EndSound_NotASFX
	endif

	;The sound has ended. Read the new pointer and restart instrument.

	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	jp PLY_PlaySound






;***********
;Independent
;***********
PLY_PS_Independent
	ld (iy + 7),16			;Set Volume

	;Sound ?
	bit 7-2,b			;-2 Because the byte has been shifted previously.
	jr nz,PLY_PS_I_SoundOn
	;No Sound ! It means we don't care about the software frequency (manual frequency, arpeggio, pitch).
	ld ixl,%1001
	jr PLY_PS_I_SkipSoftwareFrequencyCalculation
PLY_PS_I_SoundOn
	ld ixl,%1000			;Sound is on.
	ld ixh,e			;Save the original note for the Hardware frequency, because a Software Arpeggio will modify it.

	;Calculate the Software frequency
	bit 4-2,b			;Manual Frequency ? -2 Because the byte has been shifted previously.
	call PLY_PS_CalculateFrequency_TestManualFrequency
	ld (iy + 0),l			;Code Software Frequency.
	ld (iy + 1),h
	exx

	ld e,ixh
PLY_PS_I_SkipSoftwareFrequencyCalculation

	ld b,(hl)			;Get Second Byte.
	inc hl
	ld a,b				;Get the Hardware Envelope waveform.
	and %1111			;We don't care about the bit 7-4, but we have to clear them, else the waveform might be reset.
	ld (PLY_PSGReg13),a


	;Calculate the Hardware frequency
	rr b				;Must shift it to match the expected data of the subroutine.
	rr b
	bit 4-2,b			;Manual Hardware Frequency ? -2 Because the byte has been shifted previously.
	call PLY_PS_CalculateFrequency_TestManualFrequency
	ld (PLY_PSGReg11),hl		;Code Hardware Frequency.
	exx



	;Noise ? We can't use the previous common code, because the setting of the Noise is different, since Independent can have no Sound.
	bit 7-2,b
	ret z
	ld a,(hl)
	inc hl
	ld (PLY_PSGReg6),a
	ld a,ixl	;Set the Noise bit.
	res 3,a
	ld ixl,a
	ret

















;Subroutine that =
;If Manual Frequency? (Flag Z off), read frequency (Word) and adds the TrackPitch (DE').
;Else, Auto Frequency.
;	if Arpeggio? = 1 (bit 3 from B), read it (Byte).
;	if Pitch? = 1 (bit 4 from B), read it (Word).
;	Calculate the frequency according to the Note (E) + Arpeggio + TrackPitch (DE').

;HL = Pointer on Instrument data.
;DE'= TrackPitch.

;RET=
;HL = Pointer on Instrument moved forward.
;HL'= Frequency
;	RETURN IN AUXILIARY REGISTERS
PLY_PS_CalculateFrequency_TestManualFrequency
	jr z,PLY_PS_CalculateFrequency
	;Manual Frequency. We read it, no need to read Pitch and Arpeggio.
	;However, we add TrackPitch to the read Frequency, and that's all.
	ld a,(hl)
	inc hl
	exx
	add a,e						;Add TrackPitch LSB.
	ld l,a
	exx
	ld a,(hl)
	inc hl
	exx
	adc a,d						;Add TrackPitch HSB.
	ld h,a
	ret




PLY_PS_CalculateFrequency
	;Pitch ?
	bit 5-1,b
	jr z,PLY_PS_S_SoundOn_NoPitch
	ld a,(hl)
	inc hl
	exx
	add a,e						;If Pitch found, add it directly to the TrackPitch.
	ld e,a
	exx
	ld a,(hl)
	inc hl
	exx
	adc a,d
	ld d,a
	exx
	PLY_PS_S_SoundOn_NoPitch

	;Arpeggio ?
	ld a,e
	bit 4-1,b
	jr z,PLY_PS_S_SoundOn_ArpeggioEnd
	add a,(hl)					;Add Arpeggio to Note.
	inc hl
	cp 144
	jr c,$+4
	ld a,143
	PLY_PS_S_SoundOn_ArpeggioEnd

	;Frequency calculation.
	exx
	ld l,a
	ld h,0
	add hl,hl
	
	ld bc,PLY_FrequencyTable
	add hl,bc

	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	add hl,de					;Add TrackPitch + InstrumentPitch (if any).

	ret
















;Read one Track.
;HL=Track Pointer.

;Ret =
;HL=New Track Pointer.
;Carry = 1 = Wait A lines. Carry=0=Line not empty.
;A=Wait (0(=256)-127), if Carry.
;D=Parameters + Volume.
;E=Note
;B=Instrument. 0=RST
;IX=PitchAdd. Only used if Pitch? = 1.
PLY_ReadTrack
	ld a,(hl)
	inc hl
	srl a			;Full Optimisation ? If yes = Note only, no Pitch, no Volume, Same Instrument.
	jr c,PLY_ReadTrack_FullOptimisation
	sub 32			;0-31 = Wait.
	jr c,PLY_ReadTrack_Wait
	jr z,PLY_ReadTrack_NoOptimisation_EscapeCode
	dec a			;0 (32-32) = Escape Code for more Notes (parameters will be read)
	
	;Note. Parameters are present. But the note is only present if Note? flag is 1.
	ld e,a			;Save Note.

	;Read Parameters
PLY_ReadTrack_ReadParameters
	ld a,(hl)
	ld d,a			;Save Parameters.
	inc hl

	rla			;Pitch ?
	jr nc,PLY_ReadTrack_Pitch_End
	ld b,(hl)		;Get PitchAdd
	ld ixl,b
	inc hl
	ld b,(hl)
	ld ixh,b
	inc hl
PLY_ReadTrack_Pitch_End

	rla			;Skip IsNote? flag.
	rla			;New Instrument ?
	ret nc
	ld b,(hl)
	inc hl
	or a			;Remove Carry, as the player interpret it as a Wait command.
	ret

;Escape code, read the Note and returns to read the Parameters.
PLY_ReadTrack_NoOptimisation_EscapeCode
	ld e,(hl)
	inc hl
	jr PLY_ReadTrack_ReadParameters
	




PLY_ReadTrack_FullOptimisation
	;Note only, no Pitch, no Volume, Same Instrument.
	ld d,%01000000			;Note only.
	sub 1
	ld e,a
	ret nc
	ld e,(hl)			;Escape Code found (0). Read Note.
	inc hl
	or a
	ret





PLY_ReadTrack_Wait
	add a,32
	ret







PLY_FrequencyTable
	if PLY_UseCPCMachine
	dw 3822,3608,3405,3214,3034,2863,2703,2551,2408,2273,2145,2025
	dw 1911,1804,1703,1607,1517,1432,1351,1276,1204,1136,1073,1012
	dw 956,902,851,804,758,716,676,638,602,568,536,506
	dw 478,451,426,402,379,358,338,319,301,284,268,253
	dw 239,225,213,201,190,179,169,159,150,142,134,127
	dw 119,113,106,100,95,89,84,80,75,71,67,63
	dw 60,56,53,50,47,45,42,40,38,36,34,32
	dw 30,28,27,25,24,22,21,20,19,18,17,16
	dw 15,14,13,13,12,11,11,10,9,9,8,8
	dw 7,7,7,6,6,6,5,5,5,4,4,4
	dw 4,4,3,3,3,3,3,2,2,2,2,2
	dw 2,2,2,2,1,1,1,1,1,1,1,1
	endif

	if PLY_UseMSXMachine
	dw 4095,4095,4095,4095,4095,4095,4095,4095,4095,4030,3804,3591
	dw 3389,3199,3019,2850,2690,2539,2397,2262,2135,2015,1902,1795
	dw 1695,1599,1510,1425,1345,1270,1198,1131,1068,1008,951,898
	dw 847,800,755,712,673,635,599,566,534,504,476,449
	dw 424,400,377,356,336,317,300,283,267,252,238,224
	dw 212,200,189,178,168,159,150,141,133,126,119,112
	dw 106,100,94,89,84,79,75,71,67,63,59,56
	dw 53,50,47,45,42,40,37,35,33,31,30,28
	dw 26,25,24,22,21,20,19,18,17,16,15,14
	dw 13,12,12,11,11,10,9,9,8,8,7,7
	dw 7,6,6,6,5,5,5,4,4,4,4,4
	dw 3,3,3,3,3,2,2,2,2,2,2,2
	endif



;DE = Music
PLY_Init
	if PLY_UseFirmwareInterruptions
	ld hl,8				;Skip Header, SampleChannel, YM Clock (DB*3). The Replay Frequency is used in Interruption mode.
	add hl,de
	ld de,PLY_ReplayFrequency + 1
	ldi
	else
	ld hl,9				;Skip Header, SampleChannel, YM Clock (DB*3), and Replay Frequency.
	add hl,de
	endif

	ld de,PLY_Speed + 1
	ldi				;Copy Speed.
	ld c,(hl)			;Get Instruments chunk size.
	inc hl
	ld b,(hl)
	inc hl
	ld (PLY_Track1_InstrumentsTablePT + 1),hl
	ld (PLY_Track2_InstrumentsTablePT + 1),hl
	ld (PLY_Track3_InstrumentsTablePT + 1),hl

	add hl,bc			;Skip Instruments to go to the Linker address.
	;Get the pre-Linker information of the first pattern.
	ld de,PLY_Height + 1
	ldi
	ld de,PLY_Transposition1 + 1
	ldi
	ld de,PLY_Transposition2 + 1
	ldi
	ld de,PLY_Transposition3 + 1
	ldi
	ld de,PLY_SaveSpecialTrack + 1
	ldi
	ldi
	ld (PLY_Linker_PT + 1),hl	;Get the Linker address.

	ld a,1
	ld (PLY_SpeedCpt + 1),a
	ld (PLY_HeightCpt + 1),a

	ld a,#ff
	ld (PLY_PSGReg13),a
	
	;Set the Instruments pointers to Instrument 0 data (Header has to be skipped).
	ld hl,(PLY_Track1_InstrumentsTablePT + 1)
	ld e,(hl)
	inc hl
	ld d,(hl)
	ex de,hl
	inc hl					;Skip Instrument 0 Header.
	inc hl
	ld (PLY_Track1_Instrument + 1),hl
	ld (PLY_Track2_Instrument + 1),hl
	ld (PLY_Track3_Instrument + 1),hl
	ret



;Stop the music, cut the channels.
PLY_Stop
	if PLY_SystemFriendly
	call PLY_DisableInterruptions
	ex af,af'
	exx
	push af
	push bc
	push ix
	push iy
	endif

	ld hl,PLY_PSGReg8
	ld bc,#0300
	ld (hl),c
	inc hl
	djnz $-2
	ld a,%00111111
	jp PLY_SendRegisters








	if PLY_UseSoundEffects

;Initialize the Sound Effects.
;DE = SFX Music.
PLY_SFX_Init
	;Find the Instrument Table.
	ld hl,12
	add hl,de
	ld (PLY_SFX_Play_InstrumentTable + 1),hl
	
;Clear the three channels of any sound effect.
PLY_SFX_StopAll
	ld hl,0
	ld (PLY_SFX_Track1_Instrument + 1),hl
	ld (PLY_SFX_Track2_Instrument + 1),hl
	ld (PLY_SFX_Track3_Instrument + 1),hl
	ret


PLY_SFX_OffsetPitch equ 0
PLY_SFX_OffsetVolume equ PLY_SFX_Track1_Volume - PLY_SFX_Track1_Pitch
PLY_SFX_OffsetNote equ PLY_SFX_Track1_Note - PLY_SFX_Track1_Pitch
PLY_SFX_OffsetInstrument equ PLY_SFX_Track1_Instrument - PLY_SFX_Track1_Pitch
PLY_SFX_OffsetSpeed equ PLY_SFX_Track1_InstrumentSpeed - PLY_SFX_Track1_Pitch
PLY_SFX_OffsetSpeedCpt equ PLY_SFX_Track1_InstrumentSpeedCpt - PLY_SFX_Track1_Pitch

;Plays a Sound Effects along with the music.
;A = No Channel (0,1,2)
;L = SFX Number (>0)
;H = Volume (0...F)
;E = Note (0...143)
;D = Speed (0 = As original, 1...255 = new Speed (1 is fastest))
;BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
PLY_SFX_Play
	ld ix,PLY_SFX_Track1_Pitch
	or a
	jr z,PLY_SFX_Play_Selected
	ld ix,PLY_SFX_Track2_Pitch
	dec a
	jr z,PLY_SFX_Play_Selected
	ld ix,PLY_SFX_Track3_Pitch
	
PLY_SFX_Play_Selected
	ld (ix + PLY_SFX_OffsetPitch + 1),c	;Set Pitch
	ld (ix + PLY_SFX_OffsetPitch + 2),b
	ld a,e					;Set Note
	ld (ix + PLY_SFX_OffsetNote),a
	ld a,15					;Set Volume
	sub h
	ld (ix + PLY_SFX_OffsetVolume),a
	ld h,0					;Set Instrument Address
	add hl,hl
PLY_SFX_Play_InstrumentTable ld bc,0
	add hl,bc
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	ld a,d					;Read Speed or use the user's one ?
	or a
	jr nz,PLY_SFX_Play_UserSpeed
	ld a,(hl)				;Get Speed
PLY_SFX_Play_UserSpeed
	ld (ix + PLY_SFX_OffsetSpeed + 1),a
	ld (ix + PLY_SFX_OffsetSpeedCpt + 1),a
	inc hl					;Skip Retrig
	inc hl
	ld (ix + PLY_SFX_OffsetInstrument + 1),l
	ld (ix + PLY_SFX_OffsetInstrument + 2),h

	ret

;Stops a sound effect on the selected channel
;E = No Channel (0,1,2)
;I used the E register instead of A so that Basic users can call this code in a straightforward way (call player+15, value).
PLY_SFX_Stop
	ld a,e
	ld hl,PLY_SFX_Track1_Instrument + 1
	or a
	jr z,PLY_SFX_Stop_ChannelFound
	ld hl,PLY_SFX_Track2_Instrument + 1
	dec a
	jr z,PLY_SFX_Stop_ChannelFound
	ld hl,PLY_SFX_Track3_Instrument + 1
	dec a

PLY_SFX_Stop_ChannelFound
	ld (hl),a
	inc hl
	ld (hl),a
	ret
	


	endif



	if PLY_UseFades
;Sets the Fade value.
;E = Fade value (0 = full volume, 16 or more = no volume).
;I used the E register instead of A so that Basic users can call this code in a straightforward way (call player+9/+18, value).
PLY_SetFadeValue
	ld a,e
	ld (PLY_Channel1_FadeValue + 1),a
	ld (PLY_Channel2_FadeValue + 1),a
	ld (PLY_Channel3_FadeValue + 1),a
	ret

	endif




	if PLY_SystemFriendly
;Save Interrupt status and Disable Interruptions
PLY_DisableInterruptions
	ld a,i
	di
	;IFF in P/V flag.
	;Prepare opcode for DI.
	ld a,#f3
	jp po,PLY_DisableInterruptions_Set_Opcode
	;Opcode for EI.
	ld a,#fb
PLY_DisableInterruptions_Set_Opcode
	ld (PLY_RestoreInterruption),a
	ret
	endif


;A little convient interface for BASIC user, to allow them to use Sound Effects in Basic.
	if PLY_UseBasicSoundEffectInterface
PLY_BasicSoundEffectInterface_PlaySound
	ld c,(ix+0)	;Get Pitch
	ld b,(ix+1)
	ld d,(ix+2)	;Get Speed
	ld e,(ix+4)	;Get Note
	ld h,(ix+6)	;Get Volume
	ld l,(ix+8)	;Get SFX number
	ld a,(ix+10)	;Get Channel
	jp PLY_SFX_Play
	endif

	list
;*** End of Arkos Tracker Player
	nolist