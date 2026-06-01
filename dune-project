(lang dune 3.23)

(name miniml)

(generate_opam_files true)

(source
 (github ericdeon15/miniml))

(authors "Eric D'Eon <ericdeon15@gmail.com>")

(maintainers "Eric D'Eon <ericdeon15@gmail.com>")

(license MIT)

(documentation https://github.com/ericdeon15/miniml)

(package
 (name miniml)
 (synopsis "A small ML-style programming language implemented in OCaml")
 (description
  "MiniML is a small programming language built in OCaml.
   The project includes a lexer, parser, type checker, and interpreter
   implemented in OCaml using dune.")
 (depends
  ocaml
  dune)
 (tags
  ("compiler"
   "programming-language"
   "interpreter"
   "ocaml")))