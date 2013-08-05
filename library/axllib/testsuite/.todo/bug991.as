From asbugs@com.ibm.watson Fri Jun 16 12:48:55 1995
Date: Fri, 16 Jun 1995 07:28:41 -0400
From: asbugs@com.ibm.watson (S Watt)
To: bronstei@ch.ethz.inf, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug991
Sender: asbugs@com.ibm.watson


  Reporter:    bronstei@inf.ethz.ch
  Number:      bug991
  Description: [9] rem in Integer is not the Euclidean remainder [rembug.as][1.1]

Thank you for your bug report.  It has been assigned bug number bug991.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug991.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Jun 16 07:28:38 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA27073; Fri, 16 Jun 1995 07:28:38 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2945; Fri, 16 Jun 95 07:28:38 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.6137.Jun.16.07:28:37.-0400>
--*           for asbugs@watson; Fri, 16 Jun 95 07:28:38 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 16 Jun 95 07:28:36 EDT
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id NAA12124 for <asbugs@watson.ibm.com>; Fri, 16 Jun 1995 13:28:31 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id NAA12743 for asbugs@watson.ibm.com; Fri, 16 Jun 1995 13:28:31 +0200
--* Date: Fri, 16 Jun 1995 13:28:31 +0200
--* Message-Id: <199506161128.NAA12743@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [9] rem in Integer is not the Euclidean remainder [rembug.as][1.1]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-------------------------------- rembug.as --------------------------------
--
-- Integer being a Euclidean Domain, its remainder should be the euclidean
-- remainder, which is supposed to be always positive. Thus the following
-- should print 4, not -1:
--
-- % axl -Grun rembug.as
-- -1
--

#include "axllib.as"

import from Integer;

print << (-1) rem 5 << newline;


