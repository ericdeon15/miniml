# Chapter 3.2: Advanced Data Types

# Options

## Key Ideas

- Options represent a box being either full or empty
- Sort of similar to how objects can be null in Java

## Important Syntax

Defining options:

```ocaml
Some 15     (*Option has a value in it——type is int option*)

None        (*Option is empty––type is 'a option*)
```

## Things I Learned

- Options are preferred to exceptions because Ocaml forces programmers to handle the case of an empty option in pattern matching, where as this is not required for, say, null in Java
- `begin ... end` wrapping can be used on nested code (i.e. pattern matching) for clairty
  - Not a bad habit to pick up as code becomes more complex

## Things That Confused Me

## MiniML Connection

- If options are preferred over exceptions, I'll most likely find myself using them when writing my interpreter

## Chapter Questions

# Association Lists

## Key Ideas

- Simple implementation for a dictionary using lists and pairs
- Useful when performance isn't critical

## Important Syntax

Assoc list example:

```ocaml
let d = [("apples", 3); ("oranges", 7); ("bananas", 4)]
```

Assoc list functions:

```ocaml
(* insert a binding from key k to value v in association list d *)
let insert k v d = (k,v)::d

(* find the value v to which key k is bound, if any, in the assocation list *)
let rec lookup k = function
| [] -> None
| (k',v)::t -> if k=k' then Some v else lookup k t
```

## Things I Learned

- The standard library has functions for association lists (looke for List.assoc)
- Assoc lists aren't a built-in type, but rather a combination of types (lists and pairs)

## Things That Confused Me

## MiniML Connection

## Chapter Questions

# Type Synonyms

## Key Ideas

- We can create names for already existing types

## Important Syntax

Type synoym examples:

```ocaml
type point  = float * float
type vector = float list
type matrix = float list list
```

## Things I Learned

- Types can be aliased without having the one-of or each-of relationship of variants and records respectively (because no new type is actually being declared)

## Things That Confused Me

- If we define a type synonym, are all future pieces of data that have the same type of the synonym regarded as the new type? Can this causes issues?
  - Seems like semantic bugs can occur since no type safety is guaranteed, unlike in the instance of actually creating a new type

## MiniML Connection

## Chapter Questions

# Algebraic Data Types

## Key Ideas

- Vairants are powerful tools in Ocaml for creating complex types that can have data associated with them
- Vairants are unions, like in C
- Variants can recursive, paramterized, or polymporphic

## Important Syntax

- Example of a variant that contains data:

```ocaml
type shape =
  | Point  of point
  | Circle of point * float (* center and radius *)
  | Rect   of point * point (* lower-left and
                               upper-right corners *)
```

Pattern matching for this example:

```ocaml
let area = function
  | Point _ -> 0.0
  | Circle (_,r) -> pi *. (r ** 2.0)
  | Rect ((x1,y1),(x2,y2)) ->
      let w = x2 -. x1 in
      let h = y2 -. y1 in
        w *. h

let center = function
  | Point p -> p
  | Circle (p,_) -> p
  | Rect ((x1,y1),(x2,y2)) ->
      ((x2 +. x1) /. 2.0,
       (y2 +. y1) /. 2.0)
```

Example of a recursive variant:

```ocaml
type intlist = Nil | Cons of int * intlist
```

Example of a parameterized variant:

```ocaml
type 'a mylist = Nil | Cons of 'a * 'a mylist
(*mylist is not a type, but a type constructor*)
```

Example of a ploymorphic (anonymous) variant:

```ocaml
let f = function
  | 0 -> `Infinity
  | 1 -> `Finite 1
  | n -> `Finite (-n)
```

Polymorphic variants have no names, and their constrcutors must be preceeded by the `` ` `` character

The type of f is:

```ocaml
val f : int -> [> `Finite of int | `Infinity ]
```

The `>` denotes that any pattern matching on a value of this type must handle at least these constructors

## Things I Learned

