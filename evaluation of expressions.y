%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    int num;
}

%token <num> NUMBER
%token EOL

%left '+' '-'
%left '*' '/'

%type <num> expr

%%

input:
    expr EOL {
        printf("Result: %d\n", $1);
    }
;

expr:
    expr '+' expr  { $$ = $1 + $3; }
  | expr '-' expr  { $$ = $1 - $3; }
  | expr '*' expr  { $$ = $1 * $3; }
  | expr '/' expr  { 
        if ($3 == 0) {
            yyerror("Division by zero");
            exit(1);
        }
        $$ = $1 / $3; 
    }
  | '(' expr ')'   { $$ = $2; }
  | NUMBER         { $$ = $1; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
