open Utils

type exp =
  | CONST of int
  | VAR of id
  | TRUE
  | FALSE
  | ADD of exp * exp
  | SUB of exp * exp
  | MUL of exp * exp
  | DIV of exp * exp
  | ISZERO of exp
  | IF of exp * exp * exp
  | LET of bool * id * exp * exp
  | FUN of id * exp
  | CALL of exp * exp
  | READ
and id = string
and file = exp
and eenv = (id * exp) list

type value =
  | VInt of int
  | VBool of bool
  | VProc of id * exp * env
  | VRecProc of id * id * exp * env
and env = (id * value) list

let string_of_value v =
  match v with
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VProc (x, e, env) -> "<fun>"
  | VRecProc (f, x, e, env) -> "<fun>"
  
type typ =
  | TInt
  | TBool
  | TFun of typ * typ
  | TVar of id
and tenv = (id * typ) list

let cnt = ref 0
let new_tvar () = cnt := !cnt + 1; "t" ^ string_of_int (!cnt)

let rec string_of_typ t =
  match t with
  | TInt -> "int"
  | TBool -> "bool"
  | TFun (t1, t2) -> string_of_typ t1 ^ " -> " ^ string_of_typ t2
  | TVar t -> "\'" ^ t

let empty_env = []

let extend : id * 'a -> (id * 'a) list -> (id * 'a) list
= fun (x, v) env -> (x, v)::env

let rec lookup : (id * 'a) list -> id -> 'a
= fun env x ->
  match env with
  | [] -> raise (Failure ("Unbounded value " ^ x))
  | (y, v)::tl -> if y = x then v else lookup tl x

type typ_eqn = (typ * typ) list

let print_equations eqn =
  iter (fun (t1, t2) -> print_endline ((string_of_typ t1) ^ " = " ^ (string_of_typ t2))) eqn

type subst = (id * typ) list

let empty_subst = []

let print_subst subst =
  iter (fun (x, t) -> print_endline (x ^ " |-> " ^ string_of_typ t)) subst

let rec lookup_subst subst tvar =
  match subst with
  | [] -> TVar tvar
  | (t, typ)::tl -> if t = tvar then typ else lookup_subst tl tvar

let rec apply_subst typ subst =
  match typ with
  | TInt | TBool -> typ
  | TFun (t1, t2) -> TFun (apply_subst t1 subst, apply_subst t2 subst)
  | TVar t -> lookup_subst subst t

let extend_subst (tvar, typ) subst =
  (tvar, typ)::(map (fun (x, t) -> (x, apply_subst t [(tvar, typ)])) subst)
