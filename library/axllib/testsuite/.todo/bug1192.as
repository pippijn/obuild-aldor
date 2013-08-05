--* From hemmecke@kernel.risc.uni-linz.ac.at  Sun Feb 20 23:04:17 2000
--* Received: from kernel.risc.uni-linz.ac.at (root@kernel.risc.uni-linz.ac.at [193.170.37.225])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id XAA01910
--* 	for <ax-bugs@nag.co.uk>; Sun, 20 Feb 2000 23:04:16 GMT
--* Received: from iapetus.risc.uni-linz.ac.at (root@iapetus.risc.uni-linz.ac.at [193.170.36.25])
--* 	by kernel.risc.uni-linz.ac.at (8.9.2/8.9.2/Debian/GNU) with ESMTP id AAA03421
--* 	for <ax-bugs@nag.co.uk>; Mon, 21 Feb 2000 00:05:16 +0100 (CET)
--* From: hemmecke@risc.uni-linz.ac.at
--* Received: (from hemmecke@localhost)
--* 	by iapetus.risc.uni-linz.ac.at (8.9.3/8.9.3/Debian/GNU) id AAA30458
--* 	for ax-bugs@nag.co.uk; Mon, 21 Feb 2000 00:05:16 +0100
--* Date: Mon, 21 Feb 2000 00:05:16 +0100
--* Message-Id: <200002202305.AAA30458@iapetus.risc.uni-linz.ac.at>
--* To: ax-bugs@nag.co.uk
--* Subject: [1] problem with courtesy conversion

--@ Fixed  by: <Who> <Date>
30 Mar 2000 TTT: workaround is to separate the two definitions in two files.
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -DC1 -DC2 xxx.as
-- Version: Aldor version 1.1.12p2 for LINUX(glibc)
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 20-FEB-2000
-- Aldor version 1.1.12p2 for SPARC [Solaris: GCC] 
-- Subject: problem with courtesy conversion

-- This code works fine with
--   axiomxl xxx.as

-- However, 
--   axiomxl -DC1 -DC2 xxx.as
-- yields

--:Aldor version 1.1.12p2 for LINUX(glibc) 
--:"bug.as", line 2873:         foo(U: Generator %): () == step! U;
--:                     .........................................^
--:[L2873 C42] #1 (Error) Argument 1 of `step!' did not match any possible parameter type.
--:    The rejected type is Generator(%).
--:    Expected type Generator(%).



-- The option C1 alone seems to indicate where one has to look for the
-- real error.
--   axiomxl -DC1 xxx.as

--:"bug.as", line 2870: 
--:                    ("inducedDivision", inducedDivision!(<)),
--:.....................^
--:[L2870 C22] #1 (Error) Argument 1 of `bracket' did not match any possible parameter type.
--:    The rejected type is String, Generator(%) -> ().
--:    Expected type Cross(String, Generator(%) -> ()).


-- I need something like C1+C2. Is there a simple workaround?


#include "axllib"
G% ==> Generator %;

define CalixPartialDivisionCategory: Category == with {
	<: (%, %) -> Boolean;
	division: String -> G% -> ();
	divisionII!:	    G% -> ();
	inducedDivision!:   G% -> ();
	inducedDivision!:   ((%, %) -> Boolean) -> G% -> ();
	pommaret!:	    G% -> ();
    default {
	division(m: String): G% -> () == {
		divisions: List Cross(String, G% -> ()) == [ 
		    ("inducedDivision", inducedDivision!(<)),
		    ("pommaret", pommaret!)
		];
		error "";
	}

	divisionII!(U: G%): () == {}
#if C2
	inducedDivision!(less?: (%, %) -> Boolean)(U: G%): () == {}
#endif
	pommaret!(U: G%): () == {}
    } -- end default
}

define CalixPartialDivisionPowerProductCategory: Category ==
    CalixPartialDivisionCategory with {
    default {
	foo(U: Generator %): () == step! U;
#if C1
	bar(Y: %): SingleInteger == 1;
#endif
    }
}
