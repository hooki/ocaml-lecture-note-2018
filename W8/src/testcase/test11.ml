let rec fact = fun x -> if iszero x then 1 else x * fact (x - 1) in
fact