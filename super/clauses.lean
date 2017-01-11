import tools.super
open super tactic monad

example (a b : ℕ → Prop) (h : ∀x, (¬a x → b x) ∧ ¬b x ∧ ¬a x) := by do

c ← get_local `h >>= clause.of_classical_proof,
trace c,

cs ← get_clauses_classical [c],
trace cs,

c0 ← returnopt $ cs^.nth 0,
c1 ← returnopt $ cs^.nth 1,
c2 ← returnopt $ cs^.nth 2,

trace c0^.type,
trace c0^.proof,

triv
