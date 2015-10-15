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
.scru "      **** use crsrs and return to play around! **** hello biatches, it's vulture design in 2014... erm 2015! it's probably raf's last coded release for c64! this music collection was meant to be tribute to kombi band mostly because founder, slawomir losowski used c64 as midi sequencer back in 80's"

.scru "       credits... code: raf. graphics: odyn (intro) and raf (collection). font: ? music: surgeon, gregfeel, shogoon, scarlet and mch (intro jingle)   "

.scru " few guys promised us exclusive kombi covers but unfortunately only our long belonging member surgeon made few covers so we had to dig other covers from hvsc to put up"
.scru " this collection - we hoped someone will still help us, this is why it was delayed for over a year... finally we cut out jukebox and karaoke features which were"
.scru " thought as partyshakers - unfortunately you have to switch tunes yourself and grab lyrics from another source ;) " 
.scru " there is also no real intro "
.scru "because another guy screwed things up - he promised and ran away from us. after all we are really proud because we made it happen -"
.scru " we can honor kombi's artistic achievement. we wish slawomir losowski all the best"
.scru " - he is still active musician after all those 40 years!      greetings to www.c64power.com community  "

.scru"                    "
byte 0   