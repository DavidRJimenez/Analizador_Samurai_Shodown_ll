%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;

#define YYSTYPE char*

// Función auxiliar para concatenar cadenas de forma segura
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

// Barras de vida para los personajes
int vida_1 = 100; // Barra de vida del jugador 1
int vida_2 = 100; // Barra de vida del jugador 2

void aplicar_dano(const char *accion, int *vida) {
    if (strcmp(accion, "Corte Débil") == 0) {
        *vida -= 10;
    } else if (strcmp(accion, "Corte Medio") == 0) {
        *vida -= 15;
    } else if (strcmp(accion, "Corte Fuerte") == 0) {
        *vida -= 20;
    } else if (strcmp(accion, "Patada Débil") == 0) {
        *vida -= 8;
    } else if (strcmp(accion, "Patada Media") == 0) {
        *vida -= 12;
    } else if (strcmp(accion, "Patada Fuerte") == 0) {
        *vida -= 18;
    } else if (strcmp(accion, "Especial con Poder Máximo") == 0) {
        *vida -= 30;
    }
}
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
            // Muestra la vida final de ambos personajes
            printf("Vida de %s: %d\n", $1, vida_1);
            printf("Vida de %s: %d\n", $2, vida_2);

        }
       ;

jugadores: personaje personaje {
                if (strcmp($1, $2) == 0) {
                    yyerror("Error: Los personajes no pueden ser los mismos.");
                    YYERROR;
                } else {
                    printf("Personajes seleccionados: %s, %s\n", $1, $2);
                    // Asignar vida según el personaje
                    if (strcmp($1, "Haohmaru") == 0) {
                        vida_1 = 100;
                    } else if (strcmp($1, "Nakoruru") == 0) {
                        vida_1 = 100;
                    } 
                    // Agregar más personajes aquí
                    if (strcmp($2, "Haohmaru") == 0) {
                        vida_2 = 100;
                    } else if (strcmp($2, "Nakoruru") == 0) {
                        vida_2 = 100;
                    } 
                    // Agregar más personajes aquí
                }
                // Asegúrate de asignar correctamente los nombres de los personajes
                $$ = concat($1, $2); // Asigna el nombre de ambos personajes
            }

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

movimientos: movimiento { 
                $$ = strdup($1); // Asigna memoria para la primera cadena
            }
           | movimientos movimiento { 
                char *temp = malloc(strlen($1) + strlen($2) + 1); // Asegúrate de tener suficiente espacio
                if (temp) {
                    strcpy(temp, $1); // Copia la primera cadena
                    strcat(temp, $2); // Concatena la segunda cadena
                    free($1); // Libera la memoria de la primera cadena
                    $$ = temp; // Asigna la nueva cadena concatenada
                } else {
                    yyerror("Error de memoria");
                    YYERROR;
                }
            }
           ;

movimiento: MOVIMIENTO accion { 
                // Aplicar daño al jugador 1
                aplicar_dano($2, &vida_1); 
                $$ = $2; 
            }
          ;

accion: CORTE_DEBIL direccion { 
            char *temp = malloc(strlen("Corte Débil ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Corte Débil ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | CORTE_MEDIO direccion { 
            char *temp = malloc(strlen("Corte Medio ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Corte Medio ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | CORTE_FUERTE direccion { 
            char *temp = malloc(strlen("Corte Fuerte ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Corte Fuerte ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | PATADA_DEBIL direccion { 
            char *temp = malloc(strlen("Patada Débil ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Patada Débil ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | PATADA_MEDIA direccion { 
            char *temp = malloc(strlen("Patada Media ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Patada Media ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | PATADA_FUERTE direccion { 
            char *temp = malloc(strlen("Patada Fuerte ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Patada Fuerte ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | SALTO direccion { 
            char *temp = malloc(strlen("Salto ") + strlen($2) + 1);
            if (temp) {
                strcpy(temp, "Salto ");
                strcat(temp, $2);
                $$ = temp; // Asigna la cadena concatenada a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      | MOV_ESPECIAL POW_MAXIMO direccion{ 
            char *temp = malloc(strlen("Especial con Poder Máximo") + 1);
            if (temp) {
                strcpy(temp, "Especial con Poder Máximo");
                $$ = temp; // Asigna la cadena a $$
            } else {
                yyerror("Error de memoria");
                YYERROR;
            }
        }
      ;

direccion: DERECHA { $$ = "derecha"; }
         | IZQUIERDA { $$ = "izquierda"; }
         | AGACHARSE { $$ = "agachado"; }
         | CORRER { $$ = "corriendo"; }
         | RETIRADA { $$ = "retirándose"; }
         | ESQUIVAR { $$ = "esquivando"; }
         | RODAR { $$ = "rodando"; }
         ;

%%
int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error al abrir el archivo\n");
            return 1;
        }
    }
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
