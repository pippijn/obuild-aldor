--* From DOOLEY%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun 30 18:11:12 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23849; Thu, 30 Jun 1994 18:11:12 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2255; Thu, 30 Jun 94 18:11:14 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.DOOLEY.NOTE.VAGENT2.0533.Jun.30.18:11:14.-0400>
--*           for asbugs@watson; Thu, 30 Jun 94 18:11:14 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 0529; Thu, 30 Jun 1994 18:11:13 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 30 Jun 94 18:11:13 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA24478; Thu, 30 Jun 1994 18:07:05 -0400
--* Date: Thu, 30 Jun 1994 18:07:05 -0400
--* From: dooley@watson.ibm.com (Sam Dooley)
--* Message-Id: <9406302207.AA24478@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] Using ':*' as an argument to '->' fails to type check. [hide0.as][v0.36.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

f(x:* Integer) : Integer == x;
