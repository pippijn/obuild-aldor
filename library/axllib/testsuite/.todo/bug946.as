--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Feb 10 15:23:03 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA28506; Fri, 10 Feb 1995 15:23:03 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8011; Fri, 10 Feb 95 15:22:40 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ROOT.NOTE.VAGENT2.1717.Feb.10.15:22:39.-0500>
--*           for asbugs@watson; Fri, 10 Feb 95 15:22:40 -0500
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 1713; Fri, 10 Feb 1995 15:22:39 EST
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Fri, 10 Feb 95 15:22:38 EST
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA18743; Fri, 10 Feb 1995 15:16:28 -0600
--* Date: Fri, 10 Feb 1995 15:16:28 -0600
--* From: root@watson.ibm.com
--* Message-Id: <9502102116.AA18743@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [5] (R is %) is not defined

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.0.4
-- Original bug file name: /tmp/bug.as

--+ Module(R:CommutativeRing): Category == BiModule(R,R) with
--+  {if not (R is %) then
--+   {default ((x:%)*(r:R)):% == r*x}
--+  } -- with
Module(R:CommutativeRing): Category == BiModule(R,R) with
 {if not (R is %) then
  {default ((x:%)*(r:R)):% == r*x}
 } -- with
