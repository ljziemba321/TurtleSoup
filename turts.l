%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct
{
	char str[1024];
	int ival;
}tstruct;

#define YYSTYPE tstruct

#include "turts.tab.h"

%}

LETTER	[a-zA-Z]
DIGIT	[0-9]
%%

hatch		{return HATCH;}
soup		{return SOUP;}
turtle		{return TURTLE;}
num			{return NUM;}
color		{return COLOR;}
notrail		{return NOTRAIL;}
trail		{return TRAIL;}
forward		{return FORWARD;}
right		{return RIGHT;}
left		{return LEFT;}
turn		{return TURN;}
is			{return IS;}
shell		{return SHELL;}
endshell	{return ENDSHELL;}
do			{return DO;}
enddo		{return ENDDO;}
instinct	{return INSTINCT;}
endinstinct	{return ENDINSTINCT;}
red			{ strcpy(yylval.str, yytext); return COL;}
green		{ strcpy(yylval.str, yytext); return COL;}
blue		{ strcpy(yylval.str, yytext); return COL;}
black		{ strcpy(yylval.str, yytext); return COL;}
white		{ strcpy(yylval.str, yytext); return COL;}
yellow		{ strcpy(yylval.str, yytext); return COL;}
orange		{ strcpy(yylval.str, yytext); return COL;}
purple		{ strcpy(yylval.str, yytext); return COL;}
pink		{ strcpy(yylval.str, yytext); return COL;}
{DIGIT}+	{ strcpy(yylval.str, yytext); return NUMBER;}
{LETTER}+	{ strcpy(yylval.str, yytext); return NAME;}

[ \t\n]

<<EOF>>		yyterminate();

.		return yytext[0];

%%

