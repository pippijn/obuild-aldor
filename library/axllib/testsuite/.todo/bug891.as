--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Oct 28 10:26:35 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA16497; Fri, 28 Oct 1994 10:26:35 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0865; Fri, 28 Oct 94 10:26:41 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.1203.Oct.28.10:26:40.-0400>
--*           for asbugs@watson; Fri, 28 Oct 94 10:26:41 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 28 Oct 94 10:26:39 EDT
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id PAA15306 for <asbugs@watson.ibm.com>; Fri, 28 Oct 1994 15:26:30 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id PAA02524 for asbugs@watson.ibm.com; Fri, 28 Oct 1994 15:26:29 +0100
--* Date: Fri, 28 Oct 1994 15:26:29 +0100
--* Message-Id: <199410281426.PAA02524@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [3] a parameter 'T' in signature isn't expanded

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp nilrec.as
-- Version: 0.37.0
-- Original bug file name: nilrec.as

------------------------------- nilrec.as ----------------------------------

#include "axllib"

-- This type compiles, but it seems that the signature of 'record' is wrong
NilRecord(T:Tuple Type): with {
	coerce: Record T -> %;
	eq?: (%, %) -> Boolean;
	nil: %;
	nil?: % -> Boolean;
	record: % -> Record T;
} == add {
	macro Rep == Pointer;

	import from Rep;

	eq?(r:%, s:%):Boolean	== rep r = rep s;
	nil?(r:%):Boolean	== nil? rep r;
	nil:%			== per(nil$Pointer);
	coerce(r:Record T):%	== per(r pretend Pointer);
	record(r:%):Record T	== r pretend Record T;
}


-- This one doesn't, since the 'T' in Record T did not get expanded.
-- "nilrec.as", line 45:                 rc a;
--                       ................^
-- [L39 C17] #1 (Error) Operator (argument 1 of apply) did not match any
-- possible parameter type.
--     The rejected type is Record(T).
--     Expected type Record(a: SingleInteger, b: SingleInteger).

Foo(): with {
	foo: % -> SingleInteger;
} == add {
	macro Z   == SingleInteger;
	macro Rep == NilRecord(a:Z, b:Z);
	macro R   == Record(a:Z, b:Z);

	import from Z, Rep, R;

	foo(r:%):Z == {
		nil? rep r => 0;
		rc := record rep r;
		rc a;
	}
}

