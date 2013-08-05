--* From Manuel.Bronstein@sophia.inria.fr  Mon Mar 22 20:33:23 1999
--* Received: from nirvana.inria.fr (bmanuel@nirvana.inria.fr [138.96.48.30])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id UAA17500 for <ax-bugs@nag.co.uk>; Mon, 22 Mar 1999 20:33:11 GMT
--* Received: by nirvana.inria.fr (8.8.8/8.8.5) id VAA24795 for ax-bugs@nag.co.uk; Mon, 22 Mar 1999 21:32:47 +0100
--* Date: Mon, 22 Mar 1999 21:32:47 +0100
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <199903222032.VAA24795@nirvana.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [2] optimizer changes -1 to 255

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -q2 -fx optbug.as
-- Version: 1.1.12
-- Original bug file name: optbug3.as

------------------------------- optbug3.as ----------------------------------
--
-- TO REPROCUCE THIS BUG YOU NEED TO BREAK THIS FILE INTO 2 FILES:
--   mychar.as   AND  optbug.as
-- ISSUE THEN:
--  % axiomxl -q2 -fo -fao mychar.as
--  % axiomxl -q1 -fx optbug.as mychar.o      -- works ok when ran
--  % axiomxl -q2 -fx optbug.as mychar.o      -- infinite loop when ran
--
-- THE REASON IS THAT THE TEST  c = eof IS OPTIMIZED AS FOLLOWS AT -q2:
--         T0_c = (char) (FiSInt) T3;
-- L2:     if (T0_c == 255) goto L1;
-- SO THE -1 of mychar.as IS TRANSFORMED INTO 255 --> HAVOC
--
-- THIS BUG HAS BEEN VERIFIED ON DEC/OSF1 ONLY
--

------------------------  mychar.as --------------------------
#include "axllib"

MyChar: with {
	char:	SingleInteger -> %;
	eof:	%;
	=: (%, %) -> Boolean;
} == add {
	import from Machine;
	macro Rep == Char;

	char(i:SingleInteger):%	== per char(i::SInt);
	eof:%			== per char(-1@SInt);
	(a:%) = (b:%):Boolean	== (rep a = rep b)::Boolean;
}

------------------------  optbug.as --------------------------
#include "axllib"

#library foo "mychar.ao"
import from foo;
inline from foo;

import {
	fopen: (String, String) -> Pointer;
	fgetc: Pointer -> SingleInteger;
} from Foreign "C";

local scan!(p:Pointer):MyChar == {
	n := fgetc p;
	char n;
}

main():() == {
	import from Pointer, MyChar;
	p := fopen("mychar.as", "r");
	~nil? p => {
		c := scan! p;
		while ~(c = eof) repeat c := scan! p;
	}
}

main();
