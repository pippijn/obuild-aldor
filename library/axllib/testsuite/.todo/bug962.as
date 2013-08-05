--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon May  1 11:44:30 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA27123; Mon, 1 May 1995 11:44:30 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3185; Mon, 01 May 95 11:44:28 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.0656.May.01.11:44:15.-0400>
--*           for asbugs@watson; Mon, 01 May 95 11:44:28 -0400
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 01 May 95 11:44:14 EDT
--* Via: uk.co.iec; Mon, 1 May 1995 15:58:17 +0100
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA00344;
--*           Mon, 1 May 95 15:59:59 BST
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Mon, 1 May 95 15:55:57 +0100
--* Message-Id: <7250.9505011455@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA07250;
--*           Mon, 1 May 95 15:55:57 +0100
--* To: asbugs@watson.ibm.com
--* Subject: Seg Fault instead of error

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

Bountiful(D: BasicType): BasicType with {
    if D has Attribute then
      Attribute;
    unction: () -> String;
}  == SingleInteger add {
    unction(): String == "You are forgiven";
}

