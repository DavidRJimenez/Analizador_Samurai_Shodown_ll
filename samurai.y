%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int vida_1 = 100; // Barra de vida del jugador 1
int vida_2 = 100; // Barra de vida del jugador 2
char personaje_1[50]; // Nombre del personaje 1
char personaje_2[50]; // Nombre del personaje 2
int turno = 1; // Variable para controlar el turno (1 para jugador 1, 2 para jugador 2)

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yylex();
extern FILE *yyin;

// Definición de tokens
#define YYSTYPE char*

// Declaraciones de funciones
void aplicar_dano(const char *accion, int *vida, int distancia);
int ataque_exitoso(int distancia);
char* concat(const char* str1, const char* str2);
%}

// Definir tokens
%token HAOHMARU NAKORURU UKYO CHARLOTTE GALFORD
%token JUBEI TERREMOTO HANZO KYOSHIRO WAN_FU
%token GENAN GENJURO CHAMCHAM NEINHALT_SIEGER
%token NICOTINE KUROKO MIZUKI
%token CORTE_DEBIL CORTE_MEDIO CORTE_FUERTE PATADA_DEBIL PATADA_MEDIA PATADA_FUERTE
%token SALTO DERECHA IZQUIERDA AGACHARSE CORRER RETIRADA ESQUIVAR RODAR
%token BURLA CANCELAR_BURLA MOV_ESPECIAL POW_MAXIMO NEWLINE MOVIMIENTO FIN_MOVIMIENTOS

%left CORTE_DEBIL CORTE_MEDIO CORTE_FUERTE
%left PATADA_DEBIL PATADA_MEDIA PATADA_FUERTE
%left SALTO DERECHA IZQUIERDA AGACHARSE
%left CORRER RETIRADA ESQUIVAR RODAR
%left BURLA CANCELAR_BURLA MOV_ESPECIAL POW_MAXIMO

%%

combate: jugadores NEWLINE movimientos FIN_MOVIMIENTOS {
            printf("Movimientos reconocidos: %s\n", $3);
            printf("Combate válido\n");
            printf("Vida de %s: %d\n", personaje_1, vida_1);
            printf("Vida de %s: %d\n", personaje_2, vida_2);
            if (vida_1 <= 0 && vida_2 <= 0) {
                printf("Empate: ambos jugadores han llegado a 0 de vida.\n");
            } else if (vida_1 <= 0) {
                printf("El ganador es %s.\n", personaje_2);
            } else if (vida_2 <= 0) {
                printf("El ganador es %s.\n", personaje_1);
            } else {
                printf("Ningún jugador ha llegado a 0, no hay ganador.\n");
            }
            free($3); // Liberar memoria de movimientos
        }
       ;

jugadores: personaje personaje {
                if (strcmp($1, $2) == 0) {
                    yyerror("Error: Los personajes no pueden ser los mismos.");
                    YYERROR;
                } else {
                    printf("Personajes seleccionados: %s, %s\n", $1, $2);
                    strcpy(personaje_1, $1);
                    strcpy(personaje_2, $2);
                }
            }
         ;

personaje: HAOHMARU { $$ = "Haohmaru"; }
         | NAKORURU { $$ = "Nakoruru"; }
         | UKYO { $$ = "Ukyo"; }
         | CHARLOTTE { $$ = "Charlotte"; }
         | GALFORD { $$ = "Galford"; }
         | JUBEI { $$ = "Jubei"; }
         | TERREMOTO { $$ = "Terremoto"; }
         | HANZO { $$ = "Hanzo"; }
         | KYOSHIRO { $$ = "Kyoshiro"; }
         | WAN_FU { $$ = "Wan-Fu"; }
         | GENAN { $$ = "Genan"; }
         | GENJURO { $$ = "Genjuro"; }
         | CHAMCHAM { $$ = "Cham Cham"; }
         | NEINHALT_SIEGER { $$ = "Neinhalt Sieger"; }
         | NICOTINE { $$ = "Nicotine"; }
         | KUROKO { $$ = "Kuroko"; }
         | MIZUKI { $$ = "Mizuki"; }
         ;

