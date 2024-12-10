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
    const CONST;
}
%start S 
%token VAR_GLOBAL DECLARATION INSTRUCTION 
%token  READ WRITE 
%token IF ELSE  
%token FOR   
%token acc_ouv acc_ferm '[' ']' '(' ')' affect ',' point_virg

%token <CHAR>IDF
%token <FLOAT>CONST_FLOAT_SIGN CONST_FLOAT_NON_SIGN 
%token <INTEGER>CONST_ENTIERE_SIGN CONST_ENTIERE_NON_SIGN
%token <CONST> CONST


%left '+' '-' '*' '/' 
%left '<' '>' eg noneg infeg supeg
%left '!' '|' '&'
 
 
%%
S: VAR_GLOBAL acc_ouv part_VarG acc_ferm INSTRUCTION acc_ouv partie_Inst acc_ferm{ printf("test passed");};

//partie VAR_Global
part_VarG: IDF part_VarG ; 
         | IDF


//partie Declarations


//partie Instrcutions
partie_Inst : instr partie_Inst 
            | instr ;


instr : affectation point_virg
affectation : IDF affect IDF  
     {
        if (verif_dec($1)==0||verif_dec($3)==0) {
            printf("Erreur! var non déclaré dans la ligne : %d",ligne);
        }
        else {
            if(modif_cst($1)==0) {
                printf("Erreur! modification d'une constante dans la ligne %d",ligne);
            }else {
                if (verif_comp(recevoirType($1),recevoirType($3))==0) {
                    printf("Erreur! Incompatibilité du type dans la ligne : %d",ligne);
                }
            }
        }
     }       
            | IDF affect CONST_FLOAT_SIGN
            | IDF affect CONST_FLOAT_NON_SIGN 
            {
               if (verif_dec($1)==0||verif_dec($3)==0) {
            printf("Erreur! var non déclaré dans la ligne : %d",ligne);
        }
        else {
            if(modif_cst($1)==0) {
                printf("Erreur! modification d'une constante dans la ligne %d",ligne);
            }else {
                if (verif_comp(recevoirType($1),1)==0){
                    printf("Erreur! Incompatibilité du type dans la ligne : %d",ligne);
                }
            }
        }
            }
            | IDF affect CONST_ENTIERE_NON_SIGN 
            | IDF affect CONST_ENTIERE_SIGN {
                 if (verif_dec($1)==0||verif_dec($3)==0) {
            printf("Erreur! var non déclaré dans la ligne : %d",ligne);
        }
        else {
            if(modif_cst($1)==0) {
                printf("Erreur! modification d'une constante dans la ligne %d",ligne);
            }else {
                if (verif_comp(recevoirType($1),0)==0){
                    printf("Erreur! Incompatibilité du type dans la ligne : %d",ligne);
                }
            }
        }
            }
     


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