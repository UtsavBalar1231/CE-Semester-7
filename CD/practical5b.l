%{
#include <stdio.h>
#include <string.h>
// EOF Newline character is included by default
int spaces = 1, characters = 1;
int words = 0, lines = 0;
%}

%%
[ \t\n] {
	spaces++;
	characters++;
	if (strcmp(yytext, "\n") == 0)
		lines++;
}

[^ \t\n]+ {
	if (yyleng > 1)
		words++;
	characters += yyleng;
}

%%

void result() {
	printf("spaces:\t%d\n", spaces);
	printf("words:\t%d\n", words);
	printf("lines:\t%d\n", lines);
	printf("characters:\t%d\n", characters);
}

void main()
{
    yyin = fopen("test.c", "r");
    yylex();
    fclose(yyin);
	result();
}