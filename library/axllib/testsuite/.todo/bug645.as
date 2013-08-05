--* From PETEB%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Mon May 23 21:22:45 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA14868; Mon, 23 May 1994 21:22:45 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 6735; Mon, 23 May 94 21:22:47 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.4317.May.23.21:22:47.-0400>
--*           for asbugs@watson; Mon, 23 May 94 21:22:47 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 4313; Mon, 23 May 1994 21:22:46 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 23 May 94 21:22:46 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA22210; Mon, 23 May 1994 21:20:04 -0500
--* Date: Mon, 23 May 1994 21:20:04 -0500
--* From: pab@watson.ibm.com
--* Message-Id: <9405240220.AA22210@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [6] Storage alloc. error, and odd err. message [bb.as][v35.2]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"
#library AsDem "asdem"
import from AsDem;

GEN ==> Generator X;

GeneratorOps(X: Type): with {
	map: (X -> X, GEN)-> GEN;
	filter: ( X->Boolean, GEN) -> GEN;
	concat: (GEN, GEN) -> GEN;
	combine: ( (X, X) -> X, GEN, GEN) -> GEN
}
== add {
	map(f: X->X, g: GEN): GEN ==
		generate for x in g repeat yield f x;

	filter(f: X->Boolean, g: GEN): GEN == {
		generate
			for x in g repeat
				if f x then yield x;
	}

	concat(g1: GEN, g2: GEN): GEN == {
		generate {
			for x in g1 repeat yield x;
			for x in g2 repeat yield x;
		}
	}
	
	combine(f: (X, X) -> X, g1: GEN, g2: GEN): GEN == {
		generate for x in g1
			 for y in g2 repeat
				yield f(x, y);
	}

}

--- candidate for Daftest Program for Printing Prime Numbers Award

I    ==> SingleInteger
IGEN ==> Generator I
import from GeneratorOps I
import from Generator I

numFilter(n: I, G: IGEN): IGEN == filter( (m: I): Boolean +-> not zero? (m mod n), G);

sieve(G: IGEN): IGEN == {
	step! G;
	-- bug: tinfer appears to require a clue on the type of a generator
	empty? G => { generate if false then yield 0 };
	next := value G;	
	concat (generate yield next,
		i for i in sieve numFilter(next, G))
}

AA(): Generator Ring == {
	import from Integer;
	generate for i in sieve(generator(2..)) repeat yield Complex(SmallPrimeField(i));
}


T1(): () == {
	for ZZ in AA() repeat {
		Dom: Ring == ZZ;
		import from Dom;
		if Dom has with { apply: (OutPort, Dom)->OutPort} then print "Cool!" else print "ugh!";
		x: Dom == 1+1+1;
		print(x)();
	}
}

T1();
