import tools.super

namespace imp
open tactic

@[reducible] def uname := string

inductive aexp
| val  : nat → aexp
| var  : uname → aexp
| plus : aexp → aexp → aexp

instance : decidable_eq aexp :=
by mk_dec_eq_instance

@[reducible] def value := nat

def state := uname → value

open aexp

def aval : aexp → state → value
| (val n)      s := n
| (var x)      s := s x
| (plus a₁ a₂) s := aval a₁ s + aval a₂ s

def updt (s : state) (x : uname) (v : value) : state :=
λ y, if x = y then v else s y

def asimp_const : aexp → aexp
| (val n)      := val n
| (var x)      := var x
| (plus a₁ a₂) :=
  match asimp_const a₁, asimp_const a₂ with
  | val n₁, val n₂ := val (n₁ + n₂)
  | b₁,     b₂     := plus b₁ b₂
  end

lemma aval_asimp_const (a : aexp) (s : state) : aval (asimp_const a) s = aval a s :=
begin
  induction a with n x a₁ a₂ ih₁ ih₂,
  repeat {reflexivity},
  unfold asimp_const aval,
  rewrite [-ih₁, -ih₂],
  cases (asimp_const a₁),
  repeat {cases (asimp_const a₂), repeat {reflexivity}}
end

end imp
