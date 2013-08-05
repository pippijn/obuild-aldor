--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA04888; Tue, 4 Jun 96 17:49:57 BST
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id SAA13977 for <ax-bugs@nag.co.uk>; Tue, 4 Jun 1996 18:44:23 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id SAA11174 for ax-bugs@nag.co.uk; Tue, 4 Jun 1996 18:44:22 +0200
--* Date: Tue, 4 Jun 1996 18:44:22 +0200
--* Message-Id: <199606041644.SAA11174@ru7.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [5] missed apply at compile time

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.6
-- Original bug file name: appl.as

------------------------ appl.as ------------------------
--
-- While goodprint compiles ok, badprint doesn't, although
-- the 2 should be equivalent.
--
-- % axiomxl -m2 appl.as
-- "appl.as", line 37:         print(r.P, x);
--                     ...............^
-- [L37 C16] #1 (Error) Argument 1 of `print' did not match any possible parameter type.
--     The rejected type is P: Bar(S).
--     Expected type String.
--

#include "axllib"

Foo(T:BasicType):Category == ListCategory(T) with {
	apply: (TextWriter, %, String) -> TextWriter;
}

Bar(T:BasicType):Foo(T) == List(T) add {
	macro Rep == List T;
	import from Rep;

	apply(port:TextWriter, l:%, x:String):TextWriter ==
		port << x << " --> " << rep l;
}

macro REC == Record(S:BasicType, P:Bar S);

goodprint(r:REC, x:String):() == {
	import from Bar(r.S);
	apply(print, r.P, x);
}

badprint(r:REC, x:String):() == {
	import from Bar(r.S);
	print(r.P, x);
}

