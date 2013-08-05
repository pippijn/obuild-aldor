--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Dec 13 07:20:35 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA15881; Tue, 13 Dec 1994 07:20:35 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4993; Tue, 13 Dec 94 07:20:32 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.4389.Dec.13.07:20:32.-0500>
--*           for asbugs@watson; Tue, 13 Dec 94 07:20:32 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Tue, 13 Dec 94 07:20:31 EST
--* Received: from ru7.inf.ethz.ch (santas@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id NAA04480; Tue, 13 Dec 1994 13:20:29 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id NAA14610; Tue, 13 Dec 1994 13:20:28 +0100
--* Date: Tue, 13 Dec 1994 13:20:28 +0100
--* Message-Id: <199412131220.NAA14610@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: segmentation faults involving "add {T1==SI; y:T1==6}"
--* Cc: bronstei@inf.ethz.ch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


Any of the two lines below results in segmentation faults.

Philip


---------------------sharingAbstract.as---------------------
#include "axllib"

SI == SingleInteger;
x:SI == 3;
f(x:SI, y:SI):SI == x+y;
print << f(x,x) << newline;

P0 == add { T1 == SI };
P1 == add { T1 == SI ; y:T1 == 6 };

main():SI == {import from P1;
              x1:T1 == 4;
              x2:T1$P0 == 5;
              --f(f(x1,x2), y);  -- SEGMENTATION FAULT
              --f(y,y);          -- SEGMENTATION FAULT
              f(x1,x2)
             };
print << main() << newline;

