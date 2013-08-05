--* From adk@epcc.ed.ac.uk  Fri Jan  5 19:07:18 2001
--* Received: from server-21.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id TAA13473
--* 	for <ax-bugs@nag.co.uk>; Fri, 5 Jan 2001 19:07:17 GMT
--* From: adk@epcc.ed.ac.uk
--* X-VirusChecked: Checked
--* Received: (qmail 10018 invoked from network); 5 Jan 2001 19:02:26 -0000
--* Received: from e450.epcc.ed.ac.uk (129.215.56.230)
--*   by server-21.tower-4.starlabs.net with SMTP; 5 Jan 2001 19:02:26 -0000
--* Received: from maxinst.epcc.ed.ac.uk (maxinst [129.215.63.6])
--* 	by e450.epcc.ed.ac.uk (8.9.3+Sun/8.9.1) with ESMTP id TAA13838;
--* 	Fri, 5 Jan 2001 19:07:22 GMT
--* Received: (from adk@localhost)
--* 	by maxinst.epcc.ed.ac.uk (8.9.3+Sun/8.9.1) id TAA01609;
--* 	Fri, 5 Jan 2001 19:08:47 GMT
--* Date: Fri, 5 Jan 2001 19:08:47 GMT
--* Message-Id: <200101051908.TAA01609@maxinst.epcc.ed.ac.uk>
--* To: adk@ph.ed.ac.uk, ax-bugs@nag.co.uk
--* Subject: [7] Compiler dies painfully on some circular category definitions.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: aldor -WTa+all -V -Fasy bug-balint.as
-- Version: 1.1.12p2 for SPARC [Solaris: GCC]
-- Original bug file name: bug-balint.as

#include "axllib"
#pile

#if OKISH

define glop : Category == with
    foo : glop

#else

define glop : Category == with
    foo : glop
    bar : Field

#endif
#endpile

