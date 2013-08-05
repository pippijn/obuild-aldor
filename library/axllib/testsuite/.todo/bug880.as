--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Oct  7 07:01:04 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19537; Fri, 7 Oct 1994 07:01:04 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5667; Fri, 07 Oct 94 07:01:10 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.MIKER.NOTE.YKTVMV.9175.Oct.07.07:01:09.-0400>
--*           for asbugs@watson; Fri, 07 Oct 94 07:01:10 -0400
--* Received: from ben.britain.eu.net by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 07 Oct 94 07:01:09 EDT
--* Received: from iec.co.uk by ben.britain.eu.net via JANET with NIFTP (PP)
--*           id <g.15317-0@ben.britain.eu.net>; Fri, 7 Oct 1994 11:54:54 +0100
--* From: Mike Richardson <miker@num-alg-grp.co.uk>
--* Date: Fri, 7 Oct 94 11:51:41 BST
--* Message-Id: <2422.9410071051@nags2.nag.co.uk>
--* Received: from co.uk (nags8) by nags2.nag.co.uk (4.1/UK-2.1) id AA02422;
--*           Fri, 7 Oct 94 11:51:41 BST
--* To: asbugs@watson.ibm.com
--* Subject: [5] Assignment of function returning no value causes looping

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -Fx t.as
-- Version: 0.37.0
-- Original bug file name: /home/red5/miker/Axiom/ASdoc/t.as

#include "axllib"
import from Integer;

-- I should expect an error message from this:
-- instead, it puts the compiler into a loop.

f(n:Integer) : () == {n};
i := f(1);
