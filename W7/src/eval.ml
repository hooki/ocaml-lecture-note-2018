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

type value =
  | Int of int
  | Bool of bool
  | Proc of id * exp * env
  | RecProc of id * id * exp * env
and env = (id * value) list

let extend_env : id * value -> env -> env
= fun (x, v) env -> (x, v)::env

let rec lookup_env : env -> id -> value
= fun env x ->
  match env with
  | [] -> raise (Failure ("no idiable " ^ x ^ " found"))
  | (y, v)::tl -> if y = x then v else lookup_env tl x

let empty_env = []

let string_of_value v =
  match v with
  | Int n -> string_of_int n
  | Bool b -> string_of_bool b
  | Proc (x, e, env) -> "<fun>"
  | RecProc (f, x, e, env) -> "<fun>"

exception UndefinedSemantics

let rec eval : env -> exp -> value
= fun env e ->
  match e with
  | CONST n -> Int n
  | VAR x -> lookup_env env x
  | TRUE -> Bool true
  | FALSE -> Bool false
  | ADD (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | Int n1, Int n2 -> Int (n1 + n2)
    | _ -> raise UndefinedSemantics
  end
  | SUB (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | Int n1, Int n2 -> Int (n1 - n2)
    | _ -> raise UndefinedSemantics
  end
  | MUL (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | Int n1, Int n2 -> Int (n1 * n2)
    | _ -> raise UndefinedSemantics
  end
  | DIV (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | Int n1, Int n2 -> Int (n1 / n2)
    | _ -> raise UndefinedSemantics
  end
  | ISZERO e ->
  begin
    let n = eval env e in
    match n with
    | Int n -> Bool (n = 0)
    | _ -> raise UndefinedSemantics
  end
  | IF (e1, e2, e3) ->
  begin
    let c = eval env e1 in
    match c with
    | Bool c -> eval env (if c then e2 else e3)
    | _ -> raise UndefinedSemantics
  end
  | LET (r, x, e1, e2) ->
  begin
    let v = eval env e1 in
    if r then
    begin
      match v with
      | Proc (param, body, denv) -> eval (extend_env (x, RecProc (x, param, body, denv)) env) e2
      | v -> eval (extend_env (x, v) env) e2
    end
    else eval (extend_env (x, v) env) e2
  end
  | FUN (x, e) -> Proc (x, e, env)
  | CALL (e1, e2) ->
  begin
    let proc = eval env e1 in
    let v = eval env e2 in
    match proc with
    | Proc (x, body, env) -> eval (extend_env (x, v) env) body
    | RecProc (f, x, body, env) -> eval (extend_env (f, proc) (extend_env (x, v) env)) body
    | _ -> raise UndefinedSemantics
  end
  | READ -> let _ = print_string "> " in Int (read_int ())

let run : exp -> value
= fun e -> eval empty_env e
