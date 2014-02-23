;menuitems.asm

menuItems:
       .
.scru "00         a                            "
.scru "01         b                            "
.scru "02         c                            "
.scru "03         f                            "
.scru "04         g                            "
.scru "05aaaa                                  "
.scru "06 bbbbbbbbbbbbb                        "
.scru "07  cccccccccccc                        "
.scru "08 dddddddddddd                         "
.scru "09  eeeeeeeeeeee                        "
.scru "10  fffffffff                           "
.scru "11   ggggggggggg                        "
.scru "12      hhhhhhhhhhhh                    "
.scru "13   iiiiiiiiii                         "
.scru "14         jjjjjjjjj                    "
.scru "15                                      "
.scru "16                                      "
.scru "17                                      "
.scru "17                                      "
.scru "19                                      "

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
	lda #0
	sta mul40hi
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


	