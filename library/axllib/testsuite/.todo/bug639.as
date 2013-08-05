--* From postmaster%watson.vnet.ibm.com@yktvmh.watson.ibm.com  Mon May 16 14:55:31 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22708; Mon, 16 May 1994 14:55:31 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1093; Mon, 16 May 94 14:55:38 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.RMC.NOTE.VAGENT2.6787.May.16.14:55:38.-0400>
--*           for asbugs@watson; Mon, 16 May 94 14:55:38 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 6785; Mon, 16 May 1994 14:55:37 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 16 May 94 14:55:37 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA20625; Mon, 16 May 1994 14:53:06 -0400
--* Date: Mon, 16 May 1994 14:53:06 -0400
--* From: rmc@watson.ibm.com
--* Message-Id: <9405161853.AA20625@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [5] segmentation fault in xasharp [as/test.as][35.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--+ xasharp bug.
--+
--+ xasharp -M2 -Fx lambert.as
--+
--+ click on button help
--+ click on ugly
--+
#include "axllib"

import from Integer;

print(1 quo 1)()
