
; load from memory debug
;*=$1000
;.incprg "..\packmsx\1.prg"
;msx1end .byte 0

*= $7000
mainstart
		lda #$00
		sta $d020
		sei
		jsr DreamLoad
        bcc dloadok 	          ;success?
        lda #<DreamLoadErr          ;error message
        ldy #>DreamLoadErr
        jsr $ab1e
		jmp *

dloadok	lda #$00
		sta $d021
		
		jsr systemSetup
		
		;lda #$35
		;sta $01
		
		jsr setupkbd		
		
		;lda #$37 ; TODO zmiana konfigu wypierdala obsluge klawiatury : czemu???
		;sta $01

		;jsr ShowPic
	
	
        lda #msx1_len               ;filename as argument  ; TODO zmien na jakis bufor czy cus w ktorym beda trzymane nazwy kawalkow
        ldx #<msx1
        ldy #>msx1
        jsr loadfile 	
	
;; load from mem debug
;depack 
;		lda #<msx1end
;		sta opbase + 1
;		lda #>msx1end
;		sta opbase + 2
;;


;depack 
		lda #<$4857
		sta opbase + 1
		lda #>$4857
		sta opbase + 2
		
		jsr exod_decrunch

		lda #<musicirq  ;this is how we set up
		sta $fffe  ;the address of our interrupt code
		lda #>musicirq
		sta $ffff		

musstart		lda #$00
		tax
		tay 
		jsr $1000

		cli

uu2:	jsr keyscan
		lda $11 ;actkey
		cmp #$ff	;$ff= no key pressed
		beq uu2

		cmp #$D ; 'M' character
		beq loadTune
		
		cmp #$40	;convert to screen codes
		bmi ok2
		sec
		sbc #$40
ok2:
		sta $0400
		sta msx1
	
x22:	jmp uu2
		
;;;
loadTune:
		sei
		jsr loadfile
		jmp musstart
		
;;;;;;;;;;;;;;;;;;;;

musicirq:
		inc $d020
		enterIRQ

		lda #$ff   ;this is the orthodox and safe way of clearing the interrupt condition of the VICII.
		sta $d019  ;if you don't do this the interrupt condition will be present all the time and you end
			   ;up having the CPU running the interrupt code all the time

musplay:
		inc $d020
		jsr $1003
		dec $d020
		
irqend: exitIRQ

		dec $d020
		rti		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
msx1 	.scru "1*"
msx1_len = * - msx1

DreamLoadErr
.scru "error installing dreamload!"
.byte 13, 0
		

		