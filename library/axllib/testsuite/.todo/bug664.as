--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu May 26 17:12:00 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21477; Thu, 26 May 1994 17:12:00 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3381; Thu, 26 May 94 17:12:01 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.4571.May.26.17:12:00.-0400>
--*           for asbugs@watson; Thu, 26 May 94 17:12:00 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Thu, 26 May 94 17:11:59 EDT
--* Received: from ru7.inf.ethz.ch (ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.8/8.6.6) with ESMTP id XAA25926; Thu, 26 May 1994 23:11:12 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id XAA16883; Thu, 26 May 1994 23:10:47 +0200
--* Date: Thu, 26 May 1994 23:10:47 +0200
--* Message-Id: <199405262110.XAA16883@ru7.inf.ethz.ch>
--* To: smwatt@watson.ibm.com, jenks@watson.ibm.com
--* Subject: f 4.5.6
--* In-Reply-To: Mail from 'smwatt@watson.ibm.com (Stephen Watt)'
--*       dated: Thu, 26 May 1994 16:05:58 -0400
--* Cc: asbugs@watson.ibm.com, bronstei@inf.ethz.ch, williams@inf.ethz.ch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


OK, thanks,but can you please tell me exactly what schema you
are following, because maybe the following is a bug:

-------------------------------------------------
#include "axllib"
SI ==> SingleInteger
import from SI
import from Float

f(x:SI)(y:SI):SI == x+y
f(x:Float):Float == x
f(x:SI):SI == x
apply(x:SI,y:SI):SI == x*y

print(f 4.5.6)()    --------This reports error
--(Error) There are no suitable meanings for the operator `print(f(4.5(6)))'.
--(Error) Operator (argument 1 of apply) did not match with any possible parameter type.

print(f . 4.5)()
print(f 4.5)()
print(f 4 . 5)()
------------------------------------------------

and an even smaller example, wehere I do not import anything from Float:
(but the compiler complains about float style literals).

----------------------------
#include "axllib"
SI ==> SingleInteger
import from SI

f(x:SI)(y:SI):SI == x+y
f(x:SI):SI == x
apply(x:SI,y:SI):SI == x*y

print(f . 4.5)()
print(f 4.5)()
print(f 4 . 5)()
---------------------------

Philip

