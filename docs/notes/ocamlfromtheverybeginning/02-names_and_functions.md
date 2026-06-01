# Chapter 2: Names and Functions

## Key Ideas

- Ocaml is a functional language
- Variables and functions must be denoted by `let`
- Recursion is central to Ocaml programming

## Important syntax

Define variables and functions with the `let` keyword:

```ocaml
let x = 5;;
let double y = y * 2;;

double x;;
(* Result is 10 *)
```

Use the `let ... in` construct to chain declarations:

```ocaml
let x = 5 in x * 2;;
(* Result is also 10 *)
```

Recusrive functions are denoted with the `rec` keyword:

```ocaml
let rec factorial a =
  if a = 1
    then 1
  else
    a * factorial (a - 1);;

```

## Things I Learned

- Stack overflow errors in Ocaml give the hint for (looping recursion)?
- Types for functions are the types of the params followed by the type of the return value
  - Example for `double` function: int -> int

## Things That Confused Me

- Why do recursive functions need to be denoted by the `rec` keyword?

## MiniML Connection

- Seeing the hints in the error message in the chapter made me think of how important it is to have clear error messages in my own languages

## Chapter Questions
