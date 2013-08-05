--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Nov 10 14:36:36 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22554; Thu, 10 Nov 1994 14:36:36 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0941; Thu, 10 Nov 94 14:36:37 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.0871.Nov.10.14:36:36.-0500>
--*           for asbugs@watson; Thu, 10 Nov 94 14:36:37 -0500
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 0863; Thu, 10 Nov 1994 14:36:35 EST
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 10 Nov 94 14:36:34 EST
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21844; Thu, 10 Nov 1994 14:38:59 -0500
--* Date: Thu, 10 Nov 1994 14:38:59 -0500
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9411101938.AA21844@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3] Infixed lambda expressions do not allow defaultly typed parameters.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: It don't matter
-- Version: r1.0.2
-- Original bug file name: bug.as

#include "axllib"

default i, j: Integer;

(i,j): Integer +-> i + j;
