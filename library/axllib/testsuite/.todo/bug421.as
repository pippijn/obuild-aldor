--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Sep 19 02:31:09 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21167; Sun, 19 Sep 1993 02:31:09 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8313; Sun, 19 Sep 93 02:35:22 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.EDWARDS.NOTE.YKTVMV.3221.Sep.19.02:35:21.-0400>
--*           for asbugs@watson; Sun, 19 Sep 93 02:35:21 -0400
--* Received: from ibm4.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 19 Sep 93 02:35:20 EDT
--* Received: by ibm4.scri.fsu.edu id AA12562
--*   (5.65c/IDA-1.4.4 for asbugs@watson.ibm.com); Sun, 19 Sep 1993 02:35:14 -0400
--* Date: Sun, 19 Sep 1993 02:35:14 -0400
--* From: Robert Edwards <edwards@ibm4.scri.fsu.edu>
--* Message-Id: <199309190635.AA12562@ibm4.scri.fsu.edu>
--* To: asbugs@watson.ibm.com
--* Subject: for j: element(x,i) in all repeat -- segmentation fault [bug18.as][A# version 30.4 for OSF/1 AXP]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--+ % asharp -rv bug18.as
--+ A# version 30.4 for OSF/1 AXP
--+ Exec: unicl -I/margit/a/users/edwards/applications/asharp/base/axposf/include -c bug18.c
--+ Exec:  cc -I/margit/a/users/edwards/applications/asharp/base/axposf/include -I/usr/include -c  bug18.c
--+ 	      ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time   2.2s   0  0 .7 .7  0 .7 .7  0  0 .7 31  2  0  0  0  6 55 .7 %
--+  Source 190L : 5181 lines per minute
--+ Exec: unicl -I/margit/a/users/edwards/applications/asharp/base/axposf/include -c asmain.c
--+ Exec:  cc -I/margit/a/users/edwards/applications/asharp/base/axposf/include -I/usr/include -c  asmain.c
--+ 	      ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time   0.2s   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0100  0 %
--+  Source 190L : 45600 lines per minute
--+ Exec: unicl bug18.o asmain.o -L/margit/a/users/edwards/applications/asharp/base/axposf/lib -o  bug18 -laslib -lfoam -lm
--+ Exec:  cc -I/usr/include -o bug18  bug18.o asmain.o -L/margit/a/users/edwards/applications/asharp/base/axposf/lib -laslib -lfoam -lm
--+ Exec: ./bug18
--+ sh: 21116 Memory fault - core dumped
--+
--+
--+ #### Note, no printing of diagnostic information
-- Finite
--   Provides category and domain for finite sized objects

#include "axllib"

macro
  PI == SingleInteger
  SI == SingleInteger
  NNI == SingleInteger

ReallyFinite: Category == BasicType
  with
    card: NNI
    ord:  % -> PI               -- BoundedInteger(1,card) does not work
    val:  PI -> %               -- BoundedInteger(1,card) does not work
    all: Generator %


FiniteBasicType: Category == ReallyFinite
  with
    coerce: % -> SI
    coerce: SI -> %

BoundedInteger(low: SI, high: SI): FiniteBasicType
  == SI add
    Rep ==> SI

    print("Constructing domain BoundedInteger(")(low)(",")(high)(")")()

    card: NNI == retract(high - low + 1)

    ord(a: %): PI ==
      rep(a) < low or rep(a) > high =>
        error "BoundedInteger: ord out of range"
      retract(rep(a) - low + 1)

    macro Coerce X == X
--  macro Coerce X == coerce(X)

    val(a: PI): % ==
      a < 1 or Coerce(a) > Coerce(card) =>
        error "BoundedInteger: ord out of range"
      per (Coerce(a) - 1 + low)

    coerce(a: %): SI == rep a

    coerce(a: SI): % ==
      a < low or a > high =>
        error "BoundedInteger: ord of coerce out of range"
      per a

    all: Generator % == generate
      a := low
      while a <= high repeat
        yield per a
        a := a + 1


import SI
import String

for x: BoundedInteger(3,7) in all repeat
  print("x = ")(x)()

boo: Cross(FiniteBasicType, FiniteBasicType) := (BoundedInteger(1,4), BoundedInteger(2,6))

print("Maybe I will croak")()

Blech:
  with
    fred: Tuple(FiniteBasicType) -> %
  == add
    print("I am instantiating Blech")()

    fred(x: Tuple(FiniteBasicType)): % ==
      for i: SI in 1 .. length(x) repeat
        for j: element(x,i) in all repeat
          print("i = ")(i)("  j = ")(j)()
      x pretend %


print("I am about to croak")()

blech: Blech == fred(boo)

print("ribbit")()
