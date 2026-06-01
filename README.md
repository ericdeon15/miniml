# MiniML

MiniML is an experimental ML-style programming language implemented in OCaml.  
The project is being developed as a systems and programming languages self-study focused on compiler and interpreter construction.

## Goals

The primary goals of MiniML are to explore:

- Abstract syntax tree (AST) design
- Lexing and parsing
- Static type checking
- Functional language semantics
- Interpreter and runtime implementation
- Compiler architecture and tooling
- Program analysis techniques

The language is heavily inspired by the ML family of languages, particularly OCaml.

---

## Planned Features

- Integer and boolean types
- Variables and lexical scoping
- First-class functions
- Pattern matching
- Algebraic data types
- Hindley–Milner-style type inference
- Recursive functions
- Modules and namespaces
- Bytecode or virtual machine backend
- Static analysis tooling

---

## Project Structure

```text
miniml/
├── dune-project
├── lib/
├── bin/
├── test/
└── README.md
```

As the project evolves, the codebase will likely be organized into components such as:

- Lexer
- Parser
- AST definitions
- Type checker
- Interpreter
- Optimizer
- Backend/runtime

---

## Building

### Requirements

- OCaml
- Dune

Recommended installation using OPAM:

```bash
opam install ocaml dune
```

### Build

```bash
dune build
```

### Run

```bash
dune exec miniml
```

---

## Development

This project is intended primarily as a learning and exploration project in:

- Programming language implementation
- Functional programming
- Compiler construction
- Static analysis
- Systems programming

The implementation is being written entirely in OCaml using the Dune build system.

---

## Resources

This project is being developed alongside material and ideas from:

- _Programming Languages: Build, Prove, and Compare_ by Benjamin Pierce
- Cornell CS3110 course notes and textbook
- _Crafting Interpreters_ by Robert Nystrom
- _Types and Programming Languages_ by Benjamin Pierce
- Real World OCaml
- OCaml documentation and Dune documentation

---

## License

MIT License
