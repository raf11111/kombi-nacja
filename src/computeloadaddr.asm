computeloadaddr:	
; wyliczenie innych kawalkow (index: tune_number << 2)	
		lda actualTune
		asl
		tay
		
		lda tune1,y ; lo
		sta opbase + 1
		iny
		lda tune1,y ; hi
		clc
		adc #$40 ; TODO jak kawalki beda sie ladowac pod inny adres to zmienic!
		sta opbase +2
		rts