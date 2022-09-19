%{
#include "y.tab.h"
%}

KEYWORD int|char|float|double|void|struct|union|enum|typedef|extern|static|auto|register|const|volatile|signed|unsigned|short|long|if|else|switch|case|default|while|do|for|goto|continue|break|return|sizeof|asm|inline|restrict
LETTER [a-zA-Z_]
CONSTANT [0-9]
EQUALS =
SEMICOLON ;
COMMA ,
SPACE [ \t]+

%%
{KEYWORD}* {
    printf("KEYWORD\t=>\t%s\n", yytext);
    return KEYWORD;
}

{LETTER}+({LETTER}|{CONSTANT})* {
    printf("ID\t=>\t%s\n", yytext);
    return ID;
}

{CONSTANT}+\.?({CONSTANT})* {
    printf("CONST\t=>\t%s\n", yytext);
    return CONST;
}

{EQUALS} {
    printf("EQUAL\n");
    return EQ;
}

{SEMICOLON} {
    printf("SEMI\n");
    return SEMI;
}

{COMMA} {
    printf("COMMA\n");
    return COMMA;
}

{SPACE} {
    if (yytext[0] == ' ')
        printf("SPACE\n");
    else
        printf("TAB SPACE\n");
    return SPACE;
}

\n return NEWLINE;

%%