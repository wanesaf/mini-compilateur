flex lexical.l
bison -d syntaxic.y
gcc lex.yy.c syntaxic.tab.c
./a.exe