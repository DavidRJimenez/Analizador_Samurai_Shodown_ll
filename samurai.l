%{
#include "samurai.tab.h"
%}

%%
"Haohmaru"            { printf("Token HAOHMARU\n"); return HAOHMARU; }
"Nakoruru"            { printf("Token NAKORURU\n"); return NAKORURU; }
"Ukyo"                { printf("Token UKYO\n"); return UKYO; }
"Charlotte"           { printf("Token CHARLOTTE\n"); return CHARLOTTE; }
"Galford"             { printf("Token GALFORD\n"); return GALFORD; }
"Jubei"               { printf("Token JUBEI\n"); return JUBEI; }
"Terremoto"           { printf("Token TERREMOTO\n"); return TERREMOTO; }
"Hanzo"               { printf("Token HANZO\n"); return HANZO; }
"Kyoshiro"            { printf("Token KYOSHIRO\n"); return KYOSHIRO; }
"Wan-Fu"              { printf("Token WAN_FU\n"); return WAN_FU; }
"Genan"               { printf("Token GENAN\n"); return GENAN; }
"Genjuro"             { printf("Token GENJURO\n"); return GENJURO; }
"Cham Cham"           { printf("Token CHAMCHAM\n"); return CHAMCHAM; }
"Neinhalt Sieger"     { printf("Token NEINHALT_SIEGER\n"); return NEINHALT_SIEGER; }
"Nicotine"            { printf("Token NICOTINE\n"); return NICOTINE; }
"Kuroko"              { printf("Token KUROKO\n"); return KUROKO; }
"Mizuki"              { printf("Token MIZUKI\n"); return MIZUKI; }
"CORTE_DEBIL"         { printf("Token CORTE_DEBIL\n"); return CORTE_DEBIL; }
"CORTE_MEDIO"         { printf("Token CORTE_MEDIO\n"); return CORTE_MEDIO; }
"CORTE_FUERTE"        { printf("Token CORTE_FUERTE\n"); return CORTE_FUERTE; }
"PATADA_DEBIL"        { printf("Token PATADA_DEBIL\n"); return PATADA_DEBIL; }
"PATADA_MEDIA"        { printf("Token PATADA_MEDIA\n"); return PATADA_MEDIA; }
"PATADA_FUERTE"       { printf("Token PATADA_FUERTE\n"); return PATADA_FUERTE; }
"SALTO"               { printf("Token SALTO\n"); return SALTO; }
"derecha\n"           { printf("Token DERECHA\n"); return DERECHA; }
"izquierda\n"         { printf("Token IZQUIERDA\n"); return IZQUIERDA; }
"AGACHARSE"           { printf("Token AGACHARSE\n"); return AGACHARSE; }
"CORRER"              { printf("Token CORRER\n"); return CORRER; }
"RETIRADA"            { printf("Token RETIRADA\n"); return RETIRADA; }
"ESQUIVAR"           { printf("Token ESQUIVAR\n"); return ESQUIVAR; }
"RODAR"               { printf("Token RODAR\n"); return RODAR; }
"BURLA"               { printf("Token BURLA\n"); return BURLA; }
"CANCELAR_BURLA"      { printf("Token CANCELAR_BURLA\n"); return CANCELAR_BURLA; }
"MOV_ESPECIAL"        { printf("Token MOV_ESPECIAL\n"); return MOV_ESPECIAL; }
"POW_MAXIMO"          { printf("Token POW_MAXIMO\n"); return POW_MAXIMO; }
"MOVIMIENTO"          { printf("Token MOVIMIENTO\n"); return MOVIMIENTO; }
"FIN_MOVIMIENTOS"     { printf("Token FIN_MOVIMIENTOS\n"); return FIN_MOVIMIENTOS; }

"\n"                  { printf("Token NEWLINE\n"); return NEWLINE; }
[ \t]+                { /* Ignorar espacios */ }
%%
int yywrap() {
    return 1;
}