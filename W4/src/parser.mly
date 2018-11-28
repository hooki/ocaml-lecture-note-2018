%{
  let rec create_float n1 n2 = if n2 >= 1. then create_float n1 (n2 /. 10.) else n1 +. n2
%}

%token <int> NUM
%token <string> ID
%token PLUS MINUS STAR SLASH
%token LPAREN RPAREN
%token EQUAL
%token EOF
%token DOT
%token SEMI
%token LET
%token DEF

%left SEMI
%left PLUS MINUS
%left STAR SLASH
%left DOT

%start file
%type <Calc.file> file
%%

file:
  exp EOF { $1 }
  ;

exp:
    num { $1 }
  | ID { Calc.VAR $1 }
  | LPAREN exp RPAREN { $2 }
  | exp PLUS exp { Calc.ADD ($1, $3) }
  | exp MINUS exp { Calc.SUB ($1, $3) }
  | exp STAR exp { Calc.MUL ($1, $3) }
  | exp SLASH exp { Calc.DIV ($1, $3) }
  | LET ID EQUAL exp SEMI exp { Calc.VDECL ($2, $4, $6) }
  | DEF ID LPAREN ID RPAREN EQUAL exp SEMI exp { Calc.FDECL ($2, $4, $7, $9) }
  | exp LPAREN exp RPAREN { Calc.FCALL ($1, $3) }

num:
    NUM { Calc.NUM (float_of_int $1) }
  | MINUS num { Calc.MUL (Calc.NUM (-1.), $2) }
  | NUM DOT NUM { Calc.NUM (create_float (float_of_int $1) (float_of_int $3)) }

%%

let parser_error s = print_endline s
