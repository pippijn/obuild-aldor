--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Nov 21 19:37:50 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA24956; Mon, 21 Nov 1994 19:37:50 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7513; Mon, 21 Nov 94 19:37:56 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.6751.Nov.21.19:37:56.-0500>
--*           for asbugs@watson; Mon, 21 Nov 94 19:37:56 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Mon, 21 Nov 94 19:37:56 EST
--* Received: from ru7.inf.ethz.ch (santas@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id BAA29687; Tue, 22 Nov 1994 01:37:44 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id BAA14410; Tue, 22 Nov 1994 01:37:44 +0100
--* Date: Tue, 22 Nov 1994 01:37:44 +0100
--* Message-Id: <199411220037.BAA14410@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: anonymous category functions
--* Cc: bronstei@inf.ethz.ch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


Anonymous categories fail to compile (they report segmentation faults).
A# version 0.37.0 for SPARC

----------------------------------------
#include "axllib"

F(X: ((A:Type):Category +-> with {f: A -> A}) Integer): with{}
  == X
----------------------------------------

Philip

