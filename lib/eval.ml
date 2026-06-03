(* lib/eval.ml *)

open Ast

let rec eval = function
  | Int n -> n
  | Add (a, b) -> eval a + eval b
  | Sub (a, b) -> eval a - eval b
  | Mul (a, b) -> eval a * eval b
  | Div (a, b) -> eval a / eval b
  | Neg e -> -eval e
