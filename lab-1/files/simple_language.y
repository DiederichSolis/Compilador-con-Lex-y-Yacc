%{
#include <iostream>
#include <string>
#include <map>
static std::map<std::string, int> vars;
inline void yyerror(const char *str) { std::cout << str << std::endl; }
int yylex();
%}

%union { int num; std::string *str; }

%token<num> NUMBER
%token<str> ID
%token LET
%type<num> expression
%type<num> assignment

%right '='
%left '+' '-'
%left '*' '/'

%%

program:
    statement_list
    ;

statement_list:
    statement
    | statement_list statement
    ;

statement:
    assignment
    | assignment ':'        { }
    | expression ':'        { std::cout << $1 << std::endl; }
    | ID ':'                { std::cout << vars[*$1] << std::endl; delete $1; }
    ;


assignment:
    LET ID '=' expression
    {
        printf("Assign %s = %d\n", $2->c_str(), $4);
        $$ = vars[*$2] = $4;
        delete $2;
    }
    ;

expression:
    NUMBER                  { $$ = $1; }
    | ID                    { $$ = vars[*$1]; delete $1; }
    | expression '+' expression { $$ = $1 + $3; }
    | expression '-' expression { $$ = $1 - $3; }
    | expression '*' expression { $$ = $1 * $3; }
    | expression '/' expression { $$ = $1 / $3; }
    ;

%%

int main() {
    yyparse();
    return 0;
}
