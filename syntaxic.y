%{
#include <stdio.h>
#include <stdlib.h>
extern int ligne;
extern int colonne;
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
%token acc_ferm acc_ouvr croch_ouvr croch_ferm parth_ouvr parth_ferm affect virg point_virg deuxpoints  chaine
%token IDF 
%token CONST_FLOAT_SIGN CONST_FLOAT_NON_SIGN 
%token CONST_ENTIERE_SIGN CONST_ENTIERE_NON_SIGN

%right affect
%left plus minus mul division
%left inf sup eg noneg infeg supeg
%left neg or and

%%
S: VAR_GLOBAL acc_ouvr declaration acc_ferm 
   DECLARATION acc_ouvr declaration acc_ferm
   INSTRUCTION acc_ouvr instruction acc_ferm
     { printf("compilation terminee, pas d'erreurs lexicales ou syntaxiques.\n"); };

//partie Var_global et Declaration
declaration:
    | dec_list
    ;

dec_list:
    dec point_virg 
    | dec_list dec point_virg 
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

doubleDec : typeG IDF virg IDF //INTEGER X,Y
          | typeG IDF virg IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm//INTEGER X,T[7];
          | typeG IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm virg IDF//INTEGER T[7],X;
          | typeG IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm virg IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm//INTEGER T[7],X[1];
;
dec:
    typeG IDF
    | CONST INTEGER IDF affect typeEC
    | CONST FLOAT IDF affect typeFC
    | CONST CHAR IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm affect chaine
    | typeG IDF croch_ouvr CONST_ENTIERE_NON_SIGN croch_ferm //pour les tableaux il reste de vérifier qui il est sup a 0
    | doubleDec
    ;

//partie Instruction
instruction :
            | instr_list
            ;

instr_list : instr point_virg ;
            | instr_list instr point_virg;  
           ;

instr : affectation 
      | conditionIF 
      | boucle 
      | entreeSortie
      ;

affectation : IDF affect expression; // a = expression


conditionIF : IF parth_ouvr condition parth_ferm acc_ouvr instruction acc_ferm //IF with else
              ELSE acc_ouvr instruction acc_ferm 
            | IF parth_ouvr condition parth_ferm acc_ouvr instruction acc_ferm//if seulement
            ;

boucle : FOR parth_ouvr // FOR (i=0 :2 ://n) { i = i + 1 ;}
       IDF affect expression
       deuxpoints expression deuxpoints 
       IDF parth_ferm
       acc_ouvr instruction acc_ferm 
      


entreeSortie: READ parth_ouvr IDF parth_ferm //READ(a)
            | WRITE parth_ouvr  chaine  parth_ferm //WRITE("kiajdjzidjazd:da^paz")
            | WRITE parth_ouvr  chaine  virg IDF virg  chaine  parth_ferm //WRITE("...", nomVar, "...")

expression : terme
           | expression plus terme
           | expression minus terme
           ;

terme : facteur 
      | terme mul facteur 
      | terme division facteur 
      ;

facteur : IDF 
        | typeEC 
        | typeFC 
        | parth_ouvr expression parth_ferm
        ;

condition: expression inf expression
         | expression sup expression
         | expression eg expression
         | expression noneg expression
         | expression infeg expression
         | expression supeg expression
         | neg expression
         | condition and and  condition
         | condition or or  condition ;



%%
int yyerror(char *msg)
{
    printf("%s : erreur syntaxique a la ligne %d et colonne %d\n", msg, ligne,colonne);
    return 1;
}


int main()  {   
yyparse(); 
return 0;  
}

//souhil 