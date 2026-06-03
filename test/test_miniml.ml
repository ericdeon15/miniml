(*  test/test_miniml.ml *)

(** Test suite for the [Eval] and [Pretty] module.

    These tests help validate that:
    - the AST is properly evaluated
    - the pretty printing reflects the AST structure accurately *)

open Miniml.Ast
open Miniml.Eval
open Miniml.Pretty
open Alcotest

(*********************************************************************************)

(* Eval tests *)

(** Verifies that an integer expression is correctly evaluated *)
let test_integer_eval () =
  let result = eval (Int 1) in
  Alcotest.check Alcotest.int "Int 1 = 1" 1 result

(** Verifies that a simple, non-nested addition expression is correctly
    evaluated *)
let test_add_two_nums_eval () =
  let result = eval (Add (Int 1, Int 2)) in
  Alcotest.check Alcotest.int "(Add(Int 1, Int 2) = 3" 3 result

(** Verifies that a simple, non-nested subraction expression is correctly
    evaluated *)
let test_sub_two_nums_eval () =
  let result = eval (Sub (Int 3, Int 1)) in
  Alcotest.check Alcotest.int "(Sub(Int 3, Int 1) = 2" 2 result

(** Verifies that a simple, non-nested multiplication expression is correctly
    evaluated *)
let test_mul_two_nums_eval () =
  let result = eval (Mul (Int 2, Int 3)) in
  Alcotest.check Alcotest.int "(Mul(Int 2, Int 3) = 6" 6 result

(** Verifies that a simple, non-nested division expression is correctly
    evaluated *)
let test_div_two_nums_eval () =
  let result = eval (Div (Int 6, Int 3)) in
  Alcotest.check Alcotest.int "(Div(Int 6, Int 3) = 2" 2 result

(** Verifies that a negation expression is correctly evaluated on a positive
    number *)
let test_neg_pos_num_eval () =
  let result = eval (Neg (Int 1)) in
  Alcotest.check Alcotest.int "(Neg(Int 1) = -1" (-1) result

(** Verifies that a negation expression is correctly evaluated on a negative
    number *)
let test_neg_neg_num_eval () =
  let result = eval (Neg (Int (-1))) in
  Alcotest.check Alcotest.int "(Neg(Int (-1)) = 1" 1 result

(** Verifies that a nested addition expression is correctly evaluated *)
let test_nested_add_eval () =
  let result = eval (Add (Add (Int 1, Int 2), Add (Int 3, Int 4))) in
  Alcotest.check Alcotest.int "((1 + 2) + (3 + 4)) = 10" 10 result

(** Verifies that nested subtraction respects the explicit AST structure *)
let test_nested_sub_eval () =
  let result = eval (Sub (Sub (Int 10, Int 3), Sub (Int 4, Int 1))) in
  Alcotest.check Alcotest.int "((10 - 3) - (4 - 1)) = 4" 4 result

(** Verifies that a nested expression with mixed binary operators is correctly
    evaluated *)
let test_nested_mixed_ops_eval () =
  let result = eval (Mul (Add (Int 2, Int 3), Sub (Int 10, Int 4))) in
  Alcotest.check Alcotest.int "((2 + 3) * (10 - 4)) = 30" 30 result

(** Verifies that nested negation is correctly evaluated inside a larger
    expression *)
let test_nested_neg_eval () =
  let result =
    eval (Add (Neg (Add (Int 2, Int 3)), Mul (Int 4, Neg (Int 2))))
  in
  Alcotest.check Alcotest.int "(-(2 + 3) + (4 * -2)) = -13" (-13) result

(** Verifies that integer division is correctly evaluated inside nested
    arithmetic *)
let test_nested_div_eval () =
  let result =
    eval (Div (Mul (Add (Int 8, Int 4), Sub (Int 7, Int 2)), Int 6))
  in
  Alcotest.check Alcotest.int "(((8 + 4) * (7 - 2)) / 6) = 10" 10 result

(** Verifies that a larger arithmetic tree is correctly evaluated *)
let test_deeply_nested_eval () =
  let result =
    eval
      (Sub
         ( Add (Mul (Int 2, Add (Int 3, Int 4)), Div (Int 20, Int 5)),
           Neg (Sub (Int 6, Int 9)) ))
  in
  Alcotest.check Alcotest.int "((2 * (3 + 4)) + (20 / 5)) - -(6 - 9) = 15" 15
    result

