--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Nov 23 10:16:01 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17417; Wed, 23 Nov 1994 10:16:01 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5733; Wed, 23 Nov 94 10:16:06 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.9175.Nov.23.10:16:03.-0500>
--*           for asbugs@watson; Wed, 23 Nov 94 10:16:06 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 23 Nov 94 10:16:03 EST
--* Received: from vinci.inf.ethz.ch (bronstei@vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id QAA24132 for <asbugs@watson.ibm.com>; Wed, 23 Nov 1994 16:15:54 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id QAA09331 for asbugs@watson.ibm.com; Wed, 23 Nov 1994 16:15:53 +0100
--* Date: Wed, 23 Nov 1994 16:15:53 +0100
--* Message-Id: <199411231515.QAA09331@vinci.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [4] problem with extend

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -M2 badextend2.as
-- Version: 0.37.0
-- Original bug file name: badextend2.as

------------------------------- badextend.as -------------------------
--
-- Problems between Integer and % in an extend:
--
-- asharp -M2 badextend2.as
-- "badextend2.as", line 23:         foo?(x:Integer):Boolean == zero? x;
--                           .........................................^
-- [L12 C42] #1 (Error) Argument 1 of `zero?' did not match any possible
--           parameter type.
--     The rejected type is Integer.
--     Expected type %.
-- The following could be suitable if imported:
--   zero?: Integer -> Boolean from Integer
--

#include "axllib"

MyRing:Category == Ring with { foo?: % -> Boolean; }

extend Integer:MyRing == Integer add {
	import from Integer;

	foo?(x:Integer):Boolean == zero? x;
}

