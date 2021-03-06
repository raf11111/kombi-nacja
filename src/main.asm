;
; Kombi-nacja - main part sourcecode
; by Raf/Vulture Design
;

*= $0400
.incprg "..\gfx\knation-0400.PRG"
*= $0800
.incprg "..\gfx\knation-d800.prg"
*= $1000
.incprg "..\intromsx\kombi.prg"
*= $2000
.incprg "..\gfx\knation-2000.prg"


.include "macros.asm"
.include "globallabels.asm"

.include "start.asm"
.include "scroll.asm"
.include "systemsetup.asm"
.include "showpic.asm"
.include "packedlen.asm"
.include "musiclen.asm"
.include "computeloadaddr.asm"
.include "kbdirq.asm"
.include "jukeboxtimer.asm"

*= $8000	
.incprg "..\dload\user_cfg\dload.prg" 

exom ALIGN 255,0
.include "exomizer.asm"

.include "menuitems.asm"

*= $c000
;; checkerboarded logo
;	REPEAT 7 ;14*40 / 2
;		REPEAT 20
;			BYTE $21, $12
;		REPEND
;		REPEAT 20
;			BYTE $12, $21
;		REPEND
;	REPEND

; red logo
	REPEAT 14*40
		byte $20
	REPEND

;15
	REPEAT 6*40 ; emty space
		byte $0
	REPEND

;21
.scru " bez ograniczen                 surgeon "
.scru " black and white                surgeon "
.scru " black and white               gregfeel "
.scru " black and white                  djinn "
.scru " wspomnienia z pleneru          shogoon "

	
;.scru "1*                                      "
;.scru "2*                                      "
;.scru "3*                                      "
;.scru "4*                                      "
;.scru "5*                                      "
;.scru "1                                       "
;.scru "2                                       "
;.scru "3                                       "
;.scru "4                                       "

;repeat 200
;		byte 1,2,3
;repend
	
	
*= $c800
.incprg "..\gfx\Font.prg", $c800

*= $e000
.incbin "..\gfx\kombilogo.bin"

