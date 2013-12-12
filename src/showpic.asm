ShowPic SUBROUTINE
	
   	ldx #$00
xxx	lda $0800,x
	sta $d800,x
	lda $0900,x
	sta $d900,x
	lda $0a00,x
	sta $da00,x
	lda $0b00,x
	sta $db00,x
	inx
	bne xxx	
	
		; stanard bitmap in bank 0-3fff
		lda #$3b
		sta $d011
		
		lda #$1c
		sta $d018
		
		lda #$18
		sta $d016
		
		;spacechk lda $dc01 
		;cmp #$ef 
		;bne spacechk
		
		; normla screen:
		;lda #$1b
		;sta $d011
		
		;lda #$14
		;sta $d018
		
		rts