--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Feb 22 13:50:12 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19243; Wed, 22 Feb 1995 13:50:12 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2185; Wed, 22 Feb 95 13:49:34 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ROOT.NOTE.VAGENT2.5529.Feb.22.13:49:34.-0500>
--*           for asbugs@watson; Wed, 22 Feb 95 13:49:34 -0500
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 5521; Wed, 22 Feb 1995 13:49:33 EST
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 22 Feb 95 13:49:33 EST
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA21210; Wed, 22 Feb 1995 13:43:29 -0600
--* Date: Wed, 22 Feb 1995 13:43:29 -0600
--* From: root@watson.ibm.com
--* Message-Id: <9502221943.AA21210@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [9] Bad section index error message

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.0.6
-- Original bug file name: foo

--+ the error message:
--+
--+ Bug: Bad section index
--+
--+ should include the file name that failed.
--+ one cause of this message is an out-of-date libaxiom.asl
--+ in the search path for the compiler.
the error message:

Bug: Bad section index

should include the file name that failed.
one cause of this message is an out-of-date libaxiom.asl
in the search path for the compiler.
