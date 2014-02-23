* = $1000

	jsr mul40
	
	lda mul40hi
	clc
	adc #>menuItems
	sta x+2
	
	lda mul40lo
	clc
	adc #<menuItems
	sta x+1
	
	ldy #39
x	lda $0000,y
	sta $0600,y
	dey
	bpl x
	
	rts
	
tuneToLoad byte 5


include "menuitems.asm"
include "jukeboxtimer.asm"

*= $3000
	jsr resetTimer
	jsr checkTimer
	rts
