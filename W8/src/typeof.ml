open Lang

exception TypeError

let rec gen_equations : tenv -> exp -> typ -> typ_eqn
= fun tenv e t -> (* TODO *)

let rec occurrence_check : id -> typ -> bool
= fun tvar t -> (* TODO *)

let rec unify : typ * typ -> subst -> subst
= fun eqn subst -> (* TODO *)

let rec unify_all : typ_eqn -> subst -> subst
= fun eqns subst -> (* TODO *)

let solve : typ_eqn -> subst
= fun eqns -> (* TODO *)

let typeof : exp -> typ
= fun e ->
  let t = new_tvar () in
  let eqns = gen_equations empty_env e (TVar t) in
  try
    let subst = solve eqns in
    lookup_subst subst t
  with TypeError -> print_endline "Type error. Rejected."; exit(1)
