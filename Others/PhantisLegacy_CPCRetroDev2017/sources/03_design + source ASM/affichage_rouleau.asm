;PRESENTATION EN ROULEAU
ADR_ECRAN_DEPART	EQU	#C000
ADR_ECRAN_BANDE		EQU	#F050
ADR_ECRAN_HAUTEUR	EQU	14	;nb ligne entre ADR_ECRAN_DEPART et ADR_ECRAN_BANDE	
FIN_ROULEAU		EQU	198
ORG #9000
		CALL couleurs
		CALL prs
		RET


couleurs:
		LD BC,&BC01
		OUT (C),C
		LD BC,&BD00
		OUT (C),C	;R1=0

		CALL &BD19

		XOR A
		CALL #BC0E	;mode 0
		;CALL #BC1C	;mode 0 sans cls

		LD BC,0
		CALL #BC38	;border 0

		LD A,63
		LD H,1
		LD D,20
		LD L,1
		LD E,25
		CALL #BC44	;remplir ecran avec l'encre 15 (noir)

		CALL &BD19

		XOR A
		LD IX,donnees
loop1:		PUSH AF
		LD C,(IX+00)
		LD B,(IX+00)
		CALL #BC32
		INC IX
		POP AF
		INC A
		CP 16
		JR NZ,loop1

		CALL &BD19

		LD BC,&BC01
		OUT (C),C
		LD BC,&BD28
		OUT (C),C	;R1=40

		RET
donnees:	DEFB 8,1,2,5,11,20,9,19,6,3,24,15,26,13,0,16 


;presentation sous forme de rouleau, image en &4000
prs:
		LD HL,ADR_ECRAN_DEPART
		LD DE,ADR_ECRAN_BANDE
		LD A,FIN_ROULEAU		
loopprs1:
		PUSH AF
		CALL &BD19
		CALL &BD19
		CALL sousprg1
		POP AF
		DEC A
		JR NZ,loopprs1
		RET

sousprg1:
		PUSH AF
		CP ADR_ECRAN_HAUTEUR
		JR C,sautsousprg1
		LD A,ADR_ECRAN_HAUTEUR
sautsousprg1:
		PUSH DE
		PUSH HL
		PUSH HL
		CALL sousprg2
		POP HL
		LD D,H
		LD E,L
		;RES 7,H		;&C000 en &4000 en modifiant le bit 7
		LD BC,#7000
		SBC HL,BC		;&C000 en &5000

		LD BC,#0050	;largeur ligne
		LDIR
		POP HL
		CALL &BC26	;ligne suivante
		POP DE
		POP AF
		CP ADR_ECRAN_HAUTEUR+1
		RET C
		EX DE,HL
		CALL &BC26	;ligne suivante
		EX DE,HL
		RET

sousprg2:
		OR A
		RET Z
loopsousprg2 :
		PUSH AF
		LD BC,#0050	;largeur ligne
		PUSH HL
		;RES 7,H		;&C000 en &4000 en modifiant le bit 7
		PUSH BC
		LD BC,#7000
		SBC HL,BC
		POP BC			;&C000 en &5000

		PUSH DE
		LDIR
		POP DE
		POP HL
		CALL &BC26	;ligne suivante
		EX DE,HL
		CALL &BC29	;ligne precedente
		EX DE,HL
		POP AF
		DEC A
		JR NZ,loopsousprg2
		RET

