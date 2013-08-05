--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Mar 14 11:44:21 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17883; Tue, 14 Mar 1995 11:44:21 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7883; Tue, 14 Mar 95 11:43:30 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.6563.Mar.14.11:43:29.-0500>
--*           for asbugs@watson; Tue, 14 Mar 95 11:43:30 -0500
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 14 Mar 95 11:43:28 EST
--* Via: uk.co.iec; Tue, 14 Mar 1995 14:45:42 +0000
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA15575;
--*           Tue, 14 Mar 95 14:47:39 GMT
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Tue, 14 Mar 95 14:45:20 GMT
--* Message-Id: <1866.9503141445@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA01866;
--*           Tue, 14 Mar 95 14:45:20 GMT
--* To: asbugs@watson.ibm.com
--* Subject: Confusing the interpreter.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Actually, there are similar problems w/out the -gloop:
$ cd /tmp
$ rm string.ao; touch string.ao
$ axiomxl -gloop <<EOF
#include "axllib"
print << "hello"
EOF

--- At least a warning would be nice.

