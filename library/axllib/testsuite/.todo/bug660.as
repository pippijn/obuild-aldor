--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu May 26 16:30:20 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21464; Thu, 26 May 1994 16:30:20 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2073; Thu, 26 May 94 16:30:19 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.1879.May.26.16:30:17.-0400>
--*           for asbugs@watson; Thu, 26 May 94 16:30:19 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Thu, 26 May 94 16:30:17 EDT
--* Received: from ru7.inf.ethz.ch (ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.8/8.6.6) with ESMTP id WAA24501; Thu, 26 May 1994 22:29:33 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id WAA16699; Thu, 26 May 1994 22:29:12 +0200
--* Date: Thu, 26 May 1994 22:29:12 +0200
--* Message-Id: <199405262029.WAA16699@ru7.inf.ethz.ch>
--* To: smwatt@watson.ibm.com, jenks@watson.ibm.com
--* Subject: ambiguity for  f 4.5
--* In-Reply-To: Mail from 'smwatt@watson.ibm.com (Stephen Watt)'
--*       dated: Thu, 26 May 1994 16:05:58 -0400
--* Cc: asbugs@watson.ibm.com, bronstei@inf.ethz.ch, williams@inf.ethz.ch,
--*         santas@inf.ethz.ch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


I agree on the use of parentheses to enclose the operators.
This makes things simper, and programs easier to read.
But:

>On (2), f.4.5  and  f. 4 . 5  are exactly the same in A#.

OK, then
----------------------
#include "axllib"
SI ==> SingleInteger
import from SI
import from Float

f(x:SI)(y:SI):SI == x+y
f(x:Float):Float == x
apply(x:SI,y:SI):SI == x*y

print(f. 4.5)()
print(f  4.5)()
print(f 4 . 5)()
----------------------

return 3 different results.

Philip

