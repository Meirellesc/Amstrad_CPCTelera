tailleraster1	EQU 178

ORG &A000
CHARGEMENT_FICHIER_OVERSCAN
LD B,&0C
LD HL,fichier_overscan
LD DE,&A000
CALL &BC77 ;lecture entete
LD HL,&0200
CALL &BC83 ;lecture fichier
CALL &BC7A ;ferme le fichier
;fin &7EC0

VIDER_800_A_7FF
LD HL,#800
LD DE,#801
LD BC,#1FF
LD (HL),0
LDIR

;SAUVER LE FICHIER BASIC/BINAIRE
SAUVER_NOUVEAU_FICHIER_SCA
;SCA   deb=&0200 fin=&7EC0
;ASM   deb=&7F00 fin=&85B5
;TAILLE DU NOUVEAU FICHIER deb=&200 fin=&85B5 lg=&83B5 (+marge de securite =&83C0)
LD B,12
LD HL,NOM_FICHIER
LD DE,&C000
CALL &BC8C

LD HL,&200	;debut du fichier
LD DE,&83C0	;longueur du fichier (avec une marge de securite)
LD BC,&7F00	;adresse execution du fichier
LD A,2		;type BINAIRE
CALL &BC98
CALL &BC8F
CALL &BC89
CALL &BC92
RET

NOM_FICHIER
DEFB "LEGACY  .SC2"

RET

fichier_overscan
DEFM "LEGACY  .SCA"


;------------------------------------------------------------------------------
; ANIMATION OVERSCAN
;------------------------------------------------------------------------------
;fin &85B5
ORG &7F00


CALL MESCOULEURS
CALL OUT_OVERSCAN
;CALL CHARGEMENT_FICHIER_OVERSCAN

;LD A,10:CALL DELAY
;CALL FRAME1
LD A,&0C
LD (&200),A	;Correction soucis compression avec Zenith II (1er octet corrompu)
CALL ANIMATION_OUT_RIDEAU_BAS

;LD A,45:CALL DELAY
;CALL FRAME4
CALL LESRASTERS
LD A,35:CALL DELAY

CALL FRAME1
LD A,3:CALL DELAY:CALL FRAME2
LD A,3:CALL DELAY:CALL FRAME3
LD A,3:CALL DELAY:CALL FRAME4
LD A,35:CALL DELAY

CALL ANIMATION_OUT_RIDEAU_HAUT
CALL COULEURS_NOIRES
CALL OUT_NORMAL
RET




;------------------------------------------------------------------------------
; OUT NORMAL
;------------------------------------------------------------------------------
OUT_NORMAL
;OUT R1=40
largeur
LD BC,&BC01
OUT (C),C
LD BC,&BD28
OUT (C),C

;hauteur
LD BC,&BC06
OUT (C),C
LD BC,&BD19
OUT (C),C

;decalage horizontal
LD BC,&BC02
OUT (C),C
LD BC,&BD2E
OUT (C),C

;decalage vertical
LD BC,&BC07
OUT (C),C
LD BC,&BD1E
OUT (C),C

;ecran 17 ko (&C000 a &FFFF)
LD BC,&BC0C
OUT (C),C
LD BC,&BD3C
OUT (C),C

;debut offset (en &C000)
LD BC,&BC0D
OUT (C),C
LD BC,&BD00
OUT (C),C
RET

;------------------------------------------------------------------------------
; OUT overscan
;------------------------------------------------------------------------------
OUT_OVERSCAN
;largeur
LD BC,&BC01
OUT (C),C
LD BC,&BD30
OUT (C),C

;hauteur (&22)
LD BC,&BC06
OUT (C),C
LD BC,&BD00 ;masquer
OUT (C),C

;decalage horizontal
LD BC,&BC02
OUT (C),C
LD BC,&BD32
OUT (C),C

;decalage vertical
LD BC,&BC07
OUT (C),C
LD BC,&BD23
OUT (C),C

;ecran 32 ko (&0000 a &7FFF)
LD BC,&BC0C
OUT (C),C
LD BC,&BD0D
OUT (C),C

;debut offset (en &0200)
LD BC,&BC0D
OUT (C),C
LD BC,&BD00
OUT (C),C
RET

;------------------------------------------------------------------------------
; ANIMATION_OUT_RIDEAU_BAS
;------------------------------------------------------------------------------
ANIMATION_OUT_RIDEAU_BAS
;animation sur R6 = 0 a &22
LD BC,&BC06
OUT (C),C
LD B,&BD

LD A,&22
LD C,0
OUT (C),C

.anim4bas
INC C
OUT (C),C

