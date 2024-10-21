%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "samurai.h"
void yyerror(const char *s);
int yylex();
extern FILE *yyin;
Jugador *jugador1 = NULL;
Jugador *jugador2 = NULL;
#define YYSTYPE char*
%}

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

%%
combate: jugadores NEWLINE lista_movimientos FIN_MOVIMIENTOS {
    printf("Estado final del combate:\n");
    printf("%s - Vida: %d, Poder: %d, Posición: %d\n", 
           jugador1->nombre, jugador1->vida, jugador1->poder, jugador1->posicion);
    printf("%s - Vida: %d, Poder: %d, Posición: %d\n", 
           jugador2->nombre, jugador2->vida, jugador2->poder, jugador2->posicion);
}
;

jugadores: HAOHMARU NAKORURU {
    jugador1 = crear_jugador("Haohmaru", 0);
    jugador2 = crear_jugador("Nakoruru", MAX_DISTANCIA);
    printf("Combate iniciado: %s vs %s\n", jugador1->nombre, jugador2->nombre);
}
| NAKORURU HAOHMARU {
    jugador1 = crear_jugador("Nakoruru", 0);
    jugador2 = crear_jugador("Haohmaru", MAX_DISTANCIA);
    printf("Combate iniciado: %s vs %s\n", jugador1->nombre, jugador2->nombre);
}
;

lista_movimientos: /* empty */
| lista_movimientos movimiento
;

movimiento: MOVIMIENTO accion NEWLINE
;

accion: CORTE_DEBIL direccion {
    realizar_ataque(jugador1, jugador2, 1);
}
| CORTE_MEDIO direccion {
    realizar_ataque(jugador1, jugador2, 2);
}
| CORTE_FUERTE direccion {
    realizar_ataque(jugador1, jugador2, 3);
}
| PATADA_DEBIL direccion {
    realizar_ataque(jugador1, jugador2, 4);
}
| PATADA_MEDIA direccion {
    realizar_ataque(jugador1, jugador2, 5);
}
| PATADA_FUERTE direccion {
    realizar_ataque(jugador1, jugador2, 6);
}
| MOV_ESPECIAL POW_MAXIMO {
    realizar_ataque(jugador1, jugador2, 7);
}
;

direccion: DERECHA {
    mover_jugador(jugador1, 1);
}
| IZQUIERDA {
    mover_jugador(jugador1, -1);
}
;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    srand(time(NULL));
    
    if (argc > 1) {
        FILE *archivo = fopen(argv[1], "r");
        if (!archivo) {
            perror("Error al abrir el archivo");
            return 1;
        }
        yyin = archivo;
    }
    
    yyparse();
    
    if (jugador1) free(jugador1);
    if (jugador2) free(jugador2);
    
    return 0;
}

