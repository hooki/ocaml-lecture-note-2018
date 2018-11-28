{
  open Parser
  exception Eof
  exception LexicalError
  let comment_depth = ref 0
}

let blank = [' ' '\n' '\t' '\r']+
let digit = ['0'-'9']+

rule start = parse
    blank { start lexbuf }
  | "(*" { comment_depth := 1; comment lexbuf; start lexbuf }
  | digit { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { STAR }
  | "/" { SLASH }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "." { DOT }
  | eof { EOF }
  | _ { raise LexicalError }

and comment = parse
    "(*" { comment_depth := !comment_depth + 1; comment lexbuf }
  | "*)" { comment_depth := !comment_depth - 1; if !comment_depth > 0 then comment lexbuf }
  | eof { raise Eof }
  | _ { comment lexbuf }