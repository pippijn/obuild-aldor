--* From adk@mailer.scri.fsu.edu  Fri Jul  4 18:51:26 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA13065; Fri, 4 Jul 97 18:51:26 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id SAA05076 for <ax-bugs@nag.co.uk>; Fri, 4 Jul 1997 18:52:34 +0100 (BST)
--* Received: from ibm4.scri.fsu.edu (ibm4.scri.fsu.edu [144.174.131.4]) by mailer.scri.fsu.edu (8.8.5/8.7.5) with ESMTP id NAA22557; Fri, 4 Jul 1997 13:51:04 -0400 (EDT)
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm4.scri.fsu.edu (8.8.5) id RAA40892; Fri, 4 Jul 1997 17:48:07 GMT
--* Date: Fri, 4 Jul 1997 17:48:07 GMT
--* Message-Id: <199707041748.RAA40892@ibm4.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs@nag.co.uk, edwards@scri.fsu.edu
--* Subject: [2] `Have determined 1 possible types...' bug again!

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Ginterp countable-test.as > countable-test.log ## N.B., file libadk.al just contains countable.ao produce from countable.as sent in the previous bug report!
-- Version: 1.1.9a
-- Original bug file name: countable-test.as

--+ AXIOM-XL version 1.1.9a for AIX RS/6000 
--+ "countable-test.as", line 101:   for i in 1 .. 10 for z: DP37INT in all()
--+                                ...................^
--+ [L101 C20] #1 (Error) Have determined 1 possible types for the expression.
--+ 	Meaning 1: Generator(Integer)
--+ 
--+ "countable-test.as", line 102:     repeat print << "z = " << z << newline
--+                                ...........................^
--+ [L102 C28] #2 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- TextWriter
--+ The following could be suitable if imported:
--+   <<: (TextWriter, DP37INT) -> TextWriter from DP37INT, if BI37 has CountablyFinite(Integer), Integer has CountablyFinite(Integer)
--+   <<: (TextWriter, DP37INT) -> TextWriter from DP37INT, if not BI37 has CountablyFinite(Integer) and Integer has Countabl...
--+ 
--+ "countable-test.as", line 114:   for i in 1 .. 22 for z: DPINTINT in all()
--+                                ...................^
--+ [L114 C20] #3 (Error) Have determined 1 possible types for the expression.
--+ 	Meaning 1: Generator(Integer)
--+ 
--+ "countable-test.as", line 115:     repeat print << "z = " << z << newline
--+                                ...........................^
--+ [L115 C28] #4 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- TextWriter
--+ The following could be suitable if imported:
--+   <<: (TextWriter, DPINTINT) -> TextWriter from DPINTINT, if Integer has CountablyFinite(Integer), Integer has CountablyFinite(Integer)
--+   <<: (TextWriter, DPINTINT) -> TextWriter from DPINTINT, if not Integer has CountablyFinite(Integer) and Integer has Count...
--+ 
--+ "countable-test.as", line 117:   local millionth: DPINTINT == val 1000000
--+                                ...............................^
--+ [L117 C32] #5 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- Integer
--+           -- DPINTINT
--+   The context requires an expression of type DPINTINT.
--+ 
--+ "countable-test.as", line 120: 
--+     << " val " << ord millionth << " = " << millionth << newline
--+ ..................^
--+ [L120 C19] #6 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- Integer
--+ The following could be suitable if imported:
--+   ord: DPINTINT -> Integer from DPINTINT, if Integer has CountablyFinite(Integer), Integer has CountablyFinite(Integer)
--+   ord: DPINTINT -> Integer from DPINTINT, if not Integer has CountablyFinite(Integer) and Integer has Count...
--+ 
--+ "countable-test.as", line 131:   for i in 1 .. 22 for z: DPINTINTINT in all()
--+                                ...................^
--+ [L131 C20] #7 (Error) Have determined 1 possible types for the expression.
--+ 	Meaning 1: Generator(Integer)
--+ 
--+ "countable-test.as", line 132:     repeat print << "z = " << z << newline
--+                                ...........................^
--+ [L132 C28] #8 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- TextWriter
--+ The following could be suitable if imported:
--+   <<: (TextWriter, DPINTINTINT) -> TextWriter from DPINTINTINT, if Integer has CountablyFinite(Integer), DirectProduct(Integer, Integer, Integer) has CountablyFinite(I...
--+   <<: (TextWriter, DPINTINTINT) -> TextWriter from DPINTINTINT, if not Integer has CountablyFinite(Integer) and DirectProduct(Int...
--+ 
--+ "countable-test.as", line 134:   local millionth: DPINTINTINT == val 1000000
--+                                ..................................^
--+ [L134 C35] #9 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- Integer
--+           -- DPINTINTINT
--+   The context requires an expression of type DPINTINTINT.
--+ 
--+ "countable-test.as", line 137: 
--+     << " val " << ord millionth << " = " << millionth << newline
--+ ..................^
--+ [L137 C19] #10 (Error) No one possible return type satisfies the context type.
--+   These possible return types were rejected:
--+           -- Integer
--+ The following could be suitable if imported:
--+   ord: DPINTINTINT -> Integer from DPINTINTINT, if Integer has CountablyFinite(Integer), DirectProduct(Integer, Integer, Integer) has CountablyFinite(I...
--+   ord: DPINTINTINT -> Integer from DPINTINTINT, if not Integer has CountablyFinite(Integer) and DirectProduct(Int...
--+ [L137 C19] #11 (Fatal Error) Too many errors (use `-M emax=n' or `-M no-emax' to change the limit).
--+ 
#include "axllib.as"
#library libadk "libadk.al"
#pile

