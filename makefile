noticia.tab.c noticia.tab.h: noticia.y
	bison -d noticia.y

lex.yy.c: noticia.l noticia.tab.h
	flex noticia.l

noticia: lex.yy.c noticia.tab.c noticia.tab.h
	g++ noticia.tab.c lex.yy.c -lfl -o noticia


