--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Nov  5 07:45:43 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA10499; Fri, 5 Nov 1993 07:45:43 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2379; Fri, 05 Nov 93 07:45:57 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.1067.Nov.05.07:45:57.-0500>
--*           for asbugs@watson; Fri, 05 Nov 93 07:45:57 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 05 Nov 93 07:45:56 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <5523-0@bernina.ethz.ch>; Fri, 5 Nov 1993 13:45:48 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA18936; Fri, 5 Nov 93 13:45:44 +0100
--* Date: Fri, 5 Nov 93 13:45:43 +0100
--* Message-Id: <9311051245.AA20311@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA20311; Fri, 5 Nov 93 13:45:43 +0100
--* To: smwatt@watson.ibm.com, bmt@watson.ibm.com
--* Subject: default implementations
--* Cc: bronstei, santas, asbugs@watson.ibm.com

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

#if 0
-- PI: I guess that it should print 14. Anyway I get segm. fault runtime, and
-- if I use -OQinline-all I get: 
Assertion failed, file "../src/inline.c" line 2391: inlProg->denv->foamDEnv.argv
[depth] == 0 || inlProg->denv->foamDEnv.argv[depth] == emptyFormatSlot || inlPro
g->denv->foamDEnv.argv[depth] == foam->foamEElt.env

#endif

--What should the followng program print?
--(5 or 14?)
--Right now it returns Segmentation faults.

--Philip

----------------------------------------
#include "axllib"
SI==> SingleInteger
import from SI

C1: Category ==
   with
       foo: SI->SI
       goo: SI->SI
   default
       foo(x:SI):SI == goo x
       goo(x:SI):SI == x+1

T1:C1 == add
       goo(x:SI):SI == x+10

import from T1
print(foo 4)()
----------------------------------------

