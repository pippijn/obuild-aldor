--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Aug 25 10:12:30 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19167; Thu, 25 Aug 1994 10:12:30 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0871; Thu, 25 Aug 94 10:12:33 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.3997.Aug.25.10:12:30.-0400>
--*           for asbugs@watson; Thu, 25 Aug 94 10:12:32 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 3981; Thu, 25 Aug 1994 10:12:30 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 25 Aug 94 10:12:25 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA30402; Thu, 25 Aug 1994 10:12:31 -0400
--* Date: Thu, 25 Aug 1994 10:12:31 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9408251412.AA30402@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3][tinfer] Type constraints not being pushed down through generators

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp
-- Version: o.36.5
-- Original bug file name: generbug.as

#include "axllib"

MiniList(S: BasicType): LinearAggregate(S) == add {
	Rep == Union(nil: Pointer, rec: Record(first: S, rest: %));

	import from Rep, SingleInteger;

	local cons (s:S,l:%):% == per(union [s, l]);
	local first(l: %): S   == rep(l).rec.first;
	local rest (l: %): %   == rep(l).rec.rest;

	empty (): %            == per(union nil);
	empty?(l: %):Boolean   == rep(l) case nil;
	sample: %              == empty();

        [t: Tuple S]: % == {
                l := empty();
                for i in length t..1 by -1 repeat
                        l := cons(element(t, i), l);
                l
        }
	[g: Generator S]: % == {
		r := empty(); for s in g repeat r := cons(s, r);
		l := empty(); for s in l repeat l := cons(s, l);
		l
        }
	generator(l: %): Generator S == generate {
		while not empty? l repeat {
			yield first l;
			l := rest l
		}
	}
	apply(l: %, i: SingleInteger): S == {
		while i > 1 and not empty? l repeat {
			l := rest l; i := i - 1;
		}
		i ~= 1 or empty? l => error "No such element";
		first l
	}
	(l1: %) = (l2: %): Boolean == {
		while not empty? l1 and not empty? l2 repeat
			if first l1 ~= first l2 then return false;
		empty? l1 and empty? l2
	}
	(out: TextWriter) << (l: %): TextWriter == {
		empty? l => out << "[]";
		out << "[" << first l;
		for s in rest l repeat out << ", " << s;
		out << "]"
	}
}

f(): () == {
import from MiniList Integer, SingleInteger, Boolean;

print << [] << newline;
print << [1] << newline;
print << [1, 2] << newline;
print << [1, 2, 3] << newline;
print << [1, 2, 3, 4] << newline;

l := [1,2,3,4];
print << l.3 << newline;

-- m := [i^2 for i: Integer in 1..10];  ----- This one is OK
m := [i^2 for i in 1..10]; ----- This one fails to compile.
print << m << newline;
print << m.3 << newline;
print << l = l << " or " << l = m << newline;
}
f()
