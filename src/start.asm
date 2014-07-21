
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
		
		lda #0				;Initialize $dd00
		sta $dd00
	
		jsr systemSetup
		
		lda #$35
		sta $01
		
		;jsr ShowPic

		jsr scrollsetup
		
; set up default colors
SUBROUTINE defaultColors
		ldx #$00
		lda #$21
.xxx		sta $d800,x
		sta $d900,x
		sta $da00,x
		sta $db00,x
		
;		sta $c000,x
;		sta $c100,x
		
		inx
		bne .xxx	
		
SUBROUTINE aaaa		
		; menu selection bar 
		ldy #39
		lda #$04
.xx1	sta $d800 + 20 * 40, y
		dey
		bpl .xx1		
		
SUBROUTINE dfskgjdjfhgjsdfgh
;
;		inc $d020
		jsr loadTune
;		inc $d020		
		jsr computeloadaddr
;		inc $d020		
		jsr exod_decrunch
;		inc $d020		

		setIRQ logoirq
		
		jsr musstart
		
checkflag:
		lda OPFLAG
		cmp #OPWaitingForAction
		beq checkflag
		cmp #OPLoadTune
		bne checkflag ; last action on list = bne

		cli
		jsr loadTune
		jsr computeloadaddr
		
		lda #0
		sta tunePlaying		

		lda #0
		sta $d418
		
		jsr exod_decrunch
		jsr musstart
		OPclearflag
		jmp checkflag

loadTune:
		;sei
		lda tuneToLoad
		clc
		adc #"A"
		sta musicName
		
        lda #musicName_len               ;filename as argument  ; TODO zmien na jakis bufor czy cus w ktorym beda trzymane nazwy kawalkow
        ldx #<musicName
        ldy #>musicName		
		jsr loadfile 
		bcs loadError
		rts
		
loadError:
		inc $d020
		dec $d020
		jmp loadError

musstart:
		jsr resetTimer

		lda #0
		ldy #2 
		jsr setTimerTuneLengthAY ; a=0, y=2 gives 512 frames
		
		lda #1
		sta tunePlaying
		lda #$00
		tax
		tay 
		jsr $1000

		cli
		rts
		
;;;;;;;;;;;;;;;;;;;;

logoirq:
;		inc $d020
		enterIRQ
		clearVicIRQ 
		
		lda #$3b
		sta $d011
		
		lda #$0f  ; bitmap at $2000
		sta $d018
		
		lda #$08
		sta $d016		

		setIRQ scrollirq ; menuirq ;scrollirq
		lda #152+3
		sta $d012
		
		jsr checkkbd		
		
		jsr incTimer
		lda jukeBoxEnabled
		beq noJukeBox
		jsr checkTimer
noJukeBox:		
		;DEBUG
		;lda musicTimerLo
		;sta $c000+13*40 + 3

		;lda musicTimerHi
		;sta $c000+13*40 + 4
		;
		
		jsr doScroll
		
		exitIRQ
;		dec $d020
		rti

menuirq:
;		inc $d020
		enterIRQ
		clearVicIRQ 
		
		;;;
		lda #$1b
		sta $d011
		
		lda #$02 ; textscreen @ 0, charrom @ $0800
		sta $d018 
		
		;   no scroll
		lda #1+2+4+8
		sta $d016
		;;;
		
		setIRQ musicirq
		lda #255
		sta $d012		
		
		exitIRQ
;		dec $d020
		rti		
		
musicirq:
;		inc $d020
		enterIRQ

		clearVicIRQ
			   
musplay:
		inc $d020
		lda tunePlaying
		beq notPlaying
		jsr $1003
notPlaying:
		dec $d020
		
		setIRQ logoirq
		lda #32
		sta $d012		
		
irqend: exitIRQ

;		dec $d020
		rti		

SUBROUTINE scroller
;taken from my code from yay.. 2004!

skrol .byte $08 ; 1+2+4 + 1 additional - wartosc do $d016

scrollirq 
		enterIRQ
		
		clearVicIRQ
		
		inc $d020
	
		; textmode
		lda #$1b
		sta $d011
		
		lda #$02 ; textscreen @ 0, charrom @ $0800
		sta $d018 
		;
	
	lda skrol
	sta $d016

;	lda skrol
;	and #(255-(255-1-2-4))

;   no scroll
;	lda #1+2+4+8
;	sta $d016

;	and #(255-(255-1-2-4))

	setIRQ menuirq
	lda #172+3
	sta $d012

	dec $d020
	exitIRQ	
	rti	

exitScroll:	
	rts
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
musicName 	.scru "A.*"
musicName_len = * - musicName

tunePlaying
.byte $01		
;actualTune:
;.byte $00	
tuneToLoad:
.byte $00
OPFLAG: ; operation flag
.byte $00
jukeBoxEnabled:
.byte $00

