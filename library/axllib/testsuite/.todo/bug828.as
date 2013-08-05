--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 23 14:06:47 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA27050; Tue, 23 Aug 1994 14:06:47 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5985; Tue, 23 Aug 94 14:06:51 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.5427.Aug.23.14:06:49.-0400>
--*           for asbugs@watson; Tue, 23 Aug 94 14:06:50 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 5421; Tue, 23 Aug 1994 14:06:49 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Tue, 23 Aug 94 14:06:47 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA16754; Tue, 23 Aug 1994 14:06:51 -0400
--* Date: Tue, 23 Aug 1994 14:06:51 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9408231806.AA16754@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2][tinfer] Dependent record botch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: none
-- Version: 0.36.5
-- Original bug file name: depend99.as

-- Record should not export updating operations for dependent records.

#include "axllib"

BT ==> BasicType;


f(): (T: BT, T)    == { import from Integer; (Integer, 7) }
g(T: BT, t: T): () == { print << t }

r: Record(T: BT, t: T) := record f();
r.T := List Integer;  -- This invalidates the dependency between fields.
g explode r;
