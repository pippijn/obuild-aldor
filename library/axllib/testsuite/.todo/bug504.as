--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Nov  1 11:24:15 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA11452; Mon, 1 Nov 1993 11:24:15 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2737; Mon, 01 Nov 93 11:31:25 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.7049.Nov.01.11:31:22.-0500>
--*           for asbugs@watson; Mon, 01 Nov 93 11:31:24 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Mon, 01 Nov 93 11:31:21 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <19118-0@bernina.ethz.ch>; Mon, 1 Nov 1993 17:31:07 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA21470; Mon, 1 Nov 93 17:30:59 +0100
--* Date: Mon, 1 Nov 93 17:29:13 +0100
--* Message-Id: <9311011629.AA01840@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA01840; Mon, 1 Nov 93 17:29:13 +0100
--* To: smwatt@watson.ibm.com
--* Subject: local category/type definitions.
--* Cc: jenks@watson.ibm.com, asbugs@watson.ibm.com, bronstei, santas

-- PI: probably bad C generation for "where"

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


What should the following programs do?
Philip

-----------------------------
(foo x) where
       C:Category == with
             foo:SI->SI
       T1:C == add
             foo(x:SI):SI == {print(x+1)(); x}
       import T1
       x:SI == 3
-----------------------------

(for the moment the compiler returns:
     (Error) Program fault (segmentation violation).
     Segmentation fault (core dumped)
)

The equivalent program
-----------------------------
(foo x) where
       T1:with
             foo:SI->SI
          == add
              foo(x:SI):SI == {print(x+1)(); x}
       import T1
       x:SI == 3
-----------------------------
returns:
"nestCat.c", line 84.36: 1506-045 (S) Undeclared identifier l.
"nestCat.c", line 84.38: 1506-122 (S) Expecting pointer to struct or union.
"nestCat.c", line 84.78: 1506-122 (S) Expecting pointer to struct or union.
xlc: 1501-228 input file nestCat.o not found

Similar things happen with the program:
-----------------------------
(foo x) where
       T1:with
             foo:SI->SI
          == add
              foo(x:SI):SI == {print(x+1)(); x}
       foo:SI->SI == foo$T1
       x:SI == 3
-----------------------------
which returns:
"nestCat.c", line 82.27: 1506-045 (S) Undeclared identifier l.
"nestCat.c", line 82.29: 1506-122 (S) Expecting pointer to struct or union.
xlc: 1501-228 input file nestCat.o not found

