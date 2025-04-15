%{
#include "y.tab.h"
%}

%%

[0-9]+     { yylval.num = atoi(yytext); return NUMBER; }
[\n]       { return EOL; }
[\t ]      { /* ignore whitespace */ }
.          { return yytext[0]; }

%%
