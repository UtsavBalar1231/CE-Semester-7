%{
#include "y.tab.h"
%}

LETTER [a-zA-Z_]
DIGIT [0-9]
OPR =|<|>|!=|<=|>=|==|&&|"||"|[+\-*/]

%%
"if" return IF;

"else" return ELSE;

{DIGIT}+ return NUMBER;

{LETTER}({LETTER}|{DIGIT})* return ID;

{OPR} return OPR;

"(" return LPARAN;

")" return RPARAN;

"{" return LBRACE;

"}" return RBRACE;

";" return SEMICOLON;

"," return COMMA;

"++"|"--" return UOP;

[ \t] /* ignore white space */;

"\n" return 0;

. /* ignore everything else */;
%%