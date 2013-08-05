From asbugs@com.ibm.watson Thu Jun  1 18:49:22 1995
Date: Thu, 1 Jun 1995 13:14:45 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug980
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug980
  Description: [4] AXIOMXL cannot overwrite axlmain.c (as opposed to asmain.c)

Thank you for your bug report.  It has been assigned bug number bug980.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug980.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun  1 13:14:41 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23479; Thu, 1 Jun 1995 13:14:41 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7043; Thu, 01 Jun 95 13:14:41 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.2433.Jun.01.13:14:40.-0400>
--*           for asbugs@watson; Thu, 01 Jun 95 13:14:41 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 01 Jun 95 13:13:22 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA19381
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Thu, 1 Jun 1995 13:09:50 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA28161; Thu, 1 Jun 1995 13:10:07 -0400
--* Date: Thu, 1 Jun 1995 13:10:07 -0400
--* Message-Id: <199506011710.AA28161@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [4] AXIOMXL cannot overwrite axlmain.c (as opposed to asmain.c)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Faxlmain non-bug-tinfer-tuples.as
-- Version: 1.1.0 for AIX RS/6000
-- Original bug file name: bug-axlmain-clobber.log

AXIOM-XL version 1.1.0 for AIX RS/6000

/dev/null:
               ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
 Time    0.0 s  0100  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 %

 Store   144 K pool

non-bug-tinfer-tuples.as:
               ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
 Time    0.0 s  0100  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 %

 Source  196 lines,  130666 lines per minute
 Store   144 K pool
#1 (Fatal Error) Output would clobber the source file `axlmain.c'.


