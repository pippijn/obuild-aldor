--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Jun 23 06:44:50 1995
--* Received: from yktvmv-ob.watson.ibm.com by asharp.watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21006; Fri, 23 Jun 1995 06:44:50 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4261; Fri, 23 Jun 95 06:44:51 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.8591.Jun.23.06:44:50.-0400>
--*           for asbugs@watson; Fri, 23 Jun 95 06:44:51 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 23 Jun 95 06:44:50 EDT
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id MAA10564 for <asbugs@watson.ibm.com>; Fri, 23 Jun 1995 12:44:44 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id MAA15064 for asbugs@watson.ibm.com; Fri, 23 Jun 1995 12:44:43 +0200
--* Date: Fri, 23 Jun 1995 12:44:43 +0200
--* Message-Id: <199506231044.MAA15064@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [1] compile time seg fault [pfunc.as][1.1.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--
-- This bug occurs only when this file is split into 2 files:
--
-- % axiomxl pfunc.as
-- % axiomxl bar.as
-- #1 (Error) Program fault (segmentation violation).

-------------------------- pfunc.as ---------------------------------
#include "axllib.as"

PFunction(R:BasicType, S:BasicType): BasicType with {
	pFunction: (R -> Partial S) -> %;
} == add {
	macro Rep == R -> Partial S;
	import from Rep;

	(p:TextWriter) << (f:%):TextWriter	== p;
	(u:%) = (v:%):Boolean			== false;
	pFunction(f:R -> Partial S):%		== per f;
	sample:%		== per((r:R):Partial S +-> [sample$S]);
}

Foo: Category == BasicType with { foo: (F:Field) -> PFunction(%, F) };

------------------------ bar.as ---------------------------
#include "axllib.as"

#library mylib "pfunc.ao"
import from mylib;

Bar(R:BasicType): Category == BasicType with {
	if R has Foo then Foo;
	default {
		if R has Foo then {
			foo(F:Field):PFunction(%, F) == {
				s := foo(F)$R;
				sample;
			}
		}
	}
}		

