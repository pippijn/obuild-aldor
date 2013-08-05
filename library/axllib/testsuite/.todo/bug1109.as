--* From bronstei@inf.ethz.ch  Mon Nov 18 15:12:58 1996
--* Received: from nags2.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA11440; Mon, 18 Nov 96 15:12:58 GMT
--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA22619; Mon, 18 Nov 96 15:19:22 GMT
--* Received: from ru8.inf.ethz.ch (bronstei@ru8.inf.ethz.ch [129.132.12.17]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id QAA08072 for <ax-bugs@nag.co.uk>; Mon, 18 Nov 1996 16:12:42 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (from bronstei@localhost) by ru8.inf.ethz.ch (8.7.1/8.7.1) id QAA14056 for ax-bugs@nag.co.uk; Mon, 18 Nov 1996 16:12:40 +0100 (MET)
--* Date: Mon, 18 Nov 1996 16:12:40 +0100 (MET)
--* Message-Id: <199611181512.QAA14056@ru8.inf.ethz.ch>
--* To: ax-bugs@nag.co.uk
--* Subject: [2] optimizer bug

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -q2 -fx -lminisumit optbug.as
-- Version: 1.1.8a
-- Original bug file name: optbug.as

---------------------- optbug.as --------------------------
--
-- YOU NEED minisumit TO REPRODUCE THIS BUG
--
-- % axiomxl -q2 -lminisumit -fx optbug.as
-- % optbug
-- p = 5
-- Segmentation fault
--
-- % axiomxl -q1 -lminisumit -fx optbug.as
-- % optbug
-- p = 5
-- p = 7
-- p = 11
-- p = 13
-- p = 17

#include "axllib"

#library minisumit "libminisumit.al"
import from minisumit;
inline from minisumit;

macro Z == SingleInteger;

Foo(L:ListCategory Z): with { foo: L -> List Z; } == add {
	foo(f:L):List Z == {
		import from Z, SmallPrimes;
		zero?(d := #f) => empty();
		d = 1 => [first f quo next first f];
		p:Z := 5;
		r := bar(f, p);
		while empty? r repeat {
			-- SEG FAULTS AT -q2 HAPPENS AT THE NEXT LINE
			p := nextPrime p;
			r := bar(f, p);
		}
		r;
	}

	local bar(f:L, p:Z):List Z == {
		print << "p = " << p << newline;
		p > 15 => [0];
		empty();
	}
}			

boom():() == {
	import from Z, List Z, Foo List Z;
	foo [1, 0, 0, 0, -1];
}

boom();
