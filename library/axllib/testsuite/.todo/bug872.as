--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Sep 23 09:59:07 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19322; Fri, 23 Sep 1994 09:59:07 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2333; Fri, 23 Sep 94 09:59:11 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.MIKER.NOTE.YKTVMV.8207.Sep.23.09:59:00.-0400>
--*           for asbugs@watson; Fri, 23 Sep 94 09:59:09 -0400
--* Received: from nagrs3.nag.co.uk by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 23 Sep 94 09:58:57 EDT
--* Received: by nagrs3.nag.co.uk (AIX 3.2/UCB 5.64/4.03)
--*           id AA17506; Fri, 23 Sep 1994 15:00:01 +0100
--* Date: Fri, 23 Sep 1994 15:00:01 +0100
--* From: miker@nagrs3.nag.co.uk (Mike Richardson)
--* Message-Id: <9409231400.AA17506@nagrs3.nag.co.uk>
--* To: asbugs@watson.ibm.com
--* Subject: [3] radix-integers misbehave

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 0.37.0
-- Original bug file name: /home/red5/miker/Axiom/ASdoc/t

% asharp -gloop
%1 >> #include "axllib"
%2 >> import from Integer
%3 >> 8r6 - 8r2
0 @ Integer
%4 >> 16rA
      ^
[L5 C1] #1 (Error) No meaning for identifier `16rA'.
