%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);
int yylex();
extern FILE *yyin;
#define YYSTYPE char*
%}

// Definir tokens
%token HAOHMARU NAKORURU UKYO CHARLOTTE GALFORD
%token JUBEI TERREMOTO HANZO KYOSHIRO WAN_FU
%token GENAN GENJURO CHAMCHAM NEINHALT_SIEGER
%token NICOTINE KUROKO MIZUKI
%token CORTE_DEBIL CORTE_MEDIO CORTE_FUERTE
%token PATADA_DEBIL PATADA_MEDIA PATADA_FUERTE
%token SALTO DERECHA IZQUIERDA AGACHARSE
%token CORRER RETIRADA ESQUIVAR RODAR
%token BURLA CANCELAR_BURLA MOV_ESPECIAL POW_MAXIMO
%token NEWLINE MOVIMIENTO FIN_MOVIMIENTOS

%left CORTE_DEBIL CORTE_MEDIO CORTE_FUERTE
%left PATADA_DEBIL PATADA_MEDIA PATADA_FUERTE
%left SALTO DERECHA IZQUIERDA AGACHARSE
%left CORRER RETIRADA ESQUIVAR RODAR
%left BURLA CANCELAR_BURLA MOV_ESPECIAL POW_MAXIMO

%%

combate: jugadores NEWLINE movimientos FIN_MOVIMIENTOS { printf("Movimientos reconocidos: %s\n", $3); printf("Combate válido\n"); }

       ;


jugadores: HAOHMARU NAKORURU { printf("Personajes seleccionados: %s, %s\n", "Haohmaru", "Nakoruru"); }

         | NAKORURU HAOHMARU { printf("Personajes seleccionados: %s, %s\n", "Nakoruru", "Haohmaru"); }

         ;


movimientos: movimiento { $$ = $1; }

           | movimientos movimiento { $$ = strcat($1, $2); free($2); }

           | /* empty */ { $$ = strdup(""); }

           ;


movimiento: MOVIMIENTO accion { $$ = $2; }

          ;


accion: CORTE_DEBIL direccion { $$ = strdup("Corte Débil "); $$ = strcat($$, $2); free($2); }

      | CORTE_MEDIO direccion { $$ = strdup("Corte Medio "); $$ = strcat($$, $2); free($2); }

      | CORTE_FUERTE direccion { $$ = strdup("Corte Fuerte "); $$ = strcat($$, $2); free($2); }

      | PATADA_DEBIL direccion { $$ = strdup("Patada Débil "); $$ = strcat($$, $2); free($2); }

      | PATADA_MEDIA direccion { $$ = strdup("Patada Media "); $$ = strcat($$, $2); free($2); }

      | PATADA_FUERTE direccion { $$ = strdup("Patada Fuerte "); $$ = strcat($$, $2); free($2); }

      | MOV_ESPECIAL POW_MAXIMO { $$ = strdup("Especial con Poder Máximo"); }

      ;


direccion: DERECHA { $$ = strdup("a la derecha"); }

         | IZQUIERDA { $$ = strdup("a la izquierda"); }

         ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *archivo = fopen(argv[1], "r");
        if (!archivo) {
            perror("Error al abrir el archivo");
            return 1;
        }
        yyin = archivo;
    }
    yyparse();
    return 0;
}
