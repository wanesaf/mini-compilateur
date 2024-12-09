%{
    int ligne = 1;
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
OP_ARTH [+\-*/]


%%
VAR_GLOBAL  {return VAR_GLOBAL;}
DECLARATION {return DECLARATION;}
INSTRUCTION {return INSTRUCTION;}
INTEGER {return INTEGER;}
FLOAT {return FLOAT;}
CHAR {return CHAR;}
CONST {return CONST;}
READ {return READ;}
WRITE {return WRITE;}
IF {return IF;}
ELSE {return ELSE;} 
FOR {return FOR;}

{IDF} {return IDF;  }
{CONST_FLOAT_SIGN} {return CONST_FLOAT_SIGN;}
{CONST_FLOAT_NON_SIGN} {return CONST_FLOAT_NON_SIGN;}
{CONST_ENTIERE_SIGN} { 
    const_entiere = atoi(yytext); 
    if (!(const_entiere >= -32768 && const_entiere <= 32767)) {
        printf("valeur incorrecte!");
    }
    return CONST_ENTIERE_SIGN ;
}
{CONST_ENTIERE_NON_SIGN} { 
    const_entiere = atoi(yytext); 
    if (!(const_entiere <= 32767)) {
        printf("valeur incorrecte!");
    }
    return CONST_ENTIERE_NON_SIGN ;
}


"%%"[^\n]* {} 
[ \t] {}       
\n { ligne++; }

"|" {return '|';}
"&" {return '&';}
"!" {return '!';}

"+" {return '+'; }
"-" {return '-'; }
"*" {return '*';}
"/" {return '/';}

"=" {return "="; }
"{" {return "{" ; }
"}" { return "}";}
";" {return ";"; }
"," {return  ","; }
"(" {return "("; }
")" {return ")"; }
"[" {return "["; }
"]" {return "]"; }



">" {return ">"; }
"<" {return "<"; }
">=" {return supeg; }
"<=" {return infeg; }
"==" {return eg; }
"!=" {return noneg; }
. { printf("Erreur lexicale a la ligne %d, Caractere %s non reconnu\n", ligne, yytext); }
%%

