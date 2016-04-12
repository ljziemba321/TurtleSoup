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

%}

%token HATCH
%token SOUP
%token TURTLE
%token NUM
%token COLOR
%token NOTRAIL
%token TRAIL
%token FORWARD
%token RIGHT
%token LEFT
%token IS
%token SHELL
%token ENDSHELL
%token DO
%token ENDDO
%token INSTINCT
%token ENDINSTINCT
%token COL
%token NUMBER
%token NAME

%%


S : NUMBER	{printf("Yo, I'm here!\n");}
  ;

%%

main()
{
	yyparse();
}

