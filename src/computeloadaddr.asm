computeloadaddr:	
; wyliczenie innych kawalkow (index: tune_number << 2)	
; compute for tunes as numbers
		lda tuneToLoad
		asl
		tay

		lda packedTunesLengths,y ; lo
		sta opbase + 1
		iny
		lda packedTunesLengths,y ; hi
		clc
		adc #$40 ; TODO jak kawalki beda sie ladowac pod inny adres to zmienic!
		sta opbase +2
		rts