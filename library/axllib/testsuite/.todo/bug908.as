--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Nov 14 14:46:52 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA18971; Mon, 14 Nov 1994 14:46:52 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8935; Mon, 14 Nov 94 14:46:58 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.8657.Nov.14.14:46:57.-0500>
--*           for asbugs@watson; Mon, 14 Nov 94 14:46:58 -0500
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 8653; Mon, 14 Nov 1994 14:46:57 EST
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Mon, 14 Nov 94 14:46:57 EST
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA34648; Mon, 14 Nov 1994 14:49:29 -0500
--* Date: Mon, 14 Nov 1994 14:49:29 -0500
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9411141949.AA34648@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] Error message for an-unfree variable is misleading

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp jolly.as
-- Version: 1.0.1a
-- Original bug file name: jolly.as

--+ "jolly.as", line 25:
--+                 ns := #s - ix + 1;                      -- Max no. chars left.
--+ ................^..........^
--+ [L25 C17] #3 (Error) No meaning for identifier `ns'.
--+ [L25 C28] #4 (Error) No meaning for identifier `ix'.
--+
--+ "jolly.as", line 28:                 for si in ix.. for bi in start.. repeat {
--+                      ....................^
--+ [L28 C21] #5 (Error) No meaning for identifier `si'.
--+
--+ "jolly.as", line 29:
--+                         if si>#s or bi>=limit or (si>1 and s.(si-1)=newline)
--+ ...........................^
--+ [L29 C28] #2 (Error) No meaning for identifier `si'.
--+
--+ "jolly.as", line 31:                                 n  := si - ix;
--+                      ................................^
--+ [L31 C33] #6 (Error) No meaning for identifier `n'.
--+
--+ "jolly.as", line 32:                                 ix := si;
--+                      ................................^
--+ [L32 C33] #1 (Warning) Implicit local `ix' is a parameter, local or explicit free in an outer scope. Add a `local' declaration if this is what you intended.
--+
#include "axllib"
#include "asdem"
#library ReaderLib "readexpr.aso"

R     ==> Integer;
Expon ==> HomogeneousDirectProduct(2);
Poly  ==> Polynomial(R, Expon);

import from ReaderLib;
import from TextReader;
import from StandardIO;
import from Character;

reader(s: String): TextReader == {
	SI ==> SingleInteger;
	ix: SI := 1;
	getc(eof: Character == char 0): Character == {
		free ix;
		ix > #s => eof;
		c := s.ix; ix := ix + 1; c
	}
	gets(buffer: String, start:  SI, limit:  SI):  SI == {
		-- WITHOUT THIS LINE, YOU GET A BAD ERROR MESSAGE
		--free ix;
		ns := #s - ix + 1;                      -- Max no. chars left.
		if limit = 0 then limit := start + ns;  -- 0 => no limit.

		for si in ix.. for bi in start.. repeat {
			if si>#s or bi>=limit or (si>1 and s.(si-1)=newline)
			then {
				n  := si - ix;
				ix := si;
				end!(buffer, bi);
				return n;
			}
			buffer.bi := s.si;
		}
		never
	}
	reader(getc, gets)
}


import from SingleInteger;
import from R;
import from Expon;
import from Poly;

letterVar(s: String): Poly == {
	k := ord s.1 - ord char "x" + 1;
	var unitVector k;
}

import from ExpressionReader(Poly, letterVar);

readPrintLoop(rdr: TextReader): () == {
	lineNo: SingleInteger := 1;

	while lineNo > 0 repeat {
		(p, lineNo) := read!(rdr, lineNo);
		print << "Read " << p;
		print << " at line " << lineNo;
		print << "." << newline;
	}
}

readPrintLoop reader "x^2 - y - 3*x*y; (x-y)^4;" ;
readPrintLoop reader stdin;
