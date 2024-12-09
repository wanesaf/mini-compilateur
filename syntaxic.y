%{
#include <stdio.h>
#include <stdlib.h>
extern int ligne;
int yyparse();
int yylex();
int yyerror(char *s);
%}
%start S 
%token VAR_GLOBAL DECLARATION INSTRUCTION 
%token INTEGER FLOAT CHAR CONST
%token  READ WRITE 
%token IF ELSE  
%token FOR 
%token IDF CONST_FLOAT_SIGN CONST_FLOAT_NON_SIGN CONST_ENTIERE_SIGN CONST_ENTIERE_NON_SIGN
%token '{' '}' '[' ']' '(' ')' '=' ',' ';'

%left '+' '-' '*' '/' 
%left '<' '>' eg noneg infeg supeg
%left '!' '|' '&'
 
 
%%
S:VAR_GLOBAL DECLARATION INSTRUCTION
%%
int yyerror(char *msg)
{
    printf("%s : erreur syntaxique à la ligne %d\n", msg, ligne);
    return 1;
}


int main()  {   
yyparse(); 
return 0;  
}