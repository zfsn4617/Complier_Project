/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_SRC_MAIN_TAB_H_INCLUDED
# define YY_YY_SRC_MAIN_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_CHAR = 258,
    T_BOOL = 259,
    T_INT = 260,
    IDENTIFIER = 261,
    INTEGER = 262,
    CHAR = 263,
    BOOL = 264,
    STRING = 265,
    IF = 266,
    ELSE = 267,
    LPAREN = 268,
    RPAREN = 269,
    LBRACE = 270,
    RBRACE = 271,
    LSQUBR = 272,
    RSQUBR = 273,
    SEMICOLON = 274,
    COMMA = 275,
    EQ = 276,
    NE = 277,
    GE = 278,
    LE = 279,
    GT = 280,
    LT = 281,
    ASSIGN = 282,
    PLUS = 283,
    SUB = 284,
    MUL = 285,
    DIV = 286,
    REM = 287,
    WHILE = 288,
    FOR = 289,
    RETURN = 290,
    BREAK = 291,
    CASE = 292,
    CONST = 293,
    CONTINUE = 294,
    DEFAULT = 295,
    DELETE = 296,
    DO = 297,
    ENUM = 298,
    FALSE = 299,
    NEW = 300,
    NULLPTR = 301,
    STRUCT = 302,
    SWITCH = 303,
    TRUE = 304,
    UNION = 305,
    VOID = 306,
    OR = 307,
    AND = 308,
    ADD = 309,
    NOT = 310
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_MAIN_TAB_H_INCLUDED  */
