%{
    int ligne = 1 ; 
    int const_entiere;
    float const_float;
%}

%%
"VAR_GLOBAL"  { printf("MOT-CLE : VAR_GLOBAL\n"); } 
"DECLARATION" { printf("MOT-CLE : DECLARAATION\n"); } 
"INSTRUCTION" { printf("MOT-CLE : INSTRUCTION \n"); }
"INTEGER" { printf("MOT-CLE : INTEGER\n");};
"FLOAT" { printf("MOT-CLE : FLOAT\n");};
"CHAR" { printf("MOT-CLE : CHAR \n");};
"CONST" { printf("MOT-CLE : CONST\n");};
"READ" { printf("MOT-CLE : READ\n");};
"WRITE" { printf("MOT-CLE : WRITE\n");};
"IF" { printf("MOT-CLE : IF\n");};
"ELSE" { printf("MOT-CLE : ELSE\n");};
"FOR" { printf("MOT-CLE : FOR\n");};

[A-Z][a-z0-9]{0,7} {printf("IDF : %s\n",yytext);};
"("[-+][0-9]+\.[0-9]+")" {printf("Constante reele signee : %s\n",yytext);}
[0-9]+\.[0-9]+ {printf("Constante reele non signee : %s\n",yytext);}
"("[-+][0-9]+")" { const_entiere = atoi(yytext) ; if (const_entiere >= -32768 && const_entiere <= 32767) {printf("Constante entiere signee : %s\n",yytext);}else { printf("valeur incorrecte!");}}/*plus tard akhdem b yyerror*/
[0-9]+ { const_entiere = atoi(yytext) ; if (const_entiere >= -32768 && const_entiere <= 32767) {printf("Constante entiere non signee : %s\n",yytext);}else { printf("valeur incorrecte!");}}/* (constante reele signee mahich bin a9was)*/

[+\-*/] {printf("OPERATEUR ARITHMITIQUE : %s\n" , yytext);};//op_arthmitique
(&&|\|\||!) {printf("OPERATEUR LOGIQUE : %s\n",yytext);};//op_logique
"%%"[^\n]* {}; /* regx définie veut dire tous les mots qui commencents par %% et suivis par tous les caractéres sauf le saut de ligne  */
 /*tabulations sont ignorées*/
[ \t] {} 
\n {ligne++;}
[{};,()] { printf("SEPARATEUR : %s\n",yytext);};
">"   { printf("OP_COMP : %s \n", yytext); }
"<"   { printf("OP_COMP : %s \n", yytext); }
">="  { printf("OP_COMP : %s \n", yytext); }
"<="  { printf("OP_COMP : %s \n", yytext); }
"=="  { printf("OP_COMP : %s \n", yytext); }
"!="  { printf("OP_COMP : %s \n", yytext); }

. { printf("Erreur lexicale a la ligne %d  , Caractere %s non reconnu \n", ligne , yytext);};
%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Erreur d'ouverture du fichier");
            return 1;
        }
    }

    yylex(); // Call the lexical analyzer

    if (yyin) {
        fclose(yyin);
    }

    return 0;
}