import from libadk

printIfHas(T: Type, tName: String, C: Category, cName: String): () ==
  if (T has C) then
    print << "The domain " << tName << " has " << cName << "." << newline

printHases(T: Type, name: String): () ==
  printIfHas(T, name, Countable Integer, "Countable Integer")
  printIfHas(T, name, Countable SingleInteger,  "Countable SingleInteger")
  printIfHas(T, name, CountablyFinite Integer, "CountablyFinite Integer")
  printIfHas(T, name, CountablyFinite SingleInteger, 
	              "CountablyFinite SingleInteger")
  printIfHas(T, name, CountablyInfinite Integer, 
		      "CountablyInfinite Integer")
  printIfHas(T, name, CountablyInfinite SingleInteger, 
		      "CountablyInfinite SingleInteger")

testBI(): () ==
  SI ==> SingleInteger
  import from SI
  BI37 == BoundedInteger(SI, 3, 7)
  import from BI37

  printHases(BI37, "BI37")
  print << "card = " << card << newline
  for x: BI37 in all() repeat print << "x = " << x << newline

  y: BI37 == coerce 5
  print << "y: BI37 == coerce 5 = " << y << newline
  print << "ord y = " << ord y << newline
  print << "val 2 = " << (val 2)@BI37 << newline
  print << "coerce y = " << coerce y << newline
  print << "y::SI::BI37 = " << y::SI::BI37 << newline
  print << "ord val 2 = " << ord((val 2)@BI37) << newline
  print << "val ord y = " << (val ord y)@BI37 << newline

testDP(): () ==
  SI ==> SingleInteger
  import from SI
  BI37 == BoundedInteger(SI, 3, 7)
  BI49 == BoundedInteger(SI, 4, 9)
  DP3749 == DirectProduct(SI, BI37, BI49)
  import from DP3749, BI37, BI49

  printHases(DP3749, "DP3749")

  for z: DP3749 in all() repeat print << "z = " << z << newline

  local dp55: DP3749 == coerce(5::BI37, 5::BI49)
  print << "dp55 = (5::BI37, 5::BI49)::DP3749 = " << dp55 << newline
  local
    a: BI37
    b: BI49
  (a, b) := coerce dp55
  print << "(a, b) := coerce dp55 = (" << a << ", " << b << ")" << newline

