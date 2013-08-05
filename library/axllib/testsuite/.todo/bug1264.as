--* From mnd@dcs.st-and.ac.uk  Tue Oct 17 01:21:20 2000
--* Received: from server-6.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with SMTP id BAA09091
--* 	for <ax-bugs@nag.co.uk>; Tue, 17 Oct 2000 01:21:19 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 22358 invoked from network); 17 Oct 2000 00:20:48 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-6.tower-4.starlabs.net with SMTP; 17 Oct 2000 00:20:48 -0000
--* Received: from dcs.st-and.ac.uk (ara3234-ppp [138.251.206.28])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id NAA23591
--* 	for <ax-bugs@nag.co.uk>; Mon, 16 Oct 2000 13:35:12 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id NAA26084
--* 	for ax-bugs@nag.co.uk; Mon, 16 Oct 2000 13:25:27 +0100
--* Date: Mon, 16 Oct 2000 13:25:27 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200010161225.NAA26084@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][runtime] simpler example of has-question problem

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -ginterp sihas.as
-- Version: 1.1.13(0)
-- Original bug file name: sihas.as

#include "axllib"   
SI ==> SingleInteger;

FooCat(SI):Category == with {
   foo: () -> SI;
}
 
FooDom(N:SI):FooCat(N) == add {
   foo():SI == N;
}

import from SingleInteger;
import from FooDom(42);
 
print << "foo() = " << foo() << newline;
 
local t1:Boolean := FooDom(42) has FooCat(42);
local t2:Boolean := FooDom(42) has FooCat(93);
print << "FooDom(42) has FooCat(42) = " << t1 << newline;
print << "FooDom(42) has FooCat(93) = " << t2 << newline;
-- The end --


