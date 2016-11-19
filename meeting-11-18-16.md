High level idea is to present Lean's abilities as a theorem prover, tactic language, and programming language. We also want
to highlight the modern approach to tooling. 

Our goals are then to cover the language as well as:

- profiler
- debugger
- Gabriel's parallel/incremental .olean compiler (if ready)
- native compiler
- automation
 
# First Hour
- high level introduction
 * Lean's core theory
 * Goals, design, etc 
 * We can repurpose Leo's [recent material](https://github.com/leanprover/presentations/tree/master/20161024_ICTAC)
- Present an IMP-like language fully verified, as an example, we can walk people through
  some basic proofs, Zach's input here would be good esp. with Street Fighting

# Second and Third Hour
- debugger
 * VM introspection API
- tactic framework 
 * defining tactics
 * using tactics
 * internal APIS
 * quasiquoting
 * meta programming
- profiler
 * show profiler? 
- parallel code generator
 * Gabriel's parallel/incremental .olean compiler (if ready)
 * flow change module B which depends on module A, 
   auto recompile and report errors for B & A, 
   works on partial modules even
- customize simplifier, other automation hooks
 * fill in here
- resolution prover as example of program & tactic? 
 * Use Gabriel's [resolution prover](https://github.com/leanprover/library_dev/tree/master/automation/super)

# Icing on the cake
- visual debugger mode
- more editor tricks
- easy install mechanism
  * update install methods & streamlined
  * Pacman for Arch & [Windows](http://msys2.github.io/)
  * PPA for [Ubuntu](https://github.com/leanprover/ppa-updater)
  * [Homebrew macOS](https://github.com/leanprover/homebrew-lean)
- Galois FFI support, we should start an email thread with them directly
- Increased basic automation
  * Leo is porting Blast/congruence closure to Lean3
  * Leo has plans for LIA/Omega like integer arithematic
- Documentation, Reference Manual 
  * Leo could add basic doc comment support which we (Leo, Sebastion and I) could use
    to build a Coq style reference manual docs, would be nice for the tutorial 
  * If Leo builds out parser extenions rest should be a couple half-days.

# Native Complier TODO-list
- native closures
- select optimizations (we need a benchmark  or set of benchmarks, consensus here would be good)
 * probably sTCE (self tail call elimination, mutual requires a lower representation) 
- heavy testing
- shared module compilation (a couple remanining pieces)
