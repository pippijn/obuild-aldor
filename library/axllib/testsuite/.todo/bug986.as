From asbugs@com.ibm.watson Wed Jun  7 21:58:51 1995
Date: Wed, 7 Jun 1995 16:16:44 -0400
From: asbugs@com.ibm.watson (S Watt)
To: bronstei@ch.ethz.inf, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug986
Sender: asbugs@com.ibm.watson


  Reporter:    bronstei@inf.ethz.ch
  Number:      bug986
  Description: [4] extension messes up has test [pchas.as][1.1.0]

Thank you for your bug report.  It has been assigned bug number bug986.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug986.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Jun  7 16:16:39 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23114; Wed, 7 Jun 1995 16:16:39 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2737; Wed, 07 Jun 95 16:16:37 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.2585.Jun.07.16:16:36.-0400>
--*           for asbugs@watson; Wed, 07 Jun 95 16:16:37 -0400
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 07 Jun 95 16:16:36 EDT
--* Received: from vinci.inf.ethz.ch by bernina.ethz.ch with SMTP inbound;
--*           Wed, 7 Jun 1995 22:16:15 +0200
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id WAA04961
--*           for asbugs@watson.ibm.com; Wed, 7 Jun 1995 22:16:13 +0200
--* Date: Wed, 7 Jun 1995 22:16:13 +0200
--* From: bronstei <bronstei@inf.ethz.ch>
--* Message-Id: <199506072016.WAA04961@vinci.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [4] extension messes up has test [pchas.as][1.1.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--------------------------------- pchas.as -------------------------------
--
-- Looks like the % has Ring test is affected by an irrelevant extension
-- % axiomxl -Fx pchas.as
-- % pchas
-- 3
--

#include "axllib.as"

Foo:Category == with {
	foo: % -> %;
	default {
		foo(x:%):% == {
			import from %;
			% has Ring => x +$(% pretend Ring) x;
			x;
		}
	}
}

MyInt: Join(IntegerNumberSystem, Foo) == Integer add {};

-- if this extension is commented out, then the ouput below is correctly 6
extend Integer:Foo == add {};

import from MyInt;

-- expect 6
print << foo 3 << newline;


