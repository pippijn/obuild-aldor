--* From mnd@knockdhu.dcs.st-and.ac.uk  Wed May 31 15:50:14 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA12444
--* 	for <ax-bugs@nag.co.uk>; Wed, 31 May 2000 15:50:12 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA10898
--* 	for ax-bugs@nag.co.uk; Wed, 31 May 2000 15:56:03 +0100
--* Date: Wed, 31 May 2000 15:56:03 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200005311456.PAA10898@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [8][tinfer] tinfer of generate clauses is a wee bit weak

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun -laxllib bug1225.as
-- Version: 1.1.12p5
-- Original bug file name: gener00.as


#include "axllib"

foo():() ==
{
   local gen:SingleInteger == generate
   {
      yield 42;
      yield 67;
      yield 53;
   }

   for i in gen..20 repeat
      print << "i = " << i << newline;

   print << "That's all folks!" << newline;
}


foo();


