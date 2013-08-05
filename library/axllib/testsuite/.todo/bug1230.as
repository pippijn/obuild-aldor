--* From hemmecke@risc.uni-linz.ac.at  Wed Jun 14 21:01:34 2000
--* Received: from kernel.risc.uni-linz.ac.at (root@kernel.risc.uni-linz.ac.at [193.170.37.225])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id VAA03978
--* 	for <ax-bugs@nag.co.uk>; Wed, 14 Jun 2000 21:01:27 +0100 (BST)
--* Received: from deneb.risc.uni-linz.ac.at (deneb.risc.uni-linz.ac.at [193.170.37.113])
--* 	by kernel.risc.uni-linz.ac.at (8.9.2/8.9.2/Debian/GNU) with ESMTP id WAA24962;
--* 	Wed, 14 Jun 2000 22:01:19 +0200 (CEST)
--* Message-ID: <XFMail.000614220119.hemmecke@risc.uni-linz.ac.at>
--* X-Mailer: XFMail 1.3 [p0] on Solaris
--* X-Priority: 3 (Normal)
--* Content-Type: text/plain; charset=us-ascii
--* Content-Transfer-Encoding: 8bit
--* MIME-Version: 1.0
--* Date: Wed, 14 Jun 2000 22:01:19 +0200 (MET DST)
--* Sender: hemmecke@risc.uni-linz.ac.at
--* From: Ralf.Hemmecke@risc.uni-linz.ac.at
--* To: ax-bugs@nag.co.uk
--* Subject: [9] xaxiomxl crash

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: xaxiomxl
-- Version: Aldor version 1.1.12p5 for LINUX(glibc)
-- Original bug file name: none

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 24-JUN-2000
-- Aldor version 1.1.12p5 for LINUX(glibc) 
-- Subject: xaxiomxl crash

Start xaxiomxl, then press the options button. xaxiomxl crashes with a
segmentation fault. 

(Linux version 1.1.12p4 or p5)

Actually the crash also happens for various other buttons. Is this a
problem with some Linux libraries? Seems like this, because at least
with my sun implementation 1.1.12p2, the options selection window pops
up.

I even removed LD_LIBRARY_PATH.



