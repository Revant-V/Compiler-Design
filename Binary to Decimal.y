%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yyparse();
int yylex();
void yyerror(const char *s);
%}

%union {
    char *str;
}

%token <str> BINARY
%token EOL

%%

input:
    binary_num EOL {
        printf("Decimal: %d\n", binary_to_decimal($1));
        free($1);
    }
;

%%

int binary_to_decimal(const char *bin) {
    int result = 0;
    while (*bin) {
        result = result * 2 + (*bin - '0');
        bin++;
    }
    return result;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