movimientos: movimiento { $$ = strdup($1); }
           | movimientos movimiento {
                char* temp = concat($1, $2);
                free($1);
                $$ = temp;
            }
           ;

movimiento: MOVIMIENTO accion {
    int distancia = rand() % 2; // Generar distancia aleatoria (0 o 1)
    if (turno == 1) {
        aplicar_dano($2, &vida_2, distancia); // Aplicar daño al jugador 2
        turno = 2; // Cambiar el turno al jugador 2
    } else {
        aplicar_dano($2, &vida_1, distancia); // Aplicar daño al jugador 1
        turno = 1; // Cambiar el turno al jugador 1
    }
    $$ = strdup($2);
}

accion: CORTE_DEBIL direccion { $$ = concat("Corte Débil ", $2); free($2); }
      | CORTE_MEDIO direccion { $$ = concat("Corte Medio ", $2); free($2); }
      | CORTE_FUERTE direccion { $$ = concat("Corte Fuerte ", $2); free($2); }
      | PATADA_DEBIL direccion { $$ = concat("Patada Débil ", $2); free($2); }
      | PATADA_MEDIA direccion { $$ = concat("Patada Media ", $2); free($2); }
      | PATADA_FUERTE direccion { $$ = concat("Patada Fuerte ", $2); free($2); }
      | SALTO direccion { $$ = concat("Salto ", $2); free($2); }
      | MOV_ESPECIAL POW_MAXIMO direccion { $$ = strdup("Especial con Poder Máximo"); }
      ;

direccion: DERECHA { $$ = strdup("derecha"); }
         | IZQUIERDA { $$ = strdup("izquierda"); }
         ;

%%

// Código C adicional
char* concat(const char* str1, const char* str2) {
    size_t len1 = strlen(str1);
    size_t len2 = strlen(str2);
    char* result = (char*) malloc(len1 + len2 + 1);
    if (!result) {
        fprintf(stderr, "Error de memoria\n");
        exit(1);
    }
    strcpy(result, str1);
    strcat(result, str2);
    return result;
}

void aplicar_dano(const char *accion, int *vida, int distancia) {
    printf("Distancia para el ataque '%s': %d\n", accion, distancia); // Imprimir distancia
    int danio = 0;

    // Asignar daño basado en la acción
    if (strcmp(accion, "Corte Débil derecha") == 0 || strcmp(accion, "Corte Débil izquierda") == 0) {
        danio = 10;
    } else if (strcmp(accion, "Corte Medio derecha") == 0 || strcmp(accion, "Corte Medio izquierda") == 0) {
        danio = 15;
    } else if (strcmp(accion, "Corte Fuerte derecha") == 0 || strcmp(accion, "Corte Fuerte izquierda") == 0) {
        danio = 20;
    } else if (strcmp(accion, "Patada Débil derecha") == 0 || strcmp(accion, "Patada Débil izquierda") == 0) {
        danio = 8;
    } else if (strcmp(accion, "Patada Media derecha") == 0 || strcmp(accion, "Patada Media izquierda") == 0) {
        danio = 12;
    } else if (strcmp(accion, "Patada Fuerte derecha") == 0 || strcmp(accion, "Patada Fuerte izquierda") == 0) {
        danio = 18;
    } else if (strcmp(accion, "Especial con Poder Máximo") == 0) {
        danio = 30;
    }

    // Solo aplicar daño si el ataque es exitoso
    if (ataque_exitoso(distancia)) {
        *vida -= danio; // Aplicar daño
        if (*vida < 0) {
            *vida = 0; // Evitar valores negativos en la vida
        }
        printf("Ataque exitoso: %s inflige %d puntos de daño.\n", accion, danio);
    } else {
        printf("Ataque fallido: %s no golpea.\n", accion);
    }
}


int ataque_exitoso(int distancia) {
    return distancia == 1; // El ataque tiene éxito si la distancia es 1
}

int main(int argc, char **argv) {
    srand(time(NULL)); // Sembrar el generador de números aleatorios
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error al abrir el archivo\n");
            return 1;
        }
    }
    return yyparse();
}
