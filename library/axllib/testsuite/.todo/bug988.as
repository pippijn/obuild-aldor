From asbugs@com.ibm.watson Fri Jun  9 00:14:18 1995
Date: Thu, 8 Jun 1995 19:01:43 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug988
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug988
  Description: [2] Erroneous error message (variable used in type)

Thank you for your bug report.  It has been assigned bug number bug988.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug988.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun  8 19:01:41 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22566; Thu, 8 Jun 1995 19:01:41 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 9603; Thu, 08 Jun 95 19:01:42 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.1033.Jun.08.19:01:41.-0400>
--*           for asbugs@watson; Thu, 08 Jun 95 19:01:42 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 08 Jun 95 19:01:20 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA04974
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Thu, 8 Jun 1995 19:00:54 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA20264; Thu, 8 Jun 1995 19:00:51 -0400
--* Date: Thu, 8 Jun 1995 19:00:51 -0400
--* Message-Id: <199506082300.AA20264@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [2] Erroneous error message (variable used in type)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Ginterp bug-const-fun-arg.as > bug-const-fun-arg.out
-- Version: 1.1.0
-- Original bug file name: bug-const-fun-arg.as

--+ AXIOM-XL version 1.1.0 for AIX RS/6000
--+ "bug-const-fun-arg.as", line 30:                                 v := v+1
--+                                  ................................^
--+ [L30 C33] #1 (Error) `v' is used in a type, so must be constant, and so cannot be assigned to.
--+
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    0.3 s  0 26 12 41  6  6  3  0  0  6  0  0  0  0  0  0  0  0 %
--+
--+  Source  214 lines,  37764 lines per minute
--+  Store   212 K pool
#include "axllib"
#pile

-- This is a fake version of a domain constructor function which
-- produces has a dependent argument which is a map

HashTable(X: BasicType, Y: BasicType, f: X -> Y): BasicType with
    table: () -> %
  == Integer add
    table(): % == per 23

-- This is a global variable

v: Integer := 0

-- This creates a domain and an object in that domain. The domain is
-- parameterized by a function constant, and the function constant
-- depends on a global variable.

fc(s: String): Integer ==
  free v
  v := v+1

tc: HashTable(String, Integer, fc) == table()

-- Now we do the same thing with a function constant literal.

tcl: HashTable(String, Integer, (s: String): Integer +->
				free v
				v := v+1
		) == table()


