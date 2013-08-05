From asbugs@com.ibm.watson Wed May 17 18:19:18 1995
Date: Wed, 17 May 1995 12:32:04 -0400
From: asbugs@com.ibm.watson (S Watt)
To: bronstei@ch.ethz.inf, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug970
Sender: asbugs@com.ibm.watson


  Reporter:    bronstei@inf.ethz.ch
  Number:      bug970
  Description: [5] Generator Cross(A, B) valid but unusable [gencross.as][1.1.0]

Thank you for your bug report.  It has been assigned bug number bug970.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug970.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed May 17 12:32:00 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23912; Wed, 17 May 1995 12:32:00 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7583; Wed, 17 May 95 12:32:00 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.8542.May.17.12:32:00.-0400>
--*           for asbugs@watson; Wed, 17 May 95 12:32:00 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 17 May 95 12:31:59 EDT
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id SAA03030 for <asbugs@watson.ibm.com>; Wed, 17 May 1995 18:31:55 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id SAA19914 for asbugs@watson.ibm.com; Wed, 17 May 1995 18:31:55 +0200
--* Date: Wed, 17 May 1995 18:31:55 +0200
--* Message-Id: <199505171631.SAA19914@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [5] Generator Cross(A, B) valid but unusable [gencross.as][1.1.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

------------------------- gencross.as -------------------------
--
-- Even though  Generator Cross(A, B) is a valid return type, it
-- can't be used.
--
-- % axomxl -M2 gencross.as
-- "gencross.as", line 33: for (a, b) in aha repeat print << a << newline;
--                         .....^
-- [L23 C6] #1 (Error) Expecting an identifier or single declaration after `for'
--

#include "axllib.as"

Foo(A:BasicType, B:BasicType):BasicType with {
	generator: % -> Generator Cross(A, B);
} == add {
	macro Rep == List Record(a:A, b:B);

	import from Rep;

	sample:%				== per empty();
	(f:%) = (g:%):Boolean			== rep f = rep g;
	(p:TextWriter) << (f:%):TextWriter	== p << rep f;

	generator(f:%):Generator Cross(A, B) == generate {
		while (l := rep f) repeat yield (first(l).a, first(l).b);
	};
}

import from SingleInteger, Foo(SingleInteger, SingleInteger);

aha:Foo(SingleInteger, SingleInteger) := sample;
for (a, b) in aha repeat print << a << newline;


