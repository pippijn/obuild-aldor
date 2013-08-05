--* From mnd@knockdhu.dcs.st-and.ac.uk  Tue Mar  7 12:33:47 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id MAA23386
--* 	for <ax-bugs@nag.co.uk>; Tue, 7 Mar 2000 12:33:36 GMT
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id MAA18714
--* 	for ax-bugs@nag.co.uk; Tue, 7 Mar 2000 12:39:13 GMT
--* Date: Tue, 7 Mar 2000 12:39:13 GMT
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200003071239.MAA18714@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] #pile then #include non-piled code fails

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See source
-- Version: 1.1.12p5
-- Original bug file name: incl00.as


-- Save the second part of this file (the bit between #if 0 ... #endif)
-- as `incl01.as'. Then compile this file and note the errors. Compiling
-- with -DOkay fixes the problem.
--
-- Perhaps piling ought to be turned off when a file is #included?

#include "axllib.as"

#if Okay
#else
#pile
#endif


#include "incl01.as"

----------------------------- incl01.as -----------------------------
#if 0
-- This file compiles perfectly well on its own. It is mean to be
-- included by `incl00.as'.

#include "axllib"

Foo:with
{
   foo: % -> %;
}
== add
{
   Rep == SingleInteger;

   foo(x:%):% == x;
}
#endif


