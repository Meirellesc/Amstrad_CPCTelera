org #4000
run #4000



 ;;
 ;; Dibuja la pelota
 ;;
dibujar:
 ld a, #60		;;2 pixeles amarillos
 ld (#C000), a	;;Apunta a la primeira fila 
 ld (#D800), a	;;Apunta a la quarta fila
 ld a, #F6		;;Am - Rj - Rj - Am
 ld (#C800),a	;;Apunta a la segunda fila
 ld (#D000),a	;;Apunta a la tercera fila
 ld (#C000),a 
 ;;
 ;; Pequenya espera
 ;;
 ld b, #10 		;; Conta para 16 halts (10hex = 16dec)
 halt		;; Espera ~1/300 segundos
 dec b		;; Un halt menos a terminar
 jr nz, $-2		;; Saltar a HALT si quedan repeticiones (!B=0)


 ;;
 ;; Borra la pelota
 ;;
borrar:
 ld a, #00		;;2 pixeles fondo
 ld (#C000), a	;;Apunta a la primeira fila 
 ld (#C800),a	;;Apunta a la segunda fila
 ld (#D000),a	;;Apunta a la tercera fila
 ld (#D800), a	;;Apunta a la quarta fila

 inc a

jr dibujar		;;Bucle infinito