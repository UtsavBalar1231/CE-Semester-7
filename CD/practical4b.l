%%
^[//].*[\n]? ;
.|\n ECHO;
%%

void main() {
    yyin = fopen("test.c", "r");
    yylex();
}
