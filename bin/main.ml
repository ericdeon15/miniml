let rec member x l = match l with [] -> false | h :: t -> h = x || member x t

let rec filter f l =
  match l with
  | [] -> []
  | h :: t -> if f h then h :: filter f t else filter f t

let () = print_endline (string_of_bool (member 1 [ 0; 2 ]))
