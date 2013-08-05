--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun  9 06:40:06 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA24791; Thu, 9 Jun 1994 06:40:06 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4511; Thu, 09 Jun 94 06:40:07 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.8263.Jun.09.06:40:07.-0400>
--*           for asbugs@watson; Thu, 09 Jun 94 06:40:07 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 8259; Thu, 9 Jun 1994 06:40:07 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 09 Jun 94 06:40:06 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA22144; Thu, 9 Jun 1994 06:42:55 -0400
--* Date: Thu, 9 Jun 1994 06:42:55 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9406091042.AA22144@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3] abnorm can't handle curried definitions with default values (see fileGetc) [inport.as][0.35.6+]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


----
---- inport.as
----

#include "axllib"

import from SingleInteger;


InPort: with {
	coerce:    InFile -> %;
	inport:	   ((eof: Character == char 0) -> Character) -> %;

	getchar:   (%, eof: Character == char 0) -> Character;
	getline:   % -> String;
	generator: % -> Generator Character;
	lines:     % -> Generator String;
}
== add {

	Rep ==> (eof: Character == char 0) -> Character;

	local fileGetc(inf: InFile)(eof: Character == char 0): Character ==
		getchar(inf, eof);

	coerce(inf: InFile): % ==
		per fileGetc inf;

	getchar(inp: %, eof: Character == char 0): Character ==
		rep(inp)(eof);

	getline(inp: %): String == {
		buf: Array Character := empty();
		for c: Character in inp repeat
			if c = newline then break else extend!(buf, c);
		capture buf;
	}

	capture(v: Array Character): String == {
		l := #v;
		r: String := new(l);
		for i in 1..l repeat r.i := v.i;
		r
	}

	generator(inp: %): Generator Character == generate {
		repeat {
			c := getchar inp;
			if c = char 0 then break;
			yield c;
		}
	}

	lines(inp: %): Generator String == generate {
		buf: Array Character := empty();
		for c: Character in inp repeat {
			if c = newline then {
				s := capture buf;
				yield s;
				buf := empty();		--!! Should share buf.
			}
			else
				extend!(buf, c);
		}
		if #buf > 0 then
			yield capture buf;
	}
}
