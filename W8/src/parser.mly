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
%type <Lang.file> file
%%

file:
  exp EOF { $1 }
  ;

exp:
    LPAREN exp RPAREN { $2 }
  | NUM { Lang.CONST $1 }
  | ID { Lang.VAR $1 }
  | TRUE { Lang.TRUE }
  | FALSE { Lang.FALSE }
  | exp PLUS exp { Lang.ADD ($1, $3) }
  | exp MINUS exp { Lang.SUB ($1, $3) }
  | exp STAR exp { Lang.MUL ($1, $3) }
  | exp SLASH exp { Lang.DIV ($1, $3) }
  | ISZERO exp { Lang.ISZERO $2 }
  | IF exp THEN exp ELSE exp { Lang.IF ($2, $4, $6) }
  | LET ID EQUAL exp IN exp { Lang.LET (false, $2, $4, $6) }
  | LET REC ID EQUAL exp IN exp { Lang.LET (true, $3, $5, $7) }
  | FUN ID ARROW exp { Lang.FUN ($2, $4) }
  | exp exp { Lang.CALL ($1, $2) }
  | READ { Lang.READ }
  
%%

let parser_error s = print_endline s