PUSH AF
CALL tempo2
POP AF

DEC A
CP 0
JP NZ,anim4bas
RET

;------------------------------------------------------------------------------
; TEMPORISATION POUR RIDEAU
;------------------------------------------------------------------------------
tempo2:
LD A,8
LOOPtempo2:
CALL &BD19
DEC A
CP 0
JP NZ,LOOPtempo2
RET

;------------------------------------------------------------------------------
; DELAY SUBROUTINE (0.05s to 12.75s)
; A = Timeout / 50ms
;------------------------------------------------------------------------------
DELAY		EI
DELAY_1		LD B,15			; 15 x 1/300th ms (HALT) = 50ms
DELAY_2		HALT			; Waits 1/300th s
		DJNZ DELAY_2		; Loop for 50ms
		DEC A        
		JR NZ,DELAY_1           ; Loop for A x 50ms
		DI
		RET

;------------------------------------------------------------------------------
; ANIMATION_OUT_RIDEAU_HAUT
;------------------------------------------------------------------------------
ANIMATION_OUT_RIDEAU_HAUT
;animation sur R6 = 0 a &22
LD BC,&BC06
OUT (C),C
LD B,&BD

LD A,&22
LD C,&22
OUT (C),C

.anim4haut
DEC C
OUT (C),C

PUSH AF
CALL tempo2
POP AF

DEC A
CP 0
JP NZ,anim4haut
RET


;------------------------------------------------------------------------------
; DEFINITION DES COULEURS
;------------------------------------------------------------------------------
MESCOULEURS
;MODE 0
;XOR A
;CALL &BC0E

;BORDER 0 (Noir)
LD BC,&0000
CALL &BC38

;LES ENCRES
XOR A
LD HL,COULEURS
bouclecouleurs:
PUSH AF
PUSH HL
LD B,(HL)
LD C,B
CALL &BC32
POP HL
INC HL
POP AF
INC A
CP 16
JR NZ,bouclecouleurs
RET

COULEURS:
DEFB 0,24,4,9,26,17,25,15,6,3,16,1,12,13,18,14

;------------------------------------------------------------------------------
; TOUTES LES ENCRES SONT NOIRES
;------------------------------------------------------------------------------
COULEURS_NOIRES
LD BC,&0000
CALL &BC38

;LES ENCRES
XOR A
bouclecouleursnoires:
PUSH AF
LD BC,0
CALL &BC32
POP AF
INC A
CP 16
JR NZ,bouclecouleursnoires
RET


;------------------------------------------------------------------------------
; LES RASTERS 
;------------------------------------------------------------------------------
LESRASTERS
CALL &BB00

	DI		; Desactiver les interruptions
	LD HL,(&38) 	; Lire l'ancienne interruption
	LD (Sauver),HL 	; Sauvegarder la valeur 16 bits
	LD HL,&C9FB 	; Registre 16 bits EI (&FB) + RET (&C9)
	LD (&38),HL 	; Ecrire en &0038 et &0039 le contenu du registre HL
	EI 		; Interruption autorisees

.Programme
	;raster rotation vers le bas
	LD A,(Raster1+tailleraster1-1)
	LD HL,Raster1+tailleraster1-2
	LD DE,Raster1+tailleraster1-1
	LD BC,tailleraster1-1
	LDDR
	LD (Raster1),A


	LD B,&F5 	; Se connecter au PPI/8255 port B accessible via &F5xx
.Balayage
	IN A,(C) 	; Lire le contenu
	RRA 		; On teste si le bit 0 = 1
	JP nc,Balayage 	; Si le bit 0 = 0 on boucle jusqu'a la fin du balayage
			; On est en haut de l'ecran, on peut continuer le programme

	;HALT 		; Attendre interruption 1
	;HALT 		; Attendre interruption 2

	DS 10 		; Debut de ligne

	LD B,&7F 	; On selection le Gate Array
	LD HL,Raster 	; HL pointe sur la table de couleurs
.BoucleRaster
	LD a,(hl) 	; On charge la couleur dans A
	CP &00 		; Si A=0 alors
	JP z,Touche 	; Saute au test clavier

	LD C,15
	OUT (C),C 	; Selection encre 15
	OUT (C),A 	; Ecrire la couleur

	INC HL 		; Couleur suivante dans le tableau
	DS 42 		; Attendre fin de ligne
	JP BoucleRaster


