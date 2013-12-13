
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
        ;lda #<DreamLoadErr          ;error message
        ;ldy #>DreamLoadErr
		
        ;jsr $ab1e
		jmp *-3

dloadok	lda #$00   ; TODO tlo do grafy z klawiszem ma byc $0c
		sta $d021
		
		jsr systemSetup
		
		;lda #$35
		;sta $01
		
		jsr setupkbd		
		
		;lda #$37 ; TODO zmiana konfigu wypierdala obsluge kbd : czemu???
		;sta $01

		;jsr ShowPic
	
		lda msx1 ; TODO debug only
		sta $0400+40
	
		jsr loadTune

	
;; load from mem debug
;depack 
;		lda #<msx1end
;		sta opbase + 1
;		lda #>msx1end
;		sta opbase + 2
;;


;depack 
		jsr computeloadaddr

		;lda #<$4857
		;sta opbase + 1
		;lda #>$4857
		;sta opbase + 2
		
		inc $d020
		
		jsr exod_decrunch

		inc $d020		

		lda #<musicirq  ;this is how we set up
		sta $fffe  ;the address of our interrupt code
		lda #>musicirq
		sta $ffff	

		jsr musstart

		;;; TODO: przenies obsluge klawiatury z main loop do IRQ

		

checkkbd:
		jsr keyscan
		lda $11 ;actkey
		cmp #$ff	;$ff= no key pressed
		beq checkkbd

		cmp #$40	;convert to screen codes
		bmi checkkbd2
		sec
		sbc #$40

		cmp #$D ; 'M' character
		beq loadAndInitTune		
		
checkkbd2:
		sta $0400
		sta msx1
	
		jmp checkkbd		

loadAndInitTune:
		jsr computeloadaddr
		jsr loadTune
		jsr musstart
		jmp checkkbd
		
loadTune:
		sei
        lda #msx1_len               ;filename as argument  ; TODO zmien na jakis bufor czy cus w ktorym beda trzymane nazwy kawalkow
        ldx #<msx1
        ldy #>msx1		
		jsr loadfile 
		rts

musstart:
		lda #$00
		tax
		tay 
		jsr $1000

		cli
		rts
		
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
		
actualTune:
.byte $00		