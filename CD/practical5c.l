%{
#include <stdio.h>
void write_tokens(const char *filename, char *text);
%}

KEYWORDS auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while|printf|scanf|%d|include|stdio.h|main
OPERATORS []=|!|~|+|-|*|/|%|^|\||&|<|>]
SEPARATORS ["{" | "}" | "(" | ")" | "\[" | "\]" | "." | "," | ";" | ":", "#", "\\", "\\n"]
IDENTIFIERS ([a-zA-Z][0-9])+|[a-zA-Z]*
CONSTANTS [0-9]+
SPACES [ \t\n]+

%%
{SPACES} /* Ignore */;
{CONSTANTS} /* Ignore */;

{KEYWORDS}* {
	const char *filename = "keywords.txt";
	write_tokens(filename, yytext);
}

{OPERATORS} {
	const char *filename = "operators.txt";
	write_tokens(filename, yytext);
}

{SEPARATORS} {
	const char *filename = "separators.txt";
	write_tokens(filename, yytext);
}

{IDENTIFIERS} {
	const char *filename = "identifiers.txt";
	write_tokens(filename, yytext);
}

%%

void write_tokens(const char *filename, char *text) {
	FILE *f;
	f = fopen(filename, "a");
	fprintf(f, "%s ", text);
	fclose(f);
}

void main()
{
    yyin = fopen("test.c" , "r");
    yylex();
    fclose(yyin);
}