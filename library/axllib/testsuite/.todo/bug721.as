--* From DOOLEY%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun 30 18:09:08 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21258; Thu, 30 Jun 1994 18:09:08 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2189; Thu, 30 Jun 94 18:09:09 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.DOOLEY.NOTE.VAGENT2.0289.Jun.30.18:09:08.-0400>
--*           for asbugs@watson; Thu, 30 Jun 94 18:09:09 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 0283; Thu, 30 Jun 1994 18:09:08 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 30 Jun 94 18:09:06 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA24457; Thu, 30 Jun 1994 18:04:58 -0400
--* Date: Thu, 30 Jun 1994 18:04:58 -0400
--* From: dooley@watson.ibm.com (Sam Dooley)
--* Message-Id: <9406302204.AA24457@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [5] Record ops from 'Rep add Rep == Record(...)' trigger gen0UnhandledSpecialOp. [export1.as][v0.36.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

Str ==> String;
Ptr ==> Pointer;

Cons: BasicType with {
	bracket:	(Str, Str) -> %;
	apply:		(%, 'key') -> Str;
	apply:		(%, 'val') -> Str;
	set!:		(%, 'val', Str) -> Str;

	export from 'key';
	export from 'val';
}
== Rep add {
	Rep == Record(key: Str, val: Str);
	import from Rep;

	sample: % == nil$Ptr pretend %;
	(p: TextWriter) << (x: %) : TextWriter ==
		p << "[" << x.key << ", " << x.val << "]";
}
