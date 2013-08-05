--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun May 30 00:22:04 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA14679; Sun, 30 May 1993 00:22:04 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1649; Sun, 30 May 93 00:22:36 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.4819.May.30.00:22:35.-0400>
--*           for asbugs@watson; Sun, 30 May 93 00:22:36 -0400
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 30 May 93 00:22:35 EDT
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <17920-0@bernina.ethz.ch>; Sat, 29 May 1993 18:49:34 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA12057; Sat, 29 May 93 18:49:30 +0200
--* Date: Sat, 29 May 93 18:49:29 +0200
--* Message-Id: <9305291649.AA04806@rutishauser.inf.ethz.ch>
--* Received: from ru7.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA04806; Sat, 29 May 93 18:49:29 +0200
--* To: asbugs@watson.ibm.com
--* Subject: bug in unions
--* Cc: bronstein

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>
-- PI: what is "functional.as" ?



--The following program reports errors.

--Philip

---------------------testterm1.as--------------------------

#include "../functional.as"

SI ==> SingleInteger
B ==> Boolean

import from SI
import from B

IndexName ==> Cross(String,SI)
Class ==> String
Sort ==> List Class

import from String
import from IndexName
import from Class
import from Sort

typ: with
    Typ: Cross(String,List %)->%
    TFree: Cross(String,Sort)->%
    TVar: Cross(IndexName, Sort)->%
    arrow: (%,%)->%
    longarrow: (List %,%)->%

 == add

     Rep ==> Union(Typ: Cross(String,List %), TFree: Cross(String, Sort), TVar: Cross(IndexName,Sort))

     import from Rep
     import from List %
     -- value(x:%):TTyp == (rep x) ttyp
     -- value(x:%):TTFree == (rep x) tfree
     -- value(x:%):TTVar == (rep x) tvar

     import from Fold(%,typ)
     Typ(x:String,y:List %):% == per [x,y]
     TFree(x:String,y:Sort):% == per [x,y]
     TVar(x:IndexName,y:Sort):% == per [x,y]

     arrow(S:%,T:%):% == Typ("fun",[S,T])
     import from Fold(%,%)
     longarrow: (List %,%)->% == foldright arrow

import from typ

x: typ := TFree("asd", ["qwe","rty","wer"])

---------------------------erroros----------------------
-- ru7.inf.ethz.ch100  Philip >asharp testterm1.as
-- Bug: branch not in union

