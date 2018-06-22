%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "noticia.tab.h"

%}
%%
[ \t]		;
Titulo					{ return TITULO; }
Cuerpo		      { return CUERPO; }
Autor						{ return AUTOR; }
"|"             { return TAG; }
Fecha            { return TYPE; }
end             { return END; }       ;
(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)[0-9][0-9] { yylval.sval = strdup(yytext); return FECHA; }
[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+          { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+       { yylval.sval = strdup(yytext); return STRING; }
[a-zA-Z_]?\"(\\.|[^\\"\n])*\"   { 

	yylval.sval = strdup(yytext);
	return TEXTO;
}
\n		return ENDL;
.		;

%%
