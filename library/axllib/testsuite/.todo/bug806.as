--* From PETEB%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Aug 15 13:31:20 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA27342; Mon, 15 Aug 1994 13:31:20 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0037; Mon, 15 Aug 94 13:31:22 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.2775.Aug.15.13:31:19.-0400>
--*           for asbugs@watson; Mon, 15 Aug 94 13:31:22 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 2765; Mon, 15 Aug 1994 13:31:19 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 15 Aug 94 13:31:18 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA21100; Mon, 15 Aug 1994 13:27:13 -0500
--* Date: Mon, 15 Aug 1994 13:27:13 -0500
--* From: pab@watson.ibm.com
--* Message-Id: <9408151827.AA21100@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3][tinfer] rest.xl < rest.yl should not have compiled

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: none
-- Version: current
-- Original bug file name: indexedp1.as

--Copyright The Numerical Algorithms Group Limited 1991.

--)abbrev category IDPC IndexedDirectProductCategory
--)abbrev domain IDPO IndexedDirectProductObject
--)abbrev domain IDPAM IndexedDirectProductAbelianMonoid
--)abbrev domain IDPOAM IndexedDirectProductOrderedAbelianMonoid
--)abbrev domain IDPOAMS IndexedDirectProductOrderedAbelianMonoidSup
--)abbrev domain IDPAG IndexedDirectProductAbelianGroup

--%  IndexedDirectProductCategory
#include "ax0"

+++ Author: James Davenport
+++ Date Created:
+++ Date Last Updated:
+++ Basic Functions:
+++ Related Constructors:
+++ Also See:
+++ AMS Classifications:
+++ Keywords:
+++ References:
+++ Description:
+++ This category represents the direct product of some set with
+++ respect to an ordered indexing set.

XIndexedDirectProductCategory(A:SetCategory,S:OrderedSet): Category ==
  SetCategory with {
    map:           (A -> A, %) -> %;
       ++ map(f,z) returns the new element created by applying the
       ++ function f to each component of the direct product element z.
    monomial:         (A, S) -> %;
       ++ monomial(a,s) constructs a direct product element with the s
       ++ component set to \spad{a}
    leadingCoefficient:   % -> A;
       ++ leadingCoefficient(z) returns the coefficient of the leading
       ++ (with respect to the ordering on the indexing set)
       ++ monomial of z.
       ++ Error: if z has no support.
    leadingSupport:   % -> S;
       ++ leadingSupport(z) returns the index of leading
       ++ (with respect to the ordering on the indexing set) monomial of z.
       ++ Error: if z has no support.
    reductum:      % -> %;
       ++ reductum(z) returns a new element created by removing the
       ++ leading coefficient/support pair from the element z.
       ++ Error: if z has no support.
}

++ Indexed direct products of objects over a set \spad{A}
++ of generators indexed by an ordered set S. All items have finite support.
XIndexedDirectProductObject(A:SetCategory,S:OrderedSet): XIndexedDirectProductCategory(A,S)
 == add {
    --representations
       Term ==>  Record(k:S,c:A);
       Rep ==>  List Term;
       import from Rep;
    --declarations
       default x,y: %;
       default f: A -> A;
       default s: S;
       default r:A;
       FIRST==>(first$'first');

       x = y: Boolean == {
	 x1 := rep x;
	 y1 := rep y;
         while not null x1 and not null y1 repeat {
           x1.FIRST.k ~= y1.FIRST.k => return false;
           x1.FIRST.c ~= y1.FIRST.c => return false;
           x1:=rest.x1;
           y1:=rest.y1;
	 }
         null x1 and null y1;
       }
       monomial(r,s): % == per ([[s,r]]$Rep);
       map(f,x): % == per [[tm.k,f(tm.c)] for tm in rep(x)];

       reductum x: %    == {
          null rep x => error "Can't take reductum of empty product element";
          per(rest rep x)
       }
       leadingCoefficient x: A  == {
          null rep x => error "Can't take leadingCoefficient of empty product element";
          first(rep(x)).c;
       }
       leadingSupport x: S  == {
          null rep x => error "Can't take leadingCoefficient of empty product element";
          first(rep(x)).k;
       }

	coerce(x: %): OutputForm == (leadingCoefficient x)::OutputForm;
}

++ Indexed direct products of abelian monoids over an abelian monoid \spad{A} of
++ generators indexed by the ordered set S. All items have finite support.
++ Only non-zero terms are stored.
XIndexedDirectProductAbelianMonoid(A:AbelianMonoid,S:OrderedSet):
    Join(AbelianMonoid,XIndexedDirectProductCategory(A,S))
 ==  XIndexedDirectProductObject(A,S) add {
    --representations
       Term ==>  Record(k:S,c:A);
       Rep ==>  List Term;
       import from Rep;
       default x,y: %;
       default r: A;
       default n: NonNegativeInteger;
       default f: A -> A;
       default s: S;
       0: %  == per [];
       zero? x: Boolean ==  null rep x;
       x + y: %  == {
          null rep(x) => y;
          null rep y => x;
	  xl := rep x;
	  yl := rep y;
          first.yl.k > first.xl.k => per cons(first.yl,rep(x + per(rest.yl)));
          first.xl.k > first.yl.k => per cons(first.xl,rep(per(rest.xl) + y));
          r:= first.xl.c + first.yl.c;
          r = 0 => per(rest.xl) + per(rest.yl);
          per cons([first.xl.k,r],rep(per(rest.xl) + per(rest.yl)));
       }
       n * x: %  == {
             n = 0 => 0;
             n = 1 => x;
             per [[u.k,a] for u in rep(x) | (a:=n*u.c) ~= 0$A];
      }

       monomial(r,s): % == (r = 0 => 0; per [[s,r]]);
       map(f,x): % == per([[tm.k,a] for tm in rep x | (a:=f(tm.c)) ~= 0$A]);

       reductum x: %     == (zero? x => 0; per(rest rep x));
       leadingCoefficient x: A  == (null rep x => 0; first(rep(x)).c);

}

