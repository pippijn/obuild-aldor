From asbugs@com.ibm.watson Thu Jun  1 20:04:42 1995
Date: Thu, 1 Jun 1995 13:30:28 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug982
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug982
  Description: [2] Segmentation violation when using `extend'

Thank you for your bug report.  It has been assigned bug number bug982.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug982.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun  1 13:30:26 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22536; Thu, 1 Jun 1995 13:30:26 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8375; Thu, 01 Jun 95 13:30:24 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.5979.Jun.01.13:29:44.-0400>
--*           for asbugs@watson; Thu, 01 Jun 95 13:29:49 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 01 Jun 95 13:29:43 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA19552
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Thu, 1 Jun 1995 13:23:50 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA29298; Thu, 1 Jun 1995 13:22:08 -0400
--* Date: Thu, 1 Jun 1995 13:22:08 -0400
--* Message-Id: <199506011722.AA29298@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [2] Segmentation violation when using `extend'

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Ginterp bug-string-extend.as
-- Version: AXIOM-XL version 1.1.0 for AIX RS/6000
-- Original bug file name: bug-string-extend.as

#include "axllib"
#pile

import from SingleInteger

foo: String == "Trivia"

print."Initially, hash(~1) = ~2~n" (<< foo, << hash foo)

extend String: with == String add (hash(s: %): SingleInteger == 42)

print."Next, hash(~1) = ~2~n" (<< foo, << hash foo)

extend String: with == String add (hash(s: %): SingleInteger == 84)

print."Finally, hash(~1) = ~2~n" (<< foo, << hash foo)


