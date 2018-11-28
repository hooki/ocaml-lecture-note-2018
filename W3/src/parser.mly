%{
  let rec create_float n1 n2 = if n2 >= 1. then create_float n1 (n2 /. 10.) else n1 +. n2
%}

%token <int> NUM
%token PLUS MINUS STAR SLASH
%token LPAREN RPAREN
%token EOF
%token DOT

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
  | LPAREN exp RPAREN { $2 }
  | exp PLUS exp { Calc.ADD ($1, $3) }
  | exp MINUS exp { Calc.SUB ($1, $3) }
  | exp STAR exp { Calc.MUL ($1, $3) }
  | exp SLASH exp { Calc.DIV ($1, $3) }

num:
    NUM { Calc.NUM (float_of_int $1) }
  | MINUS num { Calc.MUL (Calc.NUM (-1.), $2) }
  | NUM DOT NUM { Calc.NUM (create_float (float_of_int $1) (float_of_int $3)) }

%%

let parser_error s = print_endline s
