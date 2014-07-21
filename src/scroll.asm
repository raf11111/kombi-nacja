doScroll:
	dec skrol
	bne exitScroll
	lda #1+2+4
	sta skrol

; scroller starts at 14 textline (0 index based)
	inc scrollPtr + 1
	bne .hop

	inc scrollPtr + 2
	
.hop	ldx #00
	
scrlup	
	lda $c000+14*40+1,x
	sta $c000+14*40,x
		
	inx
	cpx #39
	bne scrlup
	
	ldy #$00
scrollPtr:
	lda $1234
	bne walwekran
	jsr scrollsetup
	jmp dalejs
walwekran 	
	sta $c000+14*40+39

dalejs 	
	rts

scrollsetup	 lda #<stext
	ldx #>stext
	sta scrollPtr + 1
	stx scrollPtr + 2
	rts
	
stext
.scru "      hello biatches, it's vulture design in 2014. it's raf's last release for c64!"
byte 0