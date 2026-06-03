(* lib/pretty.ml *)

open Ast

let rec pretty = function
  | Int n -> string_of_int n
  | Add (a, b) -> "(" ^ pretty a ^ "+" ^ pretty b ^ ")"
  | Sub (a, b) -> "(" ^ pretty a ^ "-" ^ pretty b ^ ")"
  | Mul (a, b) -> "(" ^ pretty a ^ "*" ^ pretty b ^ ")"
  | Div (a, b) -> "(" ^ pretty a ^ "/" ^ pretty b ^ ")"
  | Neg e -> "(-" ^ pretty e ^ ")"
