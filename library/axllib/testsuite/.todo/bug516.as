--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Nov  7 16:59:20 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA19052; Sun, 7 Nov 1993 16:59:20 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2541; Sun, 07 Nov 93 17:06:37 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.2221.Nov.07.17:06:36.-0500>
--*           for asbugs@watson; Sun, 07 Nov 93 17:06:37 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 07 Nov 93 17:06:36 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <26523-0@bernina.ethz.ch>; Sun, 7 Nov 1993 23:06:29 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA02039; Sun, 7 Nov 93 23:06:25 +0100
--* Date: Sun, 7 Nov 93 23:06:23 +0100
--* Message-Id: <9311072206.AA28544@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA28544; Sun, 7 Nov 93 23:06:23 +0100
--* To: smwatt@watson.ibm.com
--* Subject: C:Category == add
--* Cc: bronstei, santas, jenks@watson.ibm.com, asbugs@watson.ibm.com

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--The following program compiles!
--(the fact that it runs and returns 0 must be a bug).

--#assert test1

#if test1
-------------------
#include "axllib"
SI==>SingleInteger
import from SI

C1: Category ==
  add
    x:SI
  default
    x:SI == 4

T1:C1 == add
import from T1
print(x)()
------------------

--It seems that not only 'default' has double meaning,
--but 'add' too (it builts categories as 'with' does)!
--This happens even without defaults:

-------------------
#else

#include "axllib"
SI==>SingleInteger
import from SI

C1: Category ==
  add
    x:SI

#endif
------------------

--which compiles.
--Is this a bug or a feature?
--What does 'add' build?

--On the same issue:


--How is
--  with with add
--and
--  add add ...
--parsed?

--Philip

