import tools.super
open list

print prefix list.reverse_core

print tactic.interactive.generalize

lemma reverse_reverse_core {α} (xs ys : list α) : reverse_core (reverse_core xs ys) nil = reverse_core ys xs :=
begin generalize ys ys, induction xs, intro, refl, super list.reverse_core.equations._eqn_2 end