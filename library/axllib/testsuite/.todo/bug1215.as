--* From mnd@knockdhu.dcs.st-and.ac.uk  Mon May 22 15:09:14 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA06509
--* 	for <ax-bugs@nag.co.uk>; Mon, 22 May 2000 15:09:11 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA19724
--* 	for ax-bugs@nag.co.uk; Mon, 22 May 2000 15:15:17 +0100
--* Date: Mon, 22 May 2000 15:15:17 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200005221415.PAA19724@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [6][tinfer] Void-return value in non-void context

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p5
-- Original bug file name: ex00.as


#include "axllib"

main(quickie?:Boolean):SingleInteger ==
{
   quickie? => return; -- Return without a value ...
   42;
}


import from SingleInteger;
print << main(true) << newline;

