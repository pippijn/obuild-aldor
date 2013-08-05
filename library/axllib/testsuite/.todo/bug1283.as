--* From mnd@dcs.st-and.ac.uk  Thu Nov  9 13:38:42 2000
--* Received: from server-2.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id NAA03655
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 13:38:41 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 23552 invoked from network); 9 Nov 2000 13:38:09 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-2.tower-4.starlabs.net with SMTP; 9 Nov 2000 13:38:09 -0000
--* Received: from dcs.st-and.ac.uk (knockdhu [138.251.206.239])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id NAA01286
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 13:37:51 GMT
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id NAA31334
--* 	for ax-bugs@nag.co.uk; Thu, 9 Nov 2000 13:39:05 GMT
--* Date: Thu, 9 Nov 2000 13:39:05 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200011091339.NAA31334@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][other=include] #library processed to eagerly?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl eager.as
-- Version: 1.1.13(0)
-- Original bug file name: eager.as


#include "axllib"

-- This next line will be evaluated immediately and the non-existant
-- .ao file will generate an error. It might be nice if the #library
-- processing was postponed until after the include phase. In this
-- example the #library would never be used and could be chucked.
--
-- On the other hand, #library symbols might be allowed into .ao files
-- even if they are never used: investigate.

#library LL "I-do-not-exist.ao"

#if 0
   -- This code will never get to the parser
   import from LL;
#endif




