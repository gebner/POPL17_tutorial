import tools.super
open super tactic monad

set_option trace.super true

-- 1. what is a superposition prover?

-- 1a. clausification

example (a b : Prop) (negated_conjecture : ¬(a ∨ b → ¬b → a)) :
  true := by do
as_clause ← get_local `negated_conjecture >>= clause.of_classical_proof,
cnf ← get_clauses_classical [as_clause],
trace "clause normal form:", trace cnf,
trace "actual types:", trace (do c ← cnf, [c^.type]),
triv

example (negated_conjecture : ¬∃x:ℕ, ∀y, x ≤ y) : true := by do
as_clause ← get_local `negated_conjecture >>= clause.of_classical_proof,
cnf ← get_clauses_classical [as_clause],
trace_state,
trace "clause normal form:", trace cnf,
triv

-- 1b. inferences

meta def term_ordering (e₁ e₂ : expr) := ff

example (P : ℕ → ℕ → Prop) (c1 : ∀x,  P x 1)
                           (c2 : ∀y, ¬P 2 y) : false := by do
c1 ← get_local `c1 >>= clause.of_classical_proof,
c2 ← get_local `c2 >>= clause.of_classical_proof,
trace c1, trace c2,
resolvent ← try_resolve term_ordering c1 c2 0 0,
trace resolvent,
exact resolvent^.proof

-- 1c. subsumption

example (P : ℕ → Prop)
        (c1 : ∀x, P (2*x) ∨ P (3*x))
        (c2 : ∀y, P y) : true := by do
c1 ← get_local `c1 >>= clause.of_classical_proof,
c1 ← get_clauses_classical [c1], c1 ← returnopt $ c1^.nth 0,
c2 ← get_local `c2 >>= clause.of_classical_proof,
ss ← does_subsume c2 c1,
trace $ "subsumes: " ++ to_string ss,
triv

-- 1d. term ordering

-- 2. implementation
-- 2a. state transformer

-- 3. examples

example : ∀x y : ℕ, x>0 ∨ y>0 → x+y>0 :=
by super with nat.le_add_left nat.add_comm nat.le_trans
example : ∀x y z : ℕ, x>0 ∨ y>0 ∨ z>0 → x+z+y>0 :=
by super with nat.le_add_left nat.add_comm nat.le_trans nat.add_assoc
example : ∀x y z : ℕ, ∃w, x>1 ∨ y>2 ∨ z>3 → x+z+y > w :=
by super with nat.le_add_left nat.add_comm nat.le_trans nat.add_assoc

example (a b c : nat) : a ∈ [b, c] ++ [b, a+0, b] := by super
example (a b c : nat) : a ∈ [b, c] ++ [b, c, c] ++ [b, a+0, b] := by super

example (α) [weak_order α] (x y z : α) :
  x ≤ y ∧ y ≤ z ∧ z ≤ x  →  x = y ∧ y = z :=
by super with weak_order.le_trans weak_order.le_antisymm

-- TODO: use super to shuffle quantifiers around / restate theorems
