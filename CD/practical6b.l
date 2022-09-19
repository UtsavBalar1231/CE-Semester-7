%{
%}

%x COMMENT
%x SINGLE_COMMENT

%%
<INITIAL>"/*" {
	BEGIN(COMMENT);
	yymore();
}
<INITIAL>"/"+"/" {
	BEGIN(SINGLE_COMMENT);
	yymore();
}

<COMMENT>[^*]* yymore();

<COMMENT>"*"+[^*/]* yymore();

<COMMENT>"*"+"/" {
	int c = input();
	if (c == '\n')
		printf("--Multiline comment was detected here--\n");
	unput(c);
	BEGIN(INITIAL);
}

<SINGLE_COMMENT>[^\n] {
	int c = input();
	if (c == '\n')
		printf("--Singleline comment was detected here--\n");
	unput(c);
	yymore();
}

<SINGLE_COMMENT>[\n] {
	yyless(yyleng);
	BEGIN(INITIAL);
}

<<EOF>> {
	printf("EOF\n");
	yyterminate();
}
%%

void main() {
	yyin = fopen("test.c", "r");
	yylex();
	fclose(yyin);
}
