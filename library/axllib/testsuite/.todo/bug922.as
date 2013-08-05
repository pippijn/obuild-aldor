--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Nov 24 12:13:47 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23696; Thu, 24 Nov 1994 12:13:47 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8935; Thu, 24 Nov 94 12:13:53 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.7963.Nov.24.12:13:53.-0500>
--*           for asbugs@watson; Thu, 24 Nov 94 12:13:53 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Thu, 24 Nov 94 12:13:53 EST
--* Received: from ru7.inf.ethz.ch (santas@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id SAA21375; Thu, 24 Nov 1994 18:13:37 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id SAA16419; Thu, 24 Nov 1994 18:13:36 +0100
--* Date: Thu, 24 Nov 1994 18:13:36 +0100
--* Message-Id: <199411241713.SAA16419@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: domain components and segmentation faults when updated
--* Cc: bronstei@inf.ethz.ch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


The following returns segmentation faults at run time
(A# version 0.37.0 for SPARC).

--------------optim.as--------------------
#include "axllib"
SI ==> SingleInteger;
import from SI;
i:SI := 1;
D1:with{x:SI} == add{x == {free i; i}};
f():SI == {
     free i;
     while i <= 10 repeat {
        D == D1;
        i := i + x$D };
     i
};
f();
--------------optim.as--------------------

Philip

