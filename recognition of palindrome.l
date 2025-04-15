%{
#include "y.tab.h"
%}

%%

[a-zA-Z]   { yylval.ch = yytext[0]; return LETTER; }
\n         { return EOL; }
.          { /* Ignore everything else */ }

%%
