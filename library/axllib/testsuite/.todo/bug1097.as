--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA15863; Fri, 6 Sep 96 10:21:44 BST
--* Received: from ru8.inf.ethz.ch (bronstei@ru8.inf.ethz.ch [129.132.12.17]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id LAA24004 for <ax-bugs@nag.co.uk>; Fri, 6 Sep 1996 11:15:33 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (from bronstei@localhost) by ru8.inf.ethz.ch (8.7.1/8.7.1) id LAA27315 for ax-bugs@nag.co.uk; Fri, 6 Sep 1996 11:15:32 +0200 (MET DST)
--* Date: Fri, 6 Sep 1996 11:15:32 +0200 (MET DST)
--* Message-Id: <199609060915.LAA27315@ru8.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [1] bad inference with conditional exports

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.7a
-- Original bug file name: badinfer.as

------------------------------  badinfer.as ---------------------------------
--
-- This file produces 2 separate inference problems with conditions (1.1.7a)
-- The second one is very sensitive to small code changes, for example it
-- does not occur if either baz is not local, or if bar does not return a pair.
--
-- % axiomxl -m2 badinfer.as
-- "badinfer.as", line 33: 
--         if R has FiniteField then foo(a:P):P == a quo a;
-- ..................................................^
-- [L33 C51] #1 (Error) There are no suitable meanings for the operator `quo'.
-- The following could be suitable if imported:
--   quo: (P, P) -> P from P, if R has Field
--  
-- "badinfer.as", line 40:                         inv(down a) * a;
--                         ........................^
-- [L40 C25] #2 (Error) There are no suitable meanings for the operator `inv'.
-- The following could be suitable if imported:
--   inv: R -> R from R, if R has Field
--

#include "axllib"

MyCat(R:Ring):Category == with {
	down: % -> R;
	if R has Field then EuclideanDomain;
}

InferenceBugs(R:Ring, P:MyCat R): with {
		foo:	P -> P;
		bar:    P -> (R, P);
} == add { 
	if R has FiniteField then foo(a:P):P == a quo a;

	bar(a:P):(R, P) == { R has Field => (1, baz a); (1, a); }

	if R has Field then {
		local baz(a:P): P == {
			import from R;
			inv(down a) * a;
		}
	}
}
