type exp =
  | NUM of float
  | ADD of exp * exp
  | SUB of exp * exp
  | MUL of exp * exp
  | DIV of exp * exp
and file = exp

type value =
  | Num of float

let val2str v =
  match v with
  | Num n -> string_of_float n

let rec eval : exp -> value
= fun e -> (* TODO *)

let calc e = eval e
