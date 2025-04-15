%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    char *str;
}

%token <str> NUMBER
%token EOL
%left '+' '-'
%left '*' '/'

%type <str> expr

%%

input:
    expr EOL {
        printf("Postfix: %s\n", $1);
        free($1);
    }
;

expr:
    expr '+' expr {
        asprintf(&$$, "%s %s +", $1, $3);
        free($1); free($3);
    }
  | expr '-' expr {
        asprintf(&$$, "%s %s -", $1, $3);
        free($1); free($3);
    }
  | expr '*' expr {
        asprintf(&$$, "%s %s *", $1, $3);
        free($1); free($3);
    }
  | expr '/' expr {
        asprintf(&$$, "%s %s /", $1, $3);
        free($1); free($3);
    }
  | '(' expr ')' {
        $$ = $2;
    }
  | NUMBER {
        $$ = strdup($1);
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
