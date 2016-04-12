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

program : HATCH Fill SOUP	{printf("Program accepted\n");}
		;

Fill : Insts DecTurtle Commands
	 ;

Insts: INSTINCT ENDINSTINCT
	 ;

DecTurtle : DecTurtle NewTurtle
		   | NewTurtle
		   ;

Commands : Commands Command
		 | Command
		 ;

Command : NAME Order
		;

Order : NOTRAIL {printf("No Trail\n");}
	  | TRAIL	{printf("Trail\n");}
	  | LEFT	{printf("Turning Left\n");}
      | RIGHT	{printf("Turning Right\n");}
	  | FORWARD NUMBER {printf("Moving forward %d\n", $2.ival);}
	  | COLOR COL	{printf("New color is %s\n", $2.str);}
	  ;

NewTurtle : TURTLE NAME {printf("New name! %s\n", $2.str);}
		  ;

%%

main()
{
	yyparse();
}

