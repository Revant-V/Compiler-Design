%{
#include "y.tab.h"
%}

%%
[01]+     { yylval.str = strdup(yytext); return BINARY; }
\n        { return EOL; }
.         { /* ignore other characters */ }
%%
