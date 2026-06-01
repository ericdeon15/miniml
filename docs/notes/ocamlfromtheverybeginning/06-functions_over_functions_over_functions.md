# Chapter 6: Functions over Functions over Functions

## Key Ideas

- The map function allows us to take in a function and apply it to each value of a list
- One way to write anonymous functions is using the `fun` keyword
- Comparison functions of type 'a -> 'a -> bool help promote code reuse
- Functions in Ocaml are firt-class——they can be passed as parameters

## Important syntax

Map:

```ocaml
let rec map f l =
  match l with
  | [] -> []
  | h :: t -> f h :: map f t
```

Anonymous function:

```ocaml
fun x -> x / 2
```

Passing operators as functions:

```ocaml
( <= )
( + )
```

## Things I Learned

The type:

```text
(α -> β) -> α list -> β list
```

means:

- a function from α to β,
- then a list of α,
- returns a list of β.

The output list type depends on the function result type.

## Things That Confused Me

- Why `( <= )` works as a function

## MiniML Connection

- `map` is similar to recursive AST traversal patterns.
- Higher-order functions will probably be useful in:
  - optimization passes,
  - AST transforms,
  - static analysis utilities.
- Anonymous functions resemble compact transformation logic often used in compilers/tools.

## Chapter Questions

1. Write a simple recursive function `calm` to replace exclamation marks in a char list with periods.
   For example calm [’H’; ’e’; ’l’; ’p’; ’!’; ’ ’; ’F’; ’i’; ’r’; ’e’; ’!’]
   should evaluate to [’H’; ’e’; ’l’; ’p’; ’.’; ’ ’; ’F’; ’i’; ’r’; ’e’; ’.’].
   Now rewrite your function to use `map` instead of recursion. What are the types of your functions?

`calm` without `map`:

```ocaml
let rec calm l =
  match l with
  | [] -> []
  | h :: t ->
      (match h with
       | '!' -> '.'
       | _ -> h) :: calm t;;
```

It's type is:

```text
char list -> char list
```

`calm` with `map`:

```ocaml
let calm l =
  List.map
    (fun h ->
      match h with
      | '!' -> '.'
      | _ -> h)
    l;;
```

or

```ocaml
let calm l =
  List.map
    (function
      | '!' -> '.'
      | h -> h)
    l;;
```

Their type is:

```text
char list -> char list
```

6.

7.

8.