++ Indexed direct products of ordered abelian monoids \spad{A} of
++ generators indexed by the ordered set S.
++ The inherited order is lexicographical.
++ All items have finite support: only non-zero terms are stored.
XIndexedDirectProductOrderedAbelianMonoid(A:OrderedAbelianMonoid,S:OrderedSet):
    Join(OrderedAbelianMonoid,XIndexedDirectProductCategory(A,S))
 ==  XIndexedDirectProductAbelianMonoid(A,S) add {
    --representations
       Term==>  Record(k:S,c:A);
       Rep==>  List Term;
       import from Rep;
       default x,y: %;

       x<y: Boolean == {
	 xl := rep x;
	 yl := rep y;
         empty? yl => false;
         empty? xl => true;   -- note careful order of these two lines
         first.yl.k > first.xl.k => true;
         first.yl.k < first.xl.k => false;
         first.yl.c > first.xl.c => true;
         first.yl.c < first.xl.c => false;
         rest.xl < rest.yl;
       }
}
++ Indexed direct products of ordered abelian monoid sups \spad{A},
++ generators indexed by the ordered set S.
++ All items have finite support: only non-zero terms are stored.
XIndexedDirectProductOrderedAbelianMonoidSup(A:OrderedAbelianMonoidSup,S:OrderedSet):
    Join(OrderedAbelianMonoidSup,XIndexedDirectProductCategory(A,S))
 ==  XIndexedDirectProductOrderedAbelianMonoid(A,S) add {
    --representations
       Term ==>  Record(k:S,c:A);
       Rep ==>  List Term;
       import from Rep;
       default x,y: %;
       default r: A;
       default s: S;

       subtractIfCan(x,y): Union(value1: %, failed: 'failed') == {
         zero? y => [x];
         zero? x => [failed];
	 xl := rep x;
	 yl := rep y;
         first.xl.k < first.yl.k => [failed];
         first.xl.k > first.yl.k => {
             t:= subtractIfCan(per(rest.xl), y);
             t case failed => [failed];
             [per(cons( first.xl, rep(t.value1)))];
	 }
         u: Union(value1: A, failed: 'failed') :=subtractIfCan(first.xl.c, first.yl.c);
         u case failed => [failed];
         zero? u.value1 => subtractIfCan(per(rest.xl), per(rest.yl));
         t:= subtractIfCan(per(rest.xl), per(rest.yl));
         t case failed => [failed];
         [per(cons([first.xl.k, u.value1], rep(t.value1)))];
       }
       sup(x,y): % == {
         zero? y => x;
         zero? x=> y;
	 xl := rep x;
	 yl := rep y;
         first.xl.k < first.yl.k => per(cons(first.yl,rep(sup(x, per(rest.yl)))));
         first.xl.k > first.yl.k => per(cons(first.xl,rep(sup(per(rest.xl) ,y))));
         u:=sup(first.xl.c, first.yl.c);
         per cons([first.xl.k,u],rep(sup(per(rest.xl), per(rest.yl))));
       }
}


++ Indexed direct products of abelian groups over an abelian group \spad{A} of
++ generators indexed by the ordered set S.
++ All items have finite support: only non-zero terms are stored.
XIndexedDirectProductAbelianGroup(A:AbelianGroup,S:OrderedSet):
    Join(AbelianGroup,XIndexedDirectProductCategory(A,S))
 ==  XIndexedDirectProductAbelianMonoid(A,S) add {
    --representations
       Term ==>  Record(k:S,c:A);
       Rep  ==>  List Term;
       import from Rep;
       default x,y: %;
       default r: A;
       default n: Integer;
       default f: A -> A;
       default s: S;

       x - y: %  == {
          zero? x => - y;
          zero? y => x;
          xl := rep x;
	  yl := rep y;
          first.yl.k > first.xl.k => per(cons([first.yl.k,-first.yl.c], rep(x - per(rest.yl))));
          first.xl.k > first.yl.k => per(cons(first.xl,rep(per(rest.xl) - y)));
          r:= first.xl.c - first.yl.c;
          r = 0 => per(rest.xl) - per(rest.yl);
          per(cons([first.xl.k,r],rep(per(rest.xl) - per(rest.yl))));
	}
--      - x  == map(-#1,x)

       -x: % == per[[u.k,-u.c] for u in rep(x)];
       n * x: %  == {
             n = 0 => 0;
             n = 1 => x;
             per[[u.k,a] for u in rep(x) | (a:=n*u.c) ~= 0$A];
       }
}


