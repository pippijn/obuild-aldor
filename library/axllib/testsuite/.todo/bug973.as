From asbugs@com.ibm.watson Fri May 26 12:49:44 1995
Date: Fri, 26 May 1995 06:57:21 -0400
From: asbugs@com.ibm.watson (S Watt)
To: bronstei@ch.ethz.inf, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug973
Sender: asbugs@com.ibm.watson


  Reporter:    bronstei@inf.ethz.ch
  Number:      bug973
  Description: [6] type overloading doesn't work [foo.as][1.1.0]

Thank you for your bug report.  It has been assigned bug number bug973.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug973.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri May 26 06:57:18 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17566; Fri, 26 May 1995 06:57:18 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8533; Fri, 26 May 95 06:57:18 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.8827.May.26.06:57:17.-0400>
--*           for asbugs@watson; Fri, 26 May 95 06:57:18 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 26 May 95 06:57:16 EDT
--* Received: from mendel.inf.ethz.ch (bronstei@mendel.inf.ethz.ch [129.132.12.20]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id MAA14384 for <asbugs@watson.ibm.com>; Fri, 26 May 1995 12:57:13 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by mendel.inf.ethz.ch (8.6.10/8.6.10) id MAA09838 for asbugs@watson.ibm.com; Fri, 26 May 1995 12:57:12 +0200
--* Date: Fri, 26 May 1995 12:57:12 +0200
--* Message-Id: <199505261057.MAA09838@mendel.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [6] type overloading doesn't work [foo.as][1.1.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

------------------------- foo.as ----------------------------
--
-- What happened to the overloading of types?
--
-- % axiomxl foo.as
-- #1 (Error) Cannot determine the meaning of this expression because
-- the type of one of its subexpressions cannot yet be completely analyzed.
--

#include "axllib.as"

Foo(L:ListCategory Integer): with { f: L -> L } == add { f(l:L):L == l };

Foo(L:ListCategory Ratio Integer): with { f: L -> L } == add { f(l:L):L == l };


