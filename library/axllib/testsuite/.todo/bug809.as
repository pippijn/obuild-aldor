--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 16 19:44:07 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17997; Tue, 16 Aug 1994 19:44:07 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5069; Tue, 16 Aug 94 19:44:10 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.TERESA.NOTE.VAGENT2.8477.Aug.16.19:44:10.-0400>
--*           for asbugs@watson; Tue, 16 Aug 94 19:44:10 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 8473; Tue, 16 Aug 1994 19:44:09 EDT
--* Received: from cyst.watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 16 Aug 94 19:44:09 EDT
--* Received: from watson.ibm.com by cyst.watson.ibm.com (AIX 3.2/UCB 5.64/900528)
--*   id AA68541; Tue, 16 Aug 1994 19:37:07 -0400
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA11787; Tue, 16 Aug 1994 19:34:53 -0400
--* Date: Tue, 16 Aug 1994 19:34:53 -0400
--* From: teresa@watson.ibm.com
--* X-External-Networks: yes
--* Message-Id: <9408162334.AA11787@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2][interactive] -gloop crash if wrong file included twice? (see file)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp -gloop
-- Version: 0.36.4 (rs6000)
-- Original bug file name: listo.as

-- PI: It seems that when a wrong file like this is included within the
-- interactive mode, it crashs.
-- Run with -g loop and include this file twice to reproduce the bug.



#include "axllib"
#pile

SI ==> SingleInteger

+++ Comments.
+++ Just List with some operations and Integer indices

ListOps(S: Type): ListCategory S with

  #: % -> Integer
    ++ length with Integer type for result
  apply: (%,Integer) -> S
    ++ element extraction with integer indice
  set!: (%,Integer,S) -> %
    ++ changes destructively the i-th element in a list
    ++ and returns this list
  set: (%,Integer,S) -> %
    ++ returs a new list similar to the input one except
    ++ in the i-th element

== List S add

  Rep == List S

  import from Rep

  default l: %
  default x: S
  default i: Integer
  default si: SI

  #l :Integer == (#(rep l)$Rep)::Integer

  apply(l,i):S == apply(rep l, i::SI)$Rep

  set!(l,i,x):% ==
    lr:Rep:= rep l
    setFirst!(rest(lr,(i-1)::SI),x)$Rep
    per lr

  set(l,i,x):% ==
    lr:Rep:= copy(rep l)$Rep
    set!(lr,i,x)    -- PI: Here there is a mistake
		    -- It should be set!(per lr,i,x)	


