--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Feb 15 10:54:56 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA32918; Wed, 15 Feb 1995 10:54:56 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2267; Wed, 15 Feb 95 10:54:28 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.8699.Feb.15.10:54:26.-0500>
--*           for asbugs@watson; Wed, 15 Feb 95 10:54:27 -0500
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 15 Feb 95 10:54:25 EST
--* Via: uk.co.iec; Wed, 15 Feb 1995 14:56:02 +0000
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA22128;
--*           Wed, 15 Feb 95 14:37:44 GMT
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Wed, 15 Feb 95 14:35:02 GMT
--* Message-Id: <17679.9502151435@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA17679;
--*           Wed, 15 Feb 95 14:35:02 GMT
--* To: asbugs@watson.ibm.com
--* Subject: [4] Domain construction in a function and =>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--Return-Path: <hemmecke@aix550.informatik.uni-leipzig.de>
--Received: from nags2.nag.co.uk by vax.nag.co.uk with SMTP ;
--          Sat,  4 Feb 95 15:44:26 WET
--Received: from uk.ac.nsfnet-relay by nags2.nag.co.uk (4.1/UK-2.1)
--	id AA06030; Sat, 4 Feb 95 15:18:30 GMT
--Received: from server1.rz.uni-leipzig.de by sun3.nsfnet-relay.ac.uk
--          with Internet SMTP id <sg.29924-0@sun3.nsfnet-relay.ac.uk>;
--          Sat, 4 Feb 1995 15:09:05 +0000
--Received: from aix550.informatik.uni-leipzig.de by server1.rz.uni-leipzig.de
--          with SMTP (1.38.193.5/15.6) id AA08673;
--          Sat, 4 Feb 1995 16:08:52 +0100
--Received: by aix550.informatik.uni-leipzig.de
--           (AIX 3.2/UCB 5.64/BelWue-1.1AIXRS)
--          id AA21306; Sat, 4 Feb 1995 16:10:23 +0100
--Date: Sat, 4 Feb 1995 16:10:23 +0100
--From: hemmecke@aix550.informatik.uni-leipzig.de (Ralf Hemmecke)
--Message-Id: <9502041510.AA21306@aix550.informatik.uni-leipzig.de>
--To: infodesk@nag.co.uk
--Subject: [4] Domain construction in a function and =>
--Sender: hemmecke@aix550.informatik.uni-leipzig.de
--
-- Infodesk Log Number: LJK12271
-- Command line: axiomxl -grun -DC2 -DCA xxx.as
-- Version: AXIOM-XL version 1.0.0 for AIX RS/6000
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, University of Leipzig
-- Date: 04-FEB-95
-- AXIOM-XL version 1.0.0 for AIX RS/6000

-- Compile this via
-- (1)  axiomxl -grun -DC1 xxx.as
-- (2)  axiomxl -grun -DC2 xxx.as
-- (3)  axiomxl -grun -DC1 -DCA xxx.as
-- (4)  axiomxl -grun -DC2 -DCA xxx.as

-- Except for the last everything seems to work well.
-- (4), however, yields the output:

--: Pkg !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--: :::BEGIN:::
--: bsh: 18391 Memory fault: Eine Speicherabbilddatei wurde als "core"
--: erstellt.

-------------------------------------------------------------------
#include "axllib.as"
INT ==Integer;
BT  ==BasicType;

Dom(A:BT):BT == add {
  Rep ==Record(n:Integer,a:A);
  import from Rep;
  sample:% == per [0$Integer,sample$A];
  (x:%)=(y:%):Boolean == true;
  (p:TextWriter) << (x:%):TextWriter ==
    p << "(" << rep(x).n << "," << rep(x).a << ")";
}
------------------------------------------------------------------------
Pkg: with {
  foo: () -INT;
} == add {
  print << "Pkg !!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << newline;

  foo():INT == {
    print << ":::BEGIN:::" << newline;
#if C1
    if 0>1 then return 1;
#elseif C2
    0>1 =1;
#endif
    TT == Dom(INT);
#if CA
    tt:TT := sample$TT;
#endif
    print << ":::END:::" << newline;
    1;
  }
}

foo()$Pkg



