go: lex.yy.c turts.tab.c
	gcc turts.tab.c lex.yy.c -lfl -ly -o go

lex.yy.c: turts.l
	flex turts.l

turts.tab.c: turts.y
	bison -dv turts.y

clean:
	rm -f lex.yy.c
	rm -f turts.output
	rm -f turts.tab.h
	rm -f turts.tab.c
	rm -f go
