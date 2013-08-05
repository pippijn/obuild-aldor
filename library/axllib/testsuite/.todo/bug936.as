--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Dec 22 18:36:55 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17867; Thu, 22 Dec 1994 18:36:55 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0833; Thu, 22 Dec 94 18:36:53 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.6981.Dec.22.18:36:52.-0500>
--*           for asbugs@watson; Thu, 22 Dec 94 18:36:53 -0500
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 22 Dec 94 18:36:50 EST
--* Via: uk.co.iec; Thu, 22 Dec 1994 23:36:26 +0000
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA27466;
--*           Thu, 22 Dec 94 23:37:46 GMT
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Thu, 22 Dec 94 23:34:56 GMT
--* Message-Id: <3930.9412222334@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA03930;
--*           Thu, 22 Dec 94 23:34:56 GMT
--* To: asbugs@watson.ibm.com
--* Subject: parameter types not checked

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- This is a cut down version. That's why its silly.

#include "axllib"

SExpr  ==> Integer;

define SExprFormer(X: BasicType): Category == with {
	convert: X -> SExpr;
	convert: SExpr -> X;
}

FractionSExprOperations(
	X: Ring,
	R: with {
		numerator: % -> X;
		denominator: % -> X;
		/: (X,X) -> %;
	}
): with { foo: R-> R} == add {
	import from X, SExpr, R, C;

	foo(x:R): R == numerator x/denominator x;


}
ANYTHING==>List FileName;

import from SingleInteger;
print << (foo$(FractionSExprOperations(Integer, ANYTHING))
		pretend SingleInteger)

