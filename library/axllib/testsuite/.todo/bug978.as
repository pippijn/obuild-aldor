From asbugs@com.ibm.watson Thu Jun  1 01:19:03 1995
Date: Wed, 31 May 1995 19:50:11 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug978
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug978
  Description: [1] File initializers hash to the same name

Thank you for your bug report.  It has been assigned bug number bug978.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug978.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed May 31 19:50:10 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17544; Wed, 31 May 1995 19:50:10 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5499; Wed, 31 May 95 19:50:11 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.6209.May.31.19:50:10.-0400>
--*           for asbugs@watson; Wed, 31 May 95 19:50:10 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 31 May 95 19:50:09 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA12062
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Wed, 31 May 1995 19:49:21 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA30631; Wed, 31 May 1995 19:49:38 -0400
--* Date: Wed, 31 May 1995 19:49:38 -0400
--* Message-Id: <199505312349.AA30631@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [1] File initializers hash to the same name

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: None
-- Version: 1.01
-- Original bug file name: ../bugs/bug-file-init.txt

Two files, todd-coxeter.as and todd-coxeter-test.as when compiler to C
produce file intializers with the same name (with bad consequences).


