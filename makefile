all: noticia

noticia.tab.c noticia.tab.h: noticia.y
	bison -d noticia.y

lex.yy.c: noticia.l noticia.tab.h
	flex noticia.l

tarea: lex.yy.c tarea.tab.c tarea.tab.h
	g++ -o tarea noticia.tab.c noticia.yy.c

clean:
	rm noticia noticia.tab.c lex.yy.c noticia.tab.h


