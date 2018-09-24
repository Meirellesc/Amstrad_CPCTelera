org #4000
run #4000

ld hl, #C730

;;
;; Dibujar la barra
;;
dibujar_barra:
;;primera
ld (hl), %01110111
ld   hl, #C731
ld (hl), %00001111
ld   hl, #C732
ld (hl), %00001111
ld   hl, #C733
ld (hl), %11101110
;;segunda
ld   hl, #CF30
ld (hl), %11111111
ld   hl, #CF31
ld (hl), %00001111
ld   hl, #CF32
ld (hl), %00001111
ld   hl, #CF33
ld (hl), %11111111
;;tercera
ld   hl, #D730
ld (hl), %11111111
ld   hl, #D731
ld (hl), %00001111
ld   hl, #D732
ld (hl), %00001111
ld   hl, #D733
ld (hl), %11111111
;;quarta
ld   hl, #DF30
ld (hl), %01110111
ld   hl, #DF31
ld (hl), %00001111
ld   hl, #DF32
ld (hl), %00001111
ld   hl, #DF33
ld (hl), %11101110

jr $ 