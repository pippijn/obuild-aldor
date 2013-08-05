--* From bronstei@inf.ethz.ch  Thu Nov 14 09:38:55 1996
--* Received: from nags2.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA12953; Thu, 14 Nov 96 09:38:55 GMT
--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA14704; Thu, 14 Nov 96 09:45:43 GMT
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id KAA14346 for <ax-bugs@nag.co.uk>; Thu, 14 Nov 1996 10:38:59 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id KAA26193 for ax-bugs@nag.co.uk; Thu, 14 Nov 1996 10:38:58 +0100
--* Date: Thu, 14 Nov 1996 10:38:58 +0100
--* Message-Id: <199611140938.KAA26193@ru7.inf.ethz.ch>
--* To: ax-bugs@nag.co.uk
--* Subject: [1] improper "missing export" complaint

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.8
-- Original bug file name: missing.as

------------------------------ missing.as ---------------------------
--
-- TO REPRODUCE THIS BUG, YOU MUST BREAK THIS FILE INTO 2 FILES foo.as
-- AND bar.as, OTHERWISE THE BUG DOES NOT APPEAR
--
-- % axiomxl -m2 foo.as
-- % axiomxl -m2 bar.as
-- tfIf:<* If <* General (* (* (* R *) (* Field *) *) *) *> <* General (* (* (* (* bar *) (* (* -> *) (* (* a *) (* % *) *) (* SingleInteger *) *) *) (* (* (* (* a *) (* % *) *) *) (* SingleInteger *) (* *) *) *) *) *> <* Multiple *> *>
-- "bar.as", line 9: Baz(R:Ring):Bar R == add {
--                   .....................^
-- [L9 C22] #1 (Error) The domain is missing some exports.
--         if R has Field then
--                 The domain is missing some exports.
--
------------------------   foo.as   -----------------------
#include "axllib"

macro SI == SingleInteger;

Foo(R:Ring):Category == BasicType with {
	foo: SI -> %;
	if R has Field then bar: % -> SI;
}

Bar(R:Ring):Category == Foo R with {
	if R has Field then {
		default bar(a:%):SI == 0;
	}
}
------------------------   bar.as   -----------------------
#include "axllib"

#library lib "foo.ao"
import from lib;

macro SI  == SingleInteger;

Baz(R:Ring):Bar R == add {
	macro Rep == SI;

	import from Rep;

	(a:%) = (b:%):Boolean == false;
	(p:TextWriter) << (a:%):TextWriter == p;
	foo(n:SI):% == per n;
	sample:% == foo 1;

-- THISE IS CLAIMED TO BE "missing" BY 1.1.8,
-- ALTHOUGH IT IS PROVIDED AS DEFAULT BY Bar(R)
-- COMPILES OK IF THIS LINE IS UNCOMMENTED, GIVES "missing export" OTHERWISE
--	if R has Field then bar(a:%):SI == 0;
}

