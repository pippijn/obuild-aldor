--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Aug 31 13:04:51 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA15802; Wed, 31 Aug 1994 13:04:51 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3785; Wed, 31 Aug 94 13:04:55 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.1951.Aug.31.13:04:55.-0400>
--*           for asbugs@watson; Wed, 31 Aug 94 13:04:55 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 31 Aug 94 13:04:55 EDT
--* Received: from ru7.inf.ethz.ch (ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id TAA12211; Wed, 31 Aug 1994 19:04:47 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id TAA23078; Wed, 31 Aug 1994 19:04:46 +0200
--* Date: Wed, 31 Aug 1994 19:04:46 +0200
--* Message-Id: <199408311704.TAA23078@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: structural type eq. and segmantation faults
--* Cc: bronstei@inf.ethz.ch, jenks@watson.ibm.com

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


Structural type equality in packages results in segmentation faults
in A# version 0.36.0 for SPARC.

Philip

---------------------------------
#include "axllib"
SI == SingleInteger;
P == add {T1 == SI; y:T1 == 6};
import from P;
import from SI;
print << y << newline
---------------------------------
#include "axllib"
SI == SingleInteger;
f(x:SI):SI == x+1;
P == add {T1 == SI; y:T1 == 6};
main():SI == {import from P;
              f y
             };
import from SI;
print << main() << newline;
---------------------------------

