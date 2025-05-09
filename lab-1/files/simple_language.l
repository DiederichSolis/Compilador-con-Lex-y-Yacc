%{
#include <cstdlib>
#include <string>
#include <cstring>
#include "y.tab.h"
%}

%%

"let"                   { return LET; }
[a-zA-Z][a-zA-Z0-9]*    {
    yylval.str = new std::string(yytext);
    return ID;
}
[0-9]+                  { yylval.num = strtol(yytext, NULL, 10); return NUMBER; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"="                     { return '='; }
":"                     { return ':'; }
"("                     { return '('; }
")"                     { return ')'; }



[ \t\r]+                ;  // ignora espacios
\n        ;  // ignora saltos de línea
.         { fprintf(stderr, "❌ Token inválido (ASCII %d): [%s]\n", yytext[0], yytext); }

%%

extern "C" int yywrap() {
    return 1;
}

