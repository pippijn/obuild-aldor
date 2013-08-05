--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Nov  1 12:13:11 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA11774; Mon, 1 Nov 1993 12:13:11 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4299; Mon, 01 Nov 93 12:20:21 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.0255.Nov.01.12:20:20.-0500>
--*           for asbugs@watson; Mon, 01 Nov 93 12:20:21 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Mon, 01 Nov 93 12:20:19 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <21334-0@bernina.ethz.ch>; Mon, 1 Nov 1993 18:20:09 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA23039; Mon, 1 Nov 93 18:20:04 +0100
--* Date: Mon, 1 Nov 93 18:18:16 +0100
--* Message-Id: <9311011718.AA02127@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA02127; Mon, 1 Nov 93 18:18:16 +0100
--* To: asbugs@watson.ibm.com
--* Subject: more on bug504
--* In-Reply-To: Mail from 'asbugs@watson.ibm.com'
--*       dated: Mon, 1 Nov 1993 12:10:22 -0500

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


And this program compiles for ever.

Philip

------------------------------
(foo x) where
       T1:with
             foo:SI->SI
          == add
              foo(x:SI):SI == {print(x+1)(); x}
       foo(x:SI):SI == (foo x)$T1
       x:SI == 3
------------------------------

