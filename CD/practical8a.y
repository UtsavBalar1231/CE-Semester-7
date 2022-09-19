%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token NUM
%left '+' '-' '*' '/' '%'
%left UNARY_MINUS

%%
S: EXPR {printf("Result: %d \n", $$);}
EXPR: EXPR '+' EXPR { $$ = $1 + $3; }
| EXPR '-' EXPR { $$ = $1 - $3; }
| EXPR '*' EXPR { $$ = $1 * $3; }
| EXPR '/' EXPR { $$ = $1 / $3; }
| EXPR '%' EXPR { $$ = $1 % $3; }
| '(' EXPR ')' { $$ = $2; }
| '-' EXPR %prec UNARY_MINUS { $$ = -$2; }
| NUM { $$ = $1; }
;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s: detected\n", s);
}

int main() {
    printf("Enter expression: ");
    return yyparse();
}