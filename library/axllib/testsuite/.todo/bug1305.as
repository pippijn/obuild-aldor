--* From gnl@ph.ed.ac.uk  Wed Apr  4 19:21:10 2001
--* Received: from server-20.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id TAA08691
--* 	for <ax-bugs@nag.co.uk>; Wed, 4 Apr 2001 19:21:09 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 28069 invoked from network); 4 Apr 2001 18:17:22 -0000
--* Received: from sloth.ph.ed.ac.uk (129.215.72.230)
--*   by server-20.tower-4.starlabs.net with SMTP; 4 Apr 2001 18:17:22 -0000
--* Received: from ukqcd2.ph.ed.ac.uk (ukqcd2.ph.ed.ac.uk [129.215.73.54])
--* 	by sloth.ph.ed.ac.uk (8.9.3/8.9.3) with ESMTP id TAA22386;
--* 	Wed, 4 Apr 2001 19:20:34 +0100 (BST)
--* From: Giuseppe Lacagnina <gnl@ph.ed.ac.uk>
--* Received: (gnl@localhost) by ukqcd2.ph.ed.ac.uk (8.6.12/8.6.12) id TAA15587; Wed, 4 Apr 2001 19:20:34 +0100
--* Date: Wed, 4 Apr 2001 19:20:34 +0100
--* Message-Id: <200104041820.TAA15587@ukqcd2.ph.ed.ac.uk>
--* To: adk@ph.ed.ac.uk, ax-bugs@nag.co.uk
--* Subject: [7] What is missing?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -ginterp thingy.as
-- Version: Aldor version 1.1.12 for OSF/1 AX
-- Original bug file name: thingy.as

#include "axllib"
F ==> SingleFloat;
SI ==> SingleInteger;
local a:*SI == {import from SI; 18};
local b:*SI == {import from SI; 19};
local a:*F == {import from F; 21.0};
local b:*F == {import from F; 22.0};
print << a@F+b << newline;
a +$(SI add {(x:F) + (y:F):F == 3.141592653}) b;

