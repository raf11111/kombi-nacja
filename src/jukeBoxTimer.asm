SUBROUTINE jukeBoxTimer

setTimerTuneLengthAY ; A = lo, Y = hi
	sta musicTimeLo
	sty musicTimeHi
	rts

checkTimer
	lda musicTimeLo
	cmp musicTimerLo
	bne .skip2
	lda musicTimeHi
	cmp musicTimerHi
	bne .skip2
	
	; TIMER HIT 
	;inc tuneToLoad ; TODO find a smarter way to switch the tune - this is ugly hack
	;lda #OPLoadTune
	;sta OPFLAG
	
.skip2
	rts

incTimer
	clc
	lda musicTimerLo
	adc #1
	sta musicTimerLo
	bcc .skip1
	inc musicTimerHi
.skip1
	rts

; clock value
musicTimer
musicTimerLo
.byte $00
musicTimerHi
.byte $00	
	
resetTimer
	lda #0
	sta musicTimer
	sta musicTimer + 1
	rts

; tune len
musicTimeLo
.byte $00
musicTimeHi
.byte $00