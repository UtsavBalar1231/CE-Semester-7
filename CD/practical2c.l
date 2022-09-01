%%
^[a|e|i|o|u|A|E|I|O|U][a-zA-Z]* {ECHO; printf(": is vowel\n");}
.* {ECHO; printf(": is consonant\n");}
%%

void main() {
    printf("Enter a word or a letter: ");
    yylex();
}
