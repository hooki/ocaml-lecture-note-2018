%token <int> NUM
%token <string> ID
%token LPAREN RPAREN
%token TRUE FALSE
%token PLUS MINUS STAR SLASH
%token ISZERO
%token IF THEN ELSE
%token LET REC EQUAL IN
%token FUN ARROW
%token READ
%token EOF

%left PLUS MINUS
%left STAR SLASH

%start file
%type <Eval.file> file
%%

file:
  exp EOF { $1 }
  ;

exp:
    LPAREN exp RPAREN { $2 }
  | NUM { Eval.CONST $1 }
  | ID { Eval.VAR $1 }
  | TRUE { Eval.TRUE }
  | FALSE { Eval.FALSE }
  | exp PLUS exp { Eval.ADD ($1, $3) }
  | exp MINUS exp { Eval.SUB ($1, $3) }
  | exp STAR exp { Eval.MUL ($1, $3) }
  | exp SLASH exp { Eval.DIV ($1, $3) }
  | ISZERO exp { Eval.ISZERO $2 }
  | IF exp THEN exp ELSE exp { Eval.IF ($2, $4, $6) }
  | LET ID EQUAL exp IN exp { Eval.LET (false, $2, $4, $6) }
  | LET REC ID EQUAL exp IN exp { Eval.LET (true, $3, $5, $7) }
  | FUN ID ARROW exp { Eval.FUN ($2, $4) }
  | exp exp { Eval.CALL ($1, $2) }
  | READ { Eval.READ }
  
%%

let parser_error s = print_endline s
