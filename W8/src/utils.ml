let rec iter f lst =
  match lst with
  | [] -> ()
  | hd::tl -> f hd; iter f tl

let rec map f lst =
  match lst with
  | [] -> []
  | hd::tl -> (f hd)::(map f tl)