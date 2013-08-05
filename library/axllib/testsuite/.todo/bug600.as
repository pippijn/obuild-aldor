--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Apr 12 13:18:20 1994
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA16662; Tue, 12 Apr 1994 13:18:20 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2875; Tue, 12 Apr 94 13:17:53 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BMT.NOTE.YKTVMV.3659.Apr.12.13:17:52.-0400>
--*           for asbugs@watson; Tue, 12 Apr 94 13:17:53 -0400
--* Received: from ICNUCEVX.CNUCE.CNR.IT by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 12 Apr 94 13:17:50 EDT
--* Received: from cardano (cardano.dm.unipi.it) by icnucevx.cnuce.cnr.it (PMDF
--*  V4.2-15 #4369) id <01HB3JCQJO0GI00WQT@icnucevx.cnuce.cnr.it>; Tue,
--*  12 Apr 1994 18:52:08 MET
--* Received: by cardano (4.1/SMI-4.1) id AA00378; Tue, 12 Apr 94 18:53:05 +0200
--* Date: Tue, 12 Apr 1994 18:53:05 +0200
--* From: bmt@posso.dm.unipi.it (Barry Trager)
--* Subject: [5] because of continuation error message doesn't show function "^"
--*  which is the cause of the problem. [hilbert1.as][v34.6]
--* To: asbugs@watson.ibm.com
--* Message-Id: <9404121653.AA00378@cardano>
--* Content-Transfer-Encoding: 7BIT

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--> testcomp -O -Q inline-all -l asdem
--> testrun  -O -Q inline-all -l asdem

#include "axllib"

#library DemoLib       "asdem"

import from DemoLib

-- This file computes hilbert functions for monomial ideals
-- ref: "On the Computation of Hilbert-Poincare Series", Bigatti, Caboara, Robbiano,
-- AAECC vol 2 #1 (1991) pp 21-33

macro
  Monom == Monomial
  L == List
  SI == SingleInteger
  B == Boolean
  POLY == Polynomial(Integer, SI)

import from SingleInteger

Monomial : Order with
      totalDegree: % -> SI
      divides?: (%, %) -> B
      homogLess: (%, %) -> B
      quo: (%, %) -> %
      quo: (%, SI) -> %
      *: (%, %) -> %
      pure?: % -> B
      varMonom: (i:SI,n:SI, deg:SI) -> %
      variables: L % -> L SI
      apply: (%, SI) -> SI
      #: % -> SI
      monomial: Tuple SI -> %
   == Array(SingleInteger) add
      Rep ==> Array(SingleInteger)
      import from Rep

      monomial(t:Tuple SI):% == per array t

      totalDegree(m:%):SI ==
	sum:SI := 0
	for e in rep m repeat sum := sum  + e
	sum

      divides?(m1:%, m2:%):B ==
	for e1 in rep m1 for e2 in rep m2 repeat
	  if e1 > e2 then return false
	true

      (m1:%) < (m2:%):B ==
	for e1 in rep m1 for e2 in rep m2 repeat
	  if e1 < e2 then return true
	  if e1 > e2 then return false
	false

      (m1:%) > (m2:%):B == m2 < m1

      homogLess(m1:%, m2:%):B ==
	(d1:=totalDegree(m1)) < (d2:=totalDegree(m2)) => true
	d1 > d2 => false
	m1 < m2

      (m:%) quo (v:SI):% == --remove vth variable
         per array((if i=v then 0 else (rep m).i) for i in 1..#rep m)

      (m1:%) quo (m2:%):% ==
         per array(max(a1-a2,0) for a1 in rep m1 for a2 in rep m2)

      (m1:%) * (m2:%):% == per array(a1+a2 for a1 in rep m1 for a2 in rep m2)

      pure?(m:%):B ==
         varFlag := false
         for e in rep m repeat
            e ~= 0 =>
              varFlag => return false
              varFlag := true
         true

      varMonom(i:SI,n:SI, deg:SI):% ==
         per array((if j=i then deg else 0$SI) for j in 1..n)


      variables(I:L %) :L SI ==
	#I < 1 => nil
	n:=# rep first I
	ans : L SI := nil
	for v in 1..n repeat
	   for m in I repeat
	      (rep m).v ~= 0 =>
		 ans := cons(v, ans)
		 break
	ans

HilbertFunctionPackage: with (Hilbert: L Monom -> POLY) == add

      adjoin(m:Monom, lm:L Monom):L Monom ==
	empty?(lm) => cons(m, nil)
	ris1:L Monom:= empty()
	ris2:L Monom:= empty()
	while not empty? lm repeat
	  m1 := first lm
	  lm := rest lm
	  m <= m1 =>
	     if not divides?(m,m1) then (ris1 := cons(m1, ris1))
	     iterate
	  ris2 := cons(m1, ris2)
	  if divides?(m1, m) then
	     return concat!(reverse!(ris1), concat!(reverse! ris2, lm))
	concat!(reverse!(ris1), cons(m, reverse! ris2))

      reduce(lm:L Monom):L Monom ==
	lm := sortHomogRemDup(lm)
	empty? lm => lm
	ris :L Monom := nil
	risd:L Monom := list first lm
	d := totalDegree first lm
	for m in rest lm repeat
	  if totalDegree(m)=d then risd := cons(m, risd)
	     else
	       ris := mergeDiv(ris, risd)
	       d := totalDegree m
	       risd :=list m
	mergeDiv(ris, risd)

      merge(l1:L Monom, l2:L Monom):L Monom ==
	#l1 > #l2 => merge(l2,l1)
	ris := l2
	for m1 in l1 repeat ris := adjoin(m1, ris)
	ris

      mergeDiv( small:L Monom, big:L Monom): L Monom ==
	ans : L Monom := small
	for m in big repeat
	  if not contained?(m,small) then ans := cons(m, ans)
	ans

      contained?(m:Monom, id: L Monom) : B ==
	for mm in id repeat
	  divides?(mm, m) => return true
	false

      (I:L Monom) quo (m:Monom):L Monom ==
	reduce [mm quo m for mm in I]

      (i1:L Monom) * (i2:L Monom):L Monom ==
	  ans : L Monom := nil
	  for m1 in i1 repeat for m2 in i2 repeat
	      ans := adjoin(m1*m2, ans)
	  ans

      (i:L Monom) ^ (n:SI) : L Monom ==
	  n = 1 => i
	  odd? n => i * (i*i)^shift(n, -1)
	  (i*i)^shift(n,-1)


      pureSplit(l:List Monom):Record(pure:List Monom, mixed:List Monom) ==
	pures := nil
	mixeds := nil
	for m in l repeat
	  if pure? m then pures:=cons(m,pures) else mixeds := cons(m,mixeds)
	[pures, mixeds]

      sort(I:L Monom, v:SI):L Monom ==
	sort((a:Monom,b:Monom):B+->(a.v < b.v), I)$ListSort(Monom)


      sortHomogRemDup(l:L Monom):L Monom ==
	l:=sort(homogLess, l)$ListSort(Monom)
	empty? l => l
	ans:L Monom := list first l
	for m in rest l repeat
	   if m ~= first(ans) then ans:=cons(m, ans)
	reverse! ans

      decompose(I:L Monom, v:SI):Record(size:SI, ideals:L L Monom, degs:L SI) ==
	I := sort(I, v)
	idlist: L L Monom := nil
	deglist : L SI := nil
	size : SI := 0
	J: L Monom := nil
	while not empty? I repeat
	  d := first(I).v
	  tj : L Monom := nil
	  while not empty? I and d=(m:=first I).v repeat
	     tj := cons(m quo v, tj)
	     I := rest I
	  J := mergeDiv(tj, J)
	  idlist := cons(J, idlist)
	  deglist := cons(d, deglist)
	  size := size + #J
	[size, idlist, deglist]

      Hilbert(I:L Monom):POLY ==
	#I = 0 => 1 -- no non-zero generators = 0 ideal
	#I = 1 => 1*var(0) - var(totalDegree first I)
	lvar :L SI := variables I
	import from Record(size:SI, ideals:L L Monom, degs:L SI)
	Jbest := decompose(I, first lvar)
	for v in rest lvar while #I < Jbest.size repeat
	   JJ := decompose(I, v)
	   JJ.size < Jbest.size => Jbest := JJ
	import from L L Monom
	import from L SI
	Jold := first(Jbest.ideals)
	dold := first(Jbest.degs)
	f:=var(dold)*Hilbert(Jold)
	for J in rest Jbest.ideals for d in rest Jbest.degs repeat
	   f := f + (var(d) - var(dold)) * Hilbert(J)
	   dold := d
	1*var(0) - var(dold) + f

varMonoms(n:SI):L Monom ==
   [varMonom(i,n,1) for i in 1..n]

varMonomsPower(n:SI, deg:SI):L Monom ==
   n = 1 => [ monomial(deg)]
   ans : L Monom := nil
   for j in 0..deg repeat
      ans := concat(varMonomMult(j,varMonomsPower(n-1,deg-j)), ans)
   ans

varMonomMult(i:SI, mlist : L Monom) : L Monom ==
  [varMonomMult(i, m) for m in mlist]

varMonomMult(i:SI, m:Monom) : Monom ==
  nm:Array SI := new(#m + 1, i)
  for k in 1..#m repeat nm.k :=m.k
  nm pretend Monom

import from Monomial
import from HilbertFunctionPackage
import from List Monomial
import from Polynomial(Integer, SingleInteger)
mon1:Monom := monomial(4,0,0,0)
mon2:Monom := monomial(3,3,0,0)
mon3:Monom := monomial(3,2,1,0)
mon4:Monom := monomial(3,1,2,0)
mon5:Monom := monomial(0,2,0,1)
mon6:Monom := monomial(0,1,0,5)
l:L Monom := list(mon1, mon2, mon3, mon4, mon5, mon6)
print(l)()
print(Hilbert l)()
idA := varMonomsPower(6,5)
print(#idA)()
print(Hilbert idA)()
idB := varMonomsPower(6,6)
print(#idB)()
print(Hilbert idB)()
idC := varMonomsPower(12,3)
print(#idC)()
print(Hilbert idC)()
idD:=list(monomial(2,0,0,0),monomial(1,1,0,0),monomial(1,0,1,0),monomial(1,0,0,1),_
 monomial(0,3,0,0),monomial(0,2,1,0))^4
print(#idD)()
print(Hilbert idD)()
