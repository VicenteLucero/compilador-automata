
%{
#include <stdio.h>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float fval;
	char *sval;
	
}

// define the constant-string tokens:
%token TYPE CUERPO TAG AUTOR TITULO
%token END ENDL

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token<ival> INT
%token<fval> FLOAT
%token<sval> STRING TEXTO FECHA





%%

// the first rule defined is the highest-level rule, which in our
// case is just the concept of a whole "snazzle file":
noticia:
	header template body_section footer { cout << "Here's a Potato" << endl; }
	;
header:
	TAG TITULO TAG TEXTO ENDLS { cout <<"Titulo: \n"<< $4 << "\n" << endl; }
	;
	
template:
	typelines
	;
typelines:
	typelines typeline
	| typeline
	;
typeline:
	TYPE FECHA ENDLS { cout << "Fecha: \n" << $2 << "\n" << endl; }
	;

	
body_section:
	body_lines
	;
body_lines:
	body_lines body_line
	| body_line
	;
body_line:
	TAG CUERPO TAG TEXTO ENDLS {cout <<$4 << endl;}
	| TAG AUTOR TAG TEXTO ENDLS { cout << "Author:\n" << $4 << "\n" <<  endl;}
	;
footer:
	END ENDLS
	;
ENDLS:
	ENDLS ENDL
	| ENDL ;

%%

int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("in.noticia", "r");
	// make sure it's valid:
	if (!myfile) {
		cout << "I can't open a.noticia.file!" << endl;
		return -1;
	}
	// set flex to read from it instead of defaulting to STDIN:
	yyin = myfile;

	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "EEK, parse error!  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}
