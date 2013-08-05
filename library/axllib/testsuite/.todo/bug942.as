--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Jan 18 07:50:43 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23388; Wed, 18 Jan 1995 07:50:43 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 9047; Wed, 18 Jan 95 07:50:41 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.IGLIO.NOTE.YKTVMV.5717.Jan.18.07:50:41.-0500>
--*           for asbugs@watson; Wed, 18 Jan 95 07:50:41 -0500
--* Received: from icnucevx.cnuce.cnr.it by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 18 Jan 95 07:50:38 EST
--* Received: from cardano (cardano.dm.unipi.it)
--*  by icnucevx.cnuce.cnr.it (PMDF V4.3-13 #6635)
--*  id <01HLZSPYP6TC0RH655@icnucevx.cnuce.cnr.it>; Wed,
--*  18 Jan 1995 13:50:31 +0100 (MET)
--* Received: by cardano (4.1/SMI-4.1) id AA13515; Wed, 18 Jan 95 13:51:34 +0100
--* Date: Wed, 18 Jan 1995 13:51:34 +0100
--* From: iglio@posso.dm.unipi.it (Pietro Iglio)
--* Subject: [2] Unbalanced } in fun.def.causes problems in -gloop
--* To: asbugs@watson.ibm.com
--* Message-Id: <9501181251.AA13515@cardano>
--* Content-Transfer-Encoding: 7BIT

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -gloop
-- Version: 1.0.3
-- Original bug file name: canc.as

#include "axllib"


-- The bug is in scanIsContinued. When you enter } the compiler should
-- complain about an unbalanced brace.
foo():() ==
}
