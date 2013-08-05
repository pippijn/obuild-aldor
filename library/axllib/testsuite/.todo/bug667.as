--* From PETEB%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Tue May 31 17:43:04 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA26051; Tue, 31 May 1994 17:43:04 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1284; Tue, 31 May 94 17:43:12 EDT
--* Received: from WATSON by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.3141.May.31.17:43:11.-0400>
--*           for asbugs@watson; Tue, 31 May 94 17:43:12 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 5251; Tue, 31 May 1994 17:43:02 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 31 May 94 17:43:01 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA15069; Tue, 31 May 1994 17:40:12 -0500
--* Date: Tue, 31 May 1994 17:40:12 -0500
--* From: pab@watson.ibm.com
--* Message-Id: <9405312240.AA15069@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [6] Generator dropped at bad time [funlist1.as][v35.3]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"
--> testrun -O
--> testcomp -O
S ==> SingleInteger;
Bool ==> Boolean;

MyArray(T: Type): with {
	bracket: Tuple T -> %;
	generator: % -> Generator T;
} == add {
	Rep ==> Tuple T;
	import from Rep;
	import from SingleInteger;
	[t: Tuple T]: % == per t;

	generator(x: %): Generator T == {
		generate for i in 1..length(rep(x)) repeat yield element(rep(x), i)
	}
	
}

MyList ==> MyArray

-- give list of mapping a work-out
T1(): () == {
	import from S;
	import from MyList (S->S);

	l := [ +, -, (x: S): S +-> x*2 +2 ];

	for fn in l repeat
		print(fn 7)();
}

T2(): () == {
	import from MyList ((S, S) -> Bool);
	import from S;
	import from List S;
	l := [ <, > , <=, >=, =, ~=];
	m := [i for i in 1..10];

	for fn in l repeat
		for i1 in 1..9
		for i2 in 9..1 by -1 repeat
			print(i1)(" ")(i2)(" ")(fn(i1, i2))();
}

-- Problem is here: the type of the mapping is actually S -> Generator (S, Bool)
-- seems be be inferred as S->(S, Bool), which is then embedded.

T3(): () == {
	import from List (S -> (S, Bool));
	import from List ((S, S) -> Bool);
	import from S;
	
	l := [ (x: S): (S, Bool) +-> (x, fn(x, 0))
			for fn in [  <, > , <=, >=, =, ~= ] ];
	for fn in l repeat
		for z in -3..3 repeat {
			(a, b) := fn(z);
			print(b)(" ")(a)();
		}

}

T1();
T2();
--T3();
