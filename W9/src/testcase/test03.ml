let rec makeZero = 
  fun x -> if iszero x then x else makeZero (x - 1) in
makeZero 5