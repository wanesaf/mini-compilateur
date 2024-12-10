#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct element *TS;
typedef struct element
{
    char nom[20];
    int type;
    int nature;
    char value[20];
    TS suivant;
} element;

TS symbolTable = NULL; // la table doit etre vide au début

// fonction de recherche

TS rechercher(char nom[])
{
    TS p = symbolTable;
    while (p != NULL && strcmp(p->nom, nom) != 0)
    {
        p = p->suivant; // on avance car il n'existe pas ; 
    }
    return p; // on retourne car la condition n'est pas vérifiée donc il existe
}

int insertion(char nom[20], int type, int nature)
{

    if (!rechercher(nom)) // si l'element n'existe pas donc on le insere
    {
        TS newElement = (TS)malloc(sizeof(element));
        newElement->type = type;
        newElement->nature = nature;
        strcpy(newElement->nom, nom);
        newElement->suivant = symbolTable;
        symbolTable = newElement;
        printf("%s", newElement->nom);
        printf("%d", newElement->nature);
        printf("%d", newElement->type);
        return 1;
    }
    else
    {
        printf("Error ! ,il n'est pas inséré"); // il existe -> pas necessaire donc de l'ajouter
        return 0;
    }
}

void InsererNouvValeur(char val[], char t[])
{
    TS p = rechercher(t); // on recherche l'élement 
    strcpy(p->value, val);// on copie la nouvelle valeur
}


int recevoirValeur(char t[])
{
    TS p = rechercher(t);
    return atoi(p->value);
}

int recevoirType(char t[])
{
    TS p = rechercher(t);
    if (p)
    {
        return p->type;
    }
    else
    {
        return -1;
    }
}


int verif_compatiblite(int type1, int type2)
{
    if (type1 != type2)
    {
        return 0;
    }
    return 1;
}

int verif_declarat(char name[20])
{

    TS x = rechercher(name);
    if (x != NULL)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

int modification_cst(char name[20])
{
    TS x = rechercher(name);
    if (x->nature == 1)
    {

        return 0;
    }
    return 1;
}

int division_par_zero(char entite[])
{
    TS x = rechercher(entite);
    if (x->value == 0)
    {
        return 0;
    }
    return 1;
}
