--* From PETEB%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Jun 19 00:18:45 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA16519; Sun, 19 Jun 1994 00:18:45 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8249; Sun, 19 Jun 94 00:18:45 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.0761.Jun.19.00:18:45.-0400>
--*           for asbugs@watson; Sun, 19 Jun 94 00:18:45 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 0757; Sun, 19 Jun 1994 00:18:45 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Sun, 19 Jun 94 00:18:44 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA16859; Sun, 19 Jun 1994 00:16:01 -0500
--* Date: Sun, 19 Jun 1994 00:16:01 -0500
--* From: pab@watson.ibm.com
--* Message-Id: <9406190516.AA16859@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] tinfer enters black hole [fix1.as][v35.6]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"
X==> SingleInteger;
Tree: BasicType with {
	addTree: (%, %) -> %;
	addValue:(%, X) -> X;
	node:	     () -> X;
			
	export from X;
} == add {
	U ==> Union(i: X, p: Rep);
	Rep == List(U);

	import from Rep, U;
	
	node(): % == [];
	addTree (l: %, r: %): % == per(cons([rep(l)], r));
	addValue(l: %, v: X): % == per(cons([v], r));

	-- basicType operations
	sample: % == per [];
	(p: OutPort) << (l: %): OutPort == {
		p << "Thing(";
		for e in l repeat
			if e case i then p << e.i
			else p << (e.p);
		p << ")";
	}

	(a: %) = (b: %): Boolean == false;
}


T1(): () == {
	import from Tree;
	print << sample$(Tree SingleInteger) << newline;
	x := node();
	print << x << newline;
	x := addValue(x, 2);
	print << x << newline;
	y := addValue(node(), 2);
	print << y << newline;
	print << addTree(x, y) << newline;
}

T1();
