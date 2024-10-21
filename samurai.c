#include "samurai.h"
#include <math.h>

Jugador* crear_jugador(char* nombre, int posicion_inicial) {
    Jugador* jugador = (Jugador*)malloc(sizeof(Jugador));
    if (jugador == NULL) {
        return NULL;
    }
    jugador->nombre = strdup(nombre);
    jugador->vida = MAX_VIDA;
    jugador->poder = 0;
    jugador->posicion = posicion_inicial;
    jugador->pow_maximo = false;
    return jugador;
}

void actualizar_poder(Jugador* jugador, int cantidad) {
    jugador->poder += cantidad;
    if (jugador->poder >= MAX_PODER) {
        jugador->poder = MAX_PODER;
        jugador->pow_maximo = true;
    }
}

void recibir_danio(Jugador* jugador, int danio) {
    jugador->vida -= danio;
    if (jugador->vida < 0) {
        jugador->vida = 0;
    }
}

bool esta_vivo(Jugador* jugador) {
    return jugador->vida > 0;
}

float calcular_probabilidad_ataque(Jugador* atacante, Jugador* defensor) {
    int distancia = abs(atacante->posicion - defensor->posicion);
    
    if (distancia <= 2) {
        return 1.0;
    } else if (distancia <= 4) {
        return 0.5;
    }
    return 0.0;
}

void mover_jugador(Jugador* jugador, int direccion) {
    jugador->posicion += direccion;
    if (jugador->posicion < 0) {
        jugador->posicion = 0;
    } else if (jugador->posicion > MAX_DISTANCIA) {
        jugador->posicion = MAX_DISTANCIA;
    }
}

void realizar_ataque(Jugador* atacante, Jugador* defensor, int tipo_ataque) {
    float prob = calcular_probabilidad_ataque(atacante, defensor);
    float random = (float)rand() / RAND_MAX;
    
    if (random <= prob) {
        int danio = 0;
        switch(tipo_ataque) {
            case 1: danio = 5; break;  // CORTE_DEBIL
            case 2: danio = 10; break; // CORTE_MEDIO
            case 3: danio = 15; break; // CORTE_FUERTE
            case 4: danio = 3; break;  // PATADA_DEBIL
            case 5: danio = 7; break;  // PATADA_MEDIA
            case 6: danio = 12; break; // PATADA_FUERTE
            case 7: // MOV_ESPECIAL
                if (atacante->pow_maximo) {
                    danio = 30;
                    atacante->poder = 0;
                    atacante->pow_maximo = false;
                }
                break;
        }
        recibir_danio(defensor, danio);
        actualizar_poder(atacante, 5);
    }
}