; Test touche
.Touche
	LD BC,&F40E
	OUT (C),C
	LD BC,&F6C0
	OUT (C),C
	XOR A
	OUT (C),A
	LD BC,&F792
	OUT (C),C
	LD BC,&F645	;ligne 5
	OUT (C),C
	LD B,&F4
	IN A,(C)
	LD BC,&F782
	OUT (C),C
	LD BC,&F600
	OUT (C),C
	RLA		;Charge dans A la valeur du bit 7 (touche ESPACE)
JR NC,Sortir
	LD BC,&F40E
	OUT (C),C
	LD BC,&F6C0
	OUT (C),C
	XOR A
	OUT (C),A
	LD BC,&F792
	OUT (C),C
	LD BC,&F649	;ligne 9
	OUT (C),C
	LD B,&F4
	IN A,(C)
	LD BC,&F782
	OUT (C),C
	LD BC,&F600
	OUT (C),C
	RLA		;Charge dans A la valeur du bit 7 (touche DEL)
	RLA		;Charge dans A la valeur du bit 6 (touche JOY_FIRE0)
	RLA		;Charge dans A la valeur du bit 5 (touche JOY_FIRE1 Z)
	RLA		;Charge dans A la valeur du bit 4 (touche JOY_FIRE2 X)
	JP C,Programme	;Si TIR du joystick n'a pas etait enfonce on boucle

.Sortir
	;retour au BASIC
	DI 		; Desactiver les interruptions
	LD HL,(Sauver) 	; Restauration des anciennes interruptions
	LD (&38),hl 	; Ecrire
	EI 		; Interruption autorisees
	RET

.Sauver
	DW #0000

.Raster
;00 = &54 noir
;01 = &44 bleu
;02 = &55 bleu vif
;03 = &5C rouge fonce
;04 = &58 magenta
;05 = &5D mauve
;06 = &4C rouge vif
;07 = &45 pourpre
;08 = &4D magenta vif
;09 = &56 vert
;10 = &46 turquoise
;11 = &57 bleu ciel
;12 = &5E jaune
;13 = &40 gris
;14 = &5F bleu pastel
;15 = &4E orange
;16 = &47 rose
;17 = &4F magenta pastel
;18 = &52 vert vif
;19 = &42 vert marin
;20 = &53 turquoise vif
;21 = &5A vert citron
;22 = &59 vert pastel
;23 = &5B turquoise pastel
;24 = &4A jaune vif
;25 = &43 jaune pastel
;26 = &4B blanc

	DB &5F ; bleu pastel (mon encre 15)

.Raster1

;raster


;bleu
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &55 ;bleu vif
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &55 ;bleu vif
	DB &4B ;blanc
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &53 ;turquoise vif
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &53 ;turquoise vif
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &4B ;blanc
	DB &55 ;bleu vif
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &55 ;bleu vif
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif


;vert
	DB &54 ;noir
	DB &56 ;vert fonce
	DB &54 ;noir
	DB &5A ;vert citron
	DB &54 ;noir

	DB &5A ;vert citron
	DB &56 ;vert fonce
	DB &56 ;vert fonce
	DB &5A ;vert citron
	DB &56 ;vert fonce
	DB &56 ;vert fonce
	DB &5A ;vert citron
	DB &56 ;vert fonce
	DB &5A ;vert citron
	DB &5A ;vert citron
	DB &43 ;jaune pastel
	DB &43 ;jaune pastel
	DB &5A ;vert citron
	DB &4B ;blanc
	DB &43 ;jaune pastel
	DB &43 ;jaune pastel
	DB &43 ;jaune pastel
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &43 ;jaune pastel
	DB &43 ;jaune pastel
	DB &43 ;jaune pastel
	DB &4B ;blanc
	DB &5A ;vert citron
	DB &43 ;jaune pastel
	DB &43 ;jaune pastel
	DB &5A ;vert citron
	DB &5A ;vert citron
	DB &56 ;vert fonce
	DB &5A ;vert citron
	DB &56 ;vert fonce
	DB &56 ;vert fonce
	DB &44 ;bleu fonce
	DB &56 ;vert fonce
	DB &56 ;vert fonce
	DB &44 ;bleu fonce
;bleu
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &55 ;bleu vif
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &55 ;bleu vif
	DB &4B ;blanc
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &53 ;turquoise vif
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &53 ;turquoise vif
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &4B ;blanc
	DB &55 ;bleu vif
	DB &57 ;bleu ciel
	DB &57 ;bleu ciel
	DB &55 ;bleu vif
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
	DB &44 ;bleu fonce
	DB &44 ;bleu fonce
	DB &55 ;bleu vif
