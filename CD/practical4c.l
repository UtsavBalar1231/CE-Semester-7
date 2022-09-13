%{
    int a_counter=0;
    int b_counter=0;
    void result();
%}

%s A B
%s DEAD

%%
<INITIAL>a {
    // start symbol is a so move to next state
    BEGIN A;
    a_counter++;
}

<INITIAL>[^a\n] {
    // Start symbol is not 'a'
    BEGIN DEAD;
}
 
<A>a {
    // printf("detected a after a\n");
    // accept all 'a' followed by 'a'
    a_counter++;
}

<A>b {
    // printf("detected b after a\n");
    // 'b' detected after an 'a' so move to next state
    BEGIN B;
    b_counter++;
}

<A>[^ab\n] {
    // invalid input symbol detected
    BEGIN DEAD;
}

<A>\n {
    // print the result and move back to initial state
    BEGIN INITIAL;
    result();
}

<B>b {
    // printf("detected b after b\n");
    // 'b' detected after a previous 'b'
    b_counter++;
}

<B>[^b\n] {
    // invalid input symbol detected
    BEGIN DEAD;
}

<B>\n {
    // print the result and move back to initial state
    BEGIN INITIAL;
    result();
}

<DEAD>[^\n] {
    // accept anything in dead state until newline character
    BEGIN DEAD;
}

<DEAD>\n {
    // invalid string detected, move back to initial state
    BEGIN INITIAL;
    printf("Invalid String\n\n");
}

%%

void result() {
    // printf("a_counter=%d, b_counter=%d\n", a_counter, b_counter);
    if (a_counter == b_counter)
        printf("String accepted\n");
    else
        printf("String not accepted\n");
    a_counter=0;
    b_counter=0;
    printf("\n");
}

void main()
{
    printf("Enter the string: ");
    yylex();
}