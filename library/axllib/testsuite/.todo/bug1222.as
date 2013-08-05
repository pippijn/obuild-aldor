--* From hemmecke@risc.uni-linz.ac.at  Wed May 31 09:50:47 2000
--* Received: from kernel.risc.uni-linz.ac.at (root@kernel.risc.uni-linz.ac.at [193.170.37.225])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id JAA05204
--* 	for <ax-bugs@nag.co.uk>; Wed, 31 May 2000 09:50:40 +0100 (BST)
--* Received: from deneb.risc.uni-linz.ac.at (deneb.risc.uni-linz.ac.at [193.170.37.113])
--* 	by kernel.risc.uni-linz.ac.at (8.9.2/8.9.2/Debian/GNU) with ESMTP id KAA28197;
--* 	Wed, 31 May 2000 10:50:24 +0200 (CEST)
--* Message-ID: <XFMail.000531105024.hemmecke@risc.uni-linz.ac.at>
--* X-Mailer: XFMail 1.3 [p0] on Solaris
--* X-Priority: 3 (Normal)
--* Content-Type: text/plain; charset=us-ascii
--* Content-Transfer-Encoding: 8bit
--* MIME-Version: 1.0
--* Date: Wed, 31 May 2000 10:50:24 +0200 (MET DST)
--* Sender: hemmecke@risc.uni-linz.ac.at
--* From: Ralf.Hemmecke@risc.uni-linz.ac.at
--* To: ax-bugs@nag.co.uk
--* Subject: [1] missing HashTable apply

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -q2 -v -laxllib xxx.as
-- Version: Aldor version 1.1.12p5 for LINUX(glibc)
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 31-MAY-2000
-- Aldor version 1.1.12p5 for LINUX(glibc) 
-- Subject: missing HashTable apply

-- The code does not compile for:
--   axiomxl -q2 -v -laxllib xxx.as
-- The compiler aborts with the error message:

--: #1 (Fatal Error) Looking for `apply' with code `569733829'.  Export
not found.

-- No problem with Aldor 1.1.12p2.

#include "axllib"
I ==> SingleInteger;
Dom: with {
        foo: () -> ();
} == add {
        Rep ==> I;
        import from Rep;
        foo(): () == {
                import from I, HashTable(I,I);
                t: HashTable(I, I) := table();
                set!(t,1,1);
        }
}
