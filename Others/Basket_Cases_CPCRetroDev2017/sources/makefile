main: basketcs.bas

basketcs.inc: basketcs.dib basketcs.txt
	@ dib2 -m 0 $* < $*.txt
	@ bin2asm $*.grf > $@
	@ if exist $*.grf del $*.grf
basketcs.mus: basketcs.chp chipnsfx.exe
	@ chipnsfx $< -l basketcs_ $@ -b
basketct.mus: basketct.chp chipnsfx.exe
	@ chipnsfx $< -l basketct_ $@ -b
basketcu.mus: basketcu.chp chipnsfx.exe
	@ chipnsfx $< -l basketcu_ $@ -b
basketcs.bas: basketcs.s80 basketcs.inc basketcs.mus basketct.mus basketcu.mus chipnsfx.i80
