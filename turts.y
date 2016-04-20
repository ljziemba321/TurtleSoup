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
%token TURN
%token OP


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

Order : NOTRAIL 		{sprintf($$.str, "penup()\n");}
	  | TRAIL			{sprintf($$.str, "pendown()\n");}
	  | LEFT			{sprintf($$.str, "left(90)\n");}
      | RIGHT			{sprintf($$.str, "right(90)\n");}
	  | TURN Expr		{if($2.ival > 0)
							{sprintf($$.str,"right(%s)\n", $2.str);}
						 else
							{sprintf($$.str,"left(%s)\n", $2.str);}
	  					}
	  | FORWARD Expr 	{sprintf($$.str, "forward(%s)\n", $2.str);}
	  | COLOR COL		{sprintf($$.str, "color(\"%s\")\n", $2.str);}
	  ;

NewVar	  : NAME IS Expr{sprintf($$.str, "%s = %s\n", $1.str, $3.str);
//		 				addVar($1.str);
}
		  ;

NewTurtle : TURTLE NAME {sprintf($$.str, "%s = turtle.Turtle()\n%s.shape(\"turtle\")\n%s.color(\"green\")\n%s.speed(1)\n", $2.str, $2.str, $2.str, $2.str);}
		  ;


Expr	  : Expr '+' T {sprintf($$.str,"%s+%s", $1.str ,$3.str);}
	      | T	   {sprintf($$.str,"%s", $1.str);}
		  ;

T		  : '(' Expr ')'{sprintf($$.str,"(%s)", $2.str);}
	      |  NUMBER		{sprintf($$.str,"%s", $1.str);}
		  ;



%%

main()
{
	yyparse();
}

