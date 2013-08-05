--* From hemmecke@risc.uni-linz.ac.at  Mon Sep 24 07:46:03 2001
--* Received: from welly-2.star.net.uk (welly-2.star.net.uk [195.216.16.189])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id HAA05913
--* 	for <ax-bugs@nag.co.uk>; Mon, 24 Sep 2001 07:46:02 +0100 (BST)
--* From: hemmecke@risc.uni-linz.ac.at
--* Received: (qmail 17657 invoked by uid 1001); 24 Sep 2001 06:45:33 -0000
--* Received: from 4.star-private-mail-12.star.net.uk (HELO smtp-in-4.star.net.uk) (10.200.12.4)
--*   by delivery-2.star-private-mail-4.star.net.uk with SMTP; 24 Sep 2001 06:45:33 -0000
--* Received: (qmail 25978 invoked from network); 24 Sep 2001 06:45:33 -0000
--* Received: from mail17.messagelabs.com (62.231.131.67)
--*   by smtp-in-4.star.net.uk with SMTP; 24 Sep 2001 06:45:33 -0000
--* X-VirusChecked: Checked
--* Received: (qmail 3395 invoked from network); 24 Sep 2001 06:43:10 -0000
--* Received: from kernel.risc.uni-linz.ac.at (193.170.37.225)
--*   by server-11.tower-17.messagelabs.com with SMTP; 24 Sep 2001 06:43:10 -0000
--* Received: from enceladus.risc.uni-linz.ac.at (hemmecke@thea.risc.uni-linz.ac.at [193.170.38.91])
--* 	by kernel.risc.uni-linz.ac.at (8.11.6/8.11.6) with ESMTP id f8O6jWA06558;
--* 	Mon, 24 Sep 2001 08:45:32 +0200
--* Message-ID: <XFMail.20010924084531.hemmecke@risc.uni-linz.ac.at>
--* X-Mailer: XFMail 1.4.4 on Linux
--* X-Priority: 3 (Normal)
--* Content-Type: text/plain; charset=us-ascii
--* Content-Transfer-Encoding: 8bit
--* MIME-Version: 1.0
--* In-Reply-To: <200109191119.MAA15521@nag.co.uk>
--* Date: Mon, 24 Sep 2001 08:45:31 +0200 (CEST)
--* Sender: hemmecke@risc.uni-linz.ac.at
--* To: ax-bugs@nag.co.uk
--* Subject: [5]Selfreference problem

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: aldor xxx.as
-- Version: Aldor version 1.1.13p1(5) for LINUX(glibc2.1)
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 23-SEP-2001
-- Aldor version 1.0.-1(3) for LINUX(glibc2.1) 
-- Subject: Selfreference problem

-- Compilation with 
--   aldor xxx.as
-- results in
--: Compiler bug...Bug: tfAuditExportList

#include "axllib"

macro {
        I == SingleInteger;
        S == HashTable(I, %);
        Faces == HashTable(I, S);
}

DOM: BasicType with {
        faces: % -> Faces;
        noSlices: S;
} == add {
        Rep == Record(fcs: Faces);
        import from Rep;
        sample: % == per [table()];
        (x: %) = (y: %): Boolean == false;
        (p: TextWriter) << (x: %): TextWriter == p;
        faces(x: %): Faces == rep(x).fcs;
        noSlices: S == table();
}

CalixPowerProducts(numOfVars: I): BasicType with == add {
        Rep == I;
        sample: % == per 0;
        (p: TextWriter) << (x: %): TextWriter == p;
        (x: %) = (y: %): Boolean == false;
        findPartialLeftFactor(d: DOM): I == {
                slices := search(faces d, 1, noSlices);
                0;
        }
}

