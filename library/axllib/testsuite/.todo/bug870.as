--* From IGLIO%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Sep 22 14:05:36 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19283; Thu, 22 Sep 1994 14:05:36 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4541; Thu, 22 Sep 94 14:05:38 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.IGLIO.NOTE.VAGENT2.3407.Sep.22.14:04:55.-0400>
--*           for asbugs@watson; Thu, 22 Sep 94 14:05:33 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 3247; Thu, 22 Sep 1994 14:04:54 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 22 Sep 94 14:04:18 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA15988; Thu, 22 Sep 1994 13:59:37 -0400
--* Date: Thu, 22 Sep 1994 13:59:37 -0400
--* From: iglio@watson.ibm.com
--* Message-Id: <9409221759.AA15988@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4][terrmsg] confusing error msg

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp -gloop
-- Version: 0.37.0
-- Original bug file name: canc.as

#include "axllib"

a: DoubleFloat := 2.0;
b: SingleFloat := 2.0;
n: SingleInteger := 2;

a^n;	-- Here is the problem

-- PI: The error msg says:
--   Arg 1 wrong; rejected type DoubleFloat. Expected one of SingleInteger,
--   SingleFloat;
-- It should not say `SingleFloat'. The meanings in scope are:
--  ^: (SI, SI) -> SI      (SI, I)-> SI; (SI,I)->SF, (DF,I)->DF
