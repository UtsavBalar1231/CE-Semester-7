%{
#include "y.tab.h"
extern int yylval;
%}

%%
[0-9]+ {
    /* convert yytext to an integer */
    yylval = atoi(yytext);
    return NUM;
}

[ \t] /* Ignore whitespaces */;

\n return 0;
. return yytext[0];
%%