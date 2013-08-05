--* From mnd@dcs.st-and.ac.uk  Wed Apr  4 14:03:07 2001
--* Received: from server-9.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id OAA02409
--* 	for <ax-bugs@nag.co.uk>; Wed, 4 Apr 2001 14:03:06 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 31354 invoked from network); 4 Apr 2001 13:01:11 -0000
--* Received: from host213-1-192-184.btinternet.com (HELO dcs.st-and.ac.uk) (213.1.192.184)
--*   by server-9.tower-4.starlabs.net with SMTP; 4 Apr 2001 13:01:11 -0000
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.11.0/8.11.0) id f34D1xQ02297
--* 	for ax-bugs@nag.co.uk; Wed, 4 Apr 2001 14:01:59 +0100
--* Date: Wed, 4 Apr 2001 14:01:59 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200104041301.f34D1xQ02297@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] Segfault at runtime

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See source
-- Version: 1.1.13(21)
-- Original bug file name: bug1304.as


-- Discovered when investigating bug 1295 (which wasn't a bug). We
-- get a segfault when this code is executed or interpreted.

#include "axllib"
SI ==> SingleInteger;
T ==> Tuple;
L ==> List;

import from L(T(SI));

#if LIST_OF_ONE_TUPLE
l1:L(T(SI)) := [(1,12)@Tuple(SI)];
#elseif LIST_OF_TWO_TUPLES
-- If you don't understand why this is a list of two (singleton) tuples
-- then read section 7.6 of AXLUG (courtesy conversions).
l1:L(T(SI)) := [(1,12)];
#else -- LIST_OF_TWO_TUPLES_WHICH_SEGFAULT
l1:L(T(SI)) := [1@Tuple(SI),12@Tuple(SI)];
#endif


-- This code will generate strange results for LIST_OF_TWO_TUPLES
-- because it assumes that the list contains tuples of two elements.
for e in l1 repeat
  print << length(e) << ": " << element(e,1)<<","<<element(e,2)<<newline;
print << newline;