;violet
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &4D ;magenta vif
	DB &4D ;magenta vif
	DB &4F ;magenta pastel
	DB &4D ;magenta vif
	DB &4B ;blanc
	DB &4F ;magenta pastel
	DB &4F ;magenta pastel
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4B ;blanc
	DB &4F ;magenta pastel
	DB &4F ;magenta pastel
	DB &4B ;blanc
	DB &4D ;magenta vif
	DB &4F ;magenta pastel
	DB &4D ;magenta vif
	DB &4D ;magenta vif
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)
	DB &4D ;magenta vif
	DB &58 ;magenta (fonce)
	DB &58 ;magenta (fonce)

	DB &54 ;noir
	DB &58 ;magenta (fonce)
	DB &54 ;noir
	DB &58 ;magenta (fonce)
	DB &54 ;noir

	DB &5F ; bleu pastel (mon encre 15)

	DB 0 ;fin


;------------------------------------------------------------------------------
; CLIN D'OEIL 
;------------------------------------------------------------------------------
.FRAME1 ;comparaison over2.SNA et over1.SNA
XOR A:LD (&4953),A
LD (&4954),A
LD (&5151),A
LD (&5155),A
LD (&5950),A
LD (&5951),A
LD (&6150),A
LD (&694E),A
LD A,&08:LD (&4155),A
LD (&70F5),A
LD A,&10:LD (&694F),A
LD A,&4C:LD (&4152),A
LD (&514E),A
INC A:LD (&5150),A
LD A,&66:LD (&414F),A
LD (&514F),A
LD A,&6A:LD (&58F3),A
LD (&68EF),A
LD (&68F1),A
LD (&68F2),A
LD (&68F3),A
LD A,&6E:LD (&48F3),A
LD A,&7B:LD (&68F4),A
LD (&78F0),A
LD A,&88:LD (&78F5),A
LD A,&8A:LD (&4952),A
LD (&4955),A
LD (&614F),A
LD A,&8C:LD (&4951),A
LD (&594E),A
LD (&78F4),A
LD A,&95:LD (&70F0),A
LD A,&99:LD (&494F),A
LD A,&B7:LD (&70F1),A
LD (&70F2),A
LD (&70F3),A
LD A,&CD:LD (&594F),A
LD A,&CF:LD (&4153),A
LD (&4154),A
LD (&614E),A
LD A,&D5:LD (&50F3),A
LD (&60F4),A
LD A,&D9:LD (&4950),A
LD (&78F1),A
LD (&78F2),A
LD (&78F3),A
LD A,&E6:LD (&4150),A
LD (&4151),A
LD (&70F4),A
LD A,&EC:LD (&58F4),A
RET
 
.FRAME2 ;comparaison over3.SNA et over2.SNA
XOR A:LD (&614D),A
LD A,&08:LD (&5155),A
LD A,&45:LD (&41B1),A
LD (&594D),A
LD (&60EE),A
LD (&714F),A
LD (&7950),A
LD A,&4C:LD (&414E),A
LD (&514F),A
LD (&614F),A
LD (&70EE),A
LD A,&66:LD (&5150),A
LD (&6150),A
LD (&6151),A
LD (&6152),A
LD (&6153),A
LD (&6154),A
LD (&7152),A
LD (&7153),A
LD A,&6A:LD (&78F1),A
LD (&78F2),A
LD A,&7A:LD (&58F3),A
LD (&78F3),A
INC A:LD (&4951),A
LD (&4952),A
LD (&4953),A
LD (&4954),A
LD A,&7E:LD (&58F4),A
LD (&68F4),A
LD (&78F4),A
INC A:LD (&78F0),A
LD A,&88:LD (&4155),A
LD (&4955),A
LD A,&8A:LD (&41B3),A
LD (&5955),A
LD A,&8C:LD (&494E),A
LD (&594F),A
LD (&6954),A
LD (&7953),A
LD A,&8E:LD (&594E),A
LD (&68EE),A
LD (&694F),A
LD (&7150),A
LD (&7951),A
LD A,&95:LD (&50F3),A
LD (&70F1),A
LD (&70F2),A
LD (&70F3),A
LD A,&99:LD (&5950),A
LD (&5954),A
LD (&6950),A
LD (&6951),A
LD (&6952),A
LD (&6953),A
LD (&7952),A
LD A,&AC:LD (&50F4),A
LD A,&B5:LD (&70F4),A
LD A,&B7:LD (&4151),A
LD (&4152),A
LD (&4153),A
LD A,&BD:LD (&60F4),A
LD A,&BF:LD (&4150),A
LD (&4154),A
LD (&70EF),A
LD A,&CC:LD (&7151),A
LD A,&CF:LD (&41B2),A
LD A,&D9:LD (&5951),A
LD (&5952),A
LD (&5953),A
LD A,&DD:LD (&494F),A
LD (&4950),A
LD (&78EE),A
LD (&78EF),A
LD A,&E6:LD (&48F3),A
LD (&5154),A
LD A,&EE:LD (&414F),A
LD A,&F7:LD (&5151),A
LD (&5152),A
LD (&5153),A
RET
 
