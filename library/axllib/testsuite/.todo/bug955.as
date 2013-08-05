--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Mar  8 11:22:37 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA26265; Wed, 8 Mar 1995 11:22:37 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1007; Wed, 08 Mar 95 11:21:44 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.1835.Mar.08.11:21:41.-0500>
--*           for asbugs@watson; Wed, 08 Mar 95 11:21:43 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 08 Mar 95 11:21:38 EST
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id RAA08408 for <asbugs@watson.ibm.com>; Wed, 8 Mar 1995 17:21:33 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id RAA03138 for asbugs@watson.ibm.com; Wed, 8 Mar 1995 17:21:32 +0100
--* Date: Wed, 8 Mar 1995 17:21:32 +0100
--* Message-Id: <199503081621.RAA03138@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [4] Tagged Tuple not accepted for Tuple Type [bugsym.as][1.0.6]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

------------------------------- bugsym.as ----------------------------------
#include "axllib.as"

-- This type compiles ok
Foo(T:Tuple Type): with { foo: % } == add {
        macro Rep == SingleInteger;
	import from Rep;

	foo:% == per 1;
}

-- This one causes a compiler error
-- % axiomxl -Q0 bugsym.as
-- Bug: gen0Syme:  syme unallocated by gen0Vars
Bar(T:Type):Type == Foo(val:T);

