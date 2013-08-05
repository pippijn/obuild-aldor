--* From mnd@dcs.st-and.ac.uk  Thu Nov  9 14:10:49 2000
--* Received: from server-13.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id OAA03966
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 14:10:48 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 26801 invoked from network); 9 Nov 2000 14:00:15 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-13.tower-4.starlabs.net with SMTP; 9 Nov 2000 14:00:15 -0000
--* Received: from dcs.st-and.ac.uk (knockdhu [138.251.206.239])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id OAA02704
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 14:09:51 GMT
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id OAA31846
--* 	for ax-bugs@nag.co.uk; Thu, 9 Nov 2000 14:11:05 GMT
--* Date: Thu, 9 Nov 2000 14:11:05 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200011091411.OAA31846@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][other=terror] slightly confusing error message

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl wrongarg.as
-- Version: 1.1.13(0)
-- Original bug file name: wrongarg.as


#include "axllib.as"


foo(x:DoubleFloat, y:String):() == print << x << " " << y << newline;
foo(x:SingleInteger, y:String):() == print << x << " " << y << newline;

import from SingleInteger, String, DoubleFloat;


-- This works fine ...
foo(42, "Yo");


-- This next line generates the wrong error message:
-- Argument 1 of `foo' did not match any possible parameter type.
--    The rejected type is DoubleFloat.
--    Expected type SingleInteger.
-- If anything, it ought to complain that argument 2 is wrong.
foo(4.2, 4.2);
