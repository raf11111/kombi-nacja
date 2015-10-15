;menuitems.asm

;algo dla zwiekszenia utworu
;przenies ekran od powiedzmy 17 linii do 24 (indeks od 0) w gore
;napisz nowa linie (aktualna muzyka + 9?) w ostatniej linii


menuItems:
       
.scru "--                                      "
.scru "--                                      "
.scru "--                                      "
.scru "--                                      "
.scru "--                                      "	   
	   
.scru "                                        "
.scru "                                        "
.scru "                                        "
.scru "                                        "

.scru " bez ograniczen                 surgeon "
.scru " black and white                surgeon "
.scru " black and white               gregfeel "
.scru " black and white                  djinn "
.scru " wspomnienia z pleneru          shogoon "
.scru " kochac cie za pozno            surgeon "
.scru " jej wspomnienie                scarlet "
.scru " nasze rendez vous              surgeon "
.scru " przytul mnie                   shogoon "
.scru " slodkiego milego zycia         surgeon "
.scru " pokolenie (bonus track)        surgeon "

.scru "                                        "
.scru "                                        "
.scru "                                        "
.scru "                                        "

menuShowTuneToLoad:
; wyswietlic linie: 5 w gore od obecnej pozycji

	lda tuneToLoad
	rts

moveScreenUp:
	; from 16th line of text screen
	CHAR SET $c000 + 17 * 40
	REPEAT 8 * 40 
		lda CHAR
		sta CHAR - 40
		CHAR SET CHAR + 1
	REPEND
	
	rts
	
moveScreenDown:
	CHAR SET $c000 + 24 * 40 - 1
	REPEAT 9 * 40 
		lda CHAR
		sta CHAR + 40
		CHAR SET CHAR - 1
	REPEND
	
	rts

SUBROUTINE multiply40 ; TODO: works for numbers up to 25	
	
; mnozenie przez 40: 2x asl , 1x adc, 3x asl
mul40
	sta multiplyTemp 
	tax
	lda #0
	sta mul40hi
	txa
	sta mul40lo
	ASL
	ASL
	CLC
	ADC multiplyTemp
	ASL

	BCC nocarry
	inc mul40hi
nocarry
	
	ASL
	ROL mul40hi
	ASL
	ROL mul40hi
	sta mul40lo

	rts
	
mul40hi:
	byte 0
mul40lo:
	byte 10
multiplyTemp:
	byte 0