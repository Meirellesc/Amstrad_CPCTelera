org #4000
run #4000

ld hl, #C000

;;
;; Dibuja la pelota
;;
dibujar:
 ld (hl), %01100000	;; 2 pixeles amarillos
 ld    h, #C8	;; HL apunta a segunda fila de pixeles
 ld (hl), %11110110 	;; Am-Rj-Am-Rj 
 ld    h, #D0	;; HL apunta a tercera fila de pixeles
 ld (hl), %11110110	;; Am-Rj-Am-Rj 
 ld    h, #D8	;; HL apunta a quarta fila de pixeles
 ld (hl), %01100000	;; 2 pixeles amarillos
 ld    h, #C0	;; HL vuelve a apuntar a la primeira fila

;;
;; Pequenya espera
;;
 ld b, 16 		;; Conta para 16 halts (10hex = 16dec)
 esperar:
   halt		;; Espera ~1/300 segundos
   dec b		;; Un halt menos a terminar
 jr nz, esperar		;; Saltar a HALT si quedan repeticiones (B!=0)

;;
;; Borra la pelota
;;

 ld (hl), #00	;; 2 pixeles amarillos
 ld    h, #C8	;; HL apunta a segunda fila de pixeles
 ld (hl), #00	;; Am-Rj-Am-Rj 
 ld    h, #D0	;; HL apunta a tercera fila de pixeles
 ld (hl), #00	;; Am-Rj-Am-Rj 
 ld    h, #D8	;; HL apunta a quarta fila de pixeles
 ld (hl), #00	;; 2 pixeles amarillos
 ld    h, #C0	;; HL vuelve a apuntar a la primeira fila

 inc hl

jr dibujar