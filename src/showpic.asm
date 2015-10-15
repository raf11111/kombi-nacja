ShowPic SUBROUTINE
	
		ldx #$00
xxx		lda $0800,x
		sta $d800,x
		lda $0900,x
		sta $d900,x
		lda $0a00,x
		sta $da00,x
		lda $0b00,x
		sta $db00,x
		dex
		bne xxx	
	
		; multicolor bitmap in bank 0-3fff, char $0400, bmp $2000
		lda #$3b
		sta $d011
		
		lda #$1c
		sta $d018
		
		lda #$18
		sta $d016
		
		lda #$0c
		sta $d021
		
		lda #$0
		jsr $1000
		
		spacechk 
		lda $d012
		cmp #$f0
		bne .dalej
		jsr $1003
.dalej		
		lda $dc01 
		cmp #$ef 
		bne spacechk

		lda #$00
		sta $d021

		lda #0
		sta $d400+24
		
		; normla screen:
		;lda #$1b
		;sta $d011
		
		;lda #$14
		;sta $d018
		
		rts