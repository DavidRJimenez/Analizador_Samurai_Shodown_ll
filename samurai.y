%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;  // Declaración de yyin
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
%token BURLA CANCELAR_BURLA MOV_ESPECIAL
%token POW_MAXIMO

%%

// Reglas de gramática para el combate
combate: seleccion jugadores movimientos { printf("Combate válido\n"); }
       ;

seleccion:
    HAOHMARU NAKORURU { printf("Personajes seleccionados: %s, %s\n", "Haohmaru", "Nakoruru"); }
    | NAKORURU HAOHMARU { printf("Personajes seleccionados: %s, %s\n", "Nakoruru", "Haohmaru"); }
    | HAOHMARU UKYO { printf("Personajes seleccionados: %s, %s\n", "Haohmaru", "Ukyo"); }
    | UKYO HAOHMARU { printf("Personajes seleccionados: %s, %s\n", "Ukyo", "Haohmaru"); }
    | CHARLOTTE NAKORURU { printf("Personajes seleccionados: %s, %s\n", "Charlotte", "Nakoruru"); }
    | NAKORURU CHARLOTTE { printf("Personajes seleccionados: %s, %s\n", "Nakoruru", "Charlotte"); }
    ;

jugadores: HAOHMARU NAKORURU
         | NAKORURU HAOHMARU
         | HAOHMARU CHARLOTTE
         | CHARLOTTE HAOHMARU
         | NAKORURU CHARLOTTE
         | CHARLOTTE NAKORURU
         ;

movimientos:
    movimiento { /* Aquí se reconoce el movimiento */ }
    | movimiento movimientos
    ;

movimiento:
    CORTE_DEBIL       { printf("Movimiento reconocido: Corte Débil\n"); }
    | CORTE_MEDIO     { printf("Movimiento reconocido: Corte Medio\n"); }
    | CORTE_FUERTE    { printf("Movimiento reconocido: Corte Fuerte\n"); }
    | PATADA_DEBIL    { printf("Movimiento reconocido: Patada Débil\n"); }
    | PATADA_MEDIA     { printf("Movimiento reconocido: Patada Media\n"); }
    | PATADA_FUERTE   { printf("Movimiento reconocido: Patada Fuerte\n"); }
    | SALTO           { printf("Movimiento reconocido: Salto\n"); }
    | DERECHA         { printf("Movimiento reconocido: Derecha\n"); }
    | IZQUIERDA       { printf("Movimiento reconocido: Izquierda\n"); }
    | AGACHARSE       { printf("Movimiento reconocido: Agacharse\n"); }
    | CORRER          { printf("Movimiento reconocido: Correr\n"); }
    | RETIRADA        { printf("Movimiento reconocido: Retirada\n"); }
    | ESQUIVAR        { printf("Movimiento reconocido: Esquivar\n"); }
    | RODAR           { printf("Movimiento reconocido: Rodar\n"); }
    | BURLA           { printf("Movimiento reconocido: Burla\n"); }
    | CANCELAR_BURLA  { printf("Movimiento reconocido: Cancelar Burla\n"); }
    | MOV_ESPECIAL    { printf("Movimiento reconocido: Especial\n"); }
    | error { yyerror("Movimiento no reconocido"); }
    ;

%%

// Función para manejar errores
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
        yyin = archivo;  // Asignar el archivo de entrada
    }

    yyparse();  // Llama al analizador sintáctico
    return 0;
}