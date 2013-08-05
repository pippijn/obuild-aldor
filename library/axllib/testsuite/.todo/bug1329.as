--* From ralf@hemmecke.de  Sat Sep 22 20:17:31 2001
--* Received: from welly-4.star.net.uk (welly-4.star.net.uk [195.216.16.162])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id UAA27256
--* 	for <ax-bugs@nag.co.uk>; Sat, 22 Sep 2001 20:17:31 +0100 (BST)
--* From: ralf@hemmecke.de
--* Received: (qmail 17791 invoked from network); 22 Sep 2001 19:17:02 -0000
--* Received: from 6.star-private-mail-12.star.net.uk (HELO smtp-in-6.star.net.uk) (10.200.12.6)
--*   by 204.star-private-mail-4.star.net.uk with SMTP; 22 Sep 2001 19:17:02 -0000
--* Received: (qmail 32292 invoked from network); 22 Sep 2001 19:17:02 -0000
--* Received: from mail17.messagelabs.com (62.231.131.67)
--*   by smtp-in-6.star.net.uk with SMTP; 22 Sep 2001 19:17:02 -0000
--* X-VirusChecked: Checked
--* Received: (qmail 29779 invoked from network); 22 Sep 2001 19:14:45 -0000
--* Received: from kernel.risc.uni-linz.ac.at (193.170.37.225)
--*   by server-10.tower-17.messagelabs.com with SMTP; 22 Sep 2001 19:14:45 -0000
--* Received: from enceladus.risc.uni-linz.ac.at (hemmecke@thea.risc.uni-linz.ac.at [193.170.38.91])
--* 	by kernel.risc.uni-linz.ac.at (8.11.6/8.11.6) with ESMTP id f8MJGvA24259;
--* 	Sat, 22 Sep 2001 21:16:58 +0200
--* Message-ID: <XFMail.20010922211657.ralf@hemmecke.de>
--* X-Mailer: XFMail 1.4.4 on Linux
--* X-Priority: 3 (Normal)
--* Content-Type: text/plain; charset=us-ascii
--* Content-Transfer-Encoding: 8bit
--* MIME-Version: 1.0
--* In-Reply-To: <XFMail.20010903112421.hemmecke@risc.uni-linz.ac.at>
--* Date: Sat, 22 Sep 2001 21:16:57 +0200 (CEST)
--* Sender: hemmecke@risc.uni-linz.ac.at
--* To: ax-bugs@nag.co.uk
--* Subject: [7]List(I->()) problem

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: aldor -q0 -fx -laxllib xxx.as
-- Version: Aldor version 1.1.13p1(5) for LINUX(glibc2.1)
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 21-SEP-2001
-- Aldor version 1.0.-1(3) for LINUX(glibc2.1) 
-- Subject: List(I->()) problem

-- Compile this program with
--   aldor -q0 -fx -laxllib xxx.as
-- and execute the program.
-- Output is:
--: First line.
--: IN FUNCTION
--: Looking in List(->((SingleInteger), ())) for bracket with code
1015278159
--: Unhandled Exception: RuntimeError(??)
--: Export not found

-- For
--   aldor -q0 -fx -laxllib xxx.as
--The program just returns the following.
--: First line.
--: IN FUNCTION
--: setPartialDivision
--: Unhandled Exception: RuntimeError(??)
--: (Aldor error) Halt

#include "axllib"

I ==> SingleInteger;
#if C1
R ==> I -> I;
#else
R ==> I -> ();
#endif
CalixPowerProducts: with {
        setPartialDivision: () -> R;
} == add {
#if C1
        pommaret!(i: I): I == 1;
#else
        pommaret!(i: I): () == 1;
#endif
        setPartialDivision(): R == {
                print << "IN FUNCTION" << newline;
                divisions: List R == [pommaret!];
                error "setPartialDivision";
        }
}
main(): () == {
        import from CalixPowerProducts;
        print << "First line." << newline;
        pdiv := setPartialDivision();
        print << "We have initialised setPartialDivision." << newline;

}
main();

