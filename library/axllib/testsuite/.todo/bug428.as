--* From IGLIO%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Thu Sep 23 17:39:57 1993
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA23976; Thu, 23 Sep 1993 17:39:57 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5390; Thu, 23 Sep 93 17:44:05 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.IGLIO.NOTE.VAGENT2.6259.Sep.23.17:44:05.-0400>
--*           for asbugs@watson; Thu, 23 Sep 93 17:44:05 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 6257; Thu, 23 Sep 1993 17:44:05 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 23 Sep 93 17:44:04 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA11764; Thu, 23 Sep 1993 17:40:30 -0400
--* Date: Thu, 23 Sep 1993 17:40:30 -0400
--* From: iglio@watson.ibm.com (Pietro Iglio)
--* Message-Id: <9309232140.AA11764@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: parameter passing [default7.as][30.4]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--> testerrs
#include "axllib"

import from Integer


f( a: Integer, b: Integer == 10, c: Integer , d: Integer ):() ==
	print a


g( a: Integer, b: Integer, c: Integer , d: Integer ):() ==
	print a


g( 1, c==1, b==1, 1) -- correct (BUG: positional-passing after by-name-passing)

#if TestErrorsToo

g( 1, d==1, b==3, 1 )  -- No match for c

g( d==1, 1, 2, 3 )     -- No match for a

#endif

---------------------------------------

h( a: Integer==1, b: Integer, c: Integer , d: Integer ):() ==
	print a

h( d==1,  2, 3) -- correct

#if TestErrorsToo

h( d==1, 2 )	-- missing c

#endif



#if TestErrorsToo

i1: Integer == l(1, x: Integer == 3)
i2: Integer == l(1, 2, x: Integer == 3)

#endif

