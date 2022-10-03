%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token FOR LPAREN RPAREN ID TYPE NUMBER RELOP INCDEC ASSIGN SEMI NEWLINE

%%
SD: S NEWLINE { printf("for loop prototype is correct\n"); return 0; }

S: FOR LPAREN INNER RPAREN;

INNER: T ID ASSIGN NUMBER SEMI ID RELOP NUMBER SEMI ID OPR
|
SEMI SEMI
;

T: TYPE
|
;

OPR: INCDEC
|
INCDEC NUMBER
;

%%

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}

int main(void)
{
    yyparse();
    return 0;
}