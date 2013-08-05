--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 23 12:25:44 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA29328; Tue, 23 Aug 1994 12:25:44 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2559; Tue, 23 Aug 94 12:25:48 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.TEKE.NOTE.YKTVMV.4649.Aug.23.12:25:42.-0400>
--*           for asbugs@watson; Tue, 23 Aug 94 12:25:48 -0400
--* Received: from piger.matematik.su.se by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 23 Aug 94 12:25:42 EDT
--* Received: by piger.matematik.su.se (AIX 3.2/UCB 5.64/4.03)
--*           id AA10208; Tue, 23 Aug 1994 18:09:46 -0500
--* Date: Tue, 23 Aug 1994 18:09:46 -0500
--* From: teke@piger.matematik.su.se (Torsten Ekedahl)
--* Message-Id: <9408232309.AA10208@piger.matematik.su.se>
--* To: asbugs@watson.ibm.com
--* Subject: [5] Defined function is not recognised.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: none
-- Version: 0.36.5
-- Original bug file name: hest.as

--+ As far as I can see mkdom() and med() are correctly defined and yet
--+ the compiler claims:
--+
--+ "hest.as", line 5: == add {
--+                    ...^
--+ [L5 C4] #1 (Error) The domain is missing some exports.
--+         Missing mkdom: () -> (FiniteAggregate(T) with med: () -> %)
--+
#include "axllib"

lambda(T:Type): with_
  { mkdom: () -> FiniteAggregate(T) with { med : () -> % } }
== add {
   import from List T;
   mkdom() : FiniteAggregate(T) with { med : () -> % } ==  List T add {
          med() : % == []@List(T) pretend %;
          };
     }
