;
; Kombi-nacja - main part sourcecode
; by Raf/Vulture Design
;

.include "macros.asm"
.include "globallabels.asm"

.include "start.asm"
.include "kbd.asm"
.include "systemsetup.asm"
;.include "showpic.asm"

*= $8000	
.incprg "..\dload\user_cfg\dload.prg" 

exom ALIGN 255,0
.include "exomizer.asm"



