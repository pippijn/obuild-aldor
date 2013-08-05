--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Sep  2 16:09:43 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA25047; Thu, 2 Sep 1993 16:09:43 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2499; Thu, 02 Sep 93 16:13:43 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.VAGENT2.9483.Sep.02.16:13:40.-0400>
--*           for asbugs@watson; Thu, 02 Sep 93 16:13:42 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9475; Thu, 2 Sep 1993 16:13:40 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 02 Sep 93 16:13:39 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA10514; Thu, 2 Sep 1993 16:12:09 -0400
--* Date: Thu, 2 Sep 1993 16:12:09 -0400
--* From: santas@watson.ibm.com
--* Message-Id: <9309022012.AA10514@watson.ibm.com>
--* To: bmt@watson.ibm.com, jenks@watson.ibm.com
--* Subject: program that terminates lasts for ever
--* Cc: asbugs@watson.ibm.com, peteb@watson.ibm.com

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>



I have compiled the files queens.as and functional.as
(they are in leonardo:/home/santas).
The program is the foloowing:
these files compile and start bringing results in 1 sec in Zurich
(with the compiler there), but here they last for ever
(try to compile queens.as).

Is this a bug in the code generation?

Philip
