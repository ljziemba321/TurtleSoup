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

program : HATCH Fill SOUP	{
							printf("import turtle\n");
							printf("wn = turtle.Screen()\nwn.bgcolor(\"skyblue\")\n");
							printf("%s", $2.str);
							}
		;

Fill : Insts DecTurtle Commands		{sprintf($$.str, "%s%s", $2.str, $3.str);}
	 ;

Insts: INSTINCT ENDINSTINCT
	 ;

DecTurtle : DecTurtle NewTurtle		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		   | NewTurtle				{sprintf($$.str, $1.str);}
		   ;

Commands : Commands Command	{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Command			{sprintf($$.str, $1.str);}
		 ;

Command : NAME Order	{sprintf($$.str, "%s.%s", $1.str, $2.str);}
		;

Order : NOTRAIL 		{printf("No Trail\n");}
	  | TRAIL			{printf("Trail\n");}
	  | LEFT NUMBER		{sprintf($$.str, "left(%d)\n", $2.ival);}
      | RIGHT NUMBER	{sprintf($$.str, "right(%d)\n", $2.ival);}
	  | FORWARD NUMBER 	{sprintf($$.str, "forward(%d)\n", $2.ival);}
	  | COLOR COL		{printf("New color is %s\n", $2.str);}
	  ;

NewTurtle : TURTLE NAME {sprintf($$.str, "%s = turtle.Turtle()\n%s.shape(\"turtle\")\n", $2.str, $2.str);}
		  ;

%%

main()
{
	yyparse();
}

