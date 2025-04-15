%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    char ch;
}

%token <ch> LETTER
%token EOL

%%

input:
    palindrome EOL {
        printf("Input is a palindrome.\n");
    }
  | word EOL {
        printf("Input is NOT a palindrome.\n");
    }
;

palindrome:
    /* empty */                 { /* base case: even-length */ }
  | LETTER                      { /* base case: odd-length */ }
  | LETTER palindrome LETTER    {
        if ($1 != $3) {
            yyerror("Mismatch");
            YYABORT;
        }
    }
;

word:
    word LETTER
  | LETTER
;

%%

void yyerror(const char *s) {
    // Silently fail when not a palindrome, since we print message in the rule
}
