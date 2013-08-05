--* From mnd@knockdhu.dcs.st-and.ac.uk  Mon May 22 15:03:45 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA06369
--* 	for <ax-bugs@nag.co.uk>; Mon, 22 May 2000 15:03:43 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA19662
--* 	for ax-bugs@nag.co.uk; Mon, 22 May 2000 15:09:51 +0100
--* Date: Mon, 22 May 2000 15:09:51 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200005221409.PAA19662@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] Select statements don't work yet

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p5
-- Original bug file name: sel00.as


#include "axllib"

main(a:SingleInteger):() ==
{
   select a in
   {
      0 => print << "Zero." << newline;
      1 => print << "One." << newline;
      print << "Ooops" << newline;
   }

   print << ">> Done <<" << newline;
}


main(42);

