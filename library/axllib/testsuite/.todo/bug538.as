--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Wed Dec 15 01:58:21 1993
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA20832; Wed, 15 Dec 1993 01:58:21 -0500
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5653; Wed, 15 Dec 93 02:04:33 EST
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.7707.Dec.15.02:04:32.-0500>
--*           for asbugs@watson; Wed, 15 Dec 93 02:04:33 -0500
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 7705; Wed, 15 Dec 1993 02:04:32 EST
--* Received: from cyst.watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 15 Dec 93 02:04:31 EST
--* Received: from watson.ibm.com by cyst.watson.ibm.com (AIX 3.2/UCB 5.64/900528)
--*   id AA148841; Wed, 15 Dec 1993 02:04:11 -0500
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA04303; Wed, 15 Dec 1993 02:06:05 -0500
--* Date: Wed, 15 Dec 1993 02:06:05 -0500
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9312150706.AA04303@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] second import of Integer should not be necessary [foo.as][v33.1]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>
-- PI: w/o "import from Integer I get an err.mgs. (if n > 0 , no meaning for 0
-- in this context) and a Segmentation fault.
-- PI 4 Apr 94: now I'm getting the err msg w/out seg. fault. Probably is no
-- more a bug, because Integer is not imported in the with body. I'm waiting
-- for Steve's confirmation to mark it as fixed.



#include "axllib"

Foo(n: Integer): with
	import from Integer
	if n > 0 then
		thenf: Integer -> Integer
	else
		elsef: Integer -> Integer
	allf: Integer -> Integer
== add
	if n > 0 then
		thenf(k: Integer): Integer == k+1
	else
		elsef(k: Integer): Integer == k-1
	allf(k: Integer): Integer == k
	
