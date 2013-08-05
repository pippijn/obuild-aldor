--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun May 30 15:06:59 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21739; Sun, 30 May 1993 15:06:59 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3245; Sun, 30 May 93 15:07:32 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.7933.May.30.15:07:31.-0400>
--*           for asbugs@watson; Sun, 30 May 93 15:07:31 -0400
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 30 May 93 15:07:30 EDT
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <9404-0@bernina.ethz.ch>; Sun, 30 May 1993 21:07:24 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA20939; Sun, 30 May 93 21:07:17 +0200
--* Date: Sun, 30 May 93 21:07:16 +0200
--* Message-Id: <9305301907.AA07330@rutishauser.inf.ethz.ch>
--* Received: from ru7.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA07330; Sun, 30 May 93 21:07:16 +0200
--* To: asbugs@watson.ibm.com
--* Subject: unions (II)
--* Cc: bronstein

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>
-- PI: what is "functional" ?
#if 0

The following program reports segmentation faults.
It is a version of a program I sent yesterday: this time
instead of Cross, I use Record.

Philip
#endif
------------------------term1.as--------------------------------

#include "../functional.as"

SI ==> SingleInteger
B ==> Bit

import SI
import B

IndexName ==> Record(fin:String,sin:SI)
Class ==> String
Sort ==> List Class

import String
import IndexName
import Class
import Sort

typ: with

    Typ: (String,List %)->%
    TFree: (String,Sort)->%
    TVar: (IndexName, Sort)->%
    arrow: (%,%)->%
    longarrow: (List %,%)->%

    isTVar: % -> B
    isFun: % -> B
    funTypes: % -> (%,%)
    binderTypes: % -> (List %)
    bodyType: % -> %
    stripType: % -> (List %, %)

 == add

     -- Record macros for the Rep of typ
     TypRec ==> Record(st:String,ll:List %)
     TFreeRec ==> Record(sf:String,so:Sort)
     TVarRec ==> Record(inn:IndexName,so:Sort)

     Rep ==> Union(Typ:TypRec, TFree:TFreeRec, TVar:TVarRec)

     import TypRec
     import TVarRec
     import TFreeRec
     import Rep

     import List %
     import LoopList %
     import Fold(%,%)

     Typ(x:TypRec):% == per (union x)
     Typ(x:String, y:List %):% == per (union [x,y])
     TFree(x:TFreeRec):% == per (union x)
     TFree(x:String, y:Sort):% == per (union [x,y])
     TVar(x:TVarRec):% == per (union x)
     TVar(x:IndexName, y:Sort):% == per (union [x,y])

     arrow(S:%,T:%):% == Typ("fun",[S,T])
     longarrow: (List %,%)->% == foldright arrow

     isTVar(x:%):B ==  (rep x) case TVar

     isFun(x:%):B ==
        (rep x) case Typ => ((((rep x)Typ).st)="fun") and (#(((rep x)Typ).ll)=2)
        false

     funTypes(x:%):(%,%) ==
        -- assume that it is a fun, and don't do any test
        (first (((rep x)Typ).ll), at(((rep x)Typ).ll,2))

     binderTypes(x:%):(List %) ==
       isFun x =>cons(first(((rep x)Typ).ll),binderTypes(at((((rep x)Typ).ll),2)))
       nil

     bodyType(x:%):% ==
       isFun x => bodyType(at((((rep x)Typ).ll),2))
       x

     striptype(x:%):(List %, %) == (binderTypes x, bodyType x)


import typ

x: typ := TFree("asd", ["qwe","rty","wer"])
--------------------------------------------------------------

