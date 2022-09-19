%{
	int counter = 0;
%}

%x line

%%
<INITIAL>[^\n] {
	printf("%d %s", ++counter, yytext);
	BEGIN(line);
}

<INITIAL>[\n] {
	printf("%d %s", ++counter, yytext);
}

<line>\n {
	ECHO; 
	BEGIN(INITIAL);
}

%%

void main() {
	yyin = fopen("test.c", "r");
	yylex();
	fclose(yyin);
}