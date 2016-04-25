%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "turtstab.c"

typedef struct
{
	char str[1024];
	int ival;
}tstruct;

#define YYSTYPE tstruct
int iCount = 0;
int i;

char indents[25];
char shellName[25];



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
							printf("wn = turtle.Screen()\nwn.bgcolor(\"red\")\n");
							printf("%s", $2.str);
							}
		;


Fill : InstList Declars Commands		{sprintf($$.str, "%s%s%s", $1.str, $2.str, $3.str);}
	 | Declars Commands					{sprintf($$.str, "%s%s", $1.str, $2.str);}
	 | Declars							{sprintf($$.str, "%s", $1.str);}
	 ;


InstList : InstList Inst 	{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Inst			 	{sprintf($$.str, $1.str);}
		 ;


Inst : INSTINCT {iCount++; tabs();} NAME InstOrderList ENDINSTINCT {iCount--; tabs(); addTab($3.str, 3); sprintf($$.str, "def %s(turtName):\n%s\n", $3.str, $4.str);}
	 ;


Declars : Declars NewTurtle		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		| Declars NewVar		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		| NewVar				{/*Nothing to pass because python handles */}
		| NewTurtle				{sprintf($$.str, $1.str);}
		;


Commands : Commands TurtCommand ';'	{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Commands VarIs ';'		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Commands DoLoop ';'		{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Commands ShellCommand ';'{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | Commands InstCommand ';'	{sprintf($$.str, "%s%s", $1.str, $2.str);}
		 | InstCommand ';'			{sprintf($$.str, $1.str);}
		 | ShellCommand ';'			{sprintf($$.str, $1.str);} 
		 | DoLoop ';'				{sprintf($$.str, $1.str);}
		 | VarIs ';'				{sprintf($$.str, $1.str);}
		 | TurtCommand ';'			{sprintf($$.str, $1.str);}
		 ;


InstCommand : NAME INSTINCT NAME	{if(inTab($1.str) == 1 && inTab($3.str) == 3){sprintf($$.str, "%s%s(%s)\n", indents, $3.str, $1.str);}
		   							 else{printf("Instinct/Turtle name not declared!!!\n"); exit(1);}}
		    ;


DoLoop : DO 	{iCount++; tabs();} Expr Commands ENDDO {iCount--; tabs(); sprintf($$.str, "%sfor i in range(0, %s):\n%s", indents, $3.str, $4.str);}
	   ;


TurtCommand : NAME Order	{sprintf($$.str, "%s%s.%s", indents, $1.str, $2.str);}
		    ;


ShellCommand : NAME 	{if(inTab($1.str) == 1){sprintf(shellName, $1.str);}} SHELL ShellOrderList ENDSHELL {sprintf($$.str, $4.str);}
			 ;


ShellOrderList : ShellOrderList Order	{sprintf($$.str, "%s%s%s.%s", $1.str, indents, shellName, $2.str);}
		  	   | Order					{sprintf($$.str, "%s%s.%s", indents, shellName, $1.str);}
		  	   ;


InstOrderList : InstOrderList Order	{sprintf($$.str, "%s%sturtName.%s", $1.str, indents, $2.str);}
			  | Order				{sprintf($$.str, "%sturtName.%s", indents, $1.str);}
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


VarIs : NAME IS Expr	{if(inTab($1.str) == 2){sprintf($$.str, "%s%s = %s\n", indents, $1.str, $3.str);}
	  					     else{printf("Improper use of Name/Variable Undeclared!!  %s\n", $1.str);exit(1);}}
	  ;


NewVar : NUM NAME ';'	{addTab($2.str, 2);}
	   ;


NewTurtle : TURTLE NAME	';'	{addTab($2.str, 1); sprintf($$.str, "%s = turtle.Turtle()\n%s.shape(\"turtle\")\n%s.color(\"green\")\n%s.speed(1)\n", $2.str, $2.str, $2.str, $2.str);}
		  ;



Expr : Expr OP T		{sprintf($$.str,"%s %s %s", $1.str, $2.str, $3.str);}
	 | Expr NEG T 		{sprintf($$.str, "%s %s %s", $1.str, $2.str, $3.str);}
	 | Expr OP NEG T 	{sprintf($$.str, "%s %s %s%s", $1.str, $2.str, $3.str, $4.str);}
	 | Expr NEG NEG T 	{sprintf($$.str, "%s %s %s%s", $1.str, $2.str, $3.str, $4.str);}
	 | T	   			{sprintf($$.str,"%s", $1.str);}
	 ;


T : '(' Expr ')'	{sprintf($$.str,"(%s)", $2.str);}
  |  NUMBER			{sprintf($$.str,"%s", $1.str);}
  |  NAME			{if(inTab($1.str) == 2){sprintf($$.str, "%s", $1.str);}
					 else{printf("Variable Undeclared!!\n"); exit(1);}}
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
}

