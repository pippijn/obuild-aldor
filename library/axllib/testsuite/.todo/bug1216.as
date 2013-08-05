--* From mnd@knockdhu.dcs.st-and.ac.uk  Mon May 22 15:19:39 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA06738
--* 	for <ax-bugs@nag.co.uk>; Mon, 22 May 2000 15:19:38 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA19892
--* 	for ax-bugs@nag.co.uk; Mon, 22 May 2000 15:25:46 +0100
--* Date: Mon, 22 May 2000 15:25:46 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200005221425.PAA19892@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [5] Loading enumerations from .ao files is flaky

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See header comments
-- Version: 1.1.12p5
-- Original bug file name: enbug.as


-------------------------------------------------------------------------
-- (1) Save as two files en00.as and enlib.as
-- (2) axiomxl -grun -laxllib en00.as [ought to print "2"]
-- (3) Compile enlib.as with -Fao
-- (4) axiomxl -DBUGGED -grun -laxllib en00.as enlib.ao [compile fails]
-------------------------------------------------------------------------


---------------------------- en00.as (start) ----------------------------
#include "axllib"

#if BUGGED
#library LL "enlib.ao"
import from LL;
#else
Colours == 'red,green,blue';
#endif

main():() ==
{
   import from Colours, SingleInteger;

   local colour:Colours;

   colour := blue;
   print << (colour pretend SingleInteger) << newline;
}


main();
----------------------------- en00.as (end) -----------------------------



---------------------------- enlib.as (start) ---------------------------
#include "axllib"

Colours == 'red,green,blue';
----------------------------- enlib.as (end) ----------------------------
