%{
#include "samurai.tab.h"
%}

%%

"Haohmaru"            { return HAOHMARU; }
"Nakoruru"            { return NAKORURU; }
"Ukyo"                { return UKYO; }
"Charlotte"           { return CHARLOTTE; }
"Galford"             { return GALFORD; }
"Jubei"               { return JUBEI; }
"Terremoto"           { return TERREMOTO; }
"Hanzo"               { return HANZO; }
"Kyoshiro"            { return KYOSHIRO; }
"Wan-Fu"              { return WAN_FU; }
"Genan"               { return GENAN; }
"Genjuro"             { return GENJURO; }
"Cham Cham"           { return CHAMCHAM; }
"Neinhalt Sieger"     { return NEINHALT_SIEGER; }
"Nicotine"            { return NICOTINE; }
"Kuroko"              { return KUROKO; }
"Mizuki"              { return MIZUKI; }

"A"                   { return CORTE_DEBIL; }
"B"                   { return CORTE_MEDIO; }
"AB"                  { return CORTE_FUERTE; }
"C"                   { return PATADA_DEBIL; }
"D"                   { return PATADA_MEDIA; }
"CD"                  { return PATADA_FUERTE; }

"up"                  { return SALTO; }
"right"               { return DERECHA; }
"left"                { return IZQUIERDA; }
"down"                { return AGACHARSE; }
"run_right"           { return CORRER; }
"retreat"             { return RETIRADA; }
"dodge"               { return ESQUIVAR; }
"roll_left"           { return RODAR; }
"roll_right"          { return RODAR; }
"taunt"               { return BURLA; }
"cancel_taunt"       { return CANCELAR_BURLA; }

"special"             { return MOV_ESPECIAL; }
"pow_max"             { return POW_MAXIMO; }

[ \t\n]+              { /* Ignorar espacios y saltos de línea */ }

.                     { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
