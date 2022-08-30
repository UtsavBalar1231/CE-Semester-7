%{
int cnt = 0;
%}
%%
[^\n] {
	int c = input();
	if (c == '$')
		printf("a $ detected\n");
	yymore();
	unput(c);
}

"\n" {
printf("%d %s", ++cnt, yytext);
}
%%

int yywrap(void) {return 1;}

void main() {
  yylex();
}
