;
; Kombi-nacja - main part sourcecode
; by Raf/Vulture Design
;

*= $0400
.incprg "..\gfx\knation-0400.PRG"
*= $0800
.incprg "..\gfx\knation-d800.prg"
*= $2000
.incprg "..\gfx\knation-2000.prg"


.include "macros.asm"
.include "globallabels.asm"

.include "start.asm"
.include "kbd.asm"
.include "systemsetup.asm"
.include "showpic.asm"

*= $8000	
.incprg "..\dload\user_cfg\dload.prg" 

exom ALIGN 255,0
.include "exomizer.asm"



