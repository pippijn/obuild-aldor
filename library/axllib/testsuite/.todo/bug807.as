--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Aug 15 18:53:34 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA24627; Mon, 15 Aug 1994 18:53:34 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2251; Mon, 15 Aug 94 18:53:38 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.DOOLEY.NOTE.VAGENT2.0283.Aug.15.18:53:37.-0400>
--*           for asbugs@watson; Mon, 15 Aug 94 18:53:38 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 0279; Mon, 15 Aug 1994 18:53:37 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 15 Aug 94 18:53:36 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA17488; Mon, 15 Aug 1994 18:49:49 -0500
--* Date: Mon, 15 Aug 1994 18:49:49 -0500
--* From: dooley@watson.ibm.com (Sam Dooley)
--* Message-Id: <9408152349.AA17488@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2] Conditional meanings leaking out.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp b.as
-- Version: 0.36.3
-- Original bug file name: b.as

#include "axllib"

F(S: Type) : with {
}
== add {
	if S has BasicType then {
		f(s: S) : Boolean == s = s;
	}
	g(s: S) : Boolean == s = s;
}
