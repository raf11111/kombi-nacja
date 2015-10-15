
;test menu

; obsluga
; f1 re-play
; f3 stop
; return load + play
; cursory -1 / + 1
; spacja - pokaz tekst

*= $0900

	sei

	;jsr systemSetup
	lda #$0
	sta $d020
	sta $d021
	
		ldx #$00
xxx		lda #$20
		sta $0400,x
		sta $0500,x
		;sta $0600,x
		;sta $0700,x
		lda #1
		sta $da00,x
		sta $db00,x
		inx
		bne xxx	
	
		jsr odwroc
	
_a:		lda $d012
		cmp #$20
		bne _a
	
	
		lda #$3b
		sta $d011
		
		lda #$1c
		sta $d018
		
		lda #$08
		sta $d016
		
_b:		lda $d012
		cmp #144
		bne _b
		
		; normla screen:
		lda #$1b
		sta $d011
		
		lda #$14
		sta $d018	
		
		
		jmp _a
		
		
odwroc:
		ldy #19
od1		lda songpos,y
		eor #128
		sta songpos,y
		dey
		bpl od1
		rts
		
		.include "macros.asm"
.include "systemsetup.asm"
		
;*= $2000		
;.incbin "..\gfx\kombilogo.bin"