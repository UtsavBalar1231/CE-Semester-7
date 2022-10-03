%{
#include "y.tab.h"
%}

NUMBER [0-9]
LETTER [a-zA-Z_]

%%
"for" return FOR;

"(" return LPAREN;

")" return RPAREN;

"=" return ASSIGN;

"=="|"<="|">="|"<"|">" return RELOP;

"int "|"float "|"char " return TYPE;

{LETTER}({LETTER}|{NUMBER})* return ID;

";" return SEMI;

{NUMBER}+ return NUMBER;

"++"|"--"|"+="|"-=" return INCDEC;

[ \t] /* ignore */;

"\n" return NEWLINE;

. return yytext[0];

%%