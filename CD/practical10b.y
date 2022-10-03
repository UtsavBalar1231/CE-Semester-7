%{
#include <stdio.h>
void yyerror(char *s);
int yylex(void);
%}

%token IF ELSE LPARAN RPARAN ID NUMBER LBRACE RBRACE SEMICOLON UOP OPR COMMA

%%
S1: S {
	printf("conditional statement is valid!\n");
	return 0;
};

S: IFCONDITION
;

IFCONDITION: IF LPARAN CEXP RPARAN CONTINUE
;

CONTINUE: IFCONDITION /* for nested if condition */
| CBODY CONTINUE /* for statements inside control statements */
| LBRACE IFCONDITION RBRACE /* case where braces were used for if blocks */
| ELSE CBODY CONTINUE /* for else statements */
|
;

CBODY: BLOCK /* for multiple statements in control block */
| STMT /* for single statement in control block */
;

BLOCK: LBRACE STMTLIST RBRACE
;

STMTLIST: STMTLIST STMT
|
;

STMT: CEXP SEMICOLON
;

CEXP: EXP
| LPARAN CEXP RPARAN /* for expressions in parenthesis (e.g. (a+b)) */
| CEXP COMMA EXP /* for multiple expressions in control expression (e.g. a++, b++)*/
|
;

EXP: ID 
| NUMBER
| UOP ID /* for unary operators (e.g. ++i)*/
| ID UOP /* for unary operators (e.g. i++)*/
| ID NUMBER /* for return number cases (e.g. return 0)*/
| ID OPR EXP /* for other operators (e.g. i + 1)*/
| NUMBER OPR EXP /* for number expressions (e.g. exp && exp)*/
;

%%

void yyerror(char *s)
{
    fprintf(stderr, "Invalid control statement (%s: detected)\n", s);
}

int main()
{
    printf("Enter control statement: ");
    return yyparse();
}
