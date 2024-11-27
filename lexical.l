%{
    int ligne = 1;
    int const_entiere;
    float const_float;
%}

%option noyywrap

IDF [A-Z][a-z0-9]{0,7}
CONST_FLOAT_SIGN \([-+][0-9]+\.[0-9]+\)
CONST_FLOAT_NON_SIGN [0-9]+\.[0-9]+
CONST_ENTIERE_SIGN \([-+][0-9]+\)
CONST_ENTIERE_NON_SIGN [0-9]+
OP_ARTH [+\-*/]
OP_LOGQ (&&|\|\||!)

%%
VAR_GLOBAL  { printf("MOT-CLE : VAR_GLOBAL\n"); } 
DECLARATION { printf("MOT-CLE : DECLARATION\n");  } 
INSTRUCTION { printf("MOT-CLE : INSTRUCTION \n");  }
INTEGER { printf("MOT-CLE : INTEGER\n");  }
FLOAT { printf("MOT-CLE : FLOAT\n");  }
CHAR { printf("MOT-CLE : CHAR \n");  }
CONST { printf("MOT-CLE : CONST\n");  }
READ { printf("MOT-CLE : READ\n");  }
WRITE { printf("MOT-CLE : WRITE\n");  }
IF { printf("MOT-CLE : IF\n");  }
ELSE { printf("MOT-CLE : ELSE\n");  }
FOR { printf("MOT-CLE : FOR\n");  }

{IDF} { printf("IDF : %s\n", yytext);  }
{CONST_FLOAT_SIGN} { printf("Constante reele signee : %s\n", yytext);  }
{CONST_FLOAT_NON_SIGN} { printf("Constante reele non signee : %s\n", yytext);  }
{CONST_ENTIERE_SIGN} { 
    const_entiere = atoi(yytext); 
    if (const_entiere >= -32768 && const_entiere <= 32767) {
        printf("Constante entiere signee : %s\n", yytext);
    } else {
        printf("valeur incorrecte!");
    }
}
{CONST_ENTIERE_NON_SIGN} { 
    const_entiere = atoi(yytext); 
    if (const_entiere <= 32767) {
        printf("Constante entiere non signee : %s\n", yytext);
    } else {
        printf("valeur incorrecte!");
    }
}

{OP_ARTH} { printf("OPERATEUR ARITHMETIQUE : %s\n", yytext);  }
{OP_LOGQ} { printf("OPERATEUR LOGIQUE : %s\n", yytext);  }
"%%"[^\n]* {} 
[ \t] {}       
\n { ligne++; }
[{};,()] { printf("SEPARATEUR : %s\n", yytext); }
">" { printf("OP_COMP : %s \n", yytext); }
"<" { printf("OP_COMP : %s \n", yytext); }
">=" { printf("OP_COMP : %s \n", yytext); }
"==" { printf("OP_COMP : %s \n", yytext); }
"!=" { printf("OP_COMP : %s \n", yytext); }
. { printf("Erreur lexicale a la ligne %d, Caractere %s non reconnu\n", ligne, yytext); }

%%
int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Erreur d'ouverture du fichier");
            return 1;
        }
    }

    yylex();

    if (yyin) {
        fclose(yyin);
    }

    return 0;
}
