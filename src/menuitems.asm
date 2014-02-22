;menuitems.asm

menuItems:
       .
.scru "1*                                      "
.scru "2*                                      "
.scru "3*                                      "
.scru "4*                                      "
.scru "5*                                      "
.scru "1                                       "
.scru "2                                       "
.scru "3                                       "
.scru "4                                       "
.scru "5                                       "
.scru "1                                       "
.scru "2                                       "
.scru "3                                       "
.scru "4                                       "
.scru "5                                       "
.scru "1*                                      "
.scru "2*                                      "
.scru "3*                                      "
.scru "4*                                      "
.scru "5*                                      "

menuShowTuneToLoad:
; wyswietlic linie: 5 w gore od obecnej pozycji
; mnozenie przez 40: 2x asl , 1x adc, 3x asl

	lda tuneToLoad

	rts

multiplyTemp
	byte 0
	
moveScreenUp:
	; from 16th line of text screen
	CHAR SET $c000 + 16 * 40
	REPEAT 8 * 40 
		lda CHAR
		sta CHAR - 40
		CHAR SET CHAR + 1
	REPEND
	
	rts
	
moveScreenDown:
	CHAR SET $c000 + 24 * 40 - 1
	REPEAT 8 * 40 
		lda CHAR
		sta CHAR + 40
		CHAR SET CHAR - 1
	REPEND
	
	rts
	
	