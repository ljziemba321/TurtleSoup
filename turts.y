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
int iCount = 0;
int i;
char indents[500];


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
%token NEG


%%
program : HATCH Fill SOUP	{
							printf("import turtle\n");
							printf("wn = turtle.Screen()\nwn.bgcolor(\"skyblue\")\n");
							printf("%s", $2.str);
							}
		;

Fill : Insts Declars Commands		{sprintf($$.str, "%s%s", $2.str, $3.str);}
	 ;

Insts: INSTINCT ENDINSTINCT
	 ;

Declars    : Declars NewTurtle		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		   | Declars NewVar			{sprintf($$.str, $1.str);}
		   | NewVar					{/*New vars added to list down in NewVar Rule*/}
		   | NewTurtle				{sprintf($$.str, $1.str);}
		   ;

Commands : Commands TurtCommand	{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Commands VarIs		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Commands DoLoop		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | DoLoop				{sprintf($$.str, $1.str);}
		 | VarIs				{sprintf($$.str, $1.str);}
		 | TurtCommand			{sprintf($$.str, $1.str); printf("%s\n", $1.str);}
		 ;

DoLoop : DO {iCount++; tabs();} Expr Commands ENDDO {iCount--; tabs(); sprintf($$.str, "for(i=0; i<%s; i++):\n%s", $1.str, $2.str); printf("%s\n", $2.str);}
	   ;

TurtCommand : NAME Order	{sprintf($$.str, "%s.%s", $1.str, $2.str);}
		;

Order : NOTRAIL 		{sprintf($$.str, "penup()\n");}
	  | TRAIL			{sprintf($$.str, "pendown()\n");}
	  | LEFT			{sprintf($$.str, "left(90)\n");}
      | RIGHT			{sprintf($$.str, "right(90)\n");}
	  | TURN Expr		{sprintf($$.str, "right(%s)\n", $2.str);}
	  | TURN NEG Expr	{sprintf($$.str, "left(%s)\n", $3.str);}
	  | FORWARD Expr 	{sprintf($$.str, "forward(%s)\n", $2.str);}
	  | COLOR COL		{sprintf($$.str, "color(\"%s\")\n", $2.str);}
	  ;

VarIs : NAME IS Expr	{sprintf($$.str, "%s = %s\n", $1.str, $3.str);}
	  ;

NewVar	  : NUM NAME {/*add this name to the list*/}
		  ;

NewTurtle : TURTLE NAME {sprintf($$.str, "%s = turtle.Turtle()\n%s.shape(\"turtle\")\n%s.color(\"green\")\n%s.speed(1)\n", $2.str, $2.str, $2.str, $2.str);}
		  ;


Expr	  : Expr OP T {sprintf($$.str,"%s %s %s", $1.str, $2.str, $3.str);}
	   	  | Expr NEG T {sprintf($$.str, "%s %s %s", $1.str, $2.str, $3.str);}
		  | Expr OP NEG T {sprintf($$.str, "%s %s %s%s", $1.str, $2.str, $3.str, $4.str);}
		  | Expr NEG NEG T {sprintf($$.str, "%s %s %s%s", $1.str, $2.str, $3.str, $4.str);}
		  | T	   {sprintf($$.str,"%s", $1.str);}
		  ;

T		  : '(' Expr ')'{sprintf($$.str,"(%s)", $2.str);}
	      |  NUMBER		{sprintf($$.str,"%s", $1.str);}
		  |  NAME		{sprintf($$.str, "%s", $1.str);}
		  ;



%%

main()
{
	yyparse();
}

tabs()
{
	
	sprintf(indents, "");
	for(i = 0; i<iCount; i++)
	{
		sprintf(indents, "%s\t", indents);
	}
	printf("%s%d is cool\n", indents, iCount);
}

