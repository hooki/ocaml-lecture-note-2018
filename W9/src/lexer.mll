{
  open Parser
  exception Eof
  exception LexicalError
  let comment_depth = ref 0
  let keyword_table = Hashtbl.create 31
  let _ = List.iter (
    fun (keyword, token) -> Hashtbl.add keyword_table keyword token
  ) [ ("true", TRUE)
    ; ("false", FALSE)
    ; ("iszero", ISZERO)
    ; ("if", IF)
    ; ("then", THEN)
    ; ("else", ELSE)
    ; ("let", LET)
    ; ("rec", REC)
    ; ("in", IN)
    ; ("fun", FUN)
    ; ("read", READ)
  ]
}

let blank = [' ' '\n' '\t' '\r']+
let id = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']*
let digit = ['0'-'9']+

rule start = parse
    blank { start lexbuf }
  | "(*" { comment_depth := 1; comment lexbuf; start lexbuf }
  | digit { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  | id {
    let id = Lexing.lexeme lexbuf in
    try Hashtbl.find keyword_table id with _ -> ID id
  }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { STAR }
  | "/" { SLASH }
  | "=" { EQUAL }
  | "->" { ARROW }
  | eof { EOF }
  | _ { raise LexicalError }

and comment = parse
    "(*" { comment_depth := !comment_depth + 1; comment lexbuf }
  | "*)" { comment_depth := !comment_depth - 1; if !comment_depth > 0 then comment lexbuf }
  | eof { raise Eof }
  | _ { comment lexbuf }