.FRAME3 ;comparaison over2.SNA et over3.SNA
XOR A:LD (&4953),A
LD (&4954),A
LD (&5151),A
LD (&5152),A
LD (&5155),A
LD (&5950),A
LD (&5951),A
LD (&6150),A
LD A,&04:LD (&594D),A
LD (&60EE),A
LD A,&08:LD (&4155),A
LD (&5955),A
LD A,&10:LD (&5954),A
LD (&694F),A
LD A,&37:LD (&70EF),A
LD A,&45:LD (&5952),A
LD (&614D),A
LD A,&4C:LD (&4152),A
INC A:LD (&41B3),A
LD (&5150),A
LD (&5953),A
LD A,&59:LD (&41B1),A
LD A,&5D:LD (&70EE),A
LD A,&66:LD (&414F),A
LD (&514F),A
LD A,&6A:LD (&58F3),A
LD A,&6E:LD (&48F3),A
LD A,&75:LD (&7150),A
LD A,&77:LD (&414E),A
LD A,&7B:LD (&68F4),A
LD (&78EF),A
LD (&78F0),A
LD A,&8A:LD (&4952),A
LD (&4955),A
LD (&5153),A
LD (&614F),A
LD A,&8C:LD (&4951),A
LD (&50F4),A
LD (&594E),A
LD (&78F4),A
LD A,&8E:LD (&6152),A
LD A,&99:LD (&494E),A
LD (&494F),A
LD (&78EE),A
LD A,&AE:LD (&6954),A
LD (&7953),A
LD A,&B0:LD (&7950),A
LD A,&B7:LD (&70F1),A
LD (&70F2),A
LD (&70F3),A
LD A,&BA:LD (&6952),A
LD A,&CD:LD (&594F),A
INC A:LD (&68EE),A
INC A:LD (&4153),A
LD (&4154),A
LD (&6951),A
LD (&6953),A
LD (&7152),A
LD A,&D5:LD (&50F3),A
LD (&60F4),A
LD A,&D9:LD (&4950),A
LD (&78F1),A
LD (&78F2),A
LD (&78F3),A
LD A,&DB:LD (&6151),A
LD (&7153),A
LD A,&DF:LD (&5154),A
LD (&6154),A
INC A:LD (&714F),A
LD A,&E5:LD (&6153),A
LD (&6950),A
INC A:LD (&4150),A
LD (&4151),A
LD (&70F4),A
INC A:LD (&7151),A
LD A,&EC:LD (&58F4),A
LD A,&F3:LD (&7952),A
LD A,&F5:LD (&7951),A
LD A,&FF:LD (&41B2),A
RET
 
.FRAME4 ;comparaison over1.SNA et over2.SNA
XOR A:LD (&4154),A
LD (&4955),A
LD (&514F),A
LD (&5150),A
LD (&70F2),A
LD (&70F3),A
LD (&70F4),A
LD (&78F1),A
LD (&78F2),A
LD (&78F3),A
LD (&78F4),A
LD (&78F5),A
LD A,&08:LD (&6150),A
LD A,&26:LD (&414F),A
LD A,&3B:LD (&68F1),A
LD A,&41:LD (&4155),A
LD A,&45:LD (&4950),A
LD (&4951),A
LD (&4952),A
LD (&4953),A
LD (&4954),A
LD A,&4D:LD (&494F),A
LD (&514E),A
LD (&70F1),A
LD A,&50:LD (&694E),A
INC A:LD (&614E),A
LD A,&6E:LD (&58F4),A
LD A,&70:LD (&614F),A
LD A,&7B:LD (&68EF),A
LD A,&7E:LD (&58F3),A
LD A,&8A:LD (&4150),A
LD (&4151),A
LD (&4152),A
LD (&4153),A
LD (&5151),A
LD (&5155),A
LD (&594E),A
LD (&68F3),A
LD (&70F5),A
LD A,&8C:LD (&68F2),A
LD (&78F0),A
LD A,&8E:LD (&5951),A
LD (&68F4),A
LD A,&90:LD (&694F),A
LD A,&95:LD (&50F3),A
LD A,&99:LD (&60F4),A
LD A,&CF:LD (&5950),A
LD A,&E6:LD (&48F3),A
LD (&70F0),A
LD A,&F7:LD (&594F),A
RET