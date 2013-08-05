--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Oct 31 15:30:30 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22135; Mon, 31 Oct 1994 15:30:30 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3667; Mon, 31 Oct 94 15:30:36 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.1853.Oct.31.15:30:36.-0500>
--*           for asbugs@watson; Mon, 31 Oct 94 15:30:36 -0500
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 31 Oct 94 15:30:35 EST
--* Via: uk.co.iec; Mon, 31 Oct 1994 19:42:22 +0000
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Mon, 31 Oct 94 19:43:13 GMT
--* Message-Id: <19168.9410311943@nags2.nag.co.uk>
--* Received: from co.uk (nags8) by nags2.nag.co.uk (4.1/UK-2.1) id AA19168;
--*           Mon, 31 Oct 94 19:43:13 GMT
--* To: asbugs@watson.ibm.com
--* Subject: [7] Unconvincing error message from interpreter

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -ginterp exptoc.as
-- Version: 0.37.0
-- Original bug file name: exptoc.as

--+ The interpreter should check for exports to foreign C in a a# file.
--+
#include "axllib"
#pile

macro {
	Ptr		== Pointer;
	Int		== SingleInteger;
}

import {
	bar:		() -> ();
} from Foreign C;

export {
	fact:		Int -> Int;
	print:		Int -> ();
} to Foreign C;

fact (x: Int) : Int == if x = 0 then 1 else x * fact(x-1);
print (x: Int) : () == print<<x<<newline;

bar()
