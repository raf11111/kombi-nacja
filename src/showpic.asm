ShowPic SUBROUTINE
		lda #$0e
		sta $d020
		lda #$06
		sta $d021
	
		lda #$34
		sta $d011
		
		lda #$2c
		sta $d018
		
		spacechk lda $dc01 
		cmp #$ef 
		bne spacechk
		
		lda #$1b
		sta $d011
		
		lda #$14
		sta $d018
		
		rts