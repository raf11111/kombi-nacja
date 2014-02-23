SUBROUTINE jukeBoxTimer

checkTimer
	lda musicTimeLo
	cmp musicTimerLo
	bne .skip2
	lda musicTimeHi
	cmp musicTimerHi
	bne .skip2
	
	; TIMER HIT HERE
	inc $d020
	
.skip2
	rts

incTimer
	inc musicTimerLo
	bcc .skip1
	inc musicTimerHi
.skip1
	rts

resetTimer
	lda #0
	sta musicTimer
	sta musicTimer + 1
	rts

musicTimer
musicTimerLo
.byte $00
musicTimerHi
.byte $00

musicTimeLo
.byte $00
musicTimeHi
.byte $00