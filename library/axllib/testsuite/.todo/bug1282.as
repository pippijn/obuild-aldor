--* From mnd@dcs.st-and.ac.uk  Thu Nov  9 13:34:18 2000
--* Received: from server-5.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id NAA03584
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 13:34:17 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 14505 invoked from network); 9 Nov 2000 13:33:47 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-5.tower-4.starlabs.net with SMTP; 9 Nov 2000 13:33:47 -0000
--* Received: from dcs.st-and.ac.uk (knockdhu [138.251.206.239])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id NAA01080
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 13:33:26 GMT
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id NAA31310
--* 	for ax-bugs@nag.co.uk; Thu, 9 Nov 2000 13:34:40 GMT
--* Date: Thu, 9 Nov 2000 13:34:40 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200011091334.NAA31310@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [3][scobind] early import gets it wrong

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl file.as
-- Version: 1.1.13(0)
-- Original bug file name: early.as


#include "axllib"

import from Foo;

Foo:with { foo: () -> (); } == add { foo():() == print << "Yo!" << newline; }

foo();

