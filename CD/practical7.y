%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token A B

%%
S1: S '\n' {
    printf("string is valid\n");
    return 0;
};

S : A S B|;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s: detected\n", s);
}

int main() {
    printf("Enter a string: ");
    return yyparse();
}