--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Fri Jun  3 07:14:38 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23015; Fri, 3 Jun 1994 07:14:38 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5061; Fri, 03 Jun 94 07:14:44 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.2134.Jun.03.07:14:43.-0400>
--*           for asbugs@watson; Fri, 03 Jun 94 07:14:44 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 2132; Fri, 3 Jun 1994 07:14:43 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Fri, 03 Jun 94 07:14:42 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA12371; Fri, 3 Jun 1994 07:17:13 -0400
--* Date: Fri, 3 Jun 1994 07:17:13 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9406031117.AA12371@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3] Substitution bug for %? [sinteger.as][0.35.4b]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--
-- SInt.as
--

#assert InBasic
#include "axllib"

#library SegmentLib "segment.aso"
import from SegmentLib;

BitC ==> with {
	length: % -> SingleInteger;
	bit:    (%, SingleInteger) -> Boolean;
}

+++ RepeatedSquaring exponentiates by multiplying and squaring.
+++
+++ To work with allocated types  efficently, * should work in-place
+++ on its first argument.
+++
+++ Author: A# library
+++ Date Created: 1992-93
+++ Keywords: exponent, power

RepeatedSquaring(T: Type, E: BitC, *: (T,T)->T, 1: T): with { ^: (T, E) -> T }
== add {
	(x: T) ^ (n: E): T == {
		l := length n;
		y := 1@T;
		for i in 0..l-1 repeat {
			if bit(n, i) then y := y * x;
			x := x * x;
		}
		y
	}
}

+++ SingleInteger implements single-precision integers.  Typically 32 bits.
+++
+++ Author: A# library
+++ Date Created: 1992-93
+++ Keywords: single-precision integer

extend SingleInteger: Join(
	Logic,
	OrderedFinite,
	IntegerNumberSystem,
	Steppable
) with {
	mod_+:	(%,%,%)-> %;
	mod_-:	(%,%,%)-> %;
	mod_*:	(%,%,%)-> %;
	mod_/:  (%,%,%)-> %;
	mod_^:	(%,%,%)-> %;
}
== add {
	Rep ==> BSInt;
	SI  ==> SingleInteger;

	import { string: Literal -> % } from String;

	0:   %			 == per 0;
	1:   %			 == per 1;
	min: %			 == per min;
	max: %			 == per max;
	#: Integer == {
		import from SingleInteger$Basic;
		(convert rep max - convert rep min + 1)::Integer
	}
	integer   (l:Literal): %  == per convert (l pretend BArr);
	zero?	  (i: %): Boolean == zero?     (rep i)::Boolean;
	negative? (i: %): Boolean == negative? (rep i)::Boolean;
	positive? (i: %): Boolean == positive? (rep i)::Boolean;
	even?	  (i: %): Boolean == even?     (rep i)::Boolean;
	odd?	  (i: %): Boolean == odd?      (rep i)::Boolean;
	single?   (i: %): Boolean == true::Boolean;
	(i: %) =  (j: %): Boolean == (rep i =  rep j)::Boolean;
	(i: %) ~= (j: %): Boolean == (rep i ~= rep j)::Boolean;
	(i: %) <  (j: %): Boolean == (rep i <  rep j)::Boolean;
	(i: %) >  (j: %): Boolean == (rep j <  rep i)::Boolean;
	(i: %) <= (j: %): Boolean == (rep i <= rep j)::Boolean;
	(i: %) >= (j: %): Boolean == (rep j <= rep i)::Boolean;

	prev(i: %): %		  == per prev rep i;
	next(i: %): %		  == per next rep i;
	+ (i: %): %		  == i;
	- (i: %): %		  == per (- rep i);
	(i: %) + (j: %): %	  == per (rep i + rep j);
	(i: %) - (j: %): %	  == per (rep i - rep j);
	(i: %) * (j: %): %	  == per (rep i * rep j);
	(i: %) ^ (j: %): %        == {
		j = 0 => 1;
		j = 1 => i;
		j = 2 => i*i;
		j = 3 => i*i*i;
		(i ^ j)$RepeatedSquaring(%, %, *, 1);
	}
	(i: %) quo (j: %): %	  == per (rep i quo rep j);
	(i: %) rem (j: %): %	  == per (rep i rem rep j);
	gcd(i: %, j: %): %	  == per gcd(rep i, rep j);

	length(i: %): SI          == (length rep i) pretend SI;
	shift (i: %, n: SI): % == {
		n > 0 => per shiftUp(rep i, +n pretend BSInt);
		n < 0 => per shiftDn(rep i, -n pretend BSInt);
		i
	}
	bit   (i: %, n: SI): Boolean == bit(rep i, n pretend BSInt)::Boolean;

	~ (i: %): %	 	  == per (~ rep i);
	(i: %) /\ (j: %): %	  == per (rep i /\ rep j);
	(i: %) \/ (j: %): %	  == per (rep i \/ rep j);

	-- All the mod operations are assuming n > 0.
	-- Also assumes that n is half word sized for *.
	(i: %) mod (n: %): %	== {
		k := i rem n;
		if i < 0 then k := k + n;
		k;
	}
	mod_+(i:%, j:%, n:%): %	 == {
		k := i + j;
		if k >= n then k := k-n;
		k;
	}
	mod_-(i:%, j:%, n:%): %	 == {
		k := i - j;
		if k < 0 then k := k + n;
		k;
	}
	mod_*(i:%, j:%, n:%): %	 == {
		i = 1 => j;
		k := i * j;
		k mod n;
	}
	mod_/(i: %, j: %, n: %): % == {
		local c0, d0, c1, d1: %;
		(c0, d0) := (j, n);
		(c1, d1) := (1, 0);
		while not zero? d0 repeat {
			q := c0 quo d0;
			(c0, d0) := (d0, c0 - q*d0);
			(c1, d1) := (d1, c1 - q*d1)
		}
		if c0 ~= 1 then error "inverse does not exist";
		if c1 < 0  then c1 := c1 + n;
		mod_*(i, c1, n);
	}
	mod_^(i:%, j:%, n:%): %	 == {
		j < 0  => mod_^(mod_/(1, i, n), -j, n);
		j = 0  => 1;
		odd? j => mod_*(i, mod_^(i, j-1, n), n);
		mod_^(mod_*(i,i,n), j quo 2, n)
	}

	divide(i: %, j: %): (%,%) ==  {
		(a,b) := divide(rep i, rep j);
		(per a, per b);
	}

	retract(i: %): SI == i pretend SI;

	stepsBetween(x: %, y: %, step: %): SingleInteger ==
		retract((y-x) quo step + 1);

	apply(p: OutPort, i: %): OutPort == put(p, rep i);
}
