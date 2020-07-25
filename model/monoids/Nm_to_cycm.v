(* Copyright © 1998-2006
 * Henk Barendregt
 * Luís Cruz-Filipe
 * Herman Geuvers
 * Mariusz Giero
 * Rik van Ginneken
 * Dimitri Hendriks
 * Sébastien Hinderer
 * Bart Kirkels
 * Pierre Letouzey
 * Iris Loeb
 * Lionel Mamane
 * Milad Niqui
 * Russell O’Connor
 * Randy Pollack
 * Nickolay V. Shmyrev
 * Bas Spitters
 * Dan Synek
 * Freek Wiedijk
 * Jan Zwanenburg
 *
 * This work is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This work is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along
 * with this work; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *)

Require Export CoRN.algebra.CMonoids.
Require Export CoRN.model.monoids.Nmonoid.

Section p71E1.

(**
** A function from the natural numbers to a cyclic monoid
%\begin{convention}%
Let [M:CMonoid], [c:M] and
[is_generated_by: forall(m:M),{n:nat | (power_CMonoid c n)[=]m}].
%\end{convention}%
*)

Variable M:CMonoid.
Variable c:M.

Definition power_CMonoid_CSetoid: M-> nat_as_CSetoid -> M.
Proof.
 simpl.
 exact (@power_CMonoid M).
Defined.

Variable is_generated_by: forall(m:M),{n:nat | (power_CMonoid c n)[=]m}.

Let f:= fun (H:forall(m:M),{n:nat | (power_CMonoid c n)[=]m})=>
  fun (n:nat_as_CMonoid)=> power_CMonoid c n.

Lemma f_strext: (fun_strext (f is_generated_by)).
Proof.
 simpl.
 unfold fun_strext.
 simpl.
 double induction x y.
    unfold f.
    simpl.
    intro H.
    set (H1:=(ax_ap_irreflexive M (@cs_eq  M) (@cs_ap M))).
    unfold irreflexive in H1.
    unfold Not in H1.
    unfold ap_nat.
    intro H2.
    elim H1 with (cm_unit M).
     apply CSetoid_is_CSetoid.
    exact H.
   unfold ap_nat.
   intros n H H0.
   set (H1:= (O_S n)).
   intuition.
  unfold ap_nat.
  intros n H H0 H2.
  set (H1:= (O_S n)).
  cut (0=(S n)).
   intuition.
  intuition.
 intros n H n0 H0.
 unfold f.
 simpl.
 elim (@csg_op M).
 simpl.
 intros op op_strext H1.
 unfold bin_fun_strext in op_strext.
 set (H2:=(op_strext c c (power_CMonoid c n0) (power_CMonoid c n)H1)).
 elim H2.
  intros H3.
  set (H4:=(ap_irreflexive_unfolded M c H3)).
  elim H4.
 intro H3.
 unfold f in H0.
 set (H4:= (H0 n H3)).
 set (H5:= (not_eq_S n0 n)).
 unfold ap_nat in H4 |- *.
 unfold not in H5.
 intro H6.
 elim H5.
  intro H7.
  elim H4.
  exact H7.
 exact H6.
Qed.

Definition f_as_CSetoid_fun:=
(Build_CSetoid_fun nat_as_CMonoid M (f is_generated_by) f_strext).

Lemma surjective_f: (surjective f_as_CSetoid_fun).
Proof.
 unfold surjective.
 simpl.
 intro b.
 elim (is_generated_by b).
 intros m H.
 exists m.
 unfold f.
 exact H.
Qed.

End p71E1.
