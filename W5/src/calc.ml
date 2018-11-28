type exp =
  | UNIT
  | NUM of int
  | TRUE
  | FALSE
  | VAR of var
  | NEW of exp
  | REF of exp
  | ADD of exp * exp
  | SUB of exp * exp
  | MUL of exp * exp
  | DIV of exp * exp
  | EQUAL of exp * exp
  | LESS of exp * exp
  | NOT of exp
  | IF of exp * exp * exp
  | VDECL of var * exp * exp
  | FDECL of var * var * exp * exp
  | ASSIGN of var * exp * exp
  | FCALL of exp * exp
  | SEQ of exp * exp
and var = string
and file = exp

type value =
  | Unit
  | Num of int
  | Bool of bool
  | Loc of loc
  | Proc of var * var * exp * env
and loc = int
and env = (var * value) list
and mem = (loc * value) list

let append_env : var * value -> env -> env
= fun (x, v) env -> (x, v)::env

let rec apply_env : env -> var -> value
= fun env x ->
  match env with
  | [] -> raise (Failure ("no variable " ^ x ^ " found"))
  | (y, v)::tl -> if y = x then v else apply_env tl x

let append_mem : loc * value -> mem -> mem
= fun (l, v) mem -> (l, v)::mem

let rec apply_mem : mem -> loc -> value
= fun mem l ->
  match mem with
  | [] -> raise (Failure "should not reach here")
  | (y, v)::tl -> if y = l then v else apply_mem tl l

let empty_env = []
let empty_mem = []

let val2str v =
  match v with
  | Unit -> "unit"
  | Num n -> string_of_int n
  | Bool b -> string_of_bool b
  | Proc (f, x, e, env) -> "<fun>"
  | Loc l -> "loc " ^ string_of_int l

let counter = ref 0
let new_location () = counter := !counter + 1; !counter

exception UndefinedSemantics

let rec eval : exp -> env -> mem -> value * mem
= fun e env mem -> (* TODO *)

let calc : exp -> value
= fun e -> let v, _ = eval e empty_env empty_mem in v
