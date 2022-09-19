%{
#include <stdio.h>
%}

%s BRACKET

%%
"/*" BEGIN(BRACKET);

<BRACKET>.|\n ECHO;
<BRACKET>"*/" BEGIN(INITIAL);

.|\n ;

%%

void main()
{
    yyin = fopen("test.c", "r");
    yylex();
    fclose(yyin);
}
