From asbugs@com.ibm.watson Fri May 26 13:12:56 1995
Date: Fri, 26 May 1995 07:59:36 -0400
From: asbugs@com.ibm.watson (S Watt)
To: bronstei@ch.ethz.inf, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug974
Sender: asbugs@com.ibm.watson


  Reporter:    bronstei@inf.ethz.ch
  Number:      bug974
  Description: [3] coercion not found at runtime [myint.as][1.1.0]

Thank you for your bug report.  It has been assigned bug number bug974.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug974.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri May 26 07:59:34 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA20008; Fri, 26 May 1995 07:59:34 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8989; Fri, 26 May 95 07:59:35 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.0649.May.26.07:59:34.-0400>
--*           for asbugs@watson; Fri, 26 May 95 07:59:35 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 26 May 95 07:59:33 EDT
--* Received: from mendel.inf.ethz.ch (bronstei@mendel.inf.ethz.ch [129.132.12.20]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id NAA16636 for <asbugs@watson.ibm.com>; Fri, 26 May 1995 13:59:27 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by mendel.inf.ethz.ch (8.6.10/8.6.10) id NAA10957 for asbugs@watson.ibm.com; Fri, 26 May 1995 13:59:27 +0200
--* Date: Fri, 26 May 1995 13:59:27 +0200
--* Message-Id: <199505261159.NAA10957@mendel.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [3] coercion not found at runtime [myint.as][1.1.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

------------------------- myint.as ----------------------------
--
-- Apparently, Integer is missing the coercion from Integer into %:
--
-- % axiomxl -Fx myint.as
-- % myint
-- Looking in MyInt for coerce with code 542526270
-- Export not found
--

#include "axllib.as"

IntCat: Category == IntegerNumberSystem with { integer: % -> Integer };

MyInt:IntCat == Integer add { integer(n:%):Integer == n pretend Integer };

Foo(Z:IntCat): with { foo: Z -> Z } == add {
	foo(n:Z):Z == {
		import from Integer;
		d := integer n;
		d::Z;
	}
}

macro I == MyInt;

import from I, Foo I;
print << foo 3 << newline;



