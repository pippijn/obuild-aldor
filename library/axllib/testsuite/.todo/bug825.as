--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 23 11:44:00 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22197; Tue, 23 Aug 1994 11:44:00 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0851; Tue, 23 Aug 94 11:44:05 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.TEKE.NOTE.YKTVMV.9455.Aug.23.11:44:03.-0400>
--*           for asbugs@watson; Tue, 23 Aug 94 11:44:04 -0400
--* Received: from piger.matematik.su.se by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 23 Aug 94 11:44:03 EDT
--* Received: by piger.matematik.su.se (AIX 3.2/UCB 5.64/4.03)
--*           id AA10105; Tue, 23 Aug 1994 17:28:05 -0500
--* Date: Tue, 23 Aug 1994 17:28:05 -0500
--* From: teke@piger.matematik.su.se (Torsten Ekedahl)
--* Message-Id: <9408232228.AA10105@piger.matematik.su.se>
--* To: asbugs@watson.ibm.com
--* Subject: [5] Compiler crashes

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp hest.as
-- Version: 0.36.5 and 0.36.1
-- Original bug file name: hest.as

--+ The compiler crashes on the given source files, however any of the following two
--+ modifications makes it not crash:
--+
--+ Change
--+     FMC ==> Monoid with;
--+ to
--+     FMC ==> Monoid;
--+
--+ Or
--+ comment out
--+     RR : FMC == %;
--+ and change
--+     Adjunct: (M:Monoid) -> with
--+ to
--+     Adjunct: (RR:FMC,M:Monoid) -> with
--+ and
--+      Adjunct(M:Monoid):  with
--+ to
--+      Adjunct(RR:FMC,M:Monoid):  with
--+
--+ In this latter case an appropriate extension actually compiles and
--+ performs as expected.
#include "axllib"
FMC ==> Monoid with;

FreeMonoidCategory(E:BasicType): Category == FMC with
{
    RR : FMC == %;
    Adjunct: (M:Monoid) -> with
        { adjunction: (E -> M) -> (RR -> M) };

    default
    {
     Adjunct(M:Monoid):  with
        { adjunction: (E -> M) -> (RR -> M) } == add
     {
      adjunction(f : E -> M) : RR -> M ==
      (x:RR):M +->
      {
         import from M;
         1;
         }
      }

  }
}

