--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Dec  6 15:25:10 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA20342; Mon, 6 Dec 1993 15:25:10 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0979; Mon, 06 Dec 93 15:31:31 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.3563.Dec.06.15:31:28.-0500>
--*           for asbugs@watson; Mon, 06 Dec 93 15:31:31 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Mon, 06 Dec 93 15:31:28 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <10978-0@bernina.ethz.ch>; Mon, 6 Dec 1993 21:31:10 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA03773; Mon, 6 Dec 93 21:31:07 +0100
--* Date: Mon, 6 Dec 93 21:31:05 +0100
--* Message-Id: <9312062031.AA03165@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA03165; Mon, 6 Dec 93 21:31:05 +0100
--* To: asbugs@watson.ibm.com
--* Subject: x:SI == x:T     compiles!
--* Cc: bronstei

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- The following program compiles (RS version):

#include "axllib"
SI ==> SingleInteger
C1: Category == with
      x:SI
G1(T:C1):C1 == add
      x:SI == x:T

-- Philip

