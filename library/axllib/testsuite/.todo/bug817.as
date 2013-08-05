--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 23 00:39:03 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19334; Tue, 23 Aug 1994 00:39:03 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5607; Tue, 23 Aug 94 00:39:07 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.2749.Aug.23.00:39:06.-0400>
--*           for asbugs@watson; Tue, 23 Aug 94 00:39:07 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 2745; Tue, 23 Aug 1994 00:39:06 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Tue, 23 Aug 94 00:39:06 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA32964; Tue, 23 Aug 1994 00:39:09 -0400
--* Date: Tue, 23 Aug 1994 00:39:09 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9408230439.AA32964@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2][tinfer] Keyword arguments should disambiguate based on key.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp uniont1.as >uniont1.out
-- Version: 0.36.5
-- Original bug file name: uniont1.as

--+ "uniont1.as", line 5: u := [sf == 1]
--+                       ......^
--+ [L5 C7] #1 (Error) Have determined 2 possible types for the expression.
--+ 	Meaning 1: DoubleFloat
--+ 	Meaning 2: SingleFloat
--+
#include "axllib"

import from Union(sf: SingleFloat, df: DoubleFloat);

u := [sf == 1]
