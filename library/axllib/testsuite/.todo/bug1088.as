--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA14794; Sun, 9 Jun 96 17:30:03 BST
--* Received: from mendel.inf.ethz.ch (bronstei@mendel.inf.ethz.ch [129.132.12.20]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id SAA21198 for <ax-bugs@nag.co.uk>; Sun, 9 Jun 1996 18:24:22 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by mendel.inf.ethz.ch (8.6.10/8.6.10) id SAA24533 for ax-bugs@nag.co.uk; Sun, 9 Jun 1996 18:24:20 +0200
--* Date: Sun, 9 Jun 1996 18:24:20 +0200
--* Message-Id: <199606091624.SAA24533@mendel.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [7] optimizer generates (never called) garbage

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -q2 -fc negshift.as
-- Version: 1.1.6
-- Original bug file name: negshift.as

-------------------------------- negshift.as ----------------------------------
-- 
-- The optimizer seems to generate "interesting" code on this example:
--
-- % axiomxl -q2 -fc negshift.as
--
--     Then in negshift.c we find:
--
-- static FiClos
-- CF9_foo(e1, P0_M, P1_m)
--         FiEnv e1;
--         FiWord P0_M;
--         FiWord P1_m;
-- {
--         FiWord T0, T1, T2, T6, T7, T8, T13, T14, T15;
--         FiSInt T3, T4, T5, T9, T10, T11, T12;
--         [...]
--         T3 = -1;
--         if (T3 > 0) goto L0;
--         [...]
-- L0:	T0 = (FiWord) ((FiSInt) T2 << -1);
--         goto L1;
-- }
--
-- The negative shift in L0 causes a warning in gcc. Of course, it never gets
-- called, so it's not too harmful, but there could be something worse
-- lurking in there. Note that the assignment T3 = -1 followed by if (T3 > 0)
-- is NOT generated at -q1
--

#include "axllib"

macro SI == SingleInteger;

Foo(R:EuclideanDomain): with {
	foo:	(R,R) -> (R,R) 	-> R;
	if R has IntegerNumberSystem then foo: (R, SI) -> (R, SI) -> R;
	bar:	(List R,List R)	->	R;
} == add {
	foo(M:R, m:R):(R,R) -> R == { (A:R, a:R):R +-> A + a; }

	if R has IntegerNumberSystem then {
		foo(M:R, m:SI):(R,SI) -> R == {
			import from Integer;
			mz := m::R;
			mover2 := shift(m, -1);
			s := mod_/(1, retract(M rem mz), m);
			(A:R, a:SI):R +-> {
				aa := retract(A rem mz);
				if a < 0 then a := a + m;
				aminusA := {
					aa < 0 => mod_+(a, -aa, m);
					mod_-(a, aa, m);
				}
				b := mod_*(s, aminusA, m);
				if b > mover2 then b := b - m;
				A + (b::R) * M;
			}
		}
	}

	bar(p:List R, m:List R):R == first p;
}
