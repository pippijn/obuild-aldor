--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Dec 18 07:44:15 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17909; Sun, 18 Dec 1994 07:44:15 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 9263; Sun, 18 Dec 94 07:44:12 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.7719.Dec.18.07:44:12.-0500>
--*           for asbugs@watson; Sun, 18 Dec 94 07:44:12 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 18 Dec 94 07:44:11 EST
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id NAA07046 for <asbugs@watson.ibm.com>; Sun, 18 Dec 1994 13:44:12 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id NAA06891 for asbugs@watson.ibm.com; Sun, 18 Dec 1994 13:44:11 +0100
--* Date: Sun, 18 Dec 1994 13:44:11 +0100
--* Message-Id: <199412181244.NAA06891@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [6] cannot make a C call from -Gloop

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.0.3
-- Original bug file name: triple.c

/*------------------------ triple.c -----------------*/

/* This bug illustrates that a foreign C call cannot be done from within
   a -Gloop, even if the .o file is given. This is a problem because it
   restricts -Gloop to types which never make a C call:

% cc -c triple.c
% asharp -Gloop triple.o
%1 >> #include "axllib"
%2 >> macro Z == SingleInteger;
%3 >> import { triple:Z -> Z } from Foreign C;
%4 >> import from Z;
%5 >> triple 4;
Bug: fintEval: Return (<-> in [main]) unimplemented... (or Seq without Return)

*/

long triple(x)
long x;
{
	return x + x + x;
}

