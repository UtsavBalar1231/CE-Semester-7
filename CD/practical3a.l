%%
^\+?[0-9]+$ {ECHO; printf(" is a positive number\n");}
^\-?[0-9]+$ {ECHO; printf(" is a negative number\n");}

^\+?[0-9]+\.[0-9]*$ {ECHO; printf(" is a positive floating point number\n");}
^\-?[0-9]+\.[0-9*]$ {ECHO; printf(" is a negative floating point number\n");}

^\+?[0-9]+[+|-]?[e|E][0-9]+$ {ECHO; printf(" is a positive number with exponent\n");}
^\-?[0-9]+[+|-]?[e|E][0-9]+$ {ECHO; printf(" is a negative number with exponent\n");}

^\+?[0-9]+\.[0-9]*[+|-]?[e|E][0-9]+$ {
	ECHO;
	printf(" is a positive floating point number with exponent\n");
}

^\-?[0-9]+\.[0-9*][+|-]?[e|E][0-9]+$ {
	ECHO;
	printf(" is a negative floating point number with exponent\n");
}

.* {ECHO; printf(" is invalid input!\n");}

%%

void main() {
    printf("Enter a number: ");
    yylex();
}
