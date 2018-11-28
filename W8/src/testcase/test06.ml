let rec double =
  fun x -> if iszero x then 0 else 2 + double (x - 1) in
double 5