%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token VOID TYPE LPARAN RPARAN COMMA SEMI ID POINTER ADDRESS

%%
START: S {
	printf("function prototype is valid!\n");
	return 0;
}

S: RTYPE FNAME LPARAN INNER RPARAN SEMI
;

INNER: TYPE IDENTIFIER
|
TYPE IDENTIFIER COMMA INNER
|
VOID
|
;

FNAME: ID
|
POINTER ID
;

IDENTIFIER: ID
|
POINTER ID
|
ADDRESS ID
;

RTYPE: TYPE
|
VOID
;

%%

void yyerror(char *s)
{
    fprintf(stderr, "Invalid function prototype (%s: detected)\n", s);
}

int main()
{
    printf("Enter function protype: ");
    return yyparse();
}
