%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token KEYWORD ID CONST EQ SEMI COMMA SPACE NEWLINE

%%
S1: S NEWLINE {
    printf("Declaration is valid\n");
    return 0;
}
S: KEYWORD SPACE A SEMI
A: ID|ID COMMA A|ID EQ CONST|ID EQ CONST COMMA A|;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s: detected\n", s);
}

int main() {
    printf("Enter declaration: ");
    return yyparse();
}