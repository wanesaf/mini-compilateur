%{
#include <stdio.h>
#include <stdlib.h>
#include "symbolTable.h"
extern int ligne;
int yyparse();
int yylex();
int yyerror(char *s);
%}
%union{
    int INTEGER;
    float FLOAT;
    char* CHAR;
}
%start S 
%token VAR_GLOBAL DECLARATION INSTRUCTION 
%token READ WRITE 
%token INTEGER FLOAT CHAR CONST
%token IF ELSE  
%token FOR   
%token acc_ferm acc_ouvr croch_ouvr croch_ferm parth_ouvr parth_ferm affect virg point_virg 
%token IDF 
%token CONST_FLOAT_SIGN CONST_FLOAT_NON_SIGN 
%token CONST_ENTIERE_SIGN CONST_ENTIERE_NON_SIGN

%right affect
%left '+' '-' '*' '/' 
%left '<' '>' eg noneg infeg supeg
%left '!' '|' '&'

%%
S: VAR_GLOBAL acc_ouvr declaration acc_ferm  { printf("test passed\n"); };

declaration:
    dec_list
    ;

dec_list:
    dec point_virg { printf("Delaration unique.\n"); }
    | dec_list dec point_virg { printf("Declaration ajoutée à la liste.\n"); }
    ;

typeG:
INTEGER 
|FLOAT 
|CHAR
; 

typeFC: //type pour const float
CONST_FLOAT_NON_SIGN
|CONST_FLOAT_SIGN
;



typeEC: //type pour entiere constant
CONST_ENTIERE_NON_SIGN
|CONST_ENTIERE_SIGN 
;

dec:
    typeG IDF
    |typeG IDF virg IDF
    | CONST INTEGER IDF affect typeEC
    | CONST FLOAT IDF affect typeFC
    | typeG IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm //pour les tableaux il reste de vérifier qui il est sup a 0
    ;

             


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