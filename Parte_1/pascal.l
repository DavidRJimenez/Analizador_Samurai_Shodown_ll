%{
#include <math.h>
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%%
{DIGIT}+    { printf("Un enteró: %s (%d)\n", yytext, atoi(yytext)); }
{DIGIT}+"."{DIGIT}*  { printf("Un flotante: %s (%g)\n", yytext, atof(yytext)); }
if|then|begin|end|procedure|function  { printf("Palabra clave: %s\n", yytext); }
{ID}        { printf("Identificador: %s\n", yytext); }
"+"|"-"|"*"|"/"   { printf("Un operador: %s\n", yytext); }
"{"[^{}\n]*"}"     /* Ignora comentarios de una línea */
[ \t\n]+          /* Ignora espacios en blanco */
.           { printf("Carácter no reconocido: %s\n", yytext); }
%%

int main(int argc, char **argv) {
    if (argc > 1) 
        yyin = fopen(argv[1], "r");
    else
        yyin = stdin;
    yylex();
    return 0;
}
