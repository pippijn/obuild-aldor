From asbugs@com.ibm.watson Sat Jun  3 00:51:24 1995
Date: Fri, 2 Jun 1995 19:42:20 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug985
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug985
  Description: [4] Suggested category default for ^ in Monoid.

Thank you for your bug report.  It has been assigned bug number bug985.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug985.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Jun  2 19:42:15 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA24743; Fri, 2 Jun 1995 19:42:15 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0495; Fri, 02 Jun 95 19:42:15 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.3085.Jun.02.19:42:13.-0400>
--*           for asbugs@watson; Fri, 02 Jun 95 19:42:14 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Fri, 02 Jun 95 19:41:36 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA09617
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Fri, 2 Jun 1995 19:40:22 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA40211; Fri, 2 Jun 1995 19:40:30 -0400
--* Date: Fri, 2 Jun 1995 19:40:30 -0400
--* Message-Id: <199506022340.AA40211@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [4] Suggested category default for ^ in Monoid.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.01
-- Original bug file name: /dev/null

--+ The following would make an excellent default definition for exponentiation
--+ in the Monoid category:
--+
--+   (a: %) ^ (n: Integer): % == power(1, a, n)$BinaryPowering(%, *, Integer)
--+
--+ I would hypothesise that it is not there because Monoid preceded BinaryPowering
--+ historically.