- Vairants are referred to as algebraic data types
  - "Algebra" refers to the fact that variants contain both sum and product types
    - Sum types: The variant type itself forces variables to be only one of its values
    - Product types: Constructors can carry product types like tuples and records

- Variants are also referred to as tagged unions
  - The constructor tags each value of the vairant type

- We can create lists of different types using variants and keep everything type safe!

- To be careful of catch-all cases with variant types
  - If we have a pattern match where the last case is just the wildcard `_`, adding more constructors to the variant will cause them to match this pattern (most-likely) accidentally

- Types can be mutually recursive using the and keyword

- Record types can be recursive
  - Example:

```ocaml
type node = {value:int, next:node}
(*No way to construct since to make on node you need another node for the next already made*)
```

## Things That Confused Me

## MiniML Connection

- Variants where the constructors have data will prove immensley useful for:
  - Representing my AST
    - Without variants, can end up with
      - Tons of nullable fields
      - Unsafe casts
      - Giant structs/unions like in C
  - Naturally modeling recursive language structures
  - Guaranteeing structure correctness
  - Performing static analysis
  - Ease of transferring from grammar to code

- Recursive variants remind me so much of BNFs and the Bison code I wrote for my compiler project in school
- Polymorhpic variants are useful for libraries, but a bit unruly and hard to manage
- Both list and options in Ocaml are parameterized variants:
  ```ocaml
  type 'a list = [] | :: of 'a \* 'a list
  ```
  ```ocaml
    type 'a option = None | Some of 'a
  ```

## Chapter Questions

# Exceptions

## Key Ideas

-

## Important Syntax

Exception example:

```ocaml
let e = Failure "oops"
raise e
```

Try-catch in Ocaml:

```ocaml
let get_head l =
  match l with
  | [] -> failwith "Empty list has no head"
  | h::_ -> h

try get_head [] with
| Failure _ -> -1
```

## Things I Learned

- Exceptions are a type of extensible variant
  - These are variants that allow new constructors to be added to them after the variant is already defined
- Exceptions produce an exception packet
  - The packet contains the exception value, possible stack trace, and potentially more
  - Only `raise` and `try` recognize exception packets in Ocaml
  - Exceptions propagate up through expressions until they are caught or terminate the program

- Having test cases for exceptions in OUnit requires have a `fun () -> ...` around an expression
  - The extra anonymous function allows the `assert_raises` function to actually see and handle the exception

## Things That Confused Me

- Some of the exception semantics in the chapter were a little confusing

## MiniML Connection

## Chapter Questions

# Trees

## Syntax

Trees as tuples:

```ocaml
type 'a tree =
| Leaf
| Node of 'a * 'a tree * 'a tree

(* the code below constructs this tree:
         4
       /   \
      2     5
     / \   / \
    1   3 6   7
*)
let t =
  Node(4,
    Node(2,
      Node(1,Leaf,Leaf),
      Node(3,Leaf,Leaf)
    ),
    Node(5,
      Node(6,Leaf,Leaf),
      Node(7,Leaf,Leaf)
    )
  )
```

Trees as records:

```ocaml
type 'a tree =
  | Leaf
  | Node of 'a node

and 'a node = {
  value: 'a;
  left:  'a tree;
  right: 'a tree
}

(* represents
      2
     / \
    1   3  *)
let t =
  Node {
    value = 2;
    left  = Node {value=1; left=Leaf; right=Leaf};
    right = Node {value=3; left=Leaf; right=Leaf}
  }
```

## Things I Learned

- Just thought that this example of a preorder function that runs in linear time was interesting due the evaluation of the right side before the left
  - Cons of node value onto the accumulator argument (the accumulated values so far in that subtree) makes this odd evaluation work

```ocaml
let preorder_lin t =
  let rec pre_acc acc = function
    | Leaf -> acc
    | Node {value; left; right} -> value :: (pre_acc (pre_acc acc right) left)
  in pre_acc [] t
```

- Mutually recrusive functions can be flagged with `and`
  - Prevents the compiler from complaining that one function hasn't been defined yet
