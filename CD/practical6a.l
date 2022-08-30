%{
int cnt = 0;
%}
%x line

%%

[^\n] {
	printf("%d %s", ++cnt, yytext);
	BEGIN(line);
}

<line>\n {
	ECHO; 
	BEGIN(INITIAL);
}

%%

int yywrap(void) {return 1;}

void main() {
yylex();
