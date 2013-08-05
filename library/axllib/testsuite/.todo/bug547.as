--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Dec 22 08:45:38 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA24632; Wed, 22 Dec 1993 08:45:38 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3987; Wed, 22 Dec 93 08:51:57 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.0053.Dec.22.08:51:56.-0500>
--*           for asbugs@watson; Wed, 22 Dec 93 08:51:57 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 22 Dec 93 08:51:55 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <24999-0@bernina.ethz.ch>; Wed, 22 Dec 1993 14:51:34 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA01305; Wed, 22 Dec 93 14:51:30 +0100
--* Date: Wed, 22 Dec 93 14:51:28 +0100
--* Message-Id: <9312221351.AA23679@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA23679; Wed, 22 Dec 93 14:51:28 +0100
--* To: asbugs@watson.ibm.com
--* Subject: Elaboration of equality test fails for recursive types
--* Cc: bronstei, santas

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>
-- PI: look for PI

#if 0
Version:  A# version 33.0 for SPARC (debug version)
Severity: major for recursive type intensive programming
Problem:  Elaboration of equality test fails on monomorphic
          instances of recursively-defined type constructors.
Comments: Don't ask me why should one write such code.
          Y-combinator stuff relies on such constructs.
          Indicated errors show that something happens in asmacros.as

Error transcript:
"/home/rutishauser/ru2/asharp/base/suncc/include/asmacros.as", line 4: (Error) (After Macro Expansion) Argument 1 did not match with any possible parameter type.

The following could be suitable if imported:
  =: (foo(%), foo(%)) -> Boolean from foo(%)
Expanded expression was: x @ % pretend foo(%)

Code:
#endif
------------------------------------------------
#include "axllib"

foo(S:BasicType): BasicType with {
      Foo: (foo %) -> %;
      UnFoo: % -> foo %;
      = : (%, %) -> Boolean }
      -- this declaration is not needed, but I emphasize it
   == S add {
       Rep ==> foo % ;  -- PI: is this allowed in A#?
       import from Rep;
       Foo(x:foo %):% == per x ;
       UnFoo(x:%):foo % == rep x ;
       ((x:%) = (y:%)):Boolean == rep x = rep y ;
            }

------------------------------------------------

-- Philip

