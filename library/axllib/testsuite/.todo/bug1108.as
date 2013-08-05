--* From bronstei@inf.ethz.ch  Mon Nov 18 13:03:42 1996
--* Received: from nags2.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA10316; Mon, 18 Nov 96 13:03:42 GMT
--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA22233; Mon, 18 Nov 96 13:09:50 GMT
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id OAA01280 for <ax-bugs@nag.co.uk>; Mon, 18 Nov 1996 14:03:02 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id OAA18918 for ax-bugs@nag.co.uk; Mon, 18 Nov 1996 14:03:01 +0100
--* Date: Mon, 18 Nov 1996 14:03:01 +0100
--* Message-Id: <199611181303.OAA18918@ru7.inf.ethz.ch>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] export not found at runtime

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.8a
-- Original bug file name: nilbug.as

------------------------------- nilbug.as ----------------------------------
--
-- THIS MIGHT BE CONNECTED TO BUG892 (still open)
-- % axiomxl -fx nilbug.as
-- % nilbug
-- Looking in NilRecord((SingleInteger, String)) for coerce with code 493023431
-- Export not found
--

#include "axllib"

NilRecord(T:Tuple Type): with {
	coerce: Record T -> %;
	nil: %;
	nil?: % -> Boolean;
	record: % -> Record T;
} == add {
	macro Rep == Pointer;

	import from Rep;

	nil?(r:%):Boolean	== nil? rep r;
	nil:%			== per(nil$Pointer);
	coerce(r:Record T):%	== per(r pretend Pointer);
	record(r:%):Record T	== r pretend Record T;
}

macro {
	REC == Record(a:SingleInteger, b:String);
	NREC == NilRecord(a:SingleInteger, b:String);
}

import from SingleInteger, String, REC, NREC;
r1:REC := [5, "hello"];
n1 := r1::NREC;
