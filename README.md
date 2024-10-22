# Analizador de Combates de Samurai Shodown II

Este proyecto es un analizador sintáctico para simular combates en el juego *Samurai Shodown II*, desarrollado con Flex y Bison. El programa procesa un archivo de texto que describe el combate entre dos personajes, determinando el daño infligido en cada movimiento y calculando la vida restante de cada personaje al finalizar.

## Estructura del Proyecto

El proyecto consta de los siguientes archivos:
- `samurai.l`: archivo de Flex para el análisis léxico, define los tokens correspondientes a los personajes y movimientos del juego.
- `samurai.y`: archivo de Bison para el análisis sintáctico, define las reglas de gramática, la lógica del combate y el manejo de las vidas de los personajes.

## Cómo Funciona

### Descripción del Combate

Un archivo de combate sigue este formato:

1. **Personajes:** Dos personajes deben ser especificados, uno para cada jugador. No se permite que ambos sean el mismo personaje.
2. **Movimientos:** Una lista de movimientos con sus respectivas direcciones y acciones, seguida de `FIN_MOVIMIENTOS` para indicar el final.
3. **Ejemplo de archivo de combate (`combate.txt`):**

    ```plaintext
    Haohmaru Nakoruru
    MOVIMIENTO CORTE_MEDIO derecha
    MOVIMIENTO CORTE_FUERTE izquierda
    MOVIMIENTO PATADA_FUERTE derecha
    MOVIMIENTO MOV_ESPECIAL POW_MAXIMO derecha
    FIN_MOVIMIENTOS
    ```

El programa lee el archivo línea por línea, interpretando cada movimiento y calculando el daño infligido al oponente, dependiendo del tipo de ataque, dirección y la "cercanía" simulada (aleatoria) entre los personajes.

### Análisis de Movimientos y Combate

1. **Tokens:** Los movimientos y direcciones son reconocidos como tokens definidos en el archivo `samurai.l`. Los personajes, movimientos y direcciones válidas están predefinidos en el archivo.
2. **Distancia Aleatoria:** En cada movimiento, se simula una distancia aleatoria (0 o 1). El ataque es exitoso si la distancia es 1.
3. **Daño Aplicado:** Si el ataque es exitoso, se aplica un daño fijo al oponente dependiendo del tipo de ataque:
   - **Corte Débil:** 10 puntos de daño.
   - **Corte Medio:** 15 puntos de daño.
   - **Corte Fuerte:** 20 puntos de daño.
   - **Patada Débil:** 8 puntos de daño.
   - **Patada Media:** 12 puntos de daño.
   - **Patada Fuerte:** 18 puntos de daño.
   - **Especial con Poder Máximo:** 30 puntos de daño.

### Alternancia de Turnos

Los jugadores atacan por turnos alternos:
- En el primer movimiento, el jugador 1 ataca al jugador 2.
- En el siguiente movimiento, el jugador 2 ataca al jugador 1.
- Esto continúa alternándose hasta el final del combate.

### Resultado del Combate

Al final del análisis, el programa muestra las vidas restantes de ambos personajes y determina el resultado:
- Si ambos personajes tienen vida mayor a 0, no hay ganador.
- Si uno de los personajes tiene vida menor o igual a 0, el otro personaje es declarado ganador.
- Si ambos tienen vida igual a 0, el combate termina en empate.

## Instrucciones para Compilar y Ejecutar

### Requisitos

- Flex
- Bison
- Compilador de C (por ejemplo, GCC)

### Pasos para Compilar y Ejecutar

1. **Compilar los archivos de Flex y Bison:**
   ```bash
   flex samurai.l
   bison -d samurai.y
   gcc -o samurai lex.yy.c samurai.tab.c -lfl
   
   Ejemplo de ejecucion: ./samurai Combates/combate4.txt

Este codigo fue generado por: David Jimenez, Franco Comas y Cesar Martinez, siendo un reto muy interesante para nosotros asi como complicado, usamos o pensamos en referencias del Mortal Kombat tambien puesto que era un juego de lucha para poder llevar a cabo el codigo.


Link del repositorio: https://github.com/DavidRJimenez/Analizador_Samurai_Shodown_ll


vale aclarar que esta en la linea o rama feat/Valido, dejamos las otras ramas porque fueron cosas que intentamos desde hace 2 semanas o mas, pero no funcionaron.

Yo se que el profe sabrá cambiar de rama, pero por si las dudas para cualquier otra persona, al clonar el github, se debe usar el comando:

      ```bash
      git switch feat/Valido

      Gracias por todo:)

    

### Nota importante
no dejar el txt con un espacio al final puesto que puede salir un error, puesto que el programa esta pensado para que lo ultimo que lea sea FIN_MOVIMIENTOS