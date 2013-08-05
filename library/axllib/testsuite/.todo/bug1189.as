--* From mnd@knockdhu.cs.st-andrews.ac.uk  Wed Jan 19 15:13:01 2000
--* Received: from knockdhu.cs.st-andrews.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA27519
--* 	for <ax-bugs@nag.co.uk>; Wed, 19 Jan 2000 15:12:58 GMT
--* Received: (from mnd@localhost)
--* 	by knockdhu.cs.st-andrews.ac.uk (8.8.7/8.8.7) id PAA22772
--* 	for ax-bugs@nag.co.uk; Wed, 19 Jan 2000 15:15:25 GMT
--* Date: Wed, 19 Jan 2000 15:15:25 GMT
--* From: mnd <mnd@knockdhu.cs.st-andrews.ac.uk>
--* Message-Id: <200001191515.PAA22772@knockdhu.cs.st-andrews.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [4][tinfer] Return value of assert() segfaults compiler

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p5
-- Original bug file name: assertbug.as

--+ 
--+ If an assert() is the last statement in a function which returns a value
--+ then the compiler will segfault. Seems as though it doesn't infer a type
--+ for assert().

#include "axllib"

foo():SingleInteger ==
{
   42;
   assert(true); -- Boom
}

import from SingleInteger;

local bar:SingleInteger := foo();

