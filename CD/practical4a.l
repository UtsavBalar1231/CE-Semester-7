%%

^\<[^<|^>]+>$ printf("%s is valid\n", yytext);
.*|\n ;

%%

void main() {
    printf("start:\n");
    yylex();
}
