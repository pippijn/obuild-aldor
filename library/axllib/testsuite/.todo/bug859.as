--* From IGLIO%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Sep  7 20:38:15 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA24348; Wed, 7 Sep 1994 20:38:15 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5077; Wed, 07 Sep 94 20:38:20 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.IGLIO.NOTE.VAGENT2.3183.Sep.07.20:38:19.-0400>
--*           for asbugs@watson; Wed, 07 Sep 94 20:38:20 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 3179; Wed, 7 Sep 1994 20:38:19 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 07 Sep 94 20:38:19 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA18851; Wed, 7 Sep 1994 20:33:37 -0400
--* Date: Wed, 7 Sep 1994 20:33:37 -0400
--* From: iglio@watson.ibm.com
--* Message-Id: <9409080033.AA18851@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3][scobind] Labels: nobody checks that a label is the same block where goto is.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp -Fo -Fc canc.as
-- Version: 0.36.6
-- Original bug file name: canc.as

#include "axllib"

import from String;

@XXX

print << "Urra!";

foo():() == {
	goto XXX;
}

foo();
