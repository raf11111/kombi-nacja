;menuitems.asm

menuItems:
       .
.scru "1*         a                            "
.scru "2*         b                            "
.scru "3*         c                            "
.scru "4*         f                            "
.scru "5*         g                            "
.scru "1aaaaa                                  "
.scru "2  bbbbbbbbbbbbb                        "
.scru "3   cccccccccccc                        "
.scru "4  dddddddddddd                         "
.scru "5   eeeeeeeeeeee                        "
.scru "1   fffffffff                           "
.scru "2    ggggggggggg                        "
.scru "3       hhhhhhhhhhhh                    "
.scru "4    iiiiiiiiii                         "
.scru "5          jjjjjjjjj                    "
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
	REPEAT 9 * 40 
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
	
mul40
	lda tuneToLoad
	sta mul40lo
	ASL
	ASL
	CLC
	ADC mul40lo
	ASL

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


	