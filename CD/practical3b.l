%{
int cnt = 0, line_no = 1;
%}

%%
"(" cnt = cnt + 1;

")" {
    if (cnt > 0)
         cnt = cnt - 1;
    else {
         cnt = -1;
         REJECT;
    }
}

"\n" {
    if (cnt == 0)
        printf("No missing parenthesis found!\n");
    else
        printf("Missing parenthesis found! as line: %d\n", line_no);

    if (cnt == -1)
        printf("There are extra ) parenthesis found!\n");
    else if (cnt > 0)
        printf("There are extra ( parenthesis found!\n");

    cnt = 0;
    line_no = line_no + 1;
}

. ;

%%

void main() {
    printf("Enter a C snippet: \n");
    yylex();
}
