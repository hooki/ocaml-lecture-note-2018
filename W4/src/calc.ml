type exp =
  | NUM of float
  | VAR of var
  | ADD of exp * exp
  | SUB of exp * exp
  | MUL of exp * exp
  | DIV of exp * exp
  | VDECL of var * exp * exp
  | FDECL of var * var * exp * exp
  | FCALL of exp * exp
and var = string
and file = exp

type value =
  | Num of float
  | Fun of var * exp * env
and env = (var * value) list

let append : env -> var -> value -> env
= fun env x v -> (x, v)::env

let rec apply : env -> var -> value
= fun env x ->
  match env with
  | [] -> raise (Failure ("no variable " ^ x ^ " found"))
  | (y, v)::tl -> if y = x then v else apply tl x

let empty_env = []

let val2str v =
  match v with
  | Num n -> string_of_float n
  | Fun (x, e, env) -> "<fun>"

let rec eval : exp -> env -> value
= fun e env -> (* TODO *)

let calc e = eval e empty_env
