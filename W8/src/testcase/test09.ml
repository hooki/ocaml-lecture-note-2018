let rec add =
  fun a -> fun b ->
    if iszero a
    then
      if iszero b
      then 0
      else 1 + (add 0) (b - 1)
    else
      if iszero b
      then 1 + (add (a - 1)) 0
      else 2 + (add (a - 1)) (b - 1)
in
(add 2) 3