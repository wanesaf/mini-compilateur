flex lexical.l
bison -d syntaxic2.y
gcc lex.yy.c syntaxic2.tab.c
./a.exe