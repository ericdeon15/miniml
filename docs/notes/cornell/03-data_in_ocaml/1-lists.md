# Chapter 3.1: Standard Data Types

# Lists

## Key Ideas

- Lists are immutable
- Pattern matching is crucial for performing operations on lists
- Recursion on Ocaml lists can be optimized in its space complexity

## Important syntax

Building lists:

```ocaml
[];;        (* empty list is "nil" *)
e1::e2;;    (* cons operator :: *)
[e1;e2];;
```

Deep pattern mathching examples:

```ocaml
_::[]       (*matches all lists with exactly one element*)

_::_        (*matches all lists with at least one element*)

_::_::[]    (*matches all lists with exactly two elements*)

_::_::_::_  (*matches all lists with at least three elements*)
```

Immediate matches:

- When a function immediately pattern matches a paramter, use the `function` keyword to save loc

```ocaml
let rec sum lst =
 match lst with
   | [] -> 0
   | h::t -> h + sum t;;

let rec sum = function
   | [] -> 0
   | h::t -> h + sum t;;
```

These are equivalent

```ocaml
function
| p1 -> e1
| p2 -> e2

fun x ->
  match x with
    | p1 -> e1
    | p2 -> e2
```

## Things I Learned

- Lists in Ocaml have first-class status
- Lists are implemented as singly linked lists
- `[]` and `;` for creating lists is sytactic sugar for just using `::`
- All elements in a list must have the same type (static semantics)
- `list` is a type contructor (function that operates on types)
  - Given `int`, creates type `int list`
- `List.hd` and `List.tl` functions exist to get the head and tail, but it is not idiomatic to apply them directly to a list (raises exception for the case of an empty list)
- Lists are immutable, but the compiler helps to save space!
  - Lists derived from each other can share the same memory for shared elements
  - Safe because lists are immutable
- Dynamic semantics of pattern matching steps
  - Evaluate `e` to `v`
  - Match `v` against each pattern `p` in the order they appear
  - If no match, then raise a `Match_failure` exception
  - If match, then produce a variable bindings `b` between `v` and `pi`
  - Substitute bindings inside the corresponding expression `ei`, producing `e'`
  - Evaluate `e'` to value `v'`
  - Result of the match is `v'`
- Compiler also performs static checks for branch exhaustiveness and unused branches for pattern matching
  - Warnings are supplied to the programmer in both cases
- Tail-recusrive functions are important for optimization
  - Recursive functions that perform the function call as its last operation (i.e. tail call) are tail-recursive
  - Instead of using one stack frame per call, the frame for the caller can be popped before the callee frame is pushed, meaning one additional frame of height on the stack during operation
- Ocamldoc is like Javadoc but for Ocaml

so the result of the entire match expression is true.

## Things That Confused Me

## MiniML Connection

- Tail recursion is a great example of an optimization step
- Pattern matching is something that will be useful for static analysis and parsing

# Variants

## Key Ideas

- Variants allow us to define types similar to enums in Java

## Important Syntax

Defining a new variant type:

```ocaml
type element = Fire | Water | Air | Earth;;
```

Constructor names (the values of the vairant type) must be capitalized.

## Things I Learned

- There is no explicit mapping of a variant constructor to an `int`, dissimilar to languages like Java and its enums
- Variants are a sum type / one-of type
  - A value of the variant type is just one of its constructors

## Things That Confused Me

## Chapter Questions

# Unit Testing with OUnit

## Key Ideas

- OUnit is like JUnit but for Ocaml
- Supply a `printer` function to OUnit methods to see the values of failing tests
- Refactor testing methods whenver possible

## Important Syntax

Example OUnit code:

```ocaml
open OUnit2
open Sum

let tests = "test suite for sum" >::: [
  "empty"  >:: (fun _ -> assert_equal 0 (sum []));
  "one"    >:: (fun _ -> assert_equal 1 (sum [1]));
  "onetwo" >:: (fun _ -> assert_equal 3 (sum [1; 2]));
]

let _ = run_test_tt_main tests
```

Improved OUnit code:

```ocaml
let make_sum_test name expected_output input =
  name >:: (fun _ -> assert_equal expected_output (sum input) ~printer:string_of_int)

let tests = "test suite for sum" >::: [
  make_sum_test "empty" 0 [];
  make_sum_test "one" 1 [1];
  make_sum_test "onetwo" 3 [1; 2];
]

let _ = run_test_tt_main tests
```

## Things I Learned

- Ocaml has a testing library similar to JUnit

## Things That Confused Me

- I find the syntax of OUnit very interesting
- Is it possible to supply custom test failure messages, or only the `printer` function

## Chapter Questions

# Record

## Key Ideas

- Records are like structs in C

## Important Syntax

Record example:

```ocaml
type person = {name:string; age:int}

let me = {name = "Eric"; age = 22}

me.age;;    (*Access record field with dot notation*)
```

Record copy example:

```ocaml
let older_me = {
  eric with age = 23
}

older_me.name   (*The name (unspecified field) was copied over and is "Eric"*)
```

## Things I Learned

- Ocaml has a struct-like data type
- Records can be pattern matched
- There is syntax to create copies of records
- Records are a product type / each-of type
  - A value of record type provides each of its fields

## Things That Confused Me

## MiniML Connection

- When building a compiler in C, I used structs for representing declarations, expressions, statements, etc. –– records will most likely play a similar role in this project

## Chapter Questions

# Tuple

## Key Ideas

- Tuples differ from those in Python

## Things I Learned

- Tuples are:
  - Distinct fixed containers (not a sequence that can be iterated)
  - Rigid in their length
  - Composed of values indentified by their position
  - Indexable by pattern matching
- Tuples are a product type / each-of type
  - A value of tuple type provides each of its fields

# Advanced Pattern Matching

- p1 | ... | pn: an "or" pattern; matching against it succeeds if a match succeeds against any of the individual patterns pi, which are tried in order from left to right. All the patterns must bind the same variables.
- (p : t): a pattern with an explicit type annotation.
- c: here, c means any constant, such as integer literals, string literals, and booleans.
- 'ch1'..'ch2': here, ch means a character literal. For example, 'A'..'Z' matches any uppercase letter.
- when e: matches p but only if e evaluates to true.

See [this chapter subsection](https://courses.cs.cornell.edu/cs3110/2021sp/textbook/data/pattern_matching_examples.html) for an example of pattern matching best practices.
