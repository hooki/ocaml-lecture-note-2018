open Lang

exception UndefinedSemantics

let rec eval : env -> exp -> value
= fun env e ->
  match e with
  | CONST n -> VInt n
  | VAR x -> lookup env x
  | TRUE -> VBool true
  | FALSE -> VBool false
  | ADD (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | VInt n1, VInt n2 -> VInt (n1 + n2)
    | _ -> raise UndefinedSemantics
  end
  | SUB (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | VInt n1, VInt n2 -> VInt (n1 - n2)
    | _ -> raise UndefinedSemantics
  end
  | MUL (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | VInt n1, VInt n2 -> VInt (n1 * n2)
    | _ -> raise UndefinedSemantics
  end
  | DIV (e1, e2) ->
  begin
    let n1 = eval env e1 in
    let n2 = eval env e2 in
    match n1, n2 with
    | VInt n1, VInt n2 -> VInt (n1 / n2)
    | _ -> raise UndefinedSemantics
  end
  | ISZERO e ->
  begin
    let n = eval env e in
    match n with
    | VInt n -> VBool (n = 0)
    | _ -> raise UndefinedSemantics
  end
  | IF (e1, e2, e3) ->
  begin
    let c = eval env e1 in
    match c with
    | VBool c -> eval env (if c then e2 else e3)
    | _ -> raise UndefinedSemantics
  end
  | LET (r, x, e1, e2) ->
  begin
    let v = eval env e1 in
    if r then
    begin
      match v with
      | VProc (param, body, denv) -> eval (extend (x, VRecProc (x, param, body, denv)) env) e2
      | v -> eval (extend (x, v) env) e2
    end
    else eval (extend (x, v) env) e2
  end
  | FUN (x, e) -> VProc (x, e, env)
  | CALL (e1, e2) ->
  begin
    let proc = eval env e1 in
    let v = eval env e2 in
    match proc with
    | VProc (x, body, env) -> eval (extend (x, v) env) body
    | VRecProc (f, x, body, env) -> eval (extend (f, proc) (extend (x, v) env)) body
    | _ -> raise UndefinedSemantics
  end
  | READ -> let _ = print_string "> " in VInt (read_int ())

let run : exp -> value
= fun e -> eval empty_env e
