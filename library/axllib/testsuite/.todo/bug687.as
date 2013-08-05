--* From RMC%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Jun 13 12:12:17 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19223; Mon, 13 Jun 1994 12:12:17 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2777; Mon, 13 Jun 94 12:12:16 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.RMC.NOTE.VAGENT2.4997.Jun.13.12:12:15.-0400>
--*           for asbugs@watson; Mon, 13 Jun 94 12:12:16 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 4991; Mon, 13 Jun 1994 12:12:15 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 13 Jun 94 12:12:14 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA17707; Mon, 13 Jun 1994 12:10:04 -0400
--* Date: Mon, 13 Jun 1994 12:10:04 -0400
--* From: rmc@watson.ibm.com
--* Message-Id: <9406131610.AA17707@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3] Fields are modules over Z [try.as][latest]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

hello(F:Field,n:Integer):()=={
  local x:F;
  x := 1;
  x := n*x;
}
