*= $7000
mainstart
		lda #$00
		sta $d020
		jsr DreamLoad
		; TODO sprawdzaj kody wyjscia itd w/g /dload/doc/dload.html#toc23
		lda #$00
		sta $d021
		
		sei    
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
	
; depack 
;		lda #<msx1
;		sta opbase + 1
;		lda #>msx1
;		sta opbase + 2
		
		;jsr exod_decrunch
		;jsr $1000

		lda #<musicirq  ;this is how we set up
		sta $fffe  ;the address of our interrupt code
		lda #>musicirq
		sta $ffff		
		cli

uu2:	jsr keyscan
		lda $11 ;actkey
		cmp #$ff	;$ff= no key pressed
		beq uu2
		cmp #$40	;convert to screen codes
		bmi ok2
		sec
		sbc #$40
ok2:
		sta $0400
	
;	wywolaj 1, <msx1, >msx1
;	wywolaj 2, <msx2, >msx2
	
	
x22:	jmp uu2
		
	
;;;;;;;;;;;;;;;;;;;;

musicirq:
		inc $d020
		enterIRQ

		lda #$ff   ;this is the orthodox and safe way of clearing the interrupt condition of the VICII.
		sta $d019  ;if you don't do this the interrupt condition will be present all the time and you end
			   ;up having the CPU running the interrupt code all the time

musplay:
		inc $d020
		;jsr $1003
		dec $d020
		
irqend: exitIRQ

		dec $d020
		rti		

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
msx1 	.scru "1"
msx1_len = * - msx1
		