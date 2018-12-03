let rec double =
  fun x -> if iszero x then 0 else true + double (x - 1) in
double 5