testCoerce(): () ==
  SI ==> SingleInteger
  import from SI
  BI22 == BoundedInteger(SI, -2, 2)

  x: BI22 == coerce(-1)$BI22
  print << "x: BI22 == coerce(-1)$BI22 = " << x << newline

testInt(): () ==
  import from Integer

  print << "Starting testInt..." << newline
  printHases(Integer, "Integer")

  for i in 1 .. 10 for z: Integer in all()
    repeat print << "z = " << z << newline

testSI(): () ==
  import from SingleInteger

  print << "Starting testSI..." << newline
  printHases(SingleInteger, "SingleInteger")

  for i: SingleInteger in 1 .. 10 for z: SingleInteger in all()
    repeat print << "z = " << z << newline

  x: SingleInteger == 42
  print . "x: SI == ~a, val x = ~a, ord x = ~a~n" . (<< x, << val x, << ord x)

testDPinf(): () ==
  import from Integer

  print << "Starting testDPinf..." << newline

  BI37 == BoundedInteger(Integer, 3, 7)
  DP37INT == DirectProduct(Integer, BI37, Integer)
  import from DP37INT

  printHases(DP37INT, "DP37INT")

  for i in 1 .. 10 for z: DP37INT in all()
    repeat print << "z = " << z << newline

testDPinfinf(): () ==
  import from Integer

  print << "Starting testDPinfinf..." << newline

  DPINTINT == DirectProduct(Integer, Integer, Integer)
  import from DPINTINT

  printHases(DPINTINT, "DPINTINT")

  for i in 1 .. 22 for z: DPINTINT in all()
    repeat print << "z = " << z << newline

  local millionth: DPINTINT == val 1000000

  print << "The millionth element of the sequence is" << newline
    << " val " << ord millionth << " = " << millionth << newline

testDPinfinfinf(): () ==
  import from Integer

  print << "Starting testDPinfinfinf..." << newline

  DPINTINTINT == DirectProduct(Integer, Integer,
                               DirectProduct(Integer, Integer, Integer))
  import from DPINTINTINT

  for i in 1 .. 22 for z: DPINTINTINT in all()
    repeat print << "z = " << z << newline

  local millionth: DPINTINTINT == val 1000000

  print << "The millionth element of the sequence is" << newline
    << " val " << ord millionth << " = " << millionth << newline

testFiniteSet(): () ==
  print << "Starting testFiniteSet..." << newline

  FS == FiniteSet("x", "y", "z", "poodle")
  import from FS, SingleInteger

  fList: List FS == [f for f: FS in all()]

  print << "fList = " << fList << newline

  x: FS == coerce "poodle"

  print << "x = " << x << ", ord(x) = " << ord.x << ", val(ord(x)) = "
    << (val ord x)@FS << newline

  print << "sample = " << sample$FS << newline

testDPCondExp(): () ==
  print << "Starting testDPCondExp..." << newline

  SINS ==> Join(Steppable, IntegerNumberSystem)
  SI ==> SingleInteger

  import from SI

  BI == BoundedInteger(SI, 4, 8)
  DP == DirectProduct(SI, BI, BI)

  print . "DP has CountablyFinite SI = ~a~n" . (<< (DP has CountablyFinite SI))

  f(D: CountablyFinite SI): () == print . "Hello from f~n"
#if BUG
  f(DP)
#else
  f(DP pretend CountablyFinite SI)
#endif

print << "Start test of BoundedInteger domain..." << newline
testBI()
testCoerce()
testDP()
testInt()
testSI()
testDPinf()
testDPinfinf()
testDPinfinfinf()
testFiniteSet()
testDPCondExp()
print << "... end of test" << newline
