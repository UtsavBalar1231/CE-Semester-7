%{
#include "y.tab.h"
%}

VOID "void"|"void "
TYPE "int "|"bool "|"char "|"double "
LETTER [a-zA-Z_]
DIGIT [0-9]

%%
{VOID} return VOID;

{TYPE} return TYPE;

{LETTER}({LETTER}|{DIGIT})* return ID;

"(" return LPARAN;

")" return RPARAN;

"," return COMMA;

";" return SEMI;

"*" return POINTER;

"&" return ADDRESS;

[ \t] /* ignore white space */;

"\n" return 0;

. return yytext[0];
%%
