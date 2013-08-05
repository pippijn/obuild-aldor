--* From mnd@dcs.st-and.ac.uk  Wed Jul 25 11:59:43 2001
--* Received: from mail.london-1.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id LAA06689
--* 	for <ax-bugs@nag.co.uk>; Wed, 25 Jul 2001 11:59:25 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 29425 invoked from network); 25 Jul 2001 10:53:40 -0000
--* Received: from host213-122-170-215.btinternet.com (HELO dcs.st-and.ac.uk) (213.122.170.215)
--*   by server-11.tower-4.starlabs.net with SMTP; 25 Jul 2001 10:53:40 -0000
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.11.0/8.11.0) id f6PAxpw02564
--* 	for ax-bugs@nag.co.uk; Wed, 25 Jul 2001 11:59:51 +0100
--* Date: Wed, 25 Jul 2001 11:59:51 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200107251059.f6PAxpw02564@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [5] Multi-exports not found

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun -laxllib bug1320.as
-- Version: 1.1.13(30)
-- Original bug file name: segv01.as


#include "axllib"

INT ==> Integer;

Tst:with { a:INT; b:INT;} == add {
  import from INT;

  -- Compiler doesn't work out the types of a and b until too late ...
  (a,b) == (1,2)
}