(** List of all eval-related tests *)
let eval_tests =
  [
    ("one integer expression", `Quick, test_integer_eval);
    ("simple addition expresion", `Quick, test_add_two_nums_eval);
    ("simple subtraction expression", `Quick, test_sub_two_nums_eval);
    ("simple multiplication expression", `Quick, test_mul_two_nums_eval);
    ("simple division expression", `Quick, test_div_two_nums_eval);
    ("positive num negation expression", `Quick, test_neg_pos_num_eval);
    ("negative num negation expression", `Quick, test_neg_neg_num_eval);
    ("nested addition expression", `Quick, test_nested_add_eval);
    ("nested subtraction expression", `Quick, test_nested_sub_eval);
    ("nested mixed ops expression", `Quick, test_nested_mixed_ops_eval);
    ("nested negation expression", `Quick, test_nested_neg_eval);
    ("nested division expression", `Quick, test_nested_div_eval);
    ("deeply nested expression", `Quick, test_deeply_nested_eval);
  ]

(*********************************************************************************)

(* Pretty print tests *)

(** Verifies that an integer expression is correctly pretty printed *)
let test_integer_pretty () =
  let result = pretty (Int 1) in
  Alcotest.check Alcotest.string "Int 1 = 1" "1" result

(** Verifies that a simple, non-nested addition expression is correctly pretty
    printed *)
let test_add_two_nums_pretty () =
  let result = pretty (Add (Int 1, Int 2)) in
  Alcotest.check Alcotest.string "(Add(Int 1, Int 2) = (1+2)" "(1+2)" result

(** Verifies that a simple, non-nested subraction expression is correctly pretty
    printed *)
let test_sub_two_nums_pretty () =
  let result = pretty (Sub (Int 3, Int 1)) in
  Alcotest.check Alcotest.string "(Sub(Int 3, Int 1) = (3-1)" "(3-1)" result

(** Verifies that a simple, non-nested multiplication expression is correctly
    pretty printed *)
let test_mul_two_nums_pretty () =
  let result = pretty (Mul (Int 2, Int 3)) in
  Alcotest.check Alcotest.string "(Mul(Int 2, Int 3) = (2*3)" "(2*3)" result

(** Verifies that a simple, non-nested division expression is correctly pretty
    printed *)
let test_div_two_nums_pretty () =
  let result = pretty (Div (Int 6, Int 3)) in
  Alcotest.check Alcotest.string "(Div(Int 6, Int 3) = (6/3)" "(6/3)" result

(** Verifies that a negation expression is correctly pretty printed on a
    positive number *)
let test_neg_pos_num_pretty () =
  let result = pretty (Neg (Int 1)) in
  Alcotest.check Alcotest.string "(Neg(Int 1) = (-1)" "(-1)" result

(** Verifies that a negation expression is correctly pretty printed on a
    negative number *)
let test_neg_neg_num_pretty () =
  let result = pretty (Neg (Int (-1))) in
  Alcotest.check Alcotest.string "(Neg(Int (-1)) = (--1)" "(--1)" result

(** Verifies that a nested addition expression is correctly pretty printed *)
let test_nested_add_pretty () =
  let result = pretty (Add (Add (Int 1, Int 2), Add (Int 3, Int 4))) in
  Alcotest.check Alcotest.string "((1+2)+(3+4))" "((1+2)+(3+4))" result

(** Verifies that nested subtraction preserves the explicit AST structure when
    pretty printed *)
let test_nested_sub_pretty () =
  let result = pretty (Sub (Sub (Int 10, Int 3), Sub (Int 4, Int 1))) in
  Alcotest.check Alcotest.string "((10-3)-(4-1))" "((10-3)-(4-1))" result

(** Verifies that a nested expression with mixed binary operators is correctly
    pretty printed *)
let test_nested_mixed_ops_pretty () =
  let result = pretty (Mul (Add (Int 2, Int 3), Sub (Int 10, Int 4))) in
  Alcotest.check Alcotest.string "((2+3)*(10-4))" "((2+3)*(10-4))" result

(** Verifies that nested negation is correctly pretty printed inside a larger
    expression *)
let test_nested_neg_pretty () =
  let result =
    pretty (Add (Neg (Add (Int 2, Int 3)), Mul (Int 4, Neg (Int 2))))
  in
  Alcotest.check Alcotest.string "((-(2+3))+(4*(-2)))"
    "((-(2+3))+(4*(-2)))" result

(** Verifies that integer division is correctly pretty printed inside nested
    arithmetic *)
let test_nested_div_pretty () =
  let result =
    pretty (Div (Mul (Add (Int 8, Int 4), Sub (Int 7, Int 2)), Int 6))
  in
  Alcotest.check Alcotest.string "(((8+4)*(7-2))/6)" "(((8+4)*(7-2))/6)"
    result

(** Verifies that a larger arithmetic tree is correctly pretty printed *)
let test_deeply_nested_pretty () =
  let result =
    pretty
      (Sub
         ( Add (Mul (Int 2, Add (Int 3, Int 4)), Div (Int 20, Int 5)),
           Neg (Sub (Int 6, Int 9)) ))
  in
  Alcotest.check Alcotest.string "(((2*(3+4))+(20/5))-(-(6-9)))"
    "(((2*(3+4))+(20/5))-(-(6-9)))" result

(** List of all pretty-print-related tests *)
let pretty_tests =
  [
    ("one integer expression", `Quick, test_integer_pretty);
    ("simple addition expresion", `Quick, test_add_two_nums_pretty);
    ("simple subtraction expression", `Quick, test_sub_two_nums_pretty);
    ("simple multiplication expression", `Quick, test_mul_two_nums_pretty);
    ("simple division expression", `Quick, test_div_two_nums_pretty);
    ("positive num negation expression", `Quick, test_neg_pos_num_pretty);
    ("negative num negation expression", `Quick, test_neg_neg_num_pretty);
    ("nested addition expression", `Quick, test_nested_add_pretty);
    ("nested subtraction expression", `Quick, test_nested_sub_pretty);
    ("nested mixed ops expression", `Quick, test_nested_mixed_ops_pretty);
    ("nested negation expression", `Quick, test_nested_neg_pretty);
    ("nested division expression", `Quick, test_nested_div_pretty);
    ("deeply nested expression", `Quick, test_deeply_nested_pretty);
  ]

(** Entry point for Alcotest test runner. *)
let () = Alcotest.run "miniml tests" [ ("eval", eval_tests); ("pretty", pretty_tests) ]
