--* From PETEB%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Jun 26 15:55:28 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA28882; Sun, 26 Jun 1994 15:55:28 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2215; Sun, 26 Jun 94 15:55:28 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.5429.Jun.26.15:55:28.-0400>
--*           for asbugs@watson; Sun, 26 Jun 94 15:55:28 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 5425; Sun, 26 Jun 1994 15:55:28 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Sun, 26 Jun 94 15:55:27 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA20263; Sun, 26 Jun 1994 15:52:47 -0500
--* Date: Sun, 26 Jun 1994 15:52:47 -0500
--* From: pab@watson.ibm.com
--* Message-Id: <9406262052.AA20263@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] imports not cascading [for0.as][latest]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--> testcomp

#include "axllib"
#pile

macro SI == SingleInteger


FiniteBasicType: Category == BasicType
  with
    coerce: % -> SI
    coerce: SI -> %
    all: Generator %


BoundedInteger(low: SI, high: SI): FiniteBasicType == SI
  add
    Rep ==> SI

    print<<"Constructing domain BoundedInteger("<<low<<","<<high<<")"<<newline

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

-----------------------------------------------------------------------------
MapDefault ==>
    (a: %) = (b: %): Boolean ==
      import from String
      print<<"Not implemented"<<newline
      true

    (a: %) ~= (b: %): Boolean ==
      import from String
      print<<"Not implemented"<<newline
      false

Map(Domain: BasicType, Codomain: BasicType): Category == BasicType
  with
    apply: (%, Domain) -> Codomain	++ function evaluation
    coerce: (Domain -> Codomain) -> %	++ constructor (make less lazy)
    coerce: % -> (Domain -> Codomain)   ++ constructor (make more lazy)

--    default MapDefault

-------------------------------------------------------------------------------

FunctionMap(Domain: BasicType, Codomain: BasicType): Map(Domain, Codomain) ==
  add
    Rep ==> Domain -> Codomain
    import from Rep

    print<<"Constructing domain FunctionMap"<<newline

    MapDefault  -- compiler bug evasion

    sample: % == ((x: Domain): Codomain +-> sample)::%
    (p: TextWriter) << (a: %): TextWriter ==
      import from String
      p << "Not implemented" << newline

    apply(f: %, d: Domain): Codomain == (rep f)(d)
    coerce(f: Rep): % ==
      print<<"FunctionMap: coerce:Rep -> %"<<newline
      per f
    coerce(f: %): Rep == rep f


ArrayMap(Domain: FiniteBasicType, Codomain: BasicType): Map(Domain, Codomain) ==
  add
    Rep ==> Array(Codomain)
    import from Rep

    print<<"Constructing domain ArrayMap"<<newline

    MapDefault  -- compiler bug evasion

    sample: % == nil$Pointer pretend %
    (p: TextWriter) << (a: %): TextWriter ==
      import from String
      p << rep a << " :: ArrayMap" << newline

    apply(f: %, d: Domain): Codomain == apply(rep f,d::SI)

    coerce(f: Domain -> Codomain): % ==
---   per [ f(i) for i:Domain in all$Domain ]
      per [ f(i) for i:Domain in all ]

    coerce(a: %): Domain -> Codomain ==
      (i: Domain): Codomain +-> apply(a,i)


-------------------------------------------------------------------------------
print<<"Start test..."<<newline

SI ==> SingleInteger

import from SI
import from String

BI: FiniteBasicType == BoundedInteger(1,4)
-- macro BI == BoundedInteger(1,4)

f: FunctionMap(BI,SI) ==
  coerce( (x: BI): SI +-> 10 * x::SI )

import from BI
print<<"f(13) = "<<f(13::BI)<<newline

l: ArrayMap(BI,SI) == f :: BI -> SI :: ArrayMap(BI,SI)
-- l: ArrayMap(BI,SI) == coerce(coerce(f)@(BI -> SI))@(ArrayMap(BI,SI))

print<<"l(3) = "<<l(3::BI)<<newline
print<<"l = "<<l<<newline

print<<"...End test"<<newline
