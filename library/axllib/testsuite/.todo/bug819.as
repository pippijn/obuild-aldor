--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 23 08:52:28 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA05048; Tue, 23 Aug 1994 08:52:28 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3145; Tue, 23 Aug 94 08:52:32 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.TEKE.NOTE.YKTVMV.6597.Aug.23.08:52:31.-0400>
--*           for asbugs@watson; Tue, 23 Aug 94 08:52:32 -0400
--* Received: from piger.matematik.su.se by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 23 Aug 94 08:52:31 EDT
--* Received: by piger.matematik.su.se (AIX 3.2/UCB 5.64/4.03)
--*           id AA10749; Tue, 23 Aug 1994 14:36:36 -0500
--* Date: Tue, 23 Aug 1994 14:36:36 -0500
--* From: teke@piger.matematik.su.se (Torsten Ekedahl)
--* Message-Id: <9408231936.AA10749@piger.matematik.su.se>
--* To: asbugs@watson.ibm.com
--* Subject: [5] Compiler accepts incorrect definition

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp -G run hest.as
-- Version: 0.36.5
-- Original bug file name: hest.as

--+ The function accepts a definition of a function with one
#include "axllib"



ff(A:Type,aa:A): A  == (b:A):A +-> aa;


