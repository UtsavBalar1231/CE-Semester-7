%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token NUM
%left '+' '-' '*' '/'

%%
S: EXPR {
	printf("Valid arithmetic expression\n");
	return 0;
}

EXPR: EXPR '+' EXPR 
| EXPR '-' EXPR  
| EXPR '*' EXPR
| EXPR '/' EXPR
| NUM
;
%%

void yyerror(char *s)
{
    fprintf(stderr, "Invalid expression (%s: detected)\n", s);
}

int main()
{
    printf("Enter expression: ");
    return yyparse();
}
