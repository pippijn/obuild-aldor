--* From Manuel.Bronstein@sophia.inria.fr  Wed May 31 10:13:27 2000
--* Received: from droopix.inria.fr (IDENT:root@droopix.inria.fr [138.96.111.4])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id KAA05660
--* 	for <ax-bugs@nag.co.uk>; Wed, 31 May 2000 10:13:19 +0100 (BST)
--* Received: by droopix.inria.fr (8.10.0/8.10.0) id e4V9D5Q00857 for ax-bugs@nag.co.uk; Wed, 31 May 2000 11:13:05 +0200
--* Date: Wed, 31 May 2000 11:13:05 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <200005310913.e4V9D5Q00857@droopix.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [2] dependent type broken at compile-time

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p4
-- Original bug file name: deptype.as

----------------------------- deptype.as ----------------------------------
--
-- % axiomxl deptype.as
-- "deptype.as", line 29:         s := f empty();
--                        ...............^
-- [L29 C16] #1 (Error) Argument 1 of `f' did not match any possible parameter type.
--     The rejected type is List(Integer).
--     Expected type LR.
--

#include "axllib"

macro {
	Z == Integer;
	L == List Z;
}

Foo(R:Type): AbelianGroup with {
	foo: (LR:LinearAggregate R) -> LR -> %;
} == Z add {
	foo(s:Z):% == s pretend %;

	foo(LR:LinearAggregate R):LR -> % == { (l:LR):% +-> 0 }
}

main():() == {
	import from Z, List Z, Foo Z;
	f := foo(List Z);
	s := f empty();
}
