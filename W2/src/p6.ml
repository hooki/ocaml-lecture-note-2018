(* problem 6*)

type mobile = branch * branch     (* left and rigth branches *)
and branch = 
    SimpleBranch of length * weight
  | CompoundBranch of length * mobile
and length = int
and weight = int

let rec balanced : mobile -> bool
= fun m -> (* TODO *)