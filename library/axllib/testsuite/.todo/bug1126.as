--* From adk@mailer.scri.fsu.edu  Fri Jul 11 20:10:17 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA24966; Fri, 11 Jul 97 20:10:17 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id UAA18747 for <ax-bugs@nag.co.uk>; Fri, 11 Jul 1997 20:11:34 +0100 (BST)
--* Received: from ibm4.scri.fsu.edu (ibm4.scri.fsu.edu [144.174.131.4]) by mailer.scri.fsu.edu (8.8.5/8.7.5) with ESMTP id PAA01969; Fri, 11 Jul 1997 15:10:00 -0400 (EDT)
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm4.scri.fsu.edu (8.8.5) id TAA33474; Fri, 11 Jul 1997 19:07:05 GMT
--* Date: Fri, 11 Jul 1997 19:07:05 GMT
--* Message-Id: <199707111907.TAA33474@ibm4.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs@nag.co.uk, edwards@scri.fsu.edu
--* Subject: [3] import from T does not recognise T

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Mno-mactext -Ginterp dp-bug.as
-- Version: 1.1.9a
-- Original bug file name: bugs/dp-bug.as

--+ AXIOM-XL version 1.1.9a for AIX RS/6000 
--+ "foo.as", line 12:     import from Rep, T
--+                    .....................^
--+ [L12 C22] #1 (Error) No meaning for identifier `T'.
--+ 
--+ "foo.as", line 19: 
--+         element(explode rep a, i) ~= element(explode rep b, i) => false
--+ ................^............................^
--+ [L19 C17] #2 (Error) Argument 1 of `element' did not match any possible parameter type.
--+     The rejected type is T.
--+     Expected type Tuple(BasicType).
--+ 
--+ "foo.as", line 28:         p << element(explode rep a, i) << " "
--+                    .....................^
--+ [L28 C22] #4 (Error) Argument 1 of `element' did not match any possible parameter type.
--+     The rejected type is T.
--+     Expected type Tuple(BasicType).
--+ 
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    4.3 s  0  2  1  2 .5 .5  0 .2  0  1 94  0  0  0  0  0  0  0 %
--+ 
--+  Source  220 lines,  3048 lines per minute
--+  Store  2524 K pool
#include "axllib"
#pile

SI ==> SingleInteger

DP(T: Tuple BasicType): BasicType with
    dp: T -> %

  == add
    Rep == Record T

    import from Rep, T

    dp(t:T):% == per [t]

    (a:%) = (b:%):Boolean ==
      import from SI, Segment SI
      for i:SI in 1 .. length T repeat
        element(explode rep a, i) ~= element(explode rep b, i) => false
      true

    sample:% == 1$SI pretend %	-- this is just a hack

    (p:TextWriter) << (a:%):TextWriter ==
      import from SI, Segment SI
      p << "DP( "
      for i:SI in 1 .. length T repeat
        p << element(explode rep a, i) << " "
      p << ")"

test():() ==
  import from SI, Float
  D == DP(SI, Float)

  d: D == dp(3,3.14159)

  print << "d = " << d << newline
