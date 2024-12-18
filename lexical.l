%{
    int ligne = 1;
    int colonne=1;
    int const_entiere;
    float const_float;
    #include "syntaxic.tab.h"
%}

%option noyywrap

IDF [A-Z][a-z0-9]{0,7}
CONST_FLOAT_SIGN \([-+][0-9]+\.[0-9]+\)
CONST_FLOAT_NON_SIGN [0-9]+\.[0-9]+
CONST_ENTIERE_SIGN \([-+][0-9]+\)
CONST_ENTIERE_NON_SIGN [0-9]+

%%
VAR_GLOBAL           { colonne=colonne+yyleng;return VAR_GLOBAL;  }
DECLARATION          { colonne=colonne+yyleng;return DECLARATION; }
INSTRUCTION          { colonne=colonne+yyleng;return INSTRUCTION; }
INTEGER              { colonne=colonne+yyleng;return INTEGER;  }
FLOAT                { colonne=colonne+yyleng;return FLOAT;  }
CHAR                 { colonne=colonne+yyleng;return CHAR; }
CONST                { colonne=colonne+yyleng;return CONST;  }
READ                 { colonne=colonne+yyleng;return READ; }
WRITE                { colonne=colonne+yyleng;return WRITE; }
IF                   { colonne=colonne+yyleng;return IF; }
ELSE                 { colonne=colonne+yyleng;return ELSE; }
FOR                  { colonne=colonne+yyleng;return FOR; }


{IDF}                { colonne=colonne+yyleng;return IDF;  }
{CONST_FLOAT_SIGN}   { colonne=colonne+yyleng;return CONST_FLOAT_SIGN;  }
{CONST_FLOAT_NON_SIGN} { colonne=colonne+yyleng;return CONST_FLOAT_NON_SIGN;  }
{CONST_ENTIERE_SIGN} { 
                        const_entiere = atoi(yytext); 
                        if (!(const_entiere >= -32768 && const_entiere <= 32767)) {
                            printf("valeur incorrecte!\n");
                        }
                        colonne=colonne+yyleng;
                        return CONST_ENTIERE_SIGN; 
                      }
{CONST_ENTIERE_NON_SIGN} { 
                            const_entiere = atoi(yytext); 
                            if (!(const_entiere <= 32767)) {
                                printf("valeur incorrecte!\n");
                            }
                            colonne=colonne+yyleng;
                            return CONST_ENTIERE_NON_SIGN; 
                          }


"%%"[^\n]*           { }
[ ]               { colonne++;}
\n                   { colonne = 1 ; ligne++; }

"|"                  { colonne=colonne+yyleng;return or; }
"&"                  { colonne=colonne+yyleng;return and; }
"!"                  { colonne=colonne+yyleng;return neg; }

"+"                  { colonne=colonne+yyleng;return plus; }
"-"                  { colonne=colonne+yyleng; return minus; }
"*"                  { colonne=colonne+yyleng;return mul; }
"/"                  { colonne=colonne+yyleng;return division; }

"="                  { colonne=colonne+yyleng;return affect; }
"{"                  { colonne=colonne+yyleng;return acc_ouvr;  }
"}"                  { colonne=colonne+yyleng;return acc_ferm;  }
";"                  { colonne=colonne+yyleng;return point_virg; }
","                  { colonne=colonne+yyleng;return virg; }
":"                  { colonne=colonne+yyleng;return deuxpoints; }
"("                  { colonne=colonne+yyleng;return parth_ouvr; }
")"                  { colonne=colonne+yyleng;return parth_ferm; }
"["                  { colonne=colonne+yyleng;return croch_ouvr; }
"]"                  { colonne=colonne+yyleng;return croch_ferm; }
\"([^\"\\]|\\.)*\"   { colonne=colonne+yyleng;return chaine;}


">"                  { colonne=colonne+yyleng;return sup; }
"<"                  { colonne=colonne+yyleng;return inf; }
">="                 { colonne=colonne+yyleng;return supeg; }
"<="                 { colonne=colonne+yyleng;return infeg; }
"=="                 { colonne=colonne+yyleng;return eg; }
"!="                 { colonne=colonne+yyleng;return noneg; }
.                    { printf("Erreur lexicale à la ligne %d colonne %d:  Caractère %s non reconnu\n", ligne,colonne,yytext); }
%%

//moh
//chemli oumb3d nrigliwek kho 