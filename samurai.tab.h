/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SAMURAI_TAB_H_INCLUDED
# define YY_YY_SAMURAI_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    HAOHMARU = 258,                /* HAOHMARU  */
    NAKORURU = 259,                /* NAKORURU  */
    UKYO = 260,                    /* UKYO  */
    CHARLOTTE = 261,               /* CHARLOTTE  */
    GALFORD = 262,                 /* GALFORD  */
    JUBEI = 263,                   /* JUBEI  */
    TERREMOTO = 264,               /* TERREMOTO  */
    HANZO = 265,                   /* HANZO  */
    KYOSHIRO = 266,                /* KYOSHIRO  */
    WAN_FU = 267,                  /* WAN_FU  */
    GENAN = 268,                   /* GENAN  */
    GENJURO = 269,                 /* GENJURO  */
    CHAMCHAM = 270,                /* CHAMCHAM  */
    NEINHALT_SIEGER = 271,         /* NEINHALT_SIEGER  */
    NICOTINE = 272,                /* NICOTINE  */
    KUROKO = 273,                  /* KUROKO  */
    MIZUKI = 274,                  /* MIZUKI  */
    CORTE_DEBIL = 275,             /* CORTE_DEBIL  */
    CORTE_MEDIO = 276,             /* CORTE_MEDIO  */
    CORTE_FUERTE = 277,            /* CORTE_FUERTE  */
    PATADA_DEBIL = 278,            /* PATADA_DEBIL  */
    PATADA_MEDIA = 279,            /* PATADA_MEDIA  */
    PATADA_FUERTE = 280,           /* PATADA_FUERTE  */
    SALTO = 281,                   /* SALTO  */
    DERECHA = 282,                 /* DERECHA  */
    IZQUIERDA = 283,               /* IZQUIERDA  */
    AGACHARSE = 284,               /* AGACHARSE  */
    CORRER = 285,                  /* CORRER  */
    RETIRADA = 286,                /* RETIRADA  */
    ESQUIVAR = 287,                /* ESQUIVAR  */
    RODAR = 288,                   /* RODAR  */
    BURLA = 289,                   /* BURLA  */
    CANCELAR_BURLA = 290,          /* CANCELAR_BURLA  */
    MOV_ESPECIAL = 291,            /* MOV_ESPECIAL  */
    POW_MAXIMO = 292               /* POW_MAXIMO  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SAMURAI_TAB_H_INCLUDED  */
