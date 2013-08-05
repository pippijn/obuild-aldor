--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Nov  7 17:27:13 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA17549; Sun, 7 Nov 1993 17:27:13 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2625; Sun, 07 Nov 93 17:34:30 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.2381.Nov.07.17:34:28.-0500>
--*           for asbugs@watson; Sun, 07 Nov 93 17:34:30 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 07 Nov 93 17:34:28 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <26977-0@bernina.ethz.ch>; Sun, 7 Nov 1993 23:34:20 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA02214; Sun, 7 Nov 93 23:34:16 +0100
--* Date: Sun, 7 Nov 93 23:34:15 +0100
--* Message-Id: <9311072234.AA28626@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA28626; Sun, 7 Nov 93 23:34:15 +0100
--* To: smwatt@watson.ibm.com
--* Subject: C:Category==with{x:SI==4}
--* Cc: bronstei, santas, jenks@watson.ibm.com, asbugs@watson.ibm.com

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

#if 0
The following program compiles (it can be a solution
to the 'default' problem, no?)
Are categories allowed to accept expressions other
than declarations? What is the effect of these expressions?
Thanks,

Philip
#endif
-------------------
#include "axllib"
SI==>SingleInteger
import from SI

C1: Category ==
  with
    x:SI==5

T1:C1 == add
    x:SI==4

import from T1
print(x)()
-------------------

