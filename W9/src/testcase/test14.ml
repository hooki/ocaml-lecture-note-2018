let f = fun a -> if iszero a then 0 else 1 + (f a)
in f 10
