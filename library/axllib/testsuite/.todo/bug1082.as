--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA04955; Tue, 4 Jun 96 18:01:11 BST
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id SAA14366 for <ax-bugs@nag.co.uk>; Tue, 4 Jun 1996 18:55:44 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id SAA11216 for ax-bugs@nag.co.uk; Tue, 4 Jun 1996 18:55:44 +0200
--* Date: Tue, 4 Jun 1996 18:55:44 +0200
--* Message-Id: <199606041655.SAA11216@ru7.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [1] dependent types are broken

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.6
-- Original bug file name: deptype.as

------------------------ deptype.as ------------------------
--
-- Dependent types don't work in this example (no workaround in sight):
--
-- % axiomxl -m2 deptype.as 
-- "deptype.as", line 21:         #(f(r.P));
--                        .............^
-- [L21 C14] #1 (Error) Argument 1 of `f' did not match any possible parameter type.
--     The rejected type is P: List(S).
--     Expected type List(r(S)).
-- 

#include "axllib"

Foo(T:BasicType, L:ListCategory T): with { f: L -> L } == add { f(l:L):L == l };

macro REC == Record(S:BasicType, P:List S);

bang(r:REC):SingleInteger == {
	import from Foo(r.S, List(r.S));
	#(f(r.P));
}
