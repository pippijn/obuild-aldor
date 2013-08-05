From asbugs@com.ibm.watson Thu Jun  1 00:54:27 1995
Date: Wed, 31 May 1995 19:47:03 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug977
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug977
  Description: [3] Problems with mod_*

Thank you for your bug report.  It has been assigned bug number bug977.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug977.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed May 31 19:47:02 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA18020; Wed, 31 May 1995 19:47:02 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5441; Wed, 31 May 95 19:47:02 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.6093.May.31.19:47:02.-0400>
--*           for asbugs@watson; Wed, 31 May 95 19:47:02 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 31 May 95 19:47:01 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA12038
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Wed, 31 May 1995 19:46:23 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA20855; Wed, 31 May 1995 19:46:40 -0400
--* Date: Wed, 31 May 1995 19:46:40 -0400
--* Message-Id: <199505312346.AA20855@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [3] Problems with mod_*

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: None
-- Version: 1.01
-- Original bug file name: ../bugs/bug-mod-star.txt

1. mod_*$SI should use a double word, as it does not work properly for
   any SingleInteger modulus.

2. mod_*$Machine is not implemented.

3. doubleDivide$Machine returns 3 Words, not 2 as documented in the manual.


