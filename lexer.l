%option noyywrap
%{
#include <stdio.h>
#include <stdbool.h>

int words = 0;
int chars = 0; //Char starts at 0, as char count will incremenet before displaying syntax error
int lines = 1; //Text editors start from Line 1, reflect this in error

bool errorFound = false;
%}

    /*
	Program		{VarDecl}{Block}
	VarDecl		({Type}{id}{semicolon})+
	Type		{int}|{char}
	Block		{StmtList}
	StmtList	{Stmt}+
	Stmt		{ID}{assignOp}{Expr}{semicolon} | {write}{ID}
	Expr		{ID}{Op}{ID}
	Op			[+]|[-]
	*/

%%
"int"               { words++; chars += strlen(yytext);
                      printf("TYPE: %s\n", yytext);
                    }
"char"              { words++; chars += strlen(yytext);
                      printf("TYPE: %s\n", yytext);
                    }
"return"            { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"write"             { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"if"                { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"else"              { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"while"             { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"for"               { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"break"             { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"continue"          { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
"void"              { words++; chars += strlen(yytext);
                      printf("KEYWORD: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { words++; chars += strlen(yytext);
                         printf("IDENTIFIER: %s\n", yytext); }
[0-9]+\.[0-9]+      { words++; chars += strlen(yytext);
                      printf("FLOAT: %s\n", yytext); }  // Floating point numbers
[0-9]+              { words++; chars += strlen(yytext);
                      printf("NUMBER: %s\n", yytext); }
"("                 { chars += strlen(yytext);
                      printf("SYMBOL: %s\n", yytext); }
")"                 { chars += strlen(yytext);
                      printf("SYMBOL: %s\n", yytext); }
"{"                 { chars += strlen(yytext);
                      printf("SYMBOL: %s\n", yytext); }
"}"                 { chars += strlen(yytext);
                      printf("SYMBOL: %s\n", yytext); }
":"                 { chars += strlen(yytext);
                      printf("SYMBOL: %s\n", yytext); }
";"                 { chars += strlen(yytext);
                      printf("SEMI: %s\n", yytext); }
"="                 { chars += strlen(yytext);
                      printf("EQUAL: %s\n", yytext); }
","                 { chars += strlen(yytext);
                      printf("SYMBOL: %s\n", yytext); }
"+"                 { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"-"                 { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"*"                 { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"/"                 { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"=="                { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"!="                { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"<"                 { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
">"                 { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
"<="                { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
">="                { chars += strlen(yytext);
                      printf("OPERATOR: %s\n", yytext); }
\"[^\"]*\"          { chars += strlen(yytext);
                      printf("STRING: %s\n", yytext); } // Strings in double quotes
"//"[^\n]*          { /* Ignore single-line comments */ }
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*"*/"  { /* Ignore multi-line comments */ }
[ \t\r]+            {chars++;}
[\n]                {lines++; chars=0;}
.                   {chars += strlen(yytext);
                       printf("%s : Unrecognized symbol at line %d char %d\n", yytext,lines,chars);
                       errorFound = true;}
%%

int main(int argc, char **argv) {
    ++argv, --argc;  /* Skip over program name */
    if (argc > 0)
        yyin = fopen(argv[0], "r");
    else
        yyin = stdin;

    yylex();

    if (errorFound)
        printf("Errors detected! Program will fail to compile.\n");
    else
        printf("No errors detected.\n");
    return 0;
}

