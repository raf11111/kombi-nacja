
; load from memory debug
;*=$1000
;.incprg "..\packmsx\1.prg"
;musicNameend .byte 0

;; load from mem debug
;depack 
;		lda #<musicNameend
;		sta opbase + 1
;		lda #>musicNameend
;		sta opbase + 2
;;

		;lda #<$4857
		;sta opbase + 1
		;lda #>$4857
		;sta opbase + 2

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
		inc $d020
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
	
		jsr loadTune
		jsr computeloadaddr
		jsr exod_decrunch

		lda #<musicirq  ;this is how we set up
		sta $fffe  ;the address of our interrupt code
		lda #>musicirq
		sta $ffff	

		jsr musstart
		
checkflag:
		lda OPFLAG
		cmp #OPLoadTune
		bne checkflag
		cli
		jsr loadTune
		jsr computeloadaddr
		jsr exod_decrunch
		jsr musstart
		clearflag
		jmp checkflag

loadTune:
		sei
        lda #musicName_len               ;filename as argument  ; TODO zmien na jakis bufor czy cus w ktorym beda trzymane nazwy kawalkow
        ldx #<musicName
        ldy #>musicName		
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
		lda tunePlaying
		beq notPlaying
		jsr $1003
notPlaying:
		inc $d020
.include "kbdirq.asm"
		dec $d020
		dec $d020
		
irqend: exitIRQ

		dec $d020
		rti		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
musicName 	.scru "5"
musicName_len = * - musicName

tunePlaying
.byte $01		
actualTune:
.byte $04	
tuneToLoad:
.byte $00
OPFLAG: ; operation flag
.byte $00	