--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun May 30 00:22:06 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21597; Sun, 30 May 1993 00:22:06 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1651; Sun, 30 May 93 00:22:37 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.4823.May.30.00:22:36.-0400>
--*           for asbugs@watson; Sun, 30 May 93 00:22:37 -0400
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 30 May 93 00:22:36 EDT
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <18090-0@bernina.ethz.ch>; Sat, 29 May 1993 18:54:27 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA12104; Sat, 29 May 93 18:54:22 +0200
--* Date: Sat, 29 May 93 18:54:21 +0200
--* Message-Id: <9305291654.AA04838@rutishauser.inf.ethz.ch>
--* Received: from ru7.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA04838; Sat, 29 May 93 18:54:21 +0200
--* To: asbugs@watson.ibm.com
--* Subject: union faults
--* Cc: bronstein

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>



--The following program compiles properly, but I get segmentation faults
--at run-time.

--Philip

--------------------------testterm1.as-------------------------------

#include "../functional.as"

SI ==> SingleInteger
B ==> Bit

import SI
import B

IndexName ==> Cross(String,SI)
Class ==> String
Sort ==> List Class

import String
import IndexName
import Class
import Sort

typ: with
    Typ: Cross(String,List %)->%
    TFree: Cross(String,Sort)->%
    TVar: Cross(IndexName, Sort)->%
    arrow: (%,%)->%
    longarrow: (List %,%)->%

 == add

     Rep ==> Union(Typ: Cross(String,List %), TFree: Cross(String, Sort), TVar: Cross(IndexName,Sort))

     import Rep
     import List %
     -- value(x:%):TTyp == (rep x) ttyp
     -- value(x:%):TTFree == (rep x) tfree
     -- value(x:%):TTVar == (rep x) tvar

     import Fold(%,typ)
     Typ(x:Cross(String,List %)):% == per [x]
     TFree(x:Cross(String,Sort)):% == per [x]
     TVar(x:Cross(IndexName,Sort)):% == per [x]

     arrow(S:%,T:%):% == Typ("fun",[S,T])
     import Fold(%,%)
     longarrow: (List %,%)->% == foldright arrow

import typ

x: typ := TFree("asd", ["qwe","rty","wer"])
---------------------------------------------------------------

