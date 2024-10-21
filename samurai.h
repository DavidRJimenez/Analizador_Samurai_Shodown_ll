/// samurai.h
#ifndef SAMURAI_H
#define SAMURAI_H

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_VIDA 100
#define MAX_PODER 100
#define MAX_DISTANCIA 10

typedef struct {
    char* nombre;
    int vida;
    int poder;
    int posicion;
    bool pow_maximo;
} Jugador;

// Prototipos de funciones
Jugador* crear_jugador(char* nombre, int posicion_inicial);
void actualizar_poder(Jugador* jugador, int cantidad);
void recibir_danio(Jugador* jugador, int danio);
bool esta_vivo(Jugador* jugador);
float calcular_probabilidad_ataque(Jugador* atacante, Jugador* defensor);
void mover_jugador(Jugador* jugador, int direccion);
void realizar_ataque(Jugador* atacante, Jugador* defensor, int tipo_ataque);

#endif  // SAMURAI